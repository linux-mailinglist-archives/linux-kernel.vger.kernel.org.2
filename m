Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCAF633A492
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 12:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbhCNLix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 07:38:53 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50455 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhCNLij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 07:38:39 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 12EBcWlM046996;
        Sun, 14 Mar 2021 20:38:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp);
 Sun, 14 Mar 2021 20:38:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 12EBcQxF046623
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 14 Mar 2021 20:38:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 0/6] usbip fixes to crashes found by syzbot
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     valentina.manea.m@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1615171203.git.skhan@linuxfoundation.org>
 <YEkQ4qS7tkwmjzDn@kroah.com>
 <5baf6b94-72c4-6e69-65a5-35c5cfb8ca0e@i-love.sakura.ne.jp>
 <YEoTw7CoK7Ob0YR+@kroah.com>
 <8dc1e893-4338-90ff-ea61-de727cad1d11@i-love.sakura.ne.jp>
 <afd1341b-2ed1-f781-d6c8-6064fea3aeb8@i-love.sakura.ne.jp>
 <192bdb07-da84-ce96-2e25-7c0df749940a@i-love.sakura.ne.jp>
Message-ID: <9e089560-388a-a82d-4841-8092578b9d5d@i-love.sakura.ne.jp>
Date:   Sun, 14 Mar 2021 20:38:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <192bdb07-da84-ce96-2e25-7c0df749940a@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/03/13 9:48, Tetsuo Handa wrote:
> On 2021/03/12 14:44, Tetsuo Handa wrote:
>> And what you are missing in your [PATCH 4,5,6/6] is
>>
>>   diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
>>   index c4457026d5ad..3c64bd06ab53 100644
>>   --- a/drivers/usb/usbip/vhci_sysfs.c
>>   +++ b/drivers/usb/usbip/vhci_sysfs.c
>>   @@ -423,6 +423,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
>>           /* end the lock */
>>   
>>           wake_up_process(vdev->ud.tcp_rx);
>>   +       schedule_timeout_uninterruptible(HZ); // Consider being preempted here.
>>           wake_up_process(vdev->ud.tcp_tx);
>>   
>>           rh_port_connect(vdev, speed);
>>
>> . wake_up_process(tcp_tx) can call vhci_shutdown_connection() before wake_up_process(tcp_tx) is called.
> 
> wake_up_process(tcp_rx) can call vhci_shutdown_connection() before wake_up_process(tcp_tx) is called.
> 
>> Since vhci_shutdown_connection() destroys tcp_tx thread and releases tcp_tx memory via kthread_stop_put(tcp_tx),
>> wake_up_process(tcp_tx) will access already freed memory. Your patch converted "NULL pointer dereference caused by
>> failing to call kthread_stop_put(tcp_tx)" into "use after free caused by succeeding to call kthread_stop_put(tcp_tx)".
>>
> 
> And note that
> 
>   diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
>   index c4457026d5ad..0e1a81d4632c 100644
>   --- a/drivers/usb/usbip/vhci_sysfs.c
>   +++ b/drivers/usb/usbip/vhci_sysfs.c
>   @@ -422,11 +422,11 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
>           spin_unlock_irqrestore(&vhci->lock, flags);
>           /* end the lock */
>   
>   -       wake_up_process(vdev->ud.tcp_rx);
>   -       wake_up_process(vdev->ud.tcp_tx);
>   -
>           rh_port_connect(vdev, speed);
>   
>   +       wake_up_process(vdev->ud.tcp_tx);
>   +       wake_up_process(vdev->ud.tcp_rx);
>   +
>           return count;
>    }
>    static DEVICE_ATTR_WO(attach);
> 
> is as well not sufficient, for you are still missing

Well, since tx thread can as well call usbip_event_add(USBIP_EH_SHUTDOWN), reversing
the order of wake_up_process(tcp_tx) and wake_up_process(tcp_rx) will not help.

> 
>   diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
>   index c4457026d5ad..c958f89a9196 100644
>   --- a/drivers/usb/usbip/vhci_sysfs.c
>   +++ b/drivers/usb/usbip/vhci_sysfs.c
>   @@ -422,11 +422,13 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
>           spin_unlock_irqrestore(&vhci->lock, flags);
>           /* end the lock */
>   
>   -       wake_up_process(vdev->ud.tcp_rx);
>   -       wake_up_process(vdev->ud.tcp_tx);
>   +       schedule_timeout_uninterruptible(HZ); // Consider being preempted here.
>   
>           rh_port_connect(vdev, speed);
>   
>   +       wake_up_process(vdev->ud.tcp_tx);
>   +       wake_up_process(vdev->ud.tcp_rx);
>   +
>           return count;
>    }
>    static DEVICE_ATTR_WO(attach);
> 
> because vhci_port_disconnect() from detach_store() can call usbip_event_add(&vdev->ud, VDEV_EVENT_DOWN)
> (same use after free bug regarding tcp_tx and tcp_rx) as soon as all shared states are set up and
> spinlocks are released.
> 
> What you had better consider first is how to protect event_handler()/usbip_sockfd_store()/attach_store()/detach_store() functions
>  from concurrent calls. Please respond to https://lkml.kernel.org/r/3dab66dc-2981-bc88-a370-4b3178dfd390@i-love.sakura.ne.jp
> before you try to make further changes.
> 

After all, I believe that there is no choice but introduce a mutex for serialization.

Greg, please pick up https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/commit/?h=usbip_test&id=f345de0d2e51a20a2a1c30fc22fa1527670d2095
and below patch.

From e0579aa776e4a3568c06f767c193d2204b64679d Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sun, 14 Mar 2021 20:24:16 +0900
Subject: [PATCH v5] usb: usbip: serialize attach/detach operations

The root problem syzbot has found [1] is that usbip module is not using
serialization between attach/detach operations and event_handler().
This results in the following race windows.

  (1) two userspace processes can perform attach operation on the same
      device by writing the same content to the same attach interface
      file

  (2) one userspace process can perform detach operation on a device by
      writing to detach interface file while the other userspace process
      is performing attach operation on that device by writing to attach
      interface file

  (3) event_handler() kernel workqueue thread can perform detach operation
      on a device while some userspace process is still performing attach
      operation on that device

What syzbot is reporting is (3), and what commits 46613c9dfa964c0c,
718ad9693e365612 and 9380afd6df70e24e did not take into account is

  As soon as one side of {tx,rx} kernel threads starts from attach
  operation, that kernel thread is allowed to call
  usbip_event_add(USBIP_EH_SHUTDOWN) which in turn allows event_handler()
  to call kthread_stop_put() on both {tx,rx} kernel threads via
  ud->eh_ops.shutdown(ud), before the other side of {tx,rx} kernel threads
  starts from attach operation.

which will be reported as either NULL pointer dereference or use-after-free
bug on the other side of {tx,rx} kernel threads.

Since this race window cannot be closed without introducing serialization,
this patch introduces usbip_event_mutex for serializing attach/detach
operations and event_handler().

[1] https://syzkaller.appspot.com/bug?extid=95ce4b142579611ef0a9

Reported-by: syzbot <syzbot+95ce4b142579611ef0a9@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 46613c9dfa964c0c ("usbip: fix vudc usbip_sockfd_store races leading to gpf")
Fixes: 718ad9693e365612 ("usbip: fix vhci_hcd attach_store() races leading to gpf")
Fixes: 9380afd6df70e24e ("usbip: fix stub_dev usbip_sockfd_store() races leading to gpf")
---
 drivers/usb/usbip/stub_dev.c     | 15 +++++++++++++--
 drivers/usb/usbip/usbip_common.h |  2 ++
 drivers/usb/usbip/usbip_event.c  | 15 +++++++++++++++
 drivers/usb/usbip/vhci_sysfs.c   | 30 ++++++++++++++++++++++++++----
 drivers/usb/usbip/vudc_sysfs.c   | 16 +++++++++++++---
 5 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index 8f1de1fbbeed..79ebc9795b4a 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -39,8 +39,8 @@ static DEVICE_ATTR_RO(usbip_status);
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
@@ -132,6 +132,17 @@ static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *a
 	spin_unlock_irq(&sdev->ud.lock);
 	return -EINVAL;
 }
+static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	ssize_t ret = usbip_event_lock_killable();
+
+	if (ret)
+		return ret;
+	ret = __usbip_sockfd_store(dev, attr, buf, count);
+	usbip_event_unlock();
+	return ret;
+}
 static DEVICE_ATTR_WO(usbip_sockfd);
 
 static struct attribute *usbip_attrs[] = {
diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
index d60ce17d3dd2..ad7de3773e06 100644
--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -326,6 +326,8 @@ void usbip_stop_eh(struct usbip_device *ud);
 void usbip_event_add(struct usbip_device *ud, unsigned long event);
 int usbip_event_happened(struct usbip_device *ud);
 int usbip_in_eh(struct task_struct *task);
+int usbip_event_lock_killable(void);
+void usbip_event_unlock(void);
 
 static inline int interface_to_busnum(struct usb_interface *interface)
 {
diff --git a/drivers/usb/usbip/usbip_event.c b/drivers/usb/usbip/usbip_event.c
index 5d88917c9631..e05b858f346d 100644
--- a/drivers/usb/usbip/usbip_event.c
+++ b/drivers/usb/usbip/usbip_event.c
@@ -58,6 +58,19 @@ static struct usbip_device *get_event(void)
 }
 
 static struct task_struct *worker_context;
+static DEFINE_MUTEX(usbip_event_mutex);
+
+int usbip_event_lock_killable(void)
+{
+	return mutex_lock_killable(&usbip_event_mutex);
+}
+EXPORT_SYMBOL_GPL(usbip_event_lock_killable);
+
+void usbip_event_unlock(void)
+{
+	mutex_unlock(&usbip_event_mutex);
+}
+EXPORT_SYMBOL_GPL(usbip_event_unlock);
 
 static void event_handler(struct work_struct *work)
 {
@@ -68,6 +81,7 @@ static void event_handler(struct work_struct *work)
 	}
 
 	while ((ud = get_event()) != NULL) {
+		mutex_lock(&usbip_event_mutex);
 		usbip_dbg_eh("pending event %lx\n", ud->event);
 
 		/*
@@ -91,6 +105,7 @@ static void event_handler(struct work_struct *work)
 			unset_event(ud, USBIP_EH_UNUSABLE);
 		}
 
+		mutex_unlock(&usbip_event_mutex);
 		wake_up(&ud->eh_waitq);
 	}
 }
diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index c4b4256e5dad..d06087e4e29b 100644
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
+	ssize_t ret = usbip_event_lock_killable();
+
+	if (ret)
+		return ret;
+	ret = __detach_store(dev, attr, buf, count);
+	usbip_event_unlock();
+	return ret;
+}
 static DEVICE_ATTR_WO(detach);
 
 static int valid_args(__u32 *pdev_nr, __u32 *rhport,
@@ -300,8 +311,8 @@ static int valid_args(__u32 *pdev_nr, __u32 *rhport,
  *
  * write() returns 0 on success, else negative errno.
  */
-static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
+static ssize_t __attach_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
 {
 	struct socket *socket;
 	int sockfd = 0;
@@ -425,6 +436,17 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 
 	return count;
 }
+static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	ssize_t ret = usbip_event_lock_killable();
+
+	if (ret)
+		return ret;
+	ret = __attach_store(dev, attr, buf, count);
+	usbip_event_unlock();
+	return ret;
+}
 static DEVICE_ATTR_WO(attach);
 
 #define MAX_STATUS_NAME 16
diff --git a/drivers/usb/usbip/vudc_sysfs.c b/drivers/usb/usbip/vudc_sysfs.c
index a3ec39fc6177..3e3e4ef298d2 100644
--- a/drivers/usb/usbip/vudc_sysfs.c
+++ b/drivers/usb/usbip/vudc_sysfs.c
@@ -90,9 +90,8 @@ static ssize_t dev_desc_read(struct file *file, struct kobject *kobj,
 }
 static BIN_ATTR_RO(dev_desc, sizeof(struct usb_device_descriptor));
 
-static ssize_t usbip_sockfd_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *in, size_t count)
+static ssize_t __usbip_sockfd_store(struct device *dev, struct device_attribute *attr,
+				    const char *in, size_t count)
 {
 	struct vudc *udc = (struct vudc *) dev_get_drvdata(dev);
 	int rv;
@@ -219,6 +218,17 @@ static ssize_t usbip_sockfd_store(struct device *dev,
 
 	return ret;
 }
+static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *attr,
+				  const char *in, size_t count)
+{
+	ssize_t ret = usbip_event_lock_killable();
+
+	if (ret)
+		return ret;
+	ret = __usbip_sockfd_store(dev, attr, in, count);
+	usbip_event_unlock();
+	return ret;
+}
 static DEVICE_ATTR_WO(usbip_sockfd);
 
 static ssize_t usbip_status_show(struct device *dev,
-- 
2.18.4
