Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807893FF48E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343948AbhIBUFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:05:07 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41813 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S236589AbhIBUFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:05:06 -0400
Received: (qmail 444108 invoked by uid 1000); 2 Sep 2021 16:04:06 -0400
Date:   Thu, 2 Sep 2021 16:04:06 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+ada0f7d3d9fd2016d927@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] INFO: task hung in do_proc_bulk
Message-ID: <20210902200406.GB442125@rowland.harvard.edu>
References: <000000000000a83c6a05caa09572@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a83c6a05caa09572@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's see if making the wait killable rather than interruptible fixes the 
issue.  This patch avoids modifying the regular usb_start_wait_urb(), 
creating a separate usbfs_start_wait_urb() just for this purpose.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git d5ae8d7f85b7

Index: usb-devel/drivers/usb/core/devio.c
===================================================================
--- usb-devel.orig/drivers/usb/core/devio.c
+++ usb-devel/drivers/usb/core/devio.c
@@ -32,6 +32,7 @@
 #include <linux/usb.h>
 #include <linux/usbdevice_fs.h>
 #include <linux/usb/hcd.h>	/* for usbcore internals */
+#include <linux/usb/quirks.h>
 #include <linux/cdev.h>
 #include <linux/notifier.h>
 #include <linux/security.h>
@@ -1102,14 +1103,55 @@ static int usbdev_release(struct inode *
 	return 0;
 }
 
+static void usbfs_blocking_completion(struct urb *urb)
+{
+	complete((struct completion *) urb->context);
+}
+
+/*
+ * Much like usb_start_wait_urb, but returns status separately from
+ * actual_length and uses a killable wait.
+ */
+static int usbfs_start_wait_urb(struct urb *urb, int timeout,
+		unsigned int *actlen)
+{
+	DECLARE_COMPLETION_ONSTACK(ctx);
+	unsigned long expire;
+	int rc;
+
+	urb->context = &ctx;
+	urb->complete = usbfs_blocking_completion;
+	*actlen = 0;
+	rc = usb_submit_urb(urb, GFP_KERNEL);
+	if (unlikely(rc))
+		return rc;
+
+	expire = (timeout ? msecs_to_jiffies(timeout) : MAX_SCHEDULE_TIMEOUT);
+	rc = wait_for_completion_killable_timeout(&ctx, expire);
+	if (rc <= 0) {
+		usb_kill_urb(urb);
+		*actlen = urb->actual_length;
+		if (urb->status != -ENOENT)
+			;	/* Completed before it was killed */
+		else if (rc < 0)
+			return -EINTR;
+		else
+			return -ETIMEDOUT;
+	}
+	*actlen = urb->actual_length;
+	return urb->status;
+}
+
 static int do_proc_control(struct usb_dev_state *ps,
 		struct usbdevfs_ctrltransfer *ctrl)
 {
 	struct usb_device *dev = ps->dev;
 	unsigned int tmo;
 	unsigned char *tbuf;
-	unsigned wLength;
+	unsigned wLength, actlen;
 	int i, pipe, ret;
+	struct urb *urb = NULL;
+	struct usb_ctrlrequest *dr = NULL;
 
 	ret = check_ctrlrecip(ps, ctrl->bRequestType, ctrl->bRequest,
 			      ctrl->wIndex);
@@ -1122,51 +1164,63 @@ static int do_proc_control(struct usb_de
 			sizeof(struct usb_ctrlrequest));
 	if (ret)
 		return ret;
+
+	ret = -ENOMEM;
 	tbuf = (unsigned char *)__get_free_page(GFP_KERNEL);
-	if (!tbuf) {
-		ret = -ENOMEM;
+	if (!tbuf)
 		goto done;
-	}
+	urb = usb_alloc_urb(0, GFP_NOIO);
+	if (!urb)
+		goto done;
+	dr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_NOIO);
+	if (!dr)
+		goto done;
+
+	dr->bRequestType = ctrl->bRequestType;
+	dr->bRequest = ctrl->bRequest;
+	dr->wValue = cpu_to_le16(ctrl->wValue);
+	dr->wIndex = cpu_to_le16(ctrl->wIndex);
+	dr->wLength = cpu_to_le16(ctrl->wLength);
+
 	tmo = ctrl->timeout;
 	snoop(&dev->dev, "control urb: bRequestType=%02x "
 		"bRequest=%02x wValue=%04x "
 		"wIndex=%04x wLength=%04x\n",
 		ctrl->bRequestType, ctrl->bRequest, ctrl->wValue,
 		ctrl->wIndex, ctrl->wLength);
-	if ((ctrl->bRequestType & USB_DIR_IN) && ctrl->wLength) {
+
+	if ((ctrl->bRequestType & USB_DIR_IN) && wLength) {
 		pipe = usb_rcvctrlpipe(dev, 0);
-		snoop_urb(dev, NULL, pipe, ctrl->wLength, tmo, SUBMIT, NULL, 0);
+		usb_fill_control_urb(urb, dev, pipe, (unsigned char *) dr, tbuf,
+				wLength, NULL, NULL);
+		snoop_urb(dev, NULL, pipe, wLength, tmo, SUBMIT, NULL, 0);
 
 		usb_unlock_device(dev);
-		i = usb_control_msg(dev, pipe, ctrl->bRequest,
-				    ctrl->bRequestType, ctrl->wValue, ctrl->wIndex,
-				    tbuf, ctrl->wLength, tmo);
+		i = usbfs_start_wait_urb(urb, tmo, &actlen);
 		usb_lock_device(dev);
-		snoop_urb(dev, NULL, pipe, max(i, 0), min(i, 0), COMPLETE,
-			  tbuf, max(i, 0));
-		if ((i > 0) && ctrl->wLength) {
-			if (copy_to_user(ctrl->data, tbuf, i)) {
+		snoop_urb(dev, NULL, pipe, actlen, i, COMPLETE, tbuf, actlen);
+		if (!i && actlen) {
+			if (copy_to_user(ctrl->data, tbuf, actlen)) {
 				ret = -EFAULT;
-				goto done;
+				goto recv_fault;
 			}
 		}
 	} else {
-		if (ctrl->wLength) {
-			if (copy_from_user(tbuf, ctrl->data, ctrl->wLength)) {
+		if (wLength) {
+			if (copy_from_user(tbuf, ctrl->data, wLength)) {
 				ret = -EFAULT;
 				goto done;
 			}
 		}
 		pipe = usb_sndctrlpipe(dev, 0);
-		snoop_urb(dev, NULL, pipe, ctrl->wLength, tmo, SUBMIT,
-			tbuf, ctrl->wLength);
+		usb_fill_control_urb(urb, dev, pipe, (unsigned char *) dr, tbuf,
+				wLength, NULL, NULL);
+		snoop_urb(dev, NULL, pipe, wLength, tmo, SUBMIT, tbuf, wLength);
 
 		usb_unlock_device(dev);
-		i = usb_control_msg(dev, pipe, ctrl->bRequest,
-				    ctrl->bRequestType, ctrl->wValue, ctrl->wIndex,
-				    tbuf, ctrl->wLength, tmo);
+		i = usbfs_start_wait_urb(urb, tmo, &actlen);
 		usb_lock_device(dev);
-		snoop_urb(dev, NULL, pipe, max(i, 0), min(i, 0), COMPLETE, NULL, 0);
+		snoop_urb(dev, NULL, pipe, actlen, i, COMPLETE, NULL, 0);
 	}
 	if (i < 0 && i != -EPIPE) {
 		dev_printk(KERN_DEBUG, &dev->dev, "usbfs: USBDEVFS_CONTROL "
@@ -1174,8 +1228,15 @@ static int do_proc_control(struct usb_de
 			   current->comm, ctrl->bRequestType, ctrl->bRequest,
 			   ctrl->wLength, i);
 	}
-	ret = i;
+	ret = (i < 0 ? i : actlen);
+
+ recv_fault:
+	/* Linger a bit, prior to the next control message. */
+	if (dev->quirks & USB_QUIRK_DELAY_CTRL_MSG)
+		msleep(200);
  done:
+	kfree(dr);
+	usb_free_urb(urb);
 	free_page((unsigned long) tbuf);
 	usbfs_decrease_memory_usage(PAGE_SIZE + sizeof(struct urb) +
 			sizeof(struct usb_ctrlrequest));
@@ -1195,10 +1256,11 @@ static int do_proc_bulk(struct usb_dev_s
 		struct usbdevfs_bulktransfer *bulk)
 {
 	struct usb_device *dev = ps->dev;
-	unsigned int tmo, len1, pipe;
-	int len2;
+	unsigned int tmo, len1, len2, pipe;
 	unsigned char *tbuf;
 	int i, ret;
+	struct urb *urb = NULL;
+	struct usb_host_endpoint *ep;
 
 	ret = findintfep(ps->dev, bulk->ep);
 	if (ret < 0)
@@ -1206,14 +1268,17 @@ static int do_proc_bulk(struct usb_dev_s
 	ret = checkintf(ps, ret);
 	if (ret)
 		return ret;
+
+	len1 = bulk->len;
+	if (len1 < 0 || len1 >= (INT_MAX - sizeof(struct urb)))
+		return -EINVAL;
+
 	if (bulk->ep & USB_DIR_IN)
 		pipe = usb_rcvbulkpipe(dev, bulk->ep & 0x7f);
 	else
 		pipe = usb_sndbulkpipe(dev, bulk->ep & 0x7f);
-	if (!usb_maxpacket(dev, pipe, !(bulk->ep & USB_DIR_IN)))
-		return -EINVAL;
-	len1 = bulk->len;
-	if (len1 >= (INT_MAX - sizeof(struct urb)))
+	ep = usb_pipe_endpoint(dev, pipe);
+	if (!ep || !usb_endpoint_maxp(&ep->desc))
 		return -EINVAL;
 	ret = usbfs_increase_memory_usage(len1 + sizeof(struct urb));
 	if (ret)
@@ -1223,17 +1288,29 @@ static int do_proc_bulk(struct usb_dev_s
 	 * len1 can be almost arbitrarily large.  Don't WARN if it's
 	 * too big, just fail the request.
 	 */
+	ret = -ENOMEM;
 	tbuf = kmalloc(len1, GFP_KERNEL | __GFP_NOWARN);
-	if (!tbuf) {
-		ret = -ENOMEM;
+	if (!tbuf)
 		goto done;
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb)
+		goto done;
+
+	if ((ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
+			USB_ENDPOINT_XFER_INT) {
+		pipe = (pipe & ~(3 << 30)) | (PIPE_INTERRUPT << 30);
+		usb_fill_int_urb(urb, dev, pipe, tbuf, len1,
+				NULL, NULL, ep->desc.bInterval);
+	} else {
+		usb_fill_bulk_urb(urb, dev, pipe, tbuf, len1, NULL, NULL);
 	}
+
 	tmo = bulk->timeout;
 	if (bulk->ep & 0x80) {
 		snoop_urb(dev, NULL, pipe, len1, tmo, SUBMIT, NULL, 0);
 
 		usb_unlock_device(dev);
-		i = usb_bulk_msg(dev, pipe, tbuf, len1, &len2, tmo);
+		i = usbfs_start_wait_urb(urb, tmo, &len2);
 		usb_lock_device(dev);
 		snoop_urb(dev, NULL, pipe, len2, i, COMPLETE, tbuf, len2);
 
@@ -1253,12 +1330,13 @@ static int do_proc_bulk(struct usb_dev_s
 		snoop_urb(dev, NULL, pipe, len1, tmo, SUBMIT, tbuf, len1);
 
 		usb_unlock_device(dev);
-		i = usb_bulk_msg(dev, pipe, tbuf, len1, &len2, tmo);
+		i = usbfs_start_wait_urb(urb, tmo, &len2);
 		usb_lock_device(dev);
 		snoop_urb(dev, NULL, pipe, len2, i, COMPLETE, NULL, 0);
 	}
 	ret = (i < 0 ? i : len2);
  done:
+	usb_free_urb(urb);
 	kfree(tbuf);
 	usbfs_decrease_memory_usage(len1 + sizeof(struct urb));
 	return ret;
