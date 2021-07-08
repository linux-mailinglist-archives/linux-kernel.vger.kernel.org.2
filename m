Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0DD3C1A0C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 21:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhGHTtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 15:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhGHTs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 15:48:58 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B573C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 12:46:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so4645182pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k10aRlUR7+OenDnP6mq1+oUG1mQi2nyXNA5HL2wFblk=;
        b=tnwoBooFdiCi3VUYZyjDBH4NCUpnInfxgZzdF1DnFPpZhiv7iN0HRd6tcUYkzUH7CW
         K/L+mRD2zCQrpgIrl/Us2ba5zt43o98P/IJgWJ59FMZe/PIAKZPd+K06586DaEegyGrq
         8GzEw4rg6jE3WTNMn+vjuj4GO1K/Z7nVKf6DLxAHIQE2OZkpBQ8ISddmsWMvxBeP0Bn2
         0F6+ClblpQkXgS163bvyRRRC2U6AJUD91F9Xet3zEYezdOzst53EUYrTAyKeB/9uVoN3
         r1qNr5jZvxSCxbwdh/GrupxuwrVCaKZgy0q2kJogWhveU+J92XrqlnFvcPOfqvGdVMVD
         VkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k10aRlUR7+OenDnP6mq1+oUG1mQi2nyXNA5HL2wFblk=;
        b=bMjL0RUHQrxgn8LImeBowI51MqRkMCMoLoESY5bk/sZFT/bxFIbxOVzmhXmNsUlO2e
         jnMFPzkDtKIPOpQMX6BnGhXWha+oE939G8z2FchXXRya1qL55h7bRC84wZ5lTZzlAKZG
         4Fv/5xZXDi0rfL22rfSsRIEDI6tL0FqXq5XWwhMRaqU6TgGdZIDj3desaSeNKUckAVzW
         WR39BhYkrHX1UIh4730hJ7KOTPuI0rHs6a78wd/WTvNnoZ2fszWSfhVfBBKO37/JV9j2
         NseChJSRdpV68xfYBj428rlrl1/CXOS/+IUeXTZLFuiG7bPCNopos1SVjDBP41WF3RVj
         SNLw==
X-Gm-Message-State: AOAM531OhC0Smha/tiLPCwdzfdzFVJCIArJ2HluP7C5bOenBilHuUX7s
        mFPXdTAQLZFvBfQPEKbeUUJGCw==
X-Google-Smtp-Source: ABdhPJwOcUHeTLiJbsu1zhkSv1UmqJ2IxztsciphD6g2qsBayBD2RlaGEk1noqHgiIwFshn8QKKIiQ==
X-Received: by 2002:a17:902:b409:b029:129:a9a6:fc76 with SMTP id x9-20020a170902b409b0290129a9a6fc76mr13442909plr.68.1625773575662;
        Thu, 08 Jul 2021 12:46:15 -0700 (PDT)
Received: from google.com (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with ESMTPSA id y9sm3506954pfn.182.2021.07.08.12.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 12:46:14 -0700 (PDT)
Date:   Thu, 8 Jul 2021 12:46:10 -0700
From:   Ricardo Koller <ricarkol@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 0/5] KVM: x86: Use kernel x86 cpuid utilities in KVM
 selftests
Message-ID: <YOdWAvtk66Rbv9Lk@google.com>
References: <20210422005626.564163-1-ricarkol@google.com>
 <c4524e4a-55c7-66f9-25d6-d397f11d25a8@redhat.com>
 <YIm7iWxggvoN9riz@google.com>
 <CALMp9eSfpdWF0OROsOqxohxMoFrrY=Gt7FYfB1_31D7no4JYLw@mail.gmail.com>
 <16823e91-5caf-f52e-e0dc-28ebb9a87b47@redhat.com>
 <YOc0BUrL6VMw78nF@google.com>
 <8a4163ee-ac31-60fa-4b8b-f7677ec0fd46@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4163ee-ac31-60fa-4b8b-f7677ec0fd46@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 07:57:24PM +0200, Paolo Bonzini wrote:
> On 08/07/21 19:21, Ricardo Koller wrote:
> > > I also prefer the kvm-unit-tests implementation, for what it's worth...
> > > Let's see what the code looks like?
> > I'm not sure I understand the question. You mean: let's see how this
> > looks using kvm-unit-tests headers? If that's the case I can work on a
> > v3 using kvm-unit-tests.
> 
> Yes, exactly.  Thanks!

Cool, will give it a try and send a v3.

Thanks,
Ricardo

> 
> Paolo
> 
