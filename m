Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B102230E28D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhBCScH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhBCSb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:31:58 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DDAC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 10:31:18 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id u20so325556iot.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 10:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5icF/SSv4kj7JR39aT9z2fccgv7ASkGrVR8k5iH/1WA=;
        b=oHANDXKgkccZkGxdARQzM+C8j1KtV8+qVeHfLOl+R2MlUSfMyNS33V0/FVTyzAHW80
         +v4pCrqxhOCeHIklQuOltb1b0EUMAhpLlhmBz/uiMItDp0YtJHV4Es4GseeCuUS/d+vd
         8czbzffcUC3iUpDVQjibd8qse1v8bSb8+xoeA9YMDpbawL3VO6lQlLvDkmuw6bKCiY9Q
         YabtLYhSEAMl9R45N8RpUGOQtcJazzLVIaEHPFBMZJAW7R95nhDxApm0ORBlqQJ32Rf6
         8LKMQVD1oAj+5aLJd3yPD6lTJN+r6QikWV4OjuvtZP7fIoUzWkQy3KX3WxhzkY3uiiDo
         wxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5icF/SSv4kj7JR39aT9z2fccgv7ASkGrVR8k5iH/1WA=;
        b=lvir63ZSlxlnroSd9ulLf9IUvY7ZCVmHDqpEhnExIo5SbfjCE4DYbjpaR9mgrzKu4T
         BnZF0hW1zLiK8ai+4Hg3SUN/7xRt9BD1Dl7M+FFh9knmmbvOWIVb1UK2AqhvHbaPuOGu
         v1WRizssU5N+nWQcfkDEfB8utPNcQVamb+cnjIREoOfPnOSsQjX5JJo1qia4hN17BfVS
         0+XBGapI95L3YX53TAWPj9nbMEQqaX6axCNnoR8TJgZr/u6fJ22fAiF43FyENBXG/OGm
         hGUP0TYH90RxuCGyBldoCx6eB7vLBU7NdDG2tPGRoYVXDGpQ8tqVAepHon97BRVbN30A
         MqRA==
X-Gm-Message-State: AOAM531a8q+gLmhivpuGJE3mqSqtMGj780WMfqRenFIs9By4U6qoplfk
        U6km/MP1PhHdfrUkAJiPd7+5QNocF10a0WjsYHUkaYIuxX0=
X-Google-Smtp-Source: ABdhPJzQoZV4k1ugfFEi2DC1BuUtnOS7uLutKuW1+SQxdmZzsKib3pbK8GKmpe+1mBaQKg64w7mZ1jAj6EhztWYQ+gQ=
X-Received: by 2002:a02:a718:: with SMTP id k24mr4132560jam.25.1612377077474;
 Wed, 03 Feb 2021 10:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20210202185734.1680553-1-bgardon@google.com> <20210202185734.1680553-25-bgardon@google.com>
 <813695b1-bcfc-73ea-f9fe-76ffd42044cd@redhat.com>
In-Reply-To: <813695b1-bcfc-73ea-f9fe-76ffd42044cd@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 3 Feb 2021 10:31:06 -0800
Message-ID: <CANgfPd9OTKUJfnuRtMguC7kBf1GZz5Ba0yT1ssX29YQ2Zm54aA@mail.gmail.com>
Subject: Re: [PATCH v2 24/28] KVM: x86/mmu: Allow zap gfn range to operate
 under the mmu read lock
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

On Wed, Feb 3, 2021 at 3:26 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 02/02/21 19:57, Ben Gardon wrote:
> > +#ifdef CONFIG_LOCKDEP
> > +     if (shared)
> > +             lockdep_assert_held_read(&kvm->mmu_lock);
> > +     else
> > +             lockdep_assert_held_write(&kvm->mmu_lock);
> > +#endif /* CONFIG_LOCKDEP */
>
> Also, there's no need for the #ifdef here.

I agree, I must have misinterpreted some feedback on a previous commit
and gone overboard with it.


> Do we want a helper
> kvm_lockdep_assert_mmu_lock_held(struct kvm *kvm, bool shared)?

There are only two places that try to assert both ways as far as I can
see on a cursory check, but it couldn't hurt.

>
> Paolo
>
