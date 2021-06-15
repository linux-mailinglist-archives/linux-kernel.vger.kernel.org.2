Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177393A8C8E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhFOXft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhFOXfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:35:48 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEE0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 16:33:43 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id m2so397904pgk.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 16:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oxXmLWIGCYTYjwQzGJM6UAklDbOYw+c6pPA5rngEQ2I=;
        b=aVBGOrTDSikZ4jbP7ACRqK+Bg9bLRXJ+34HY9maOozyNVqDwJn/0JS8abeuQ1xkSRI
         1gn8kGCwlFc86QR63flC+BevZFCfr/wx0i4jtXiGuWbgZbmEbG5jA02Qf8gWnQtTasUF
         pDOjEkpatTTlpH49HV9RXWFwX+gDei3TMsGmOiaTVEPJ2dhXGl7RSrVWrOjMVVzm7iGp
         7uVQ9yunpV/XHCwnFumDODQHV9rKYNhzXLtKMxCOPk4CGxNbjdanCB+GpteAdOVD6hmq
         3admrXo5sPOo+lIzkcPRjt3FmhUHO/fE5b9rHmOWR7i5ZzNQkPx8CfBkEHL9nudFxWu3
         Ux2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oxXmLWIGCYTYjwQzGJM6UAklDbOYw+c6pPA5rngEQ2I=;
        b=rTjDqsjXDoidTc0HynBt0VVHqRNFPNz1k2Q+Ep07NU0vy1YjJLSH5vXNxOQ5QORolK
         fEZuoZgnPAa389nj3b5BgrIlAxURvhsj7H5SlIWqySPs/nKU1y4vwF2vgXhzuaz3bJhL
         0rIcbMY0jHhA4XClb3f1H2FPylqT+Yis50p/US9QnTuJ8q53211QTWPQLFBBBvUtlzbM
         n9gB9c6ew3B2NXvXRggIifOiR2AhfbZ9V6XJ0K03rWJE4J4IuXFoV/4Q4VvVp5ofvoWN
         UZ5v9jNxKCpZ/GGDilipOZrnq7uJZcC14zjZ1zMVwMKJDFcPoS2gfTSkLNpz/YiJbfJF
         KSlw==
X-Gm-Message-State: AOAM532E5eB1GHacCQan+VSTCUuv43ohEhVXjVQorddvu4/JFVyjQRcT
        IypkQc0+vOpqAKuCaxPaVGSY+g==
X-Google-Smtp-Source: ABdhPJxyhnlX3N4Xf6zfLczSYrH8OvF0YFG4IHqKfW03xa/Nk+oKWgj2W81rQC0GXQwwZ4PdlSJ1iA==
X-Received: by 2002:a63:b645:: with SMTP id v5mr1949877pgt.15.1623800023325;
        Tue, 15 Jun 2021 16:33:43 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v15sm199513pfm.216.2021.06.15.16.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 16:33:42 -0700 (PDT)
Date:   Tue, 15 Jun 2021 23:33:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] KVM: x86: Simplify logic to handle lack of host NX
 support
Message-ID: <YMk40yLeyV1DHpYp@google.com>
References: <20210615164535.2146172-1-seanjc@google.com>
 <20210615164535.2146172-5-seanjc@google.com>
 <CALMp9eRGj_5+dZXQazVEkeKeDnc7GFm1Vnt2RS_V6akAR=rZsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eRGj_5+dZXQazVEkeKeDnc7GFm1Vnt2RS_V6akAR=rZsA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021, Jim Mattson wrote:
> On Tue, Jun 15, 2021 at 9:45 AM Sean Christopherson <seanjc@google.com> wrote:
> > @@ -226,7 +224,7 @@ static void cpuid_fix_nx_cap(struct kvm_vcpu *vcpu)
> >                         break;
> >                 }
> >         }
> > -       if (entry && cpuid_entry_has(entry, X86_FEATURE_NX) && !is_efer_nx()) {
> > +       if (entry && cpuid_entry_has(entry, X86_FEATURE_NX)) {
> >                 cpuid_entry_clear(entry, X86_FEATURE_NX);
> >                 printk(KERN_INFO "kvm: guest NX capability removed\n");
> >         }
> 
> It would be nice if we chose one consistent approach to dealing with
> invalid guest CPUID information and stuck with it. Silently modifying
> the table provided by userspace seems wrong to me. I much prefer the
> kvm_check_cpuid approach of telling userspace that the guest CPUID
> information is invalid. (Of course, once we return -EINVAL for more
> than one field, good luck figuring out which field is invalid!)

Yeah.  I suspect this one can be dropped if EFER.NX is required for everything
except EPT, but I didn't fully grok the problem that this was fixing, and it's
such an esoteric case that I both don't care and am terrified of breaking some
bizarre case.
