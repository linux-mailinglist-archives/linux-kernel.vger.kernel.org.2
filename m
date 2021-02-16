Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B3E31CBD4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 15:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhBPOYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 09:24:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229787AbhBPOYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:24:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 319DD64E00;
        Tue, 16 Feb 2021 14:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613485444;
        bh=KhFrGCYbZDRKAR2axO+NqWgtltVFh8zY277dTTLlf08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fIW1JfW7rNGbWjZt7mfMJ+KYDXuvOq/ONObhIsdAb35zZ+N9ITLc+SH9Or8hf1n1q
         dQ2YTJ9Cym8jrOZ/nCOD/OCzAWX0M4alZzHktTc+/UwMEWYkF8RoRHAuWEZebnCn/t
         k2p3nEKuMAhn4e8bJCWu0Gp5JMpMSre/+h7wuu3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/2] driver core: dd: remove deferred_devices variable
Date:   Tue, 16 Feb 2021 15:24:00 +0100
Message-Id: <20210216142400.3759099-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210216142400.3759099-1-gregkh@linuxfoundation.org>
References: <20210216142400.3759099-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to save the debugfs dentry for the "devices_deferred" debugfs
file (gotta love the juxtaposition), if we need to remove it we can look
it up from debugfs itself.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/dd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9179825ff646..66c31cda5462 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -55,7 +55,6 @@ static DEFINE_MUTEX(deferred_probe_mutex);
 static LIST_HEAD(deferred_probe_pending_list);
 static LIST_HEAD(deferred_probe_active_list);
 static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
-static struct dentry *deferred_devices;
 static bool initcalls_done;
 
 /* Save the async probe drivers' name from kernel cmdline */
@@ -310,8 +309,8 @@ static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_
  */
 static int deferred_probe_initcall(void)
 {
-	deferred_devices = debugfs_create_file("devices_deferred", 0444, NULL,
-					       NULL, &deferred_devs_fops);
+	debugfs_create_file("devices_deferred", 0444, NULL, NULL,
+			    &deferred_devs_fops);
 
 	driver_deferred_probe_enable = true;
 	driver_deferred_probe_trigger();
@@ -336,7 +335,7 @@ late_initcall(deferred_probe_initcall);
 
 static void __exit deferred_probe_exit(void)
 {
-	debugfs_remove_recursive(deferred_devices);
+	debugfs_remove_recursive(debugfs_lookup("devices_deferred", NULL));
 }
 __exitcall(deferred_probe_exit);
 
-- 
2.30.1

