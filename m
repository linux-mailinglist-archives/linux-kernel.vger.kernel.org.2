Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC9A32ADA5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2359722AbhCBWCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbhCBTVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 14:21:09 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C803DC06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 11:20:24 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u12so2690025pjr.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 11:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nTR1gSY8AyYBmlkN5NsyaE59tkLRlPt3XQnuP/gtEls=;
        b=FYAaFJLMeUfXUwWCbf1ENPmBFy0H5/UzPli0k0XMaUSiA/XyNFmOM6M8gz9PTSZzPd
         4oy+ZkmwVTFba1Hy/LJ45HqVSbLbMMmYiBYbqM9DkazTMipXqfsdXX/HFVdG0Kg+PG4/
         Jw9G6Lrh5c/pwwUjafGnSmAVGjiSknjwRA3/XmN/SL9Y3xwir4FQ4qjnWGMRZ1K7Gs06
         +l2/f67IZKCQ1cXg6+U/bxe8sekLMG7htcF5LHJXbyQ9/Fk8nAF5RRUbUb8MGQ07p/4x
         ctydUAtxPAvChUQdFQa7d+JC1eps48K7ZiNO+/glmI+fX+SSaJBnbXdOcOEAzQZgvyXn
         XAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nTR1gSY8AyYBmlkN5NsyaE59tkLRlPt3XQnuP/gtEls=;
        b=ABVId2p5bBg3LMr8Vj9fzkBfndk2yfmUgoHyFBmLgA/27iOw+dyH7vG3Id1JZBkDZ3
         PVHKB06X3u28Mko0gJrCY7ubjdIH20JYVoR3LK/LawvLpMiKyLMwMLwTEUUz29tMcVeP
         zILhZPpInHJCulEAXrqAo4z8ZBaEEXrktyf1A4PcyOjsUeTIPSiM7BKhSoW7sun+vgh0
         SfrmaEmDl4GStAKBoShTiwtNmag4eyg1pHsUyGWNU+irPYpVjqnRFQ4lzn15dOekcD/P
         in0vqENtLLqPT4AJHs9xMMWACEFgbjkep4wgkoJUsSOVWI352TdmaxdRxgxteB+d8xq6
         CzMw==
X-Gm-Message-State: AOAM5300GIvs7gn4OGR+l1fT0eVFFakvQAfLYBxxfpNIgB2UCTSliswV
        2UAIhEdaI6aKmz6FZrrpTp0nYQ==
X-Google-Smtp-Source: ABdhPJzCY3Cp3rFD0UgLcAl5GfX9tJC8u7gu1D91cETA8vt2rNf28lrXCjk6d40ldU7B1AsGIPtJew==
X-Received: by 2002:a17:902:9d82:b029:e4:b5a9:ff9f with SMTP id c2-20020a1709029d82b02900e4b5a9ff9fmr4944015plq.75.1614712824062;
        Tue, 02 Mar 2021 11:20:24 -0800 (PST)
Received: from google.com ([2620:15c:f:10:805d:6324:3372:6183])
        by smtp.gmail.com with ESMTPSA id w128sm22095590pfw.86.2021.03.02.11.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 11:20:23 -0800 (PST)
Date:   Tue, 2 Mar 2021 11:20:17 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Babu Moger <babu.moger@amd.com>
Cc:     pbonzini@redhat.com, wanpengli@tencent.com, kvm@vger.kernel.org,
        joro@8bytes.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, vkuznets@redhat.com,
        tglx@linutronix.de, jmattson@google.com
Subject: Re: [PATCH] KVM: SVM: Clear the CR4 register on reset
Message-ID: <YD6P8TbrZKD4zbxV@google.com>
References: <161471109108.30811.6392805173629704166.stgit@bmoger-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161471109108.30811.6392805173629704166.stgit@bmoger-ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021, Babu Moger wrote:
> This problem was reported on a SVM guest while executing kexec.
> Kexec fails to load the new kernel when the PCID feature is enabled.
> 
> When kexec starts loading the new kernel, it starts the process by
> resetting the vCPU's and then bringing each vCPU online one by one.
> The vCPU reset is supposed to reset all the register states before the
> vCPUs are brought online. However, the CR4 register is not reset during
> this process. If this register is already setup during the last boot,
> all the flags can remain intact. The X86_CR4_PCIDE bit can only be
> enabled in long mode. So, it must be enabled much later in SMP
> initialization.  Having the X86_CR4_PCIDE bit set during SMP boot can
> cause a boot failures.
> 
> Fix the issue by resetting the CR4 register in init_vmcb().
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Cc: stable@vger.kernel.org

The bug goes back too far to have a meaningful Fixes.

Reviewed-by: Sean Christopherson <seanjc@google.com>


On a related topic, I think we can clean up the RESET/INIT flows by hoisting the
common code into kvm_vcpu_reset().  That would also provide good motivation for
removing the init_vmcb() call in svm_create_vcpu(), which is fully redundant
with the call in svm_vcpu_reset().  I'll put that on the todo list.
