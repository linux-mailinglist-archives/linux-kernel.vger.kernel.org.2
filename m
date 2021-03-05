Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CE932E4D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhCEJa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:30:59 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:39101 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCEJa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:30:57 -0500
Received: by mail-lf1-f51.google.com with SMTP id 18so2495632lff.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 01:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sij05VFpJgeqCqXYg4ZQk/H8ai0dlbHB0/ggBdsdDto=;
        b=HHBWgQthVknxFAXQQINv6lhltvxA5fdGGjBIp+pvWxodHawuPDCe+oges7rbdo4SXB
         Y4w5kqUZKNAIAZm9BJJKenmgxmsGIVPrzO/8+BMlqoTMQfkti8NH7lGcaSD4pp9X9MTl
         gY/URwW9K89dg7mY46WR9OfWwnnQq3EVbVJ4i0YZReHorqXK+Lr7s89tus3svWNTc8dT
         hNhxQq2V+VBotjySPagjQ3kp9lmlzlrK6Yr2GougMhNJmj9jLOt+DZ9BAz2CbMwKs9bT
         zjF5DKYapw6cVw/CZyF/5pWmWHT9/7mNajF5ONla/Nz2xOtrrUZYcxk7/lFRb7cYUIlb
         eLqQ==
X-Gm-Message-State: AOAM531eO+q8r4nHOnNW+rq8jsaxp9rC+Ee5kO0xHckQ9HMZGeQhGf7N
        UwbdwHwzcbW6lcX86SCafN+/T3CEnFQ1hA==
X-Google-Smtp-Source: ABdhPJzIIwckwhz4dez/Qa5mirOLbysEmtBCHhNNNvoffsjQZdYCneb7i3/07I1Gv98gVTrUJ/xllQ==
X-Received: by 2002:a19:ed8:: with SMTP id 207mr4748995lfo.164.1614936655904;
        Fri, 05 Mar 2021 01:30:55 -0800 (PST)
Received: from localhost.. (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id w13sm239454ljw.2.2021.03.05.01.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 01:30:55 -0800 (PST)
From:   Denis Efremov <efremov@linux.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Denis Efremov <efremov@linux.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/ptrace: Remove duplicate check from pt_regs_check()
Date:   Fri,  5 Mar 2021 14:28:07 +0300
Message-Id: <20210305112807.26299-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"offsetof(struct pt_regs, msr) == offsetof(struct user_pt_regs, msr)"
checked in pt_regs_check() twice in a row. Remove the second check.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/powerpc/kernel/ptrace/ptrace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index 4f3d4ff3728c..51801777906c 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -354,8 +354,6 @@ void __init pt_regs_check(void)
 		     offsetof(struct user_pt_regs, nip));
 	BUILD_BUG_ON(offsetof(struct pt_regs, msr) !=
 		     offsetof(struct user_pt_regs, msr));
-	BUILD_BUG_ON(offsetof(struct pt_regs, msr) !=
-		     offsetof(struct user_pt_regs, msr));
 	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
 		     offsetof(struct user_pt_regs, orig_gpr3));
 	BUILD_BUG_ON(offsetof(struct pt_regs, ctr) !=
-- 
2.26.2

