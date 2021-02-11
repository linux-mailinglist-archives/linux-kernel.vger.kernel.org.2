Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759D9319238
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhBKS1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhBKSVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 13:21:11 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDFDC061788
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 10:20:30 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id t11so4470578pgu.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 10:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cx7+IAlMjVEhgHQf7V03jqKNyPkobgGwu8xQGqHKAsI=;
        b=t6mlYDY5o1l9HFJo3+mtRUEbkLgCwlPoyWFso3+T7umSCBjifIPc7mcSzE5cc8s6Wy
         KosoWcL+NaUFa1UHqUHQqHiUDx0JccBybqIiecO4hla3BhxNjHJ18V5RfQaOj+G8+OSd
         8yZ83RSQaM+k+FpGzTdruQ+oWZ6zHAJriVrTLUgj+B37QbHBWBWL8w+wyV4ZyG53TaDY
         JJRrG6kn7V8M3wRwuv3OH3IbzhnDehmeL7ntRQjmR3mWOBaqmeOUorFHzr6vopySd7AI
         T81S7KghtBTGQrHOGt6Ie/12bx7jYJL+IDWaBbJFddVQubqeRFh+tBRa2o79pypfW7vg
         vhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cx7+IAlMjVEhgHQf7V03jqKNyPkobgGwu8xQGqHKAsI=;
        b=XqL2V7FmbqXLOl15IPdct6YHA20mGCyGB/REXEQoS1upMjBzQELgzbdOT/AvdpNaRv
         xU2iXv0nZUrry2NrXs8FJhvAM43kJK6VCVdxycoUlwDIkLlWNyJVaD0RgB0yQrsoxyJB
         0aGf8HBJc2od+HIAoiHW1sCswR1MuSa2lP+0Vj2opJqvxrvt7xtQ0VOWkIW0zg+HhBeX
         iFz0W2nGQfV6qxzsCHobHEyboEwzWKr7KoClUsEkmFSklC/xB1TiZggS2stZ6xDG/rs5
         br6E2zVN/PYPBm+8ktFHxhP9qPTv4t5s8Jgx4uTGSyzYmRiNuGVsZLe0auheeAKp3F3l
         KyVg==
X-Gm-Message-State: AOAM531sUKdcBpuX1923Z6z48UaCQtCMwfK+7Y2S5ghPAsQC9/WtihwL
        Syg3XZ9TKi+3R6vl6oFqd5m62A==
X-Google-Smtp-Source: ABdhPJyT1OtutfI2yZlQMRd6GQwZS5ubkKsOpQJWkSY8DquqEy+HFzt/ZE4JZ3Qw2Lm2cfb7Aa7Ejw==
X-Received: by 2002:a63:4346:: with SMTP id q67mr9262090pga.223.1613067629710;
        Thu, 11 Feb 2021 10:20:29 -0800 (PST)
Received: from google.com ([2620:15c:f:10:f588:a708:f347:3ebb])
        by smtp.gmail.com with ESMTPSA id s135sm6452304pfs.206.2021.02.11.10.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 10:20:29 -0800 (PST)
Date:   Thu, 11 Feb 2021 10:20:22 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Makarand Sonare <makarandsonare@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pshier@google.com,
        jmattson@google.com, Ben Gardon <bgardon@google.com>
Subject: Re: [RESEND PATCH ] KVM: VMX: Enable/disable PML when dirty logging
 gets enabled/disabled
Message-ID: <YCV1Zj+CJgyPN2jB@google.com>
References: <20210210212308.2219465-1-makarandsonare@google.com>
 <YCSAh31LP4QwBfHZ@google.com>
 <d6dbe1e3-eaa9-f171-ce5f-6a00b21f1c9a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6dbe1e3-eaa9-f171-ce5f-6a00b21f1c9a@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021, Paolo Bonzini wrote:
> On 11/02/21 01:55, Sean Christopherson wrote:
> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > index ee4ac2618ec59..c6e5b026bbfe8 100644
> > > --- a/virt/kvm/kvm_main.c
> > > +++ b/virt/kvm/kvm_main.c
> > > @@ -307,6 +307,7 @@ bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req)
> > >   {
> > >   	return kvm_make_all_cpus_request_except(kvm, req, NULL);
> > >   }
> > > +EXPORT_SYMBOL_GPL(kvm_make_all_cpus_request);
> > If we move enable_pml into x86.c then this export and several of the kvm_x86_ops
> > go away.  I know this because I have a series I was about to send that does that,
> > among several other things.  I suspect that kvm->arch.pml_enabled could also go
> > away, but that's just a guess.
> 
> I don't like the idea of moving enable_pml into x86.c, but I'm ready to be
> convinced otherwise.  In any case, for sure you can _check_ enable_pml from
> x86.c via kvm_x86_ops.flush_log_dirty or kvm_x86_ops.cpu_dirty_log_size.

Ya, after taking another look at my series, exposing enable_pml isn't necessary.
What I really dislike is bouncing through VMX and exporting MMU functions for
no real benefit.  The x86/MMU functions/behavior are tightly coupled to VMX's
implementation, bouncing through kvm_x86_ops doesn't magically decouple things.

Anyways, kvm_x86_ops.cpu_dirty_log_size can be change to a simple integer instead
of a callback function, and with that change I'm happy using cpu_dirty_log_size
as the check with x86.c/mmu.c to determine whether or not hardware dirty logging
is supported.

Thanks for the early sanity check :-)
