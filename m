Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99336380939
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhENMNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:13:17 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54638 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbhENMNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:13:15 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id 8bc34d5d7da46eca; Fri, 14 May 2021 14:12:02 +0200
Received: from kreacher.localnet (89-64-80-69.dynamic.chello.pl [89.64.80.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C743F66969E;
        Fri, 14 May 2021 14:12:01 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        chenxiang <chenxiang66@hisilicon.com>
Subject: [PATCH v1 1/2] drivers: base: Fix device link removal
Date:   Fri, 14 May 2021 14:10:15 +0200
Message-ID: <5722787.lOV4Wx5bFT@kreacher>
In-Reply-To: <11761395.O9o76ZdvQC@kreacher>
References: <11761395.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.80.69
X-CLIENT-HOSTNAME: 89-64-80-69.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdehiedgvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedtrdeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdektddrieelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghrrghvrghnrghksehgohhoghhlvgdrtghomhdprhgtphhtthhopegthhgvnhigihgrnhhgieeisehhihhsihhlihgtohhnrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When device_link_free() drops references to the supplier and
consumer devices of the device link going away and the reference
being dropped turns out to be the last one for any of those
device objects, its ->release callback will be invoked and it
may sleep which goes against the SRCU callback execution
requirements.

To address this issue, make the device link removal code carry out
the device_link_free() actions preceded by SRCU synchronization from
a separate work item (the "long" workqueue is used for that, because
it does not matter when the device link memory is released and it may
take time to get to that point) instead of using SRCU callbacks.

While at it, make the code work analogously when SRCU is not enabled
to reduce the differences between the SRCU and non-SRCU cases.

Fixes: 843e600b8a2b ("driver core: Fix sleeping in invalid context during device link deletion")
Reported-by: chenxiang (M) <chenxiang66@hisilicon.com>
Tested-by: chenxiang (M) <chenxiang66@hisilicon.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    |   37 +++++++++++++++++++++++--------------
 include/linux/device.h |    6 ++----
 2 files changed, 25 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -193,6 +193,11 @@ int device_links_read_lock_held(void)
 {
 	return srcu_read_lock_held(&device_links_srcu);
 }
+
+static void device_link_synchronize_removal(void)
+{
+	synchronize_srcu(&device_links_srcu);
+}
 #else /* !CONFIG_SRCU */
 static DECLARE_RWSEM(device_links_lock);
 
@@ -223,6 +228,10 @@ int device_links_read_lock_held(void)
 	return lockdep_is_held(&device_links_lock);
 }
 #endif
+
+static inline void device_link_synchronize_removal(void)
+{
+}
 #endif /* !CONFIG_SRCU */
 
 static bool device_is_ancestor(struct device *dev, struct device *target)
@@ -444,8 +453,13 @@ static struct attribute *devlink_attrs[]
 };
 ATTRIBUTE_GROUPS(devlink);
 
-static void device_link_free(struct device_link *link)
+static void device_link_release_fn(struct work_struct *work)
 {
+	struct device_link *link = container_of(work, struct device_link, rm_work);
+
+	/* Ensure that all references to the link object have been dropped. */
+	device_link_synchronize_removal();
+
 	while (refcount_dec_not_one(&link->rpm_active))
 		pm_runtime_put(link->supplier);
 
@@ -454,24 +468,19 @@ static void device_link_free(struct devi
 	kfree(link);
 }
 
-#ifdef CONFIG_SRCU
-static void __device_link_free_srcu(struct rcu_head *rhead)
-{
-	device_link_free(container_of(rhead, struct device_link, rcu_head));
-}
-
 static void devlink_dev_release(struct device *dev)
 {
 	struct device_link *link = to_devlink(dev);
 
-	call_srcu(&device_links_srcu, &link->rcu_head, __device_link_free_srcu);
-}
-#else
-static void devlink_dev_release(struct device *dev)
-{
-	device_link_free(to_devlink(dev));
+	INIT_WORK(&link->rm_work, device_link_release_fn);
+	/*
+	 * It may take a while to complete this work because of the SRCU
+	 * synchronization in device_link_release_fn() and if the consumer or
+	 * supplier devices get deleted when it runs, so put it into the "long"
+	 * workqueue.
+	 */
+	queue_work(system_long_wq, &link->rm_work);
 }
-#endif
 
 static struct class devlink_class = {
 	.name = "devlink",
Index: linux-pm/include/linux/device.h
===================================================================
--- linux-pm.orig/include/linux/device.h
+++ linux-pm/include/linux/device.h
@@ -570,7 +570,7 @@ struct device {
  * @flags: Link flags.
  * @rpm_active: Whether or not the consumer device is runtime-PM-active.
  * @kref: Count repeated addition of the same link.
- * @rcu_head: An RCU head to use for deferred execution of SRCU callbacks.
+ * @rm_work: Work structure used for removing the link.
  * @supplier_preactivated: Supplier has been made active before consumer probe.
  */
 struct device_link {
@@ -583,9 +583,7 @@ struct device_link {
 	u32 flags;
 	refcount_t rpm_active;
 	struct kref kref;
-#ifdef CONFIG_SRCU
-	struct rcu_head rcu_head;
-#endif
+	struct work_struct rm_work;
 	bool supplier_preactivated; /* Owned by consumer probe. */
 };
 



