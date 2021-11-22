Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A336F459852
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 00:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhKVXTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 18:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhKVXTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 18:19:01 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45882C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 15:15:54 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id u11so15434852plf.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 15:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nVnyNoswxokQnIp8Sl4QeAE/5l97hmGoQDaJg8lEee0=;
        b=bXgw2P3rx9AgGhvco+g9dtKPOB7N1sgFLBRZ7W3edCUECJx+PDePPq8cuzlWMJ6rZI
         swMuf5G8aL47MHZhOZYst8mSuOEDnvkY2zo6+Szi7BYfsbf8vElNhh/+xEH6W5xpZIiA
         h1/ZYEQut9aaEOJqjcVMof4F74Dalz4kxIkXJhDAdujK9SFaaFPo3JAzfGfgdtSAifA2
         ms1wlRPffyWoYe7E0H3aqanqnVDrIHkqNkt1Nom1uvvbmUoczfNiWmUJu/7hvBw2pifs
         40y2/epKg7LuppIdCZN1Nl+n3XHJufLKBC7rYLk4EKvupbyr2SlAA2cC6pl7lf52H+ql
         Dbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nVnyNoswxokQnIp8Sl4QeAE/5l97hmGoQDaJg8lEee0=;
        b=H/t9/qQ5gdhkx7WQ4S/RKPEmmtmcZPB8BaNZIur98qfwU3zdE6jv7pyUd9Or9Y+8Yg
         FQvnUKgoHOE5iPmwzsBBydYExdKyCZ8WdFB9X4QSbfOx2kEI3maPeRKcAXws4pfsanSx
         B0Im06ERo30MVlNgcdw5gRBArK0A89nR5NnHCCEZE4ecXLaJC3rG1WY1ZzHP7JYq38nu
         VLESHmUYwy5vrYuWP0QYJFJh+MKCxRq731JipYMjN4nk3+cmsb87+jGXJUcD+Amo3tIu
         rwP1kofjM58VywCwNzbBdTgbXRY/P8Y7OHFfzo8zhEzM8mjuS8pEHIPuZcS/oQYkJ6IX
         1jMQ==
X-Gm-Message-State: AOAM532lflkwmAO4k3DFi67Ta33USAtXp4r2F0XUV4kqoPtbDKYNvxFv
        3ctxdGo9ZyAumqM5/uGcHqm2+g==
X-Google-Smtp-Source: ABdhPJwxp63OKH7j6ECzy3xy8yex+lgpwydbsFbhhnhddRB4GZaNKCxYwhknWNDlf5gNtR5pM1NWyw==
X-Received: by 2002:a17:90b:4a05:: with SMTP id kk5mr732949pjb.142.1637622953702;
        Mon, 22 Nov 2021 15:15:53 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w8sm3892503pgf.60.2021.11.22.15.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 15:15:53 -0800 (PST)
Date:   Mon, 22 Nov 2021 23:15:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hou Wenlong <houwenlong93@linux.alibaba.com>
Subject: Re: [PATCH 21/28] KVM: x86/mmu: Add TDP MMU helper to zap a root
Message-ID: <YZwkpcmAi07fOgbz@google.com>
References: <20211120045046.3940942-1-seanjc@google.com>
 <20211120045046.3940942-22-seanjc@google.com>
 <CANgfPd83-1yT=p1bMTRiOqCBq_m5AZuuhzmmyKKau9ODML39oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgfPd83-1yT=p1bMTRiOqCBq_m5AZuuhzmmyKKau9ODML39oA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021, Ben Gardon wrote:
> On Fri, Nov 19, 2021 at 8:51 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > Add a small wrapper to handle zapping a specific root.  For now, it's
> > little more than syntactic sugar, but in the future it will become a
> > unique flow with rules specific to zapping an unreachable root.
> >
> > No functional change intended.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/mmu/tdp_mmu.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> > index 9449cb5baf0b..31fb622249e5 100644
> > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > @@ -79,11 +79,18 @@ static void tdp_mmu_free_sp_rcu_callback(struct rcu_head *head)
> >         tdp_mmu_free_sp(sp);
> >  }
> >
> > +static bool tdp_mmu_zap_root(struct kvm *kvm, struct kvm_mmu_page *root,
> > +                            bool shared)
> > +{
> > +       return zap_gfn_range(kvm, root, 0, -1ull, true, false, shared);
> 
> Total aside:
> Remembering the order of these three boolean parameters through all
> these functions drives me nuts.
> It'd be really nice to put them into a neat, reusable struct that tracks:
> MMU lock mode (read / write / none)
> If yielding is okay
> If the TLBs are dirty and need to be flushed
> 
> I don't know when I'll have time to do that refactor, but it would
> make this code so much more sensible.

Heh, I did exactly that, then threw away the code when I realized that I could
break up zap_gfn_range() into three separate helpers and avoid control knob hell
(spoiler alert for later patches in this series).

There are still two booleans (to what ends up being tdp_mmu_zap_leafs()), but none
none of the call sites pass true/false for _both_ params, so the call sites end up
being quite readable.  At that point, using a struct ended up being a net negative,
e.g. kvm_tdp_mmu_unmap_gfn_range() had to marshall from one struct to another.
