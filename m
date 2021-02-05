Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569743108B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhBEKIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhBEKFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:05:18 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED55C061225
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 02:04:15 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m12so3341460pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 02:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fEERljz4qdFaDpGfFgKzxBmmCvSatSkY1c1MbUYcK2c=;
        b=HOccOI6UP5g7t9cL6Y5c3Ipx2+pKF/eOf4i3OzR4r3Oqow1Li2Ei1fDjYXSCFGhaGO
         zfF0CTQdawIrrTIxgHsGvI2e/8yFPv5fgQi04bASxCTYZaQ5ueWw5CsSBwTewCkwWxor
         zSh/cGLFidNddtHFVfXos+kLdVnB/Jcx0TdHGUVS6b89h70J8HoGFwt1PkVBSF37zzkr
         N1wiZ05+A1E2Ttuji4NoDpGH0VKEJCcf46VKp/xL/IlTXOi/6A3YLIn3trI3ffHjNuY8
         fbmh7n21i1XAHoaLVy/BdTjkDvDeQ/EbLcvoXzP0+OiTP4cJ7hBA01Okww3UavsaOm+3
         grww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fEERljz4qdFaDpGfFgKzxBmmCvSatSkY1c1MbUYcK2c=;
        b=n0zNpCYy56bBPH+cPjMB/2Blf9wJw7AGN0kf66zyuP4YH01Bi+lvxkMv4tYdq4DLLX
         4am887UCeWMhY5ZjBDVKPfPnPaT8/c4aWYJ2mkWf6aYfR81x7/NPTVfc8hL9/jz+b3pk
         pmZLiHEbD3WyHZnDS9Hy61z+s9mxHOQi6iYsCX76C4Kgz8nr1XvTCZqCRNtq/IS5N69q
         VXWP+riMvYCaEfQ/24/xJjnhVpHzAVnKlrUvy2rJ2aM45IfOeM/nlmxQFoeJPNCj5S4S
         J/O8lX9b8ozmqbmkNqAOCFc7Jv1LOJm7VnJBvlDe9L2jrmCF8FNj1BG5mNAw2A+Y5wWi
         NmDw==
X-Gm-Message-State: AOAM530sIEsvmSdFvIveo2ltfnhHBg8kIc1qwwji/xl1cL1CBAK63jV0
        aQ2nvt58dIBop6/Ey0Gm+nKmVg==
X-Google-Smtp-Source: ABdhPJyGePJ6u9nVgKlAA50Xb4wCgCVZB+/HoLTzFZAsA9PyQ2sCkDDkXEe7ds5HPfrcSqHEQPaKWA==
X-Received: by 2002:a17:90a:ba02:: with SMTP id s2mr3458890pjr.53.1612519454561;
        Fri, 05 Feb 2021 02:04:14 -0800 (PST)
Received: from C02CC49MMD6R.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id l12sm8142562pjg.54.2021.02.05.02.04.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 02:04:14 -0800 (PST)
From:   Zhimin Feng <fengzhimin@bytedance.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        fweisbec@gmail.com, zhouyibo@bytedance.com,
        zhanghaozhong@bytedance.com, Zhimin Feng <fengzhimin@bytedance.com>
Subject: [RFC: timer passthrough 7/9] KVM: vmx: save the initial value of host tscd
Date:   Fri,  5 Feb 2021 18:03:15 +0800
Message-Id: <20210205100317.24174-8-fengzhimin@bytedance.com>
X-Mailer: git-send-email 2.24.1 (Apple Git-126)
In-Reply-To: <20210205100317.24174-1-fengzhimin@bytedance.com>
References: <20210205100317.24174-1-fengzhimin@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record the host tscd value.

Signed-off-by: Zhimin Feng <fengzhimin@bytedance.com>
---
 arch/x86/kvm/vmx/vmx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a12da3cef86d..98eca70d4251 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -251,8 +251,11 @@ static void vmx_host_timer_passth_init(void *junk)
 {
 	struct timer_passth_info *local_timer_info;
 	int cpu = smp_processor_id();
+	u64 tscd;
 
 	local_timer_info = &per_cpu(passth_info, cpu);
+	rdmsrl(MSR_IA32_TSC_DEADLINE, tscd);
+	local_timer_info->host_tscd = tscd;
 	local_timer_info->curr_dev = per_cpu(tick_cpu_device, cpu).evtdev;
 	local_timer_info->orig_set_next_event =
 		local_timer_info->curr_dev->set_next_event;
@@ -266,6 +269,7 @@ static void vmx_host_timer_restore(void *junk)
 	local_timer_info = &per_cpu(passth_info, smp_processor_id());
 	local_timer_info->curr_dev->set_next_event =
 		local_timer_info->orig_set_next_event;
+	local_timer_info->host_tscd = 0;
 }
 
 #define L1D_CACHE_ORDER 4
-- 
2.11.0

