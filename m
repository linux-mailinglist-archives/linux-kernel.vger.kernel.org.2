Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC894515EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 21:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348169AbhKOVBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 16:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240122AbhKOSMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:12:16 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E43C0386D4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:38:52 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id i25-20020a631319000000b002cce0a43e94so9526513pgl.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gFHzpDmZVv3KTzaa99s4GcDQLq8lkQoNbMRzfWvXXRU=;
        b=E0lMrhcUzQ+Xxg7MzzracGH2o8ZPywwPNThCN8B2PV1+YsxQ7pcG6fw/LsdoL5DhpJ
         Po3s0ulyU4vPeedC/oWHYgY2QT/E5n8f1j7yGJCR4TH0EDLR7pHs43w4Fn0CYmqbDa0b
         C0axRULUIX1exCYTmfoFg2/WV3luxC+wnavfxXcrma1naBKaP+Qwb/UAzxoe3aOMfF+9
         /LhYB/QdqhlAwXaExqi0xERMWK/ww3Q0LLDDgsSqjoH2cQ6ymB4g9FuH95+4++E+m+gv
         gJIlxXphc6ecxg7H1I/CcfAWBgO6rECPBHy08g79iQ2oAy5ZYNMdQUXVfhQ7q0IgGMdk
         CAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gFHzpDmZVv3KTzaa99s4GcDQLq8lkQoNbMRzfWvXXRU=;
        b=MAJse7q0oqO615Bv22F9CUCtpffnB+gYW4gJeHIvpnvpXkjZFg22HKcdHCxsStmdJo
         HhP6HuUvLO+TZQ9zf3tB+foy+K/Q6Hfh8LTUDjtiRD69a/s/jKY9qMtu1z+S6FQjBZ56
         yNwJLmoZq2taWthPVWqKH4EfxDPon0YWi/gl3piWB3ZwZ1FR2BpWvJvm8nINMBePz6eu
         tBCG52uUOPypDKNT7ES2HVuYw6PepfLVGgCuGBwyUt1++z+hDkpG3Tk1p6OizISdaUxN
         eIOmDEyW5MiHXgRll651ZZ7HIz/KnEnlJj+HdwuZbJcl6YB5yE+awOCjqgzesK0FHrfd
         uYOg==
X-Gm-Message-State: AOAM533IaiawE0pCU2XA5QJS+4XzsrTdNvJe5X1ar3Yplx1OXlTT5oBY
        niJbIUi1VLd0dYyLpEr8hfQZBg3KxDd34VyYWQo8f2J+6Hx1h3tK+mLOyKHzRw6kz++QF2Z03GH
        WP99pCZxcb4efFBg9lwPRHMmzCMe8UzrK5ckVptSVqAXlA38qFLLjNoHbQk7RmylKhDSFqA==
X-Google-Smtp-Source: ABdhPJwTAV+ZG+2XqLkeiSQpjZ7KK5I0FTpAB9sdXiyOS+6eC4Xc72hJckhedQD25PX8UC+kT43g6OJrmDU=
X-Received: from adelva.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:b2b])
 (user=adelva job=sendgmr) by 2002:a17:90a:c287:: with SMTP id
 f7mr60754043pjt.114.1636997931798; Mon, 15 Nov 2021 09:38:51 -0800 (PST)
Date:   Mon, 15 Nov 2021 17:38:50 +0000
Message-Id: <20211115173850.3598768-1-adelva@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH] block: Check ADMIN before NICE for IOPRIO_CLASS_RT
From:   Alistair Delva <adelva@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Khazhismel Kumykov <khazhy@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Serge Hallyn <serge@hallyn.com>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel-team@android.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting to Android userspace on 5.14 or newer triggers the following
SELinux denial:

avc: denied { sys_nice } for comm="init" capability=23
     scontext=u:r:init:s0 tcontext=u:r:init:s0 tclass=capability
     permissive=0

Init is PID 0 running as root, so it already has CAP_SYS_ADMIN. For
better compatibility with older SEPolicy, check ADMIN before NICE.

Fixes: 9d3a39a5f1e4 ("block: grant IOPRIO_CLASS_RT to CAP_SYS_NICE")
Signed-off-by: Alistair Delva <adelva@google.com>
Cc: Khazhismel Kumykov <khazhy@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: kernel-team@android.com
Cc: stable@vger.kernel.org # v5.14+
---
 block/ioprio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 0e4ff245f2bf..4d59c559e057 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -69,7 +69,7 @@ int ioprio_check_cap(int ioprio)
 
 	switch (class) {
 		case IOPRIO_CLASS_RT:
-			if (!capable(CAP_SYS_NICE) && !capable(CAP_SYS_ADMIN))
+			if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
 				return -EPERM;
 			fallthrough;
 			/* rt has prio field too */
-- 
2.34.0.rc1.387.gb447b232ab-goog

