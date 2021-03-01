Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9B9327931
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 09:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhCAI2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 03:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbhCAI20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 03:28:26 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12FEC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 00:27:43 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z11so1689463plg.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 00:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FuaSHSbWef+FCEtgT0N7vs/Xq7VSPd0Xi/zQSMAl+iI=;
        b=MwBJd6nr/x0X6BNc1UOHSDERxXkElhOwwrOntWL5QhYeZPHWNnO7meE47FozC6o8tz
         tY5bGK6qqRtrMFiMA6bgdlcHLGM9s0O7JUNr3xo3pfEqyoPCZJzn7Dae8INdsuKk9gGi
         Q6+tOBfmC8WPNigIzUQ/HSSasJYxw5cT4BqEC8ib/sOkDdw97L1vBAUc1FHJmExZWqzY
         l7Rnq9aPQvmFeOlIOUHLU5r5+DPBjsNCQgqxB9LD68+CexCBUCU5/XFKhIpz82P6Pv6G
         6R9R2MMD6cJhz6UIGWY5ZTizw+WCBysd/PjagBqbzbs90LoFZY0q7cQj+9c7pRCAc9MO
         sO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FuaSHSbWef+FCEtgT0N7vs/Xq7VSPd0Xi/zQSMAl+iI=;
        b=l+x1ytnjnqc/uKeAt2R2mauoGm5HuaeTqQDnBgo5rhj5IgUiHtN3d7yvpMVz2oPsdm
         YHYKnj9qnJywA3H6Q5x9V5CSX/o7fWGCC7aJ4lA92JTHKFKY2mRBhMiq7NIl1rmwVwEM
         jMMbz84PP8b5PFbUQIzJ0KcIQqj6moR47vQzRgAP+d7vaNezWV39dVgfExin6O1kDbjT
         3O91EcE9F1//Bh9YQ4rP4NFGSDvdddscTSgSLwe8gk4N4WozVPTpJ70qTwdXOHGI1J12
         X48Mx6TtI2Srcj/NaQrWwrXA04Nbq8Pa59y5YEdmenUCWj2K4msiWcXL/ae8+nAYMws8
         QOvQ==
X-Gm-Message-State: AOAM532vDWx6ftqGjgIKKyd0zir2Gby/FlD2tUTZmtAcIOOpdtYFjBnx
        cN4NeFJHvtsljlApJZACv38=
X-Google-Smtp-Source: ABdhPJyY+Ovv0TZ/11Y+CISKEO2tNjjqqEoFDYrm4JtdkRZ7FRMaqUUAYOGPtxqXIiteRdIP5v2R5Q==
X-Received: by 2002:a17:90b:1c0e:: with SMTP id oc14mr16332167pjb.188.1614587263268;
        Mon, 01 Mar 2021 00:27:43 -0800 (PST)
Received: from localhost.localdomain ([111.207.172.18])
        by smtp.gmail.com with ESMTPSA id m6sm2908343pff.197.2021.03.01.00.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 00:27:42 -0800 (PST)
From:   zhaoxiao <long870912@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] KVM: x86: fix the space error for the pointer variables.
Date:   Mon,  1 Mar 2021 16:27:35 +0800
Message-Id: <20210301082735.17372-1-long870912@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhaoxiao <zhaoxiao@uniontech.com>

The following pointer variables don't meet the kernel coding style,
so fix the space error.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3712bb5245eb..98849f3112d4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5368,7 +5368,7 @@ static int kvm_add_msr_filter(struct kvm *kvm, struct kvm_msr_filter_range *user
 	if (!bitmap_size || bitmap_size > KVM_MSR_FILTER_MAX_BITMAP_SIZE)
 		return -EINVAL;
 
-	bitmap = memdup_user((__user u8*)user_range->bitmap, bitmap_size);
+	bitmap = memdup_user((__user u8 *)user_range->bitmap, bitmap_size);
 	if (IS_ERR(bitmap))
 		return PTR_ERR(bitmap);
 
@@ -10554,7 +10554,7 @@ void kvm_arch_sync_events(struct kvm *kvm)
  * address, i.e. its accessibility is not guaranteed, and must be
  * accessed via __copy_{to,from}_user().
  */
-void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
+void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 				      u32 size)
 {
 	int i, r;
-- 
2.20.1

