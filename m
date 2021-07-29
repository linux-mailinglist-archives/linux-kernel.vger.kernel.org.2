Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B053DAA0E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhG2RZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhG2RZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:25:15 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFCAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:25:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so10441774pji.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bPybBS+SEyM4KcZDsnHXnLjGpy/o0QeG21zLg9FBHkA=;
        b=bkKstZ2uPLU2FL52gETZq/yKnJxe+xxPRu0o3T8TY4cQ9wEDz7m3KHPqu1ygp45yst
         WDtTKwuOB6ArJNsrdoTU936IAF86JDoVgS7OFhxNtb8TxvQqitVPi9SkG3VpgGCz1f0Q
         kghHTiKTimFM4qgL5bs/dm3ahOaDVpDF52x7NEQeRTOe+Z7VDaQK2tp0hEWA50uShK9b
         WGYWMlgy4jgBFkzu0s9Cq/Y+D9njHK95QqyXLY0Q6xLwyMV8P1WSj0jeLccy1lVv4uUV
         vcE3qqFXweyOYj5VspsPrFcBmcwtPuDTRQoEU2HKgkXxxm5ir6pVybTDnkjQb8xPHQzl
         Wwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bPybBS+SEyM4KcZDsnHXnLjGpy/o0QeG21zLg9FBHkA=;
        b=JNwbGr1Yd3NyCYP7gT8Vbmvl8yNNZaWBBTOW+cP+kFBra+ZSFyQnzHvPqu5kPy6Dfk
         fOddJhiAJXvyQ1BTMs+RSnO5rEifMvo+pcvhSD7xkTKbW0p+fYEqCuKeBsKcyYyCmP5S
         t7lQPqvef7dV276rlto3A6JJMprKxBv8+Dge0zdGlAgSleQzeGOVSMKDlWAejVf0EhDW
         QOp4zauG/ZLrXtnYXG4gqFz1U7Hh1sSyW4djp7i3ddbxqgnnNbMslMyWBVwArv7NLHpb
         eFgF5tULWm4oBhGGLINjqAKlOcB5/i1OiAZkjBh6sXzpU+7W8acPFqpt52+/Rlaqk/48
         XWOw==
X-Gm-Message-State: AOAM533M5pmBwg9kMrx75w7DezXV0SDNYS6sAqoglpC7Aj7g5y1FXTaF
        UXDQzn2HBBhwJB5fCrGzyb0XXw==
X-Google-Smtp-Source: ABdhPJwB0muZ7UuLrpHcDc4ObRBn4wGsqT7t1aILaPUXMNV9uPzGnZIur2w4xC4sTh8ET8UYqRis1Q==
X-Received: by 2002:a17:902:9688:b029:129:183a:2a61 with SMTP id n8-20020a1709029688b0290129183a2a61mr5590736plp.27.1627579511794;
        Thu, 29 Jul 2021 10:25:11 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 16sm4408693pfu.109.2021.07.29.10.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 10:25:11 -0700 (PDT)
Date:   Thu, 29 Jul 2021 17:25:07 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] KVM: MMU: Add support for PKS emulation
Message-ID: <YQLkczVfCsFp4IxW@google.com>
References: <20210205083706.14146-1-chenyi.qiang@intel.com>
 <20210205083706.14146-5-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205083706.14146-5-chenyi.qiang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021, Chenyi Qiang wrote:
> In addition to the pkey check for user pages, advertise pkr_mask also to
> cache the conditions where protection key checks for supervisor pages
> are needed. Add CR4_PKS in mmu_role_bits to track the pkr_mask update on
> a per-mmu basis.
> 
> In original cache conditions of pkr_mask, U/S bit in page tables is a
> judgement condition and replace the PFEC.RSVD in page fault error code
> to form the index of 16 domains. PKS support would extend the U/S bits
> (if U/S=0, PKS check required). It adds an additional check for
> cr4_pke/cr4_pks to ensure the necessity and distinguish PKU and PKS from
> each other.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 11 +++---
>  arch/x86/kvm/mmu.h              | 13 ++++---
>  arch/x86/kvm/mmu/mmu.c          | 63 +++++++++++++++++++--------------
>  arch/x86/kvm/x86.c              |  3 +-
>  4 files changed, 53 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 1909d34cbac8..e515f1cecb88 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -294,7 +294,7 @@ union kvm_mmu_extended_role {
>  		unsigned int cr0_pg:1;
>  		unsigned int cr4_pae:1;
>  		unsigned int cr4_pse:1;
> -		unsigned int cr4_pke:1;
> +		unsigned int cr4_pkr:1;

Smushing these together will not work, as this code (from below)

> -     ext.cr4_pke = !!kvm_read_cr4_bits(vcpu, X86_CR4_PKE);
> +     ext.cr4_pkr = !!kvm_read_cr4_bits(vcpu, X86_CR4_PKE) ||
> +                   !!kvm_read_cr4_bits(vcpu, X86_CR4_PKS);

will generate the same mmu_role for CR4.PKE=0,PKS=1 and CR4.PKE=1,PKS=1 (and
other combinations).  I.e. KVM will fail to reconfigure the MMU and thus skip
update_pkr_bitmask() if the guest toggles PKE or PKS while the other PK* bit is set.

>  		unsigned int cr4_smap:1;
>  		unsigned int cr4_smep:1;
>  		unsigned int maxphyaddr:6;
