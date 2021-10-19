Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EA6433A48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhJSP2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhJSP2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:28:06 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56354C061746
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:25:53 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t184so6694592pgd.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lHBibsTrvq4Cgg6QnDekF4iiKeAOnVXvQAwCzckFFyo=;
        b=pw90G0DMCGMI4Cb7LtPw2ePxLUZw514sqcAvlUSfOh1KIdukydIIRiQK17s4WFTAJk
         mmID5rBS2ypCOgw5l/yLcJ04mjW34R5zuhy/D0kQ9yQJi79cioNOOBQIghADCNcj5r7z
         qgI/4sTLSkr6H75LiIqPNup+qiXB6bWqjwnu0NnhpkRpUl2GHMWNtdubGLZnuwQMfF9s
         7tbdFhVBMklvK3z4e2VnG2RJcnhRiMp9j/Rf8EP/xXYDaNhH1l1niUmkEcvjQY0407xT
         xrV8osnrNSOJb69jePLAGuuDYENt3wfIaWrESEPfC4rP+LqYbrdhXnCg4lWqd80TSXur
         Sceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lHBibsTrvq4Cgg6QnDekF4iiKeAOnVXvQAwCzckFFyo=;
        b=4rQjd/NuHBFWCX0zC+jMVb3cqj/uF+z8uJhi90DABg2WFDmXcVlbsH2tLOPN5/H1B4
         VxZiUS/vKXZGNwvQbtfxvHmZ5WliQU28BRskxvQYi7CYtF7H5rmmt2hf6Xb7XSndnsOO
         AS+K1IywY27kUWJy3DUiON/BS/H23LiVSg+iFwil+u+E/NSUrVl5hX7odd4H4j5Dw+GU
         SKbSNvhR2mTt0lQEzgNqsoornHxGoW+ahVAp2PiPEvXKYkKyN6jbW4ZZQBOsl4LgQOhP
         4M3MedkH3hUc3nv0f+JCl0iN8IRUIWeh/Xix/kO5XOnwhQGGASMkkzWZvUEnTwdi9EyP
         aY9A==
X-Gm-Message-State: AOAM532nyrSMAmGWdp/rnD5EdDIb2plo5aH+E1d4DJZkMcpVNjnz4u43
        FV9UT/g5SGFg5KAtHvZZ7Pcmjw==
X-Google-Smtp-Source: ABdhPJzFyajqFM9/+bLc8R/4S76ydlcATh6gKQvvd7kjvquOs+/k+zkHoHVUxeuzot7E+qA7PNKqmA==
X-Received: by 2002:aa7:949c:0:b0:44c:a0df:2c7f with SMTP id z28-20020aa7949c000000b0044ca0df2c7fmr542233pfk.34.1634657152664;
        Tue, 19 Oct 2021 08:25:52 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id oj1sm3280781pjb.49.2021.10.19.08.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:25:51 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:25:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/4] KVM: X86: Fix tlb flush for tdp in
 kvm_invalidate_pcid()
Message-ID: <YW7jfIMduQti8Zqk@google.com>
References: <20211019110154.4091-1-jiangshanlai@gmail.com>
 <20211019110154.4091-2-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019110154.4091-2-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> The KVM doesn't know whether any TLB for a specific pcid is cached in
> the CPU when tdp is enabled.  So it is better to flush all the guest
> TLB when invalidating any single PCID context.
> 
> The case is rare or even impossible since KVM doesn't intercept CR3
> write or INVPCID instructions when tdp is enabled.  The fix is just
> for the sake of robustness in case emulation can reach here or the
> interception policy is changed.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/kvm/x86.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c59b63c56af9..06169ed08db0 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1073,6 +1073,16 @@ static void kvm_invalidate_pcid(struct kvm_vcpu *vcpu, unsigned long pcid)
>  	unsigned long roots_to_free = 0;
>  	int i;
>  
> +	/*
> +	 * It is very unlikely to reach here when tdp_enabled.  But if it is
> +	 * the case, the kvm doesn't know whether any TLB for the @pcid is
> +	 * cached in the CPU.  So just flush the guest instead.
> +	 */
> +	if (unlikely(tdp_enabled)) {

This is reachable on VMX if EPT=1, unrestricted_guest=0, and CR0.PG=0.  In that
case, KVM is running the guest with the KVM-defined identity mapped CR3 / page
tables and intercepts MOV CR3 so that the guest can't ovewrite the "real" CR3,
and so that the guest sees its last written CR3 on read.

This is also reachable from the emulator if the guest manipulates a vCPU code
stream so that KVM sees a MOV CR3 after a legitimate emulation trigger.

However, in both cases the KVM_REQ_TLB_FLUSH_GUEST is unnecessary.  In the first
case, paging is disabled so there are no TLB entries from the guest's perspective.
In the second, the guest is malicious/broken and gets to keep the pieces.

That said, I agree a sanity check is worthwhile, though with a reworded comment
to call out the known scenarios and that the TDP page tables are not affected by
the invalidation.  Maybe this?

	/*
	 * MOV CR3 and INVPCID are usually not intercepted when using TDP, but
	 * this is reachable when running EPT=1 and unrestricted_guest=0,  and
	 * also via the emulator.  KVM's TDP page tables are not in the scope of
	 * the invalidation, but the guest's TLB entries need to be flushed as
	 * the CPU may have cached entries in its TLB for the target PCID.
	 */

> +		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
> +		return;
> +	}
> +
>  	/*
>  	 * If neither the current CR3 nor any of the prev_roots use the given
>  	 * PCID, then nothing needs to be done here because a resync will
> -- 
> 2.19.1.6.gb485710b
> 
