Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634F13A8BF1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 00:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhFOWmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 18:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOWmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 18:42:09 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D0FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:40:03 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w127so267366oig.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FjTlkg9HTKYPNQ6rTdKTsbehN1/6cFTQ2pi4yksTAgk=;
        b=XDz27kZZX+QjBrZPSqflKRb/wh1fcy/af2rHpxqucNV7a0VTYwcF5FRGpF7bqBHCZB
         sUBG77qp5izO2Ya46JP6CSIKeYCebRQjdRrjpvOZihNo92WeXwqVKxA6Ip3Ph8511QnD
         4yGldtUZNWep7+OIVBO9cNh9Zh1BFfJ9LGGDHIQuHg+ib3eJPoxTd7KufYnzzp8gUeTG
         kYUtfG8S5Ht1H6Fyt6XBrC2XohPQlateJwA/kJ3lL2p0Er355HkG+Ahjih9Pt9i5rMYw
         qTuj+uIHX8IPlF8wI6bn3EagKA3hUQnVydrGhrXJqFDD84PEBKNPpVzZX6oOHs6o87HX
         LheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FjTlkg9HTKYPNQ6rTdKTsbehN1/6cFTQ2pi4yksTAgk=;
        b=mwjKxGY3DRFNMubPrwj79lOMZqqW9nU1Vycy0RuPkpM7nUnTGr72Dqk1h+1YI8i1YU
         PT/JTQuxoQXnZQin1ONMZojF3v+6aynJxZiuyTp1sMGwHUJerpGuJzJi7qXgf2p3AmzW
         Xu/u5qi5ijDFqdKy8711c2NpXDXzERAkCBpVun64ScFI7OI1LYJgsqQGSsjk2+3AoWxp
         caWEXCEY36xu+esDRn7gEsJZgwHmgJT7Rg+1fH87Js7NAVujhysaWJIoTJ2Zf6UNoXhQ
         BNvvoPe0qE+u8NKYUfDeqBu14d8ihL/NAOst+SxsIquQMyJQ188U5hZIXj3F0Nz801hH
         tJtQ==
X-Gm-Message-State: AOAM5305qA7O4vQrZeOzRRPFt+qFjLLfdfy32kcVgCj12WmOl9ImSv+O
        RxGneyI00ltMq0IcDLU/Itrvt7YmBi9BS+7oWlpF9A==
X-Google-Smtp-Source: ABdhPJzT3bm/OStyazgk1zy8otTaykTz1x4356J5GCc8RRL7Ou/AqkZ60+dxhqdXV4LsdHJ+a/m9inZkb/jTvnPp+d0=
X-Received: by 2002:aca:1201:: with SMTP id 1mr4781940ois.6.1623796802294;
 Tue, 15 Jun 2021 15:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210615164535.2146172-1-seanjc@google.com> <20210615164535.2146172-4-seanjc@google.com>
In-Reply-To: <20210615164535.2146172-4-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 15 Jun 2021 15:39:51 -0700
Message-ID: <CALMp9eSkVaDfCJwW1eds=7H7yn2pKJPKoFVpc1GQcEqGD5S0Dg@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: x86: WARN and reject loading KVM if NX is
 supported but not enabled
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 9:45 AM Sean Christopherson <seanjc@google.com> wrote:
>
> WARN if NX is reported as supported but not enabled in EFER.  All flavors
> of the kernel, including non-PAE 32-bit kernels, set EFER.NX=1 if NX is
> supported, even if NX usage is disable via kernel command line.  KVM relies
> on NX being enabled if it's supported, e.g. KVM will generate illegal NPT
> entries if nx_huge_pages is enabled and NX is supported but not enabled.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/x86.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index acc28473dec7..1f6595df45de 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10981,6 +10981,9 @@ int kvm_arch_hardware_setup(void *opaque)
>         int r;
>
>         rdmsrl_safe(MSR_EFER, &host_efer);
> +       if (WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_NX) &&
> +                        !(host_efer & EFER_NX)))
> +               return -EIO;

Input/output error? Is that really the most appropriate error here?
Why not, say, -ENOTSUP?

I'm sure there's some arcane convention here that I'm not privy to. :-)

Reviewed-by: Jim Mattson <jmattson@google.com>
