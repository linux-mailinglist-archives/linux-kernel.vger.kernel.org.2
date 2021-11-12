Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9856B44EBA7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhKLQ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:57:09 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47900
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235311AbhKLQ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:57:08 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6423B3F175
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 16:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636736056;
        bh=Y/bAo0SDjZGHNLG0oYIbJ4ke5jmML832/GVhH0WD5jo=;
        h=From:To:Subject:Date:Message-Id;
        b=A/1DugZfb/wRrW+03b653wA2pyjx/oIZBna10J17ldvu7C9g3rELip04Lm5ChHbXe
         PyxAucQuwoZSqBuXMv5jOrIWrwotEMshADYL/ka341H30rPI23o7/YqeoZpWGptxi9
         l8bkezF+fDR/02B2WXrZs8fusZn1C6WD6ftekiC3shpoT8jqQV0oLCVB+o/Occng2F
         7Q6kNYXmoKHYoj3BMaNvnSiUY6VNFmnnn0WX5Alnmekh8I46SDmHJN7IcxrfoR4uqW
         DbM3FCl9wFAeXkF07eiIJmGJQM3zzRt9zrOB9wv7LWXhdzFojmglAidM5kFJIBU5Sz
         /DSDt4EPIitPA==
Received: by mail-wm1-f70.google.com with SMTP id 69-20020a1c0148000000b0033214e5b021so4502695wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:54:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Y/bAo0SDjZGHNLG0oYIbJ4ke5jmML832/GVhH0WD5jo=;
        b=R1umO3h8D9JsjISaM/oAMfMO1Yq63stDEspkyMlmubH8Uk3ORkpeI+Igr65+KNH1Ec
         2yDnu2IgpUWauB+82I+7b2TQ2yQzJis1zTaGLnAiBU08g36XlIDkqLDs2SUZalZ3bRdz
         C1Ek8HdskbG6APGyiYxLpeCXAKJyUp2IInvwpwq6nUJuw9qlkgANFbV67vwhZqwc4zVg
         lpoXrZW1F4vStEmHUWS3hjTtIB9Mk67vSiUwM9GXntwo1zt5covI/c6llkLmwOr+FU25
         iGmG6GwEgNn0Jl6Ahvy6Bj6UNcVB4lCqmk3YHUkhhXfh7s/sfFIurs9Yyxw7HIGZmG5+
         JpTQ==
X-Gm-Message-State: AOAM533JCsz0wEtztIduRJiYsOnUKkz8HpopoDa9WIK55BmYf0GjeNsl
        c4ZEShOmiGfwZ4LT13tsH4C2IREgs87QVkRcnKhe85YZpy8eJDw2haHGPfWLpKt5slbPc2elkvN
        j6euvJdwRJiaAI7v5oJm336rLjNwANJNS0xLWlZuv2w==
X-Received: by 2002:adf:ca05:: with SMTP id o5mr20302340wrh.7.1636736055652;
        Fri, 12 Nov 2021 08:54:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2dRTmDY3BwfEIJtHI/Hdal6tFLaJCXm9rAXKIQXdG53F20asemuEbcQ1oyNio7ZR9YfpGJQ==
X-Received: by 2002:adf:ca05:: with SMTP id o5mr20302316wrh.7.1636736055445;
        Fri, 12 Nov 2021 08:54:15 -0800 (PST)
Received: from localhost ([2001:67c:1560:8007::aac:c2e0])
        by smtp.gmail.com with ESMTPSA id 8sm4503314wmg.24.2021.11.12.08.54.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Nov 2021 08:54:14 -0800 (PST)
From:   Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
To:     linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net, minyard@acm.org,
        ioanna.alifieraki@gmail.com
Subject: [PATCH] ipmi: Move remove_work to dedicated workqueue
Date:   Fri, 12 Nov 2021 18:54:13 +0200
Message-Id: <20211112165413.7747-1-ioanna-maria.alifieraki@canonical.com>
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
flushed to avoid the race.

[1] https://bugs.launchpad.net/bugs/1950666

Cc: stable@vger.kernel.org
Fixes: 3b9a907223d7 (ipmi: fix sleep-in-atomic in free_user at cleanup SRCU user->release_barrier)
Signed-off-by: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index deed355422f4..9e0ad2ccd3e0 100644
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
@@ -5383,6 +5385,8 @@ static int ipmi_init_msghandler(void)
 
 	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
 
+	remove_work_wq = create_singlethread_workqueue("ipmi-msghandler-remove-wq");
+
 	initialized = true;
 
 out:
@@ -5408,6 +5412,9 @@ static void __exit cleanup_ipmi(void)
 	int count;
 
 	if (initialized) {
+		flush_workqueue(remove_work_wq);
+		destroy_workqueue(remove_work_wq);
+
 		atomic_notifier_chain_unregister(&panic_notifier_list,
 						 &panic_block);
 
-- 
2.17.1

