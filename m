Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B3A31AAB4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 11:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhBMKDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 05:03:20 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:52339 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhBMKDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 05:03:12 -0500
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 11DA2NNd038326;
        Sat, 13 Feb 2021 19:02:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp);
 Sat, 13 Feb 2021 19:02:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 11DA2N4i038323
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 13 Feb 2021 19:02:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: general protection fault in tomoyo_socket_sendmsg_permission
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        syzkaller-bugs@googlegroups.com, Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+95ce4b142579611ef0a9@syzkaller.appspotmail.com>
References: <000000000000647eff05b3f7e0d4@google.com>
 <5f71e0c1-d387-6d72-d8e4-edb11cf57f72@linuxfoundation.org>
 <ea4028b7-53f2-aeaf-76e7-69874efcdec5@I-love.SAKURA.ne.jp>
 <2b70d360-a293-4acb-ea6c-2badda5e8b8b@linuxfoundation.org>
 <9bdd3f10-bddb-bd87-d7ad-b4b706477006@i-love.sakura.ne.jp>
 <6b8da36f-a994-7604-77f4-52e29434605f@linuxfoundation.org>
 <5f9ec159-77d8-ffba-21d1-2810e059f998@i-love.sakura.ne.jp>
 <a06093f1-22b3-7d72-bc6c-f99f4e0d0de9@linuxfoundation.org>
 <40617d66-1334-13a0-de9b-bd7cc1155ce5@i-love.sakura.ne.jp>
 <43d8d6bf-53f3-11e6-894d-c257f7f4bd07@linuxfoundation.org>
 <4368349b-fc0c-6da3-a502-2733f953d271@i-love.sakura.ne.jp>
 <92a4c6ae-172d-91cb-b89e-8eb857fdfb3a@linuxfoundation.org>
 <d177302a-3050-41db-cf44-6d614fd0c3a0@i-love.sakura.ne.jp>
 <e5cb1f77-cd4b-9d74-4f28-d613d5478704@linuxfoundation.org>
 <954bd943-8b55-36c8-9cba-a35a03213b2c@i-love.sakura.ne.jp>
 <99d7fba8-3472-3d6e-e825-9c9c115b5776@i-love.sakura.ne.jp>
 <4d49e8fd-f89f-efa7-5583-a6ca2272c67a@linuxfoundation.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <19685ee2-1769-ad9c-941f-53e7e72ff235@i-love.sakura.ne.jp>
Date:   Sat, 13 Feb 2021 19:02:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <4d49e8fd-f89f-efa7-5583-a6ca2272c67a@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, will you queue https://lkml.kernel.org/r/20210205135707.4574-1-penguin-kernel@I-love.SAKURA.ne.jp (which can
close a report which is wasting syzbot's resource with 5300+ crashes) for 5.12 ? The change shown below will be
too large to test before merge window for 5.12 opens. 

The patch for fixing "general protection fault in tomoyo_socket_sendmsg_permission" will kill kthread_get_run().
Closing frequently crashing bug now is the better.

On 2021/02/11 22:40, Tetsuo Handa wrote:
> I guess that we need to serialize attach operation and reset/detach operations, for
> it seems there is a race window that might result in "general protection fault in
> tomoyo_socket_sendmsg_permission". Details follows...

Here is untested diff that is expected to be complete.

(1) Handle kthread_create() failure (which avoids "KASAN: null-ptr-deref Write in vhci_shutdown_connection")
    by grouping socket lookup, SOCK_STREAM check and kthread_get_run() into usbip_prepare_threads() function.

(2) Serialize usbip_sockfd_store(), detach_store(), attach_store(), usbip_sockfd_store() and
    ud->eh_ops.shutdown()/ud->eh_ops.reset()/ud->eh_ops.unusable() operations using usbip_store_mutex mutex
    (which avoids "general protection fault in tomoyo_socket_sendmsg_permission").

(3) Don't reset ud->tcp_socket to NULL in vhci_device_reset(). Since tx_thread/rx_thread depends on
    ud->tcp_socket != NULL whereas tcp_socket and tx_thread/rx_thread are assigned at the same time,
    it is never safe to reset only ud->tcp_socket from ud->eh_ops.reset(). And actually nobody is
    calling ud->eh_ops.reset() without ud->eh_ops.shutdown().

(4) usbip_sockfd_store() must perform {sdev,udc}->ud.status != SDEV_ST_AVAILABLE && {sdev,udc}->ud.status = SDEV_ST_USED
    exclusively, or multiple tx_thread/rx_thread can be created when concurrently called. Although (2) will already
    serialize this action, (1) will make it possible to perform within one spinlock section.

 drivers/usb/usbip/stub_dev.c     | 56 ++++++++++++++++++--------------
 drivers/usb/usbip/usbip_common.c | 55 +++++++++++++++++++++++++++++++
 drivers/usb/usbip/usbip_common.h | 13 ++++++++
 drivers/usb/usbip/usbip_event.c  |  9 +++++
 drivers/usb/usbip/vhci_hcd.c     |  7 +---
 drivers/usb/usbip/vhci_sysfs.c   | 50 ++++++++++++++++++++--------
 drivers/usb/usbip/vudc_sysfs.c   | 50 ++++++++++++++++------------
 7 files changed, 175 insertions(+), 65 deletions(-)

diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index 2305d425e6c9..522d58826049 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -39,12 +39,11 @@ static DEVICE_ATTR_RO(usbip_status);
  * is used to transfer usbip requests by kernel threads. -1 is a magic number
  * by which usbip connection is finished.
  */
-static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
+static ssize_t __usbip_sockfd_store(struct device *dev, struct device_attribute *attr,
+				    const char *buf, size_t count)
 {
 	struct stub_device *sdev = dev_get_drvdata(dev);
 	int sockfd = 0;
-	struct socket *socket;
 	int rv;
 
 	if (!sdev) {
@@ -57,7 +56,12 @@ static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *a
 		return -EINVAL;
 
 	if (sockfd != -1) {
-		int err;
+		struct usbip_thread_info uti;
+		int err = usbip_prepare_threads(&uti, &sdev->ud, sockfd,
+						stub_tx_loop, "stub_tx", stub_rx_loop, "stub_rx");
+
+		if (err)
+			return err;
 
 		dev_info(dev, "stub up\n");
 
@@ -65,44 +69,46 @@ static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *a
 
 		if (sdev->ud.status != SDEV_ST_AVAILABLE) {
 			dev_err(dev, "not ready\n");
-			goto err;
+			spin_unlock_irq(&sdev->ud.lock);
+			usbip_unprepare_threads(&uti);
+			return -EINVAL;
 		}
 
-		socket = sockfd_lookup(sockfd, &err);
-		if (!socket)
-			goto err;
-
-		sdev->ud.tcp_socket = socket;
+		sdev->ud.tcp_socket = uti.tcp_socket;
 		sdev->ud.sockfd = sockfd;
-
-		spin_unlock_irq(&sdev->ud.lock);
-
-		sdev->ud.tcp_rx = kthread_get_run(stub_rx_loop, &sdev->ud,
-						  "stub_rx");
-		sdev->ud.tcp_tx = kthread_get_run(stub_tx_loop, &sdev->ud,
-						  "stub_tx");
-
-		spin_lock_irq(&sdev->ud.lock);
+		sdev->ud.tcp_rx = uti.tcp_rx;
+		sdev->ud.tcp_tx = uti.tcp_tx;
 		sdev->ud.status = SDEV_ST_USED;
 		spin_unlock_irq(&sdev->ud.lock);
 
+		wake_up_process(sdev->ud.tcp_rx);
+		wake_up_process(sdev->ud.tcp_tx);
 	} else {
 		dev_info(dev, "stub down\n");
 
 		spin_lock_irq(&sdev->ud.lock);
-		if (sdev->ud.status != SDEV_ST_USED)
-			goto err;
-
+		if (sdev->ud.status != SDEV_ST_USED) {
+			spin_unlock_irq(&sdev->ud.lock);
+			return -EINVAL;
+		}
 		spin_unlock_irq(&sdev->ud.lock);
 
 		usbip_event_add(&sdev->ud, SDEV_EVENT_DOWN);
 	}
 
 	return count;
+}
 
-err:
-	spin_unlock_irq(&sdev->ud.lock);
-	return -EINVAL;
+static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	ssize_t ret;
+
+	if (mutex_lock_killable(&usbip_store_mutex))
+		return -EINTR;
+	ret = __usbip_sockfd_store(dev, attr, buf, count);
+	mutex_unlock(&usbip_store_mutex);
+	return ret;
 }
 static DEVICE_ATTR_WO(usbip_sockfd);
 
diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
index 2ab99244bc31..f86e49fc89a7 100644
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -748,6 +748,61 @@ int usbip_recv_xbuff(struct usbip_device *ud, struct urb *urb)
 }
 EXPORT_SYMBOL_GPL(usbip_recv_xbuff);
 
+int usbip_prepare_threads(struct usbip_thread_info *uti,
+			  struct usbip_device *ud, int sockfd,
+			  int (*tx_fn)(void *data), const char *tx_name,
+			  int (*rx_fn)(void *data), const char *rx_name)
+{
+	int err;
+	struct socket *socket;
+	struct task_struct *tx;
+	struct task_struct *rx;
+
+	/* Extract socket from fd. */
+	socket = sockfd_lookup(sockfd, &err);
+	if (!socket)
+		return -EINVAL;
+	/* Verify that this is a stream socket. */
+	if (socket->type != SOCK_STREAM) {
+		err = -EINVAL;
+		goto out_socket;
+	}
+	/* Create threads for this socket. */
+	rx = kthread_create(rx_fn, ud, rx_name);
+	if (IS_ERR(rx)) {
+		err = PTR_ERR(rx);
+		goto out_socket;
+	}
+	tx = kthread_create(tx_fn, ud, tx_name);
+	if (IS_ERR(tx)) {
+		err = PTR_ERR(rx);
+		goto out_rx;
+	}
+	uti->tcp_socket = socket;
+	get_task_struct(rx);
+	uti->tcp_rx = rx;
+	get_task_struct(rx);
+	uti->tcp_tx = tx;
+	return 0;
+ out_rx:
+	kthread_stop(rx);
+ out_socket:
+	sockfd_put(socket);
+	return err;
+}
+EXPORT_SYMBOL_GPL(usbip_prepare_threads);
+
+void usbip_unprepare_threads(struct usbip_thread_info *uti)
+{
+	kthread_stop_put(uti->tcp_rx);
+	uti->tcp_rx = NULL;
+	kthread_stop_put(uti->tcp_rx);
+	uti->tcp_rx = NULL;
+	sockfd_put(uti->tcp_socket);
+	uti->tcp_socket = NULL;
+}
+EXPORT_SYMBOL_GPL(usbip_unprepare_threads);
+
 static int __init usbip_core_init(void)
 {
 	return usbip_init_eh();
diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
index 8be857a4fa13..fba1827e719b 100644
--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -309,6 +309,19 @@ void usbip_header_correct_endian(struct usbip_header *pdu, int send);
 struct usbip_iso_packet_descriptor*
 usbip_alloc_iso_desc_pdu(struct urb *urb, ssize_t *bufflen);
 
+struct usbip_thread_info {
+	struct socket *tcp_socket;
+	struct task_struct *tcp_tx;
+	struct task_struct *tcp_rx;
+};
+
+extern struct mutex usbip_store_mutex;
+int usbip_prepare_threads(struct usbip_thread_info *uti,
+			  struct usbip_device *ud, int sockfd,
+			  int (*tx_fn)(void *data), const char *tx_name,
+			  int (*rx_fn)(void *data), const char *rx_name);
+void usbip_unprepare_threads(struct usbip_thread_info *uti);
+
 /* some members of urb must be substituted before. */
 int usbip_recv_iso(struct usbip_device *ud, struct urb *urb);
 void usbip_pad_iso(struct usbip_device *ud, struct urb *urb);
diff --git a/drivers/usb/usbip/usbip_event.c b/drivers/usb/usbip/usbip_event.c
index 5d88917c9631..d4f7dd366102 100644
--- a/drivers/usb/usbip/usbip_event.c
+++ b/drivers/usb/usbip/usbip_event.c
@@ -19,6 +19,9 @@ struct usbip_event {
 static DEFINE_SPINLOCK(event_lock);
 static LIST_HEAD(event_list);
 
+DEFINE_MUTEX(usbip_store_mutex);
+EXPORT_SYMBOL_GPL(usbip_store_mutex);
+
 static void set_event(struct usbip_device *ud, unsigned long event)
 {
 	unsigned long flags;
@@ -75,19 +78,25 @@ static void event_handler(struct work_struct *work)
 		 * Shutdown the device.
 		 */
 		if (ud->event & USBIP_EH_SHUTDOWN) {
+			mutex_lock(&usbip_store_mutex);
 			ud->eh_ops.shutdown(ud);
+			mutex_unlock(&usbip_store_mutex);
 			unset_event(ud, USBIP_EH_SHUTDOWN);
 		}
 
 		/* Reset the device. */
 		if (ud->event & USBIP_EH_RESET) {
+			mutex_lock(&usbip_store_mutex);
 			ud->eh_ops.reset(ud);
+			mutex_unlock(&usbip_store_mutex);
 			unset_event(ud, USBIP_EH_RESET);
 		}
 
 		/* Mark the device as unusable. */
 		if (ud->event & USBIP_EH_UNUSABLE) {
+			mutex_lock(&usbip_store_mutex);
 			ud->eh_ops.unusable(ud);
+			mutex_unlock(&usbip_store_mutex);
 			unset_event(ud, USBIP_EH_UNUSABLE);
 		}
 
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 3209b5ddd30c..eaae6fa8cff4 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1072,12 +1072,7 @@ static void vhci_device_reset(struct usbip_device *ud)
 
 	usb_put_dev(vdev->udev);
 	vdev->udev = NULL;
-
-	if (ud->tcp_socket) {
-		sockfd_put(ud->tcp_socket);
-		ud->tcp_socket = NULL;
-		ud->sockfd = -1;
-	}
+	ud->sockfd = -1;
 	ud->status = VDEV_ST_NULL;
 
 	spin_unlock_irqrestore(&ud->lock, flags);
diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index be37aec250c2..5f282dc54626 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -225,8 +225,8 @@ static int valid_port(__u32 *pdev_nr, __u32 *rhport)
 	return 1;
 }
 
-static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
+static ssize_t __detach_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
 {
 	__u32 port = 0, pdev_nr = 0, rhport = 0;
 	struct usb_hcd *hcd;
@@ -263,6 +263,17 @@ static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
 
 	return count;
 }
+static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	ssize_t ret;
+
+	if (mutex_lock_killable(&usbip_store_mutex))
+		return -EINTR;
+	ret = __detach_store(dev, attr, buf, count);
+	mutex_unlock(&usbip_store_mutex);
+	return ret;
+}
 static DEVICE_ATTR_WO(detach);
 
 static int valid_args(__u32 *pdev_nr, __u32 *rhport,
@@ -300,10 +311,10 @@ static int valid_args(__u32 *pdev_nr, __u32 *rhport,
  *
  * write() returns 0 on success, else negative errno.
  */
-static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
+static ssize_t __attach_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
 {
-	struct socket *socket;
+	struct usbip_thread_info uti;
 	int sockfd = 0;
 	__u32 port = 0, pdev_nr = 0, rhport = 0, devid = 0, speed = 0;
 	struct usb_hcd *hcd;
@@ -347,10 +358,10 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 	else
 		vdev = &vhci->vhci_hcd_hs->vdev[rhport];
 
-	/* Extract socket from fd. */
-	socket = sockfd_lookup(sockfd, &err);
-	if (!socket)
-		return -EINVAL;
+	err = usbip_prepare_threads(&uti, &vdev->ud, sockfd,
+				    vhci_tx_loop, "vhci_tx", vhci_rx_loop, "vhci_rx");
+	if (err)
+		return err;
 
 	/* now need lock until setting vdev status as used */
 
@@ -363,7 +374,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 		spin_unlock(&vdev->ud.lock);
 		spin_unlock_irqrestore(&vhci->lock, flags);
 
-		sockfd_put(socket);
+		usbip_unprepare_threads(&uti);
 
 		dev_err(dev, "port %d already used\n", rhport);
 		/*
@@ -381,20 +392,33 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 	vdev->devid         = devid;
 	vdev->speed         = speed;
 	vdev->ud.sockfd     = sockfd;
-	vdev->ud.tcp_socket = socket;
+	vdev->ud.tcp_socket = uti.tcp_socket;
+	vdev->ud.tcp_rx     = uti.tcp_rx;
+	vdev->ud.tcp_rx     = uti.tcp_tx;
 	vdev->ud.status     = VDEV_ST_NOTASSIGNED;
 
 	spin_unlock(&vdev->ud.lock);
 	spin_unlock_irqrestore(&vhci->lock, flags);
 	/* end the lock */
 
-	vdev->ud.tcp_rx = kthread_get_run(vhci_rx_loop, &vdev->ud, "vhci_rx");
-	vdev->ud.tcp_tx = kthread_get_run(vhci_tx_loop, &vdev->ud, "vhci_tx");
+	wake_up_process(vdev->ud.tcp_rx);
+	wake_up_process(vdev->ud.tcp_tx);
 
 	rh_port_connect(vdev, speed);
 
 	return count;
 }
+static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	ssize_t ret;
+
+	if (mutex_lock_killable(&usbip_store_mutex))
+		return -EINTR;
+	ret = __attach_store(dev, attr, buf, count);
+	mutex_unlock(&usbip_store_mutex);
+	return ret;
+}
 static DEVICE_ATTR_WO(attach);
 
 #define MAX_STATUS_NAME 16
diff --git a/drivers/usb/usbip/vudc_sysfs.c b/drivers/usb/usbip/vudc_sysfs.c
index 100f680c572a..de5df1c7f32f 100644
--- a/drivers/usb/usbip/vudc_sysfs.c
+++ b/drivers/usb/usbip/vudc_sysfs.c
@@ -90,14 +90,13 @@ static ssize_t dev_desc_read(struct file *file, struct kobject *kobj,
 }
 static BIN_ATTR_RO(dev_desc, sizeof(struct usb_device_descriptor));
 
-static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *attr,
-		     const char *in, size_t count)
+static ssize_t __usbip_sockfd_store(struct device *dev, struct device_attribute *attr,
+				    const char *in, size_t count)
 {
 	struct vudc *udc = (struct vudc *) dev_get_drvdata(dev);
 	int rv;
 	int sockfd = 0;
-	int err;
-	struct socket *socket;
+	struct usbip_thread_info uti = { };
 	unsigned long flags;
 	int ret;
 
@@ -109,6 +108,14 @@ static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *a
 		dev_err(dev, "no device");
 		return -ENODEV;
 	}
+
+	if (sockfd != -1) {
+		ret = usbip_prepare_threads(&uti, &udc->ud, sockfd,
+					    v_tx_loop, "vudc_tx", v_rx_loop, "vudc_rx");
+		if (ret)
+			return ret;
+	}
+
 	spin_lock_irqsave(&udc->lock, flags);
 	/* Don't export what we don't have */
 	if (!udc->driver || !udc->pullup) {
@@ -130,28 +137,17 @@ static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *a
 			ret = -EINVAL;
 			goto unlock_ud;
 		}
-
-		socket = sockfd_lookup(sockfd, &err);
-		if (!socket) {
-			dev_err(dev, "failed to lookup sock");
-			ret = -EINVAL;
-			goto unlock_ud;
-		}
-
-		udc->ud.tcp_socket = socket;
-
+		udc->ud.tcp_socket = uti.tcp_socket;
+		udc->ud.tcp_rx = uti.tcp_rx;
+		udc->ud.tcp_tx = uti.tcp_tx;
+		udc->ud.status = SDEV_ST_USED;
 		spin_unlock_irq(&udc->ud.lock);
 		spin_unlock_irqrestore(&udc->lock, flags);
 
-		udc->ud.tcp_rx = kthread_get_run(&v_rx_loop,
-						    &udc->ud, "vudc_rx");
-		udc->ud.tcp_tx = kthread_get_run(&v_tx_loop,
-						    &udc->ud, "vudc_tx");
+		wake_up_process(udc->ud.tcp_rx);
+		wake_up_process(udc->ud.tcp_tx);
 
 		spin_lock_irqsave(&udc->lock, flags);
-		spin_lock_irq(&udc->ud.lock);
-		udc->ud.status = SDEV_ST_USED;
-		spin_unlock_irq(&udc->ud.lock);
 
 		ktime_get_ts64(&udc->start_time);
 		v_start_timer(udc);
@@ -181,7 +177,19 @@ static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *a
 	spin_unlock_irq(&udc->ud.lock);
 unlock:
 	spin_unlock_irqrestore(&udc->lock, flags);
+	if (uti.tcp_socket)
+		usbip_unprepare_threads(&uti);
+	return ret;
+}
+static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *attr,
+				  const char *in, size_t count)
+{
+	ssize_t ret;
 
+	if (mutex_lock_killable(&usbip_store_mutex))
+		return -EINTR;
+	ret = __usbip_sockfd_store(dev, attr, in, count);
+	mutex_unlock(&usbip_store_mutex);
 	return ret;
 }
 static DEVICE_ATTR_WO(usbip_sockfd);
-- 
2.18.4


