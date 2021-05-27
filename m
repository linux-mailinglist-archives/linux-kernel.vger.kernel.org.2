Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFDD393961
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 01:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbhE0Xsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 19:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbhE0Xsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 19:48:37 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E252AC061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 16:47:01 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id l70so1203351pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 16:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I76gEd2y8NZgT46DhAs2hG3Qnuv9ogmPiat5OsvRnA0=;
        b=MsIb+Crojg6OI9wOzI4AxSfnbJsmfCv0M2OgzJNnUXoV9AEuj19Vpz3CqxysZNzZnZ
         Plya6C1xvbZB/3tX++03I09ERTyJl3Lt5KrSziW+uuhB2aXcQyv4fdVL9/AkYu4lxNXu
         lLnGczJAk5Dx7L4sJEq+yd0hxGoghFn4ZHAbi1KudY5mzPazZXUFQlctZYO75Yn2ndQR
         sBIrQ2F42WIt2wJ2qmdP4NCpobowA84s0UVQ0XRsVO6dFSE7GtREX3fRJPxKze5e/5cD
         q39OP5OwlgGYh3rxPc5X2eHChsnbhcRnCtXjRVNoBfm5O1sh2lT0C4BfPshagW1OgtnR
         C/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I76gEd2y8NZgT46DhAs2hG3Qnuv9ogmPiat5OsvRnA0=;
        b=h9EuKpxuwqfXD0nCqM7WXndrsCw0NNhDLVkSZANBwBDBiAaxQyDsh7T0hHeW4qhbgD
         fS6kGpgM1We0qSInqWkJIe3OpHMpcOqY6XziHpYPlXRBs2rJvjSNMIb+E0eYVp39Yb7G
         j72r7xgREGzw3NsSYy6JgLn8tGr/Ya4r+VRPcLxKJCuLZ5i20UevenMpramgcsbwqWBg
         +6r6p2WdPm2swRXvz+BHz2Gcl7nCif32XmLjgupHGhnCwtOpUjOiXYbduEhm12hVY0cw
         PjR1ayM/Y6lFe/l6DMOfAwQidYSsSRpK8/cB/rUzNSDMKd4hQc9jAW+v49UB7Mu7J3FL
         gHfw==
X-Gm-Message-State: AOAM532v3Hprr4jBO7lXgmd1GHISCauBHOyib3pv1MhCMxCMLB+I5GH1
        U+7azAkB6IeGsjT34MZuclOt+Ba1jr4ScA==
X-Google-Smtp-Source: ABdhPJxYb/vNEIhtApsqMbOJzuCCVz5BiIDHTihYPnbhn29m7ryqpjeHUCtq2JHQZt9vBgUREMYxVw==
X-Received: by 2002:a62:52c6:0:b029:2e8:c684:b741 with SMTP id g189-20020a6252c60000b02902e8c684b741mr1002753pfb.38.1622159221260;
        Thu, 27 May 2021 16:47:01 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id 84sm2816819pgh.87.2021.05.27.16.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 16:47:00 -0700 (PDT)
Date:   Thu, 27 May 2021 23:46:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 1/2] KVM: X86: Fix warning caused by stale emulation
 context
Message-ID: <YLAvcG59BgJ1i0+I@google.com>
References: <1622091679-31683-1-git-send-email-wanpengli@tencent.com>
 <YK/Q7ESa44lcqlMM@google.com>
 <CANRm+CwL-uS3FPZxpW_cB=vdD4WKLRDPTpd4hsn57eWpKZ_CtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+CwL-uS3FPZxpW_cB=vdD4WKLRDPTpd4hsn57eWpKZ_CtQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021, Wanpeng Li wrote:
> How about this?

Yep, perfect!  Sorry about the squash confusion.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index bbc4e04..dba8077 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7226,6 +7226,11 @@ static void init_emulate_ctxt(struct kvm_vcpu *vcpu)
>         BUILD_BUG_ON(HF_SMM_MASK != X86EMUL_SMM_MASK);
>         BUILD_BUG_ON(HF_SMM_INSIDE_NMI_MASK != X86EMUL_SMM_INSIDE_NMI_MASK);
> 
> +       ctxt->interruptibility = 0;
> +       ctxt->have_exception = false;
> +       ctxt->exception.vector = -1;
> +       ctxt->perm_ok = false;
> +
>         init_decode_cache(ctxt);
>         vcpu->arch.emulate_regs_need_sync_from_vcpu = false;
>  }
> @@ -7561,11 +7566,6 @@ int x86_decode_emulated_instruction(struct
> kvm_vcpu *vcpu, int emulation_type,
>             kvm_vcpu_check_breakpoint(vcpu, &r))
>                 return r;
> 
> -       ctxt->interruptibility = 0;
> -       ctxt->have_exception = false;
> -       ctxt->exception.vector = -1;
> -       ctxt->perm_ok = false;
> -
>         ctxt->ud = emulation_type & EMULTYPE_TRAP_UD;
> 
>         r = x86_decode_insn(ctxt, insn, insn_len);
