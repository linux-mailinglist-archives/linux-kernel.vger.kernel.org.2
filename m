Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9FF450531
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhKONVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:21:19 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47626
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231537AbhKONTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:19:44 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E14693F1B0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 13:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636982208;
        bh=K4Tpv8FhF+swF1QOJJDtTIl0jGfawRNMwuEF57mHnhA=;
        h=From:To:Subject:Date:Message-Id;
        b=QKmVpnPgFIKCWYUEcsASTU0qVttnoT7rV10CiDU5fui43qbDbe5L6vnTBLUFTIrAU
         cffmJkBRNhyUJjihiSPQmIYp9agoNp7cKEBlIPPvFiMTnY3JTdZoSSBidn/SfcsQl+
         4if2/sgEeTd2qomS4xrvdTz1Fnafcf0StbGQKGdrTFQ73Y6klc+3QYbMgf61hV+5cn
         sMST7yqpMj+iHNIMhFAxTj8khxnrp8BVsaMrJMnXpRvzhhebbvbAU1vemLRZdvWXPO
         CVgI9wWfcpyzfExfQKKcdTZH9Vsjqt0ZmiBeKRd79osinuCoy8vY4LSrJZFCa/FXU+
         0jeauACAuXQZg==
Received: by mail-ed1-f72.google.com with SMTP id y9-20020aa7c249000000b003e7bf7a1579so2565720edo.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:16:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=K4Tpv8FhF+swF1QOJJDtTIl0jGfawRNMwuEF57mHnhA=;
        b=vqFnjZwnDSFRl4FuJuNTk1j4GYPOVHnw2MuyzeSnXzpHlg6fBXkmOsjl2P1iBcoMV6
         x679mOUKQBmoyeExdVpnMKtOCFRStvtrEVh2nAZELGGMPtecZ47Rhv2Weyu442Q4s+yW
         4gHY+0EJJ68+acO2U+0Zsac3USyCOxWaCbpQqSagg+ox30tVLVjze+HRncj8dJ3gAcFC
         H2YtxiMtgqJkxdHaIQYL1bV+WoLW/pqRkWKcefUYJdFVMuUSvKj8dqbSYadeeB3Js7Qv
         rCipr5r/wWlF7/czC0yHYvcAZyobQ5bhLJCAoKxZH2FeGdZe2qm2gKXgnwleuNfBHQAD
         s4Rg==
X-Gm-Message-State: AOAM532VcaxmgGp5d50XRUBkeLDGpoUJwLH2WNqaSaJPy4khU7eCllwq
        c+11yvRFg9T0UQXQIf5nvL/OBH4yFKkwpTpIxJkJWmlohOPrrmQ27H/+o5jwMipU6D9v72Ayzrc
        R2suGZY4VwdSlQYzOP7v3LdNO9+KT0PHl11UoDOWS0g==
X-Received: by 2002:a05:6402:4381:: with SMTP id o1mr52408121edc.301.1636982207471;
        Mon, 15 Nov 2021 05:16:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXaUPsd1rpZtYTPzsBc/AAnTH0TNQ4iOT/8vDyX51rKauD7oN9OteTNh2f1jLRwuGbVkp2Vg==
X-Received: by 2002:a05:6402:4381:: with SMTP id o1mr52408090edc.301.1636982207232;
        Mon, 15 Nov 2021 05:16:47 -0800 (PST)
Received: from localhost ([2001:67c:1560:8007::aac:c2e0])
        by smtp.gmail.com with ESMTPSA id r7sm7735220edd.5.2021.11.15.05.16.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Nov 2021 05:16:46 -0800 (PST)
From:   Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
To:     linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net, minyard@acm.org
Subject: [PATCH v2] ipmi: Move remove_work to dedicated workqueue
Date:   Mon, 15 Nov 2021 15:16:45 +0200
Message-Id: <20211115131645.25116-1-ioanna-maria.alifieraki@canonical.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when removing an ipmi_user the removal is deferred as a work on
the system's workqueue. Although this guarantees the free operation will
occur in non atomic context, it can race with the ipmi_msghandler module
removal (see [1]) . In case a remove_user work is scheduled for removal
and shortly after ipmi_msghandler module is removed we can end up in a
situation where the module is removed fist and when the work is executed
the system crashes with :
BUG: unable to handle page fault for address: ffffffffc05c3450
PF: supervisor instruction fetch in kernel mode
PF: error_code(0x0010) - not-present page
because the pages of the module are gone. In cleanup_ipmi() there is no
easy way to detect if there are any pending works to flush them before
removing the module. This patch creates a separate workqueue and schedules
the remove_work works on it. When removing the module the workqueue is
drained when destroyed to avoid the race.

[1] https://bugs.launchpad.net/bugs/1950666

Cc: stable@vger.kernel.org
Fixes: 3b9a907223d7 (ipmi: fix sleep-in-atomic in free_user at cleanup SRCU user->release_barrier)
Signed-off-by: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index deed355422f4..1ade72bfae0f 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -191,6 +191,8 @@ struct ipmi_user {
 	struct work_struct remove_work;
 };
 
+struct workqueue_struct *remove_work_wq;
+
 static struct ipmi_user *acquire_ipmi_user(struct ipmi_user *user, int *index)
 	__acquires(user->release_barrier)
 {
@@ -1297,7 +1299,7 @@ static void free_user(struct kref *ref)
 	struct ipmi_user *user = container_of(ref, struct ipmi_user, refcount);
 
 	/* SRCU cleanup must happen in task context. */
-	schedule_work(&user->remove_work);
+	queue_work(remove_work_wq, &user->remove_work);
 }
 
 static void _ipmi_destroy_user(struct ipmi_user *user)
@@ -5383,6 +5385,13 @@ static int ipmi_init_msghandler(void)
 
 	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
 
+	remove_work_wq = create_singlethread_workqueue("ipmi-msghandler-remove-wq");
+	if (!remove_work_wq) {
+		pr_err("unable to create ipmi-msghandler-remove-wq workqueue");
+		rv = -ENOMEM;
+		goto out;
+	}
+
 	initialized = true;
 
 out:
@@ -5408,6 +5417,8 @@ static void __exit cleanup_ipmi(void)
 	int count;
 
 	if (initialized) {
+		destroy_workqueue(remove_work_wq);
+
 		atomic_notifier_chain_unregister(&panic_notifier_list,
 						 &panic_block);
 
-- 
2.17.1

