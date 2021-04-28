Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC8D36DD52
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbhD1Qqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241126AbhD1Qqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:46:53 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FC6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:46:08 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso3925062otn.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DmiskXVVNt5ciuwEiKHO8o/4wceYpi0Zcrr9JiPcz+4=;
        b=tKlQZLtx45gwtX02vXG4am95yPgB8gzjVWGEGzkBK5rHSLQtuz5IZ04D40M7aqZ8UA
         SQrj2s883sseBmwH71ouOzMNI+nk8lJvYORtMOX1fHSPdSmTYM4FgiLNSmREZxAzSaR3
         MqJ+Vk3vjL9lIS0E0F6NJ0j9VzeXhtVyH+fTVmgE83MhD/Gb3dVdfpD84wFeBMAb2PWR
         AuJlum8cNObwRmHDfiuGAdA93msryBFu9PTQ1F8YBTwzkIBJh/Yf4Rh98+8ks4HQ7g6K
         6FiQfzCzyaDxawWQPgKOnVJLKo/6MvQ+R9VGPKwgB7hs4v5qkwXjiJJgkP2K9kczPgWP
         x2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmiskXVVNt5ciuwEiKHO8o/4wceYpi0Zcrr9JiPcz+4=;
        b=p01hLU+1R9s8l13WyZow6Q/WE/KoJXkGNEs+X9cCZpsu+dLg7VOSXxaWBIPrdh7czv
         04sk8DQuEREvv7OJQSFCR/x67cKfIQphvoyhI/qNtzxMj2BqgMT3yTARx/nZJ0xUiRN2
         hhxMOhCjQFhHTYcFFQftnlWSeIqDpQ6aFvOAJFmpZssklwQFOOjv75nljE0VY22Wsimi
         k/3el+5rQSbk70bCTqRd1GygSRjE47wCcQ2yeweDok/kKaVmvoK+7hTDF9fINgdjyGFi
         FFPcYfaV8kxhXkbLGg05wg2j+E+Lrs2RYEOf5A15cxy6F8YvgjbvGN1WaLl+OYGfXoYI
         bpiA==
X-Gm-Message-State: AOAM533jZp5B+xn9zLMsSjspJNR+rK88dG2qgf1QhN+HY38aMDhiYzdf
        R/9mAU5TnzbuEIziKIJGhhDrMY/KGh8ZPZ4wYv26Iw==
X-Google-Smtp-Source: ABdhPJxm9/4vsmoaNUh37g6GSvioejnyYo2lL7TUff8Bnx5tp58+g23lXhmGQX5QBlQ6T0GCLeWBILuDhGRYFHMfqSo=
X-Received: by 2002:a9d:7857:: with SMTP id c23mr15021583otm.208.1619628367968;
 Wed, 28 Apr 2021 09:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210427223635.2711774-1-bgardon@google.com> <20210427223635.2711774-7-bgardon@google.com>
 <1b598516-4478-4de2-4241-d4b517ec03fa@redhat.com>
In-Reply-To: <1b598516-4478-4de2-4241-d4b517ec03fa@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 28 Apr 2021 09:45:56 -0700
Message-ID: <CANgfPd_o+UA4ry7Kpw3WbcPZYm32r+1o=hQmZdazsrZvO4aynA@mail.gmail.com>
Subject: Re: [PATCH 6/6] KVM: x86/mmu: Lazily allocate memslot rmaps
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 3:04 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 28/04/21 00:36, Ben Gardon wrote:
> > -static int kvm_alloc_memslot_metadata(struct kvm_memory_slot *slot,
> > +static int kvm_alloc_memslot_metadata(struct kvm *kvm,
> > +                                   struct kvm_memory_slot *slot,
> >                                     unsigned long npages)
> >   {
> >       int i;
> > @@ -10892,7 +10950,7 @@ static int kvm_alloc_memslot_metadata(struct kvm_memory_slot *slot,
> >        */
> >       memset(&slot->arch, 0, sizeof(slot->arch));
> >
> > -     r = alloc_memslot_rmap(slot, npages);
> > +     r = alloc_memslot_rmap(kvm, slot, npages);
> >       if (r)
> >               return r;
> >
>
> I wonder why you need alloc_memslot_rmap at all here in
> kvm_alloc_memslot_metadata, or alternatively why you need to do it in
> kvm_arch_assign_memslots.  It seems like only one of those would be
> necessary.

Oh, that's a good point. We need it in kvm_arch_assign_memslots
because of the race I identified in the thread for patch 5 of this
series, but we could remove it from kvm_alloc_memslot_metadata with
this patch.

Of course, it would be much nicer if we could just keep it in
kvm_alloc_memslot_metadata and find some other way to stop memslots
without rmaps from being inappropriately installed, if anyone has a
simpler way to accomplish that.

>
> Paolo
>
