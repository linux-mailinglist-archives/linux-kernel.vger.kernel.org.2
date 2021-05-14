Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59244380938
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhENMNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:13:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47652 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbhENMNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:13:13 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id 8f3f9d61dcd1e631; Fri, 14 May 2021 14:12:01 +0200
Received: from kreacher.localnet (89-64-80-69.dynamic.chello.pl [89.64.80.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 5D89466969E;
        Fri, 14 May 2021 14:12:00 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        chenxiang <chenxiang66@hisilicon.com>
Subject: [PATCH v1 2/2] drivers: base: Reduce device link removal code duplication
Date:   Fri, 14 May 2021 14:11:19 +0200
Message-ID: <4326215.LvFx2qVVIh@kreacher>
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

Reduce device link removal code duplication between the cases when
SRCU is enabled and when it is disabled by moving the only differing
piece of it (which is the removal of the link from the consumer and
supplier lists) into a separate wrapper function (defined differently
for each of the cases in question).

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/core.c |   31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -198,6 +198,12 @@ static void device_link_synchronize_remo
 {
 	synchronize_srcu(&device_links_srcu);
 }
+
+static void device_link_remove_from_lists(struct device_link *link)
+{
+	list_del_rcu(&link->s_node);
+	list_del_rcu(&link->c_node);
+}
 #else /* !CONFIG_SRCU */
 static DECLARE_RWSEM(device_links_lock);
 
@@ -232,6 +238,12 @@ int device_links_read_lock_held(void)
 static inline void device_link_synchronize_removal(void)
 {
 }
+
+static void device_link_remove_from_lists(struct device_link *link)
+{
+	list_del(&link->s_node);
+	list_del(&link->c_node);
+}
 #endif /* !CONFIG_SRCU */
 
 static bool device_is_ancestor(struct device *dev, struct device *target)
@@ -854,7 +866,6 @@ out:
 }
 EXPORT_SYMBOL_GPL(device_link_add);
 
-#ifdef CONFIG_SRCU
 static void __device_link_del(struct kref *kref)
 {
 	struct device_link *link = container_of(kref, struct device_link, kref);
@@ -864,25 +875,9 @@ static void __device_link_del(struct kre
 
 	pm_runtime_drop_link(link);
 
-	list_del_rcu(&link->s_node);
-	list_del_rcu(&link->c_node);
+	device_link_remove_from_lists(link);
 	device_unregister(&link->link_dev);
 }
-#else /* !CONFIG_SRCU */
-static void __device_link_del(struct kref *kref)
-{
-	struct device_link *link = container_of(kref, struct device_link, kref);
-
-	dev_info(link->consumer, "Dropping the link to %s\n",
-		 dev_name(link->supplier));
-
-	pm_runtime_drop_link(link);
-
-	list_del(&link->s_node);
-	list_del(&link->c_node);
-	device_unregister(&link->link_dev);
-}
-#endif /* !CONFIG_SRCU */
 
 static void device_link_put_kref(struct device_link *link)
 {



