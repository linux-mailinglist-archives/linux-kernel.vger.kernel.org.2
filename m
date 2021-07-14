Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A713C9238
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhGNUkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhGNUkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:40:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4A5C061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 13:37:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so2533696pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 13:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZVoghOGzFUo2g1EHO3svD45q6oPjKQ3+d8OVWxkKeFs=;
        b=JiU2GbbPqJEfjdLSrQJtgYY3oWalcHVF5itcoxrvKNVRdaiNBcHkThvP5a13TSbF/F
         975P58r0yXUBYucj06Qebr86YNALTQ+WyrW8dwDAzxB5rRtElAwzRA5OLP/QBpJbUPw0
         EXbFkofXnP6BHr0opiIKPx1G6cbmQMXpNY2Ft4SImg1JUU9x0QpEdd9rY9la8Lc6KI6Q
         /tBVkTIXZpTN14WonkOF+PsfWoFfhZeFXuH3VW2oazKiJSWXyLBV7BAcC3wIrR+eR9oF
         M6re8cCcSA0q47xQspQh2x4zNkVDMuZ8Fmn8Z59RpcGleVkcOUjcm7nBPQLI7V+hGLzL
         eMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZVoghOGzFUo2g1EHO3svD45q6oPjKQ3+d8OVWxkKeFs=;
        b=ih56b3k0DuDWsuKZApUTGgikBiLuq9eEEAZxGdzoPDVKyy4DhiRBQC6AB3XjBpd0lw
         hlze3xNqkJZyHry9054ZfJSddHa4Ep26guKS3SMaFH52yLmNM93a0yP4ugwEQI+KP/aZ
         4DlqbltVxUw33Av9KcywBA+aWvxFl0F/CZl+zQH5vv5m/47VDN4SwW+s8L94R3eoixUA
         eWlO8HynIQ7FwC/uRuW5zltKqHbgStXBw+ADmalzsBLINZ6XtYTxf5xduFC8GlaJ2BMB
         XB7/MRIggsZJ9BDFW+1iClnpHUWXkPDCOsJs4VUTjE9kuDJAjkCc14OzvpjRNBIKysck
         O62Q==
X-Gm-Message-State: AOAM531qje1ywKsfdtXunBo1CPc3ITz6YGrGFjKuBEFm/QLV3yZ15/m+
        Z+xFHOIx+XRcBN6VAWfDbdbCbORYChdtNw==
X-Google-Smtp-Source: ABdhPJwUL+v46lDMA+LqJ5QvGmnIpHnxv/opqwJmq3pJ98w6lIS+a2sQ5Xiu1judhEtQf2xwoOjymw==
X-Received: by 2002:a17:90b:b88:: with SMTP id bd8mr5383285pjb.26.1626295029550;
        Wed, 14 Jul 2021 13:37:09 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t37sm3942693pfg.14.2021.07.14.13.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 13:37:08 -0700 (PDT)
Date:   Wed, 14 Jul 2021 20:37:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 02/40] KVM: SVM: Provide the Hypervisor
 Feature support VMGEXIT
Message-ID: <YO9K8akh1CdY1kjd@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-3-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-3-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> Version 2 of the GHCB specification introduced advertisement of features
> that are supported by the Hypervisor.
> 
> Now that KVM supports version 2 of the GHCB specification, bump the
> maximum supported protocol version.

Heh, the changelog doesn't actually state that it's adding support for said
advertisement of features.  It took me a few seconds to figure out what the
patch was doing, even though it's quite trivial in the end.

> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/uapi/asm/svm.h |  4 ++--
>  arch/x86/kvm/svm/sev.c          | 14 ++++++++++++++
>  arch/x86/kvm/svm/svm.h          |  3 ++-
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
> index 9aaf0ab386ef..ba4137abf012 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -115,7 +115,7 @@
>  #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
>  #define SVM_VMGEXIT_AP_CREATE			1
>  #define SVM_VMGEXIT_AP_DESTROY			2
> -#define SVM_VMGEXIT_HYPERVISOR_FEATURES		0x8000fffd
> +#define SVM_VMGEXIT_HV_FT			0x8000fffd

This is fixing up commit 3 from Part1, though I think it can and should be
omitted from that patch entirely since it's not relevant to the guest, only to
KVM.

And FWIW, I like the verbose name, though it looks like Boris requested the
shorter names for the guest.  Can we keep the verbose form for KVM-only VMEGXIT
name?  Hyper-V has mostly laid claim to "HV", and feature is not the first thing
that comes to mind for "FT".

>  #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
