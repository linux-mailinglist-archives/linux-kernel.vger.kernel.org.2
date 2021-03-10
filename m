Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23E1333A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 11:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhCJKif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 05:38:35 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57347 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhCJKiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 05:38:25 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 12AAcGmh035070;
        Wed, 10 Mar 2021 19:38:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Wed, 10 Mar 2021 19:38:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 12AAcGvw035064
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 10 Mar 2021 19:38:16 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 4/6] usbip: fix stub_dev usbip_sockfd_store() races
 leading to gpf
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        valentina.manea.m@gmail.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1615171203.git.skhan@linuxfoundation.org>
 <268a0668144d5ff36ec7d87fdfa90faf583b7ccc.1615171203.git.skhan@linuxfoundation.org>
 <05aed75a-4a81-ef59-fc4f-6007f18e7839@i-love.sakura.ne.jp>
 <5df3d221-9e78-4cbe-826b-81cbfc4d5888@i-love.sakura.ne.jp>
 <3305d1a1-12e2-087b-30f5-10f4bf8eaf83@linuxfoundation.org>
 <f8f5e763-da2d-b26f-c6a5-d345bbe55448@i-love.sakura.ne.jp>
 <30a1afb2-d5a4-40b2-385d-24a2bf110e92@linuxfoundation.org>
 <7b9465aa-213e-a513-d033-12c048df15d6@i-love.sakura.ne.jp>
 <05e8e744-0847-cde2-b978-0bfd7ef93a9f@linuxfoundation.org>
 <9653ae69-86f4-7608-ce97-4ec39b063ed2@i-love.sakura.ne.jp>
 <1edb9542-59c9-bbf6-9f16-99614605a800@linuxfoundation.org>
 <47dbbf10-368c-6e45-5eac-c57b75f7ae9c@i-love.sakura.ne.jp>
 <0e8d26dc-d99c-bcaa-1e95-0b5d0e0e535b@linuxfoundation.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <3dab66dc-2981-bc88-a370-4b3178dfd390@i-love.sakura.ne.jp>
Date:   Wed, 10 Mar 2021 19:38:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <0e8d26dc-d99c-bcaa-1e95-0b5d0e0e535b@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/03/10 11:07, Shuah Khan wrote:
> On 3/9/21 6:02 PM, Tetsuo Handa wrote:
>> On 2021/03/10 9:29, Shuah Khan wrote:
>>>> It is not a large grain lock. Since event_handler() is exclusively executed, this lock
>>>> does _NOT_ block event_handler() unless attach/detach operations run concurrently.
>>>>
>>>
>>> event handler queues the events. It shouldn't be blocked by attach
>>> and detach. The events could originate for various reasons during
>>> the host and vhci operations. I don't like using this lock for
>>> attach and detach.
>>
>> How can attach/detach deadlock event_handler()?
>> event_handler() calls e.g. vhci_shutdown_connection() via ud->eh_ops.shutdown(ud).
>> vhci_shutdown_connection() e.g. waits for termination of tx/rx threads via kthread_stop_put().
>> event_handler() is already blocked by detach operation.
>> How it can make situation worse to wait for creation of tx/rx threads in attach operation?
>>
> 
> event_lock shouldn't be held during event ops. usbip_event_add()
> uses it to add events. Protecting shutdown path needs a different
> approach.

I can't understand what you are talking about.

event_lock is defined as

  static DEFINE_SPINLOCK(event_lock);

in drivers/usb/usbip/usbip_event.c and usbip_event_add() uses it like

  spin_lock_irqsave(&event_lock, flags);
  spin_unlock_irqrestore(&event_lock, flags);

, but so what? I know event_lock spinlock cannot be taken when calling

  ud->eh_ops.shutdown(ud);
  ud->eh_ops.reset(ud);
  ud->eh_ops.unusable(ud);

in event_handler() because e.g. vhci_shutdown_connection() can sleep.

What my [PATCH v4 01/12] is suggesting is usbip_event_mutex which is defined as

  static DEFINE_MUTEX(usbip_event_mutex);

in drivers/usb/usbip/usbip_event.c and held when calling

  ud->eh_ops.shutdown(ud);
  ud->eh_ops.reset(ud);
  ud->eh_ops.unusable(ud);

in event_handler(). Since event_handler() is executed exclusively via
singlethreaded workqueue, "event_handler() holds usbip_event_mutex" itself
does not introduce a new lock dependency.

My question is, how holding usbip_event_mutex can cause deadlock if
usbip_sockfd_store()/attach_store()/detach_store() also hold usbip_event_mutex .

kthread_create() is essentially several kmalloc(GFP_KERNEL) where event_handler()
cannot interfere unless event_handler() serves as a memory reclaiming function.
My question again. What functions might sleep and hold locks other than
kthread_create() for tx/rx threads?

Your answer to my question (if you identified such dependency) will go into
patch shown bottom which replaces my [PATCH v4 01/12]-[PATCH v4 04/12] patches.

> 
> In any case, do you have comments on this patch which doesn't even
> touch vhci driver?

I'm just replying to your [PATCH 4/6] because all your [PATCH 4/6]-[PATCH 6/6]
patches have the same oversight.

> 
> I understand you are identifying additional race condition that
> the vhci patches in this series might not fix. That doesn't mean
> that these patches aren't valid.
> 
> Do you have any comments specific to the patches in this series?

Your [PATCH 5/6] is still racy regarding rh_port_connect() versus rh_port_disconnect().
As soon as you call wake_up_process(), rh_port_disconnect() can be called before
rh_port_connect() is called. Since you don't like serializing event_handler() and
usbip_sockfd_store()/attach_store()/detach_store() using usbip_event_mutex, my
patch shown below which uses attach_detach_lock mutex cannot close such race window.
Ideally, wake_up_process() should be deferred to after releasing attach_detach_lock,
but please answer to my question first.



From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 10 Mar 2021 18:31:54 +0900

syzbot is reporting a NULL pointer dereference at sock_sendmsg() [1], for
lack of serialization between attach_store() and event_handler() causes
vhci_shutdown_connection() to observe vdev->ud.tcp_tx == NULL while
vdev->ud.tcp_socket != NULL. Please read the reference link for details of
this race window.

While usbip module exclusively runs event_handler(), usbip module has never
thought the possibility that multiple userspace processes can concurrently
call usbip_sockfd_store()/attach_store()/detach_store(). As a result, there
is a TOCTTOU bug in these functions regarding ud->status value which can
result in similar crashes like [1].

Simplest way would be to run all of
event_handler()/usbip_sockfd_store()/attach_store()/detach_store() functions
exclusively using a global mutex. But Shuah Khan does not want to share a
global mutex between these functions, for ...[please fill in this part]... .

Therefore, this patch introduces a per-submodule local mutex which closes
race window within usbip_sockfd_store() and attach_store()/detach_store().

This local mutex cannot close race window between event_handler()
and usbip_sockfd_store()/attach_store()/detach_store(), for calling
wake_up_process() allows kernel thread to call
usbip_event_add(VDEV_EVENT_DOWN) and event_handler() will start
detach operation before this local mutex is released.
The race window via usbip_event_add(VDEV_EVENT_DOWN) from kernel thread
will be addressed by subsequent patches in this series, by splitting
kthread_get_run() into kthread_create() and wake_up_process(), and
deferring wake_up_process() to immediately before releasing this local
mutex.

[1] https://syzkaller.appspot.com/bug?extid=95ce4b142579611ef0a9

References: https://lkml.kernel.org/r/676d4518-0faa-9fab-15db-0db8d216d7fb@i-love.sakura.ne.jp

---
 drivers/usb/usbip/stub_dev.c   | 16 ++++++++++++++--
 drivers/usb/usbip/vhci_sysfs.c | 31 +++++++++++++++++++++++++++----
 drivers/usb/usbip/vudc_sysfs.c | 16 ++++++++++++++--
 3 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index 2305d425e6c9..66c8f2385f3a 100644
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
@@ -104,6 +104,18 @@ static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *a
 	spin_unlock_irq(&sdev->ud.lock);
 	return -EINVAL;
 }
+static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	static DEFINE_MUTEX(attach_detach_lock);
+	ssize_t ret = mutex_lock_killable(&attach_detach_lock);
+
+	if (ret)
+		return ret;
+	ret = __usbip_sockfd_store(dev, attr, buf, count);
+	mutex_unlock(&attach_detach_lock);
+	return ret;
+}
 static DEVICE_ATTR_WO(usbip_sockfd);
 
 static struct attribute *usbip_attrs[] = {
diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index 96e5371dc335..777aba9b9115 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -17,6 +17,7 @@
 #include "vhci.h"
 
 /* TODO: refine locking ?*/
+static DEFINE_MUTEX(attach_detach_lock);
 
 /*
  * output example:
@@ -225,8 +226,8 @@ static int valid_port(__u32 *pdev_nr, __u32 *rhport)
 	return 1;
 }
 
-static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
+static ssize_t __detach_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
 {
 	__u32 port = 0, pdev_nr = 0, rhport = 0;
 	struct usb_hcd *hcd;
@@ -263,6 +264,17 @@ static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
 
 	return count;
 }
+static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	ssize_t ret = mutex_lock_killable(&attach_detach_lock);
+
+	if (ret)
+		return ret;
+	ret = __detach_store(dev, attr, buf, count);
+	mutex_unlock(&attach_detach_lock);
+	return ret;
+}
 static DEVICE_ATTR_WO(detach);
 
 static int valid_args(__u32 *pdev_nr, __u32 *rhport,
@@ -300,8 +312,8 @@ static int valid_args(__u32 *pdev_nr, __u32 *rhport,
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
@@ -396,6 +408,17 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 
 	return count;
 }
+static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	ssize_t ret = mutex_lock_killable(&attach_detach_lock);
+
+	if (ret)
+		return ret;
+	ret = __attach_store(dev, attr, buf, count);
+	mutex_unlock(&attach_detach_lock);
+	return ret;
+}
 static DEVICE_ATTR_WO(attach);
 
 #define MAX_STATUS_NAME 16
diff --git a/drivers/usb/usbip/vudc_sysfs.c b/drivers/usb/usbip/vudc_sysfs.c
index 100f680c572a..b14876dd2c0c 100644
--- a/drivers/usb/usbip/vudc_sysfs.c
+++ b/drivers/usb/usbip/vudc_sysfs.c
@@ -90,8 +90,8 @@ static ssize_t dev_desc_read(struct file *file, struct kobject *kobj,
 }
 static BIN_ATTR_RO(dev_desc, sizeof(struct usb_device_descriptor));
 
-static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *attr,
-		     const char *in, size_t count)
+static ssize_t __usbip_sockfd_store(struct device *dev, struct device_attribute *attr,
+				    const char *in, size_t count)
 {
 	struct vudc *udc = (struct vudc *) dev_get_drvdata(dev);
 	int rv;
@@ -184,6 +184,18 @@ static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *a
 
 	return ret;
 }
+static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *attr,
+				  const char *in, size_t count)
+{
+	static DEFINE_MUTEX(attach_detach_lock);
+	ssize_t ret = mutex_lock_killable(&attach_detach_lock);
+
+	if (ret)
+		return ret;
+	ret = __usbip_sockfd_store(dev, attr, in, count);
+	mutex_unlock(&attach_detach_lock);
+	return ret;
+}
 static DEVICE_ATTR_WO(usbip_sockfd);
 
 static ssize_t usbip_status_show(struct device *dev,
-- 
2.18.4

