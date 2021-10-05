Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294C0422E71
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbhJEQzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 12:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbhJEQzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:55:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A51EC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 09:53:16 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q7-20020a17090a2e0700b001a01027dd88so840240pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 09:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3y9/xex1IBG3Kf9w0DVpqN0KcuLp3munVqeoWolkHSo=;
        b=PentxmITW8nM8VeiGHj+6B4cRZwjDrTB8EZ9qIAH1JeaDxkcucT0uPop+/Psw9Bbws
         S1MlGKDMMPdJXHwueMTgCOjc9vqOTttLxZw4OhdH4hJ/SmmwXmHfOmiRE9aU4wUSiga3
         MrvMRVY3qNzMqGgpLCGH0NKBrMWv9V5z3XjyuZ+J/5oj6xlWk6gdB9RQDLRBvrdjVL6M
         rdu23t03peKHg2sRsTvoxT6NKj1odphgifP1T/bcBuhEU/lOvzrXsGeuD2T7E2dbS10Q
         s1n0iUKKrWxRz/lrorPwfxPaok0/u2CiFYXjaE13krIKetwcuWUYmZZ+1qYQZJBVSO59
         7SSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3y9/xex1IBG3Kf9w0DVpqN0KcuLp3munVqeoWolkHSo=;
        b=iV1dPw+B4DlhwnwNmqxsJ8bcZjH4bGpx6Y37gJpxrGAwm+VyUMwmmRJnfGaM3lIJYi
         /D2Ac9lNcnpupsQtmvRFalAcW1uj+H2HOtPn4YKp/qamo9SmG2+6lVd/UxhUQNm2LBzQ
         C+I3+dwP1EZ2goTJhBQG+q7NLzHaPvtGSfkY5VImozkrOpGJMOrBURB+M8cc8ayVCl/q
         7L+yGSU4vIYo8ldeXzr+pqbrPPIKKAiyVVwPpkExTWYPiWyr4ECeZ+QF4bT1PvJnlRRm
         n46DHxCbdr3Ir9cm8lL0QxoiU87PUefbGvbZMbXraU2OErz+TuGRKOx68E9CQRZ83NEt
         L2Ng==
X-Gm-Message-State: AOAM530XNNA2egpVXilAxv7K+tpoz0y+rEoEqsD9VHsthS0zyBImqiwk
        e7FIhws2Fz0QYCYH67ArcrpWhVqNTHdxHQ==
X-Google-Smtp-Source: ABdhPJwFPERCFazb+VU976epN6bRWoI3SrFOSR9uX1Lo6BRPQhtDqHgut/AyHa1RY3cuvQMybsR+ZQ==
X-Received: by 2002:a17:90a:b78d:: with SMTP id m13mr5053686pjr.17.1633452795563;
        Tue, 05 Oct 2021 09:53:15 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id n19sm17615473pff.37.2021.10.05.09.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 09:53:15 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] x86: move arch_get_vdso_data under CONFIG_TIME_NS
Date:   Tue,  5 Oct 2021 09:48:27 -0700
Message-Id: <20211005164827.103876-1-avagin@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the warning:
>> vma.c:32:19: warning: no previous prototype for 'arch_get_vdso_data'
      32 | struct vdso_data *arch_get_vdso_data(void *vvar_page)
         |                   ^~~~~~~~~~~~~~~~~~

Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/x86/entry/vdso/vma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 235a5794296a..427bc56c152b 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -31,11 +31,6 @@
 #define EMIT_VVAR(name, offset)	\
 	const size_t name ## _offset = offset;
 #include <asm/vvar.h>
-
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return (struct vdso_data *)(vvar_page + _vdso_data_offset);
-}
 #undef EMIT_VVAR
 
 unsigned int vclocks_used __read_mostly;
@@ -98,6 +93,11 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 }
 
 #ifdef CONFIG_TIME_NS
+struct vdso_data *arch_get_vdso_data(void *vvar_page)
+{
+	return (struct vdso_data *)(vvar_page + _vdso_data_offset);
+}
+
 static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_mm == current->mm))
-- 
2.31.1

