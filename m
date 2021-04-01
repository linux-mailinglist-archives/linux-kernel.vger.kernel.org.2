Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9289A351B0E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbhDASF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbhDARpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:45:19 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF9EC031155
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 09:48:48 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id f1so2547332ilk.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LX7TTVacyu/SInUXeH7qzWi/YSD8f9C42RXcS3AUsk4=;
        b=nH/i/l/EVo2o/yF2p0uLVlOODn7z8Rqx1FgfFLqMWiil3e0T3lr2aezMDzwUkQagKW
         3zQ/tntQwYxMxrEelRBFoVLKpQSRZk/TBG1Z0AA8XM2z9AEhdnGWm+f+a2J5gpmjvsAt
         bFlAkTNprn1amjpUp3Laa/KRjz6cXbfTA0rGEvZNYujs6sUrA+DrqyICL9LQrpQ1O6A9
         ZaWO1pC69zpk3AOVocFivGbzVryLEDNC75A5EfuFRoWjq2BSgIaTZ674ah3Y3IlUbuKS
         fzfYibYEmW8JteKRBr9BkcEYEnZvVToDiMDs2wVb5vKZ2JpU+b9pNUx4e4NQZp7Wr58p
         c1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LX7TTVacyu/SInUXeH7qzWi/YSD8f9C42RXcS3AUsk4=;
        b=OA8iIiDxPpEMqLV36+sFi4rwEMi11FQBpI0gaGacTZiOPOGNTWoZ5DtM0JLznXiItQ
         eF3P8buUzjKwgfEpz3ZMs0bveZJclP8vCgaQ8P5jgftmbesIB5cuVi//nKXFb4qpLvzG
         0fAJxC3H52C3ckm0dMrB0VLjjJY+unTBmnquLvss4K7C7GWb8nSSVEWVFVdPVpHJXMlz
         eBoz5Bsmq1dBDCId+k1X7h8REOVJaIcBXkxn+XdC9VIffphFO7jpkuaS0Lla0Xa+O1Sc
         lCKXU5AWKI59n6AkxUryZuSlsQk0npkOjfZW/cFeAtlbGn8ZDWm4HOERAjDSBHlxgsbV
         k39g==
X-Gm-Message-State: AOAM532ORi7u2K3t+z613RuHajBXva9ejIntSQ96uI7hc+osRBz1guQD
        gqo61DtfZgzSFi3orLyp+Fc5Z5STMxJiMPwsKnzYjA==
X-Google-Smtp-Source: ABdhPJxn4MslQACG762qQXLuE+98Zx9vDaVa6WzFSlWG7o0gS55sNNFPnobyOdw0Pixw5xfJwCRy9GEAafIbY9N5JkY=
X-Received: by 2002:a92:7f03:: with SMTP id a3mr7335685ild.203.1617295728089;
 Thu, 01 Apr 2021 09:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210331210841.3996155-1-bgardon@google.com> <20210331210841.3996155-9-bgardon@google.com>
 <a030f6a6-4092-7c70-af4e-148debb801cc@redhat.com>
In-Reply-To: <a030f6a6-4092-7c70-af4e-148debb801cc@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 1 Apr 2021 09:48:37 -0700
Message-ID: <CANgfPd87mz5Gqod6iRsqbdbUKxhETTrMp1R6ZqSerjvB0+mO8w@mail.gmail.com>
Subject: Re: [PATCH 08/13] KVM: x86/mmu: Protect the tdp_mmu_roots list with RCU
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
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

On Thu, Apr 1, 2021 at 2:37 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 31/03/21 23:08, Ben Gardon wrote:
> > Protect the contents of the TDP MMU roots list with RCU in preparation
> > for a future patch which will allow the iterator macro to be used under
> > the MMU lock in read mode.
> >
> > Signed-off-by: Ben Gardon<bgardon@google.com>
> > ---
> >   arch/x86/kvm/mmu/tdp_mmu.c | 64 +++++++++++++++++++++-----------------
> >   1 file changed, 36 insertions(+), 28 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> > +     spin_lock(&kvm->arch.tdp_mmu_pages_lock);
> > +     list_del_rcu(&root->link);
> > +     spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
>
>
> Please update the comment above tdp_mmu_pages_lock in
> arch/x86/include/asm/kvm_host.h as well.

Ah yes, thank you for catching that. Will do.

>
> >  /* Only safe under the MMU lock in write mode, without yielding. */
> >  #define for_each_tdp_mmu_root(_kvm, _root)                           \
> > -     list_for_each_entry(_root, &_kvm->arch.tdp_mmu_roots, link)
> > +     list_for_each_entry_rcu(_root, &_kvm->arch.tdp_mmu_roots, link, \
> > +                             lockdep_is_held_write(&kvm->mmu_lock))
>
> This should also add "... ||
> lockdep_is_help(&kvm->arch.tdp_mmu_pages_lock)", if only for
> documentation purposes.

Good idea. I hope we never have a function try to protect its loop
over the roots with that lock, but it would be correct.

>
> Paolo
>
