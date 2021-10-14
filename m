Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5714742E1A0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhJNSxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhJNSxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:53:08 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1286CC061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:51:03 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso5465583pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LVHr0bsBDvFWzi52IOLJNCVpf9+SHH8Rz7Qy8n0fv+E=;
        b=e1/6dh3LqsPP5mEDUNgJN/5k38hTVQq//lcTvS/8eKW3U4cfLo6IFof8/fdVM2/nPf
         5SjiNpGQwk8RJHhIEJB+3YsfqIwH4TYwCiu/CYy5CekjNne89tKqxBgcZfxDlBTiDtJ6
         AEGtVgxbV0tH/6HtTB0DC8dltaWRkZ6bLPc1IO4TBMoI4YJVRmrXZ5gbTd0jbu9lNbeb
         B5KW8HGAtw9CHapYy9nd+RHhvEVCR2FLAEeALHLxJgSLJ2FnAhR3PWGRM0J0VBmiSxVv
         796qkEOVCgL7KsOrL/cP3y3M/mJwu1XNJokzfWe9jJfls/zdKi71r2P+4At7x6A/VoDg
         4duA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LVHr0bsBDvFWzi52IOLJNCVpf9+SHH8Rz7Qy8n0fv+E=;
        b=wPoVRfaBPejXXcZiORFHwFBR+7nQqUw/5XrlxjbBiG7m8ljR7OR28qe/lghTIQceNo
         6/qaDtGqDkrnU+7sUy/x8h4mde4ZWE0gOBRDb62S/B71Mq3Iw5r5O3+Dq/xZk3hk1jzN
         RVRfHXdaFwxKnhsCiNRvj6s4/Ifz2h22dkatVI6nbWrFulsWq1285K5O3EAIUHn0Qk3X
         AG2Hl6omSftJHb0uYUTQaz16dv6XB+S8wE8jlQE5EFGuAckExhGfbSW4WnRhd3eq9fTw
         XdXsbA2Jrl2xqKjSj2bJitDZCT5a/9MYmoRXZA/BQHEZTfUtZbk9RaWEU6BVDev6VqwD
         41Eg==
X-Gm-Message-State: AOAM532UCdkBuDdDZl80Gnhn4teT8Jc7WUsGZ5QOGaSIGeVXPF7PLy8p
        yI8mQthRdwddg5+/VYpcm121IA==
X-Google-Smtp-Source: ABdhPJzAlaDaotn9nIMDhY0E0m/un8LtOqwH+qJ09R0Mjj0DRTrA9QmBRZIeXkpBTkaNBWkJcMNvBQ==
X-Received: by 2002:a17:90b:390d:: with SMTP id ob13mr22724433pjb.50.1634237462466;
        Thu, 14 Oct 2021 11:51:02 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id oo9sm3380968pjb.53.2021.10.14.11.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 11:51:01 -0700 (PDT)
Date:   Thu, 14 Oct 2021 18:50:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] KVM: X86: Don't reset mmu context when toggling
 X86_CR4_PGE
Message-ID: <YWh8EndpDdHYX7aY@google.com>
References: <20210919024246.89230-1-jiangshanlai@gmail.com>
 <20210919024246.89230-3-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210919024246.89230-3-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> X86_CR4_PGE doesn't participate in kvm_mmu_role, so the mmu context
> doesn't need to be reset.  It is only required to flush all the guest
> tlb.
> 
> It is also inconsistent that X86_CR4_PGE is in KVM_MMU_CR4_ROLE_BITS
> while kvm_mmu_role doesn't use X86_CR4_PGE.  So X86_CR4_PGE is also
> removed from KVM_MMU_CR4_ROLE_BITS.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---

With the KVM_REQ_TLB_FLUSH_GUEST caveat, 

Reviewed-by: Sean Christopherson <seanjc@google.com>
