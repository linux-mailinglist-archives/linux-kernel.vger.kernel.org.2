Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5193F371E98
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhECRay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhECRax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:30:53 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8514C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 10:29:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b17so4199871ede.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wo+3D2WH6zYwTkILvVy6D/EkEPxtoZBBnnAY6b6btd4=;
        b=sEGX8JuBNskey+iHEkDuFkLzMsN8mdfs5ym8ZOw6mVx23SZFxzP3RgCAcoRiBr6TPy
         fytvGyD6UGsc3MctHTcM152ui5Bm8crn9r5W1WPZA+mWKXi2pt3TH1xJOtOXZpKRPsk8
         63mjaA8bNYBoXVrih6tCRGT6ZLXuoBLHgB2PZjgHBFjiP5aMjp7oG2rGmfZdxKEu/k3B
         RQHQcS2N7zee+JD0YdlADTQjfgcjupfRhR+wEiuRErmoe5zeNtc4+mPp5Clp33uOGwTU
         yNM8pcC8oRd1fZ26aiOk6u77uiwiU8PW2dbjKqSGTVMVHWxjWYsPyNIiG8x9tn+CeQFI
         byHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wo+3D2WH6zYwTkILvVy6D/EkEPxtoZBBnnAY6b6btd4=;
        b=AMaOsU/ESnqmDqtF2K5otCcfefxkhaPFjNDZ9Iwfh7mbnX15iTsazMgbLv2OjVispu
         gQV23l0LQTJcZxt9ClSOG0cf+xiHkPOr6BhYtjwv+YX2xcbeSEGFZBs6ngkh8MtZHUh5
         fkknHNcPegDQQR3VG5gToHzCvsSbfMpcCrqhjX4qo7e8L7HTwHFzl0efbUXI74cbtkie
         VJw8xt5UP1fr0KaH2E5mRM5np5e5vgQjqtUHZS3Az+HdfMZEE7yD6I0RwHwJiT1g8aQx
         PvQrtrM5VqtCz1AYnVZr9BPHIkwxIXqyc09jyqpCN+fZanwcbNlTw9RQALTDG2aBrUY1
         69pA==
X-Gm-Message-State: AOAM531aw7Rb7y7TeBBE3a4WHyzy9tKwgq7fq7wGV7enMGG6itDlMPUo
        e4Nbey58ShkXWIe1Q+Azo8T7VgmDbmeC9fQS3KbEAO6natQ=
X-Google-Smtp-Source: ABdhPJyU5c1skKCSJwjpn4CF3EhnwaMRKedy59htKPIKzkTK643efQAWfH8HBBvmzxuv782rYPKfCxu7ar+C4333clY=
X-Received: by 2002:a50:eb47:: with SMTP id z7mr19538118edp.68.1620062998464;
 Mon, 03 May 2021 10:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210429211833.3361994-1-bgardon@google.com> <20210429211833.3361994-8-bgardon@google.com>
 <ad4ccd85-a5c0-b80f-f268-14ed0f82a3ad@redhat.com>
In-Reply-To: <ad4ccd85-a5c0-b80f-f268-14ed0f82a3ad@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 3 May 2021 10:29:47 -0700
Message-ID: <CANgfPd-mhu3YD_D2ne7QRiuAavKuge_CQuLwNSSKkLw0qeVoDA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] KVM: x86/mmu: Lazily allocate memslot rmaps
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

On Mon, May 3, 2021 at 6:42 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 29/04/21 23:18, Ben Gardon wrote:
> > +int alloc_memslots_rmaps(struct kvm *kvm, struct kvm_memslots *slots)
>
> This can be static, can't it?

Ah, yes. Absolutely.

>
> Paolo
>
> > +{
> > +     struct kvm_memory_slot *slot;
> > +     int r = 0;
> > +
> > +     kvm_for_each_memslot(slot, slots) {
> > +             r = alloc_memslot_rmap(kvm, slot, slot->npages);
> > +             if (r)
> > +                     break;
> > +     }
> > +     return r;
> > +}
> > +
>
