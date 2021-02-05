Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB857310F36
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhBEQNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbhBEQJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:09:11 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ADBC061786
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:50:54 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id a16so3942125plh.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8LdcV8DMgciJSckP8og9DY1KpzD/dHjlqzcgElgAVXM=;
        b=o26e66MUJ9hLAu9jrOp/+vQ/wqpT3vSn+OAqARm2Dr9nuJ9x0cpajYYgM/JZwGijHM
         amM2qTGshvMv9EP2EC42ryZgdh7/NhUxkeSOEkF7SuoSyH8sbTij9rUcrPdB5wz/Go59
         je0R+HE+os02G5T5NbJ8vNA7OHm6CemIB5WVstzjKJyXlmVYSrI5P6N5NKZm1kw2pFEi
         9PtA/Qmue6lAc1/NLPbkCpEH+WoTL+jFiCE7Z4wO4goZKDqk7tjWs8fdfozVd7iwAgTx
         baE2v9c7cFtOI8MQp61kF5cqiNRqWYKVaM4ipyBiorzEX7V48JJeY7n6FsVLCCNVgS2h
         4Rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8LdcV8DMgciJSckP8og9DY1KpzD/dHjlqzcgElgAVXM=;
        b=FFUZmPwwrGqyZkTAjX/KB6ztsKVf9oc/tUd35FapeEnByICHQNw1l1IpzfeY/LQ4xR
         VN2DlIpZE8VkSpsCxXccdtJ+9wLaScoZOgVOvpHkUY2uXnD/JqGvsGs0bu/Zw155eo/1
         7vEkQMGVS8Bl/Rc+j5M5YU6kHtkrL8hHWOS3ENiYhlZ5ZU7+kQXgDt+t0Go5oDeyxK8U
         7fdehjOQe12KSZCKgl/8yOwUng6HNqAwgp+xQUrgvpYZvsaTvvuxaoCg5VWIUjYlQg9A
         ezb09Rnj2oF31tLevrNH9MJLtbnZJwYOhzK436D11HSLOFotQjNbv6Wh8BNnndnlw6aU
         jBiw==
X-Gm-Message-State: AOAM530BGTubZokdfI37M0xJYoWvIkVEmpU6wThcS7/MwU14pU50kXsR
        QAQ+8Jj6vB8P9YhGTNHs7xW/LbQsRDyR9w==
X-Google-Smtp-Source: ABdhPJydY9NVYsb//m4vDxJl8NxvAKpuf/tVRmc9bhQXb3Zbesg4vXCHY8g9SUEA5D1wt6hntua+NA==
X-Received: by 2002:a17:90a:a084:: with SMTP id r4mr5138668pjp.190.1612547453595;
        Fri, 05 Feb 2021 09:50:53 -0800 (PST)
Received: from google.com ([2620:15c:f:10:d169:a9f7:513:e5])
        by smtp.gmail.com with ESMTPSA id a6sm9445934pfr.43.2021.02.05.09.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 09:50:52 -0800 (PST)
Date:   Fri, 5 Feb 2021 09:50:46 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org
Subject: Re: [PATCH] KVM: x86/MMU: Do not check unsync status for root SP.
Message-ID: <YB2Fdp0Pn0MybBsB@google.com>
References: <20210116002100.17339-1-yu.c.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116002100.17339-1-yu.c.zhang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021, Yu Zhang wrote:
> In shadow page table, only leaf SPs may be marked as unsync.
> And for non-leaf SPs, we use unsync_children to keep the number
> of the unsynced children. In kvm_mmu_sync_root(), sp->unsync
> shall always be zero for the root SP, hence no need to check it.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 6d16481a..1a6bb03 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3412,8 +3412,7 @@ void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
>  		 * mmu_need_write_protect() describe what could go wrong if this
>  		 * requirement isn't satisfied.
>  		 */
> -		if (!smp_load_acquire(&sp->unsync) &&
> -		    !smp_load_acquire(&sp->unsync_children))
> +		if (!smp_load_acquire(&sp->unsync_children))
>  			return;
>  
>  		spin_lock(&vcpu->kvm->mmu_lock);

Looks good.  To make this less scary and more obviously correct, maybe move the
the WARN on !PG_LEVEL_4K into kvm_unsync_page() instead of having the WARN in
its sole caller, and add a WARN in mmu_sync_children()?

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 86af58294272..bc8ee05bb3d3 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1995,6 +1995,12 @@ static void mmu_sync_children(struct kvm_vcpu *vcpu,
        LIST_HEAD(invalid_list);
        bool flush = false;

+       /*
+        * Only 4k SPTEs can directly be made unsync, the root shadow page
+        * should never be unsyc'd.
+        */
+       WARN_ON_ONCE(sp->unsync);
+
        while (mmu_unsync_walk(parent, &pages)) {
                bool protected = false;

@@ -2502,6 +2508,8 @@ EXPORT_SYMBOL_GPL(kvm_mmu_unprotect_page);

 static void kvm_unsync_page(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 {
+       WARN_ON(sp->role.level != PG_LEVEL_4K);
+
        trace_kvm_mmu_unsync_page(sp);
        ++vcpu->kvm->stat.mmu_unsync;
        sp->unsync = 1;
@@ -2524,7 +2532,6 @@ bool mmu_need_write_protect(struct kvm_vcpu *vcpu, gfn_t gfn,
                if (sp->unsync)
                        continue;

-               WARN_ON(sp->role.level != PG_LEVEL_4K);
                kvm_unsync_page(vcpu, sp);
        }

@@ -3406,8 +3413,7 @@ void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
                 * mmu_need_write_protect() describe what could go wrong if this
                 * requirement isn't satisfied.
                 */
-               if (!smp_load_acquire(&sp->unsync) &&
-                   !smp_load_acquire(&sp->unsync_children))
+               if (!smp_load_acquire(&sp->unsync_children))
                        return;

                write_lock(&vcpu->kvm->mmu_lock);

