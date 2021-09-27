Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37558419CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbhI0RbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236955AbhI0R0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632763506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kNKGhtUzyDvvasjBG+sOupwAerMdbRFrkMWzt1aAAJI=;
        b=e30r/zfyqmdOFfRfT+bXTaoIhXkVaUPyslhJMEibcu146PJVEnkbooJPu97+oX4gBl6UQC
        FVXJz+gOVe1htZbbZv4tPbD8lURdmGUQ4oNTh16OS41j2FFPyG1u6VIRD5kEKr98dxKNOk
        Ymui8hgNd4irGZxSXK7qUDqSmpzKt+w=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-S25X2pSZPwCN3bMuP9nPeA-1; Mon, 27 Sep 2021 13:25:04 -0400
X-MC-Unique: S25X2pSZPwCN3bMuP9nPeA-1
Received: by mail-pg1-f198.google.com with SMTP id o10-20020a65614a000000b002850cb8c434so13329098pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 10:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kNKGhtUzyDvvasjBG+sOupwAerMdbRFrkMWzt1aAAJI=;
        b=oXVBSUibaSLGHi9g666k7JHQ9uv7yhabY+53jfy5S5hsP5MXEMBqInvafvphiE0dYQ
         wTny6f5bW8nTR94uFONHODeQ/VgZSanLmxtA5lcunOcTz6TJi0NutmoGqp7vzOClCBTA
         XuWjN1K5xPGms3tieIJy8M4IrmzRiUK+fqX6DbbFQ4Hsfg9SV03np/YsKZjSH2meUPAY
         oSOWHy+Tl8ngdS29+Z7D0gZkkxkFfJ31sd1bxRRkG7FceV84APoHNqoSJphwTuxfwC/C
         NCcPeF5J0UN+5HrjUHBdvxm+yGUYXq+X3/k+zQbuXEypkQQzmM4BR+dWk9SEsw5c4GOW
         1MBg==
X-Gm-Message-State: AOAM532kib0+AB8YOMQSKyOIzM1x/p5zGuNAbMDTIpGatlmkjuVE4kUG
        dT4rLjOr4WDBS1tCK1uQZO5sCbhkP2MWrgVeAPimZXkqgOVmckmqYMIwc5dxch0MTUvPJEx2TAm
        DH8zB2gj8ekgTuGhjDQRoFqoNF3sV5DXQ3p05xZ4f
X-Received: by 2002:a17:902:e752:b0:13b:7e90:af8b with SMTP id p18-20020a170902e75200b0013b7e90af8bmr1093600plf.12.1632763503570;
        Mon, 27 Sep 2021 10:25:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnpQIKn1XEdvXS3sloEadlAQlrcu/KIkFx7e5cSy37I6kVkSfvfoO+V88kOShJrVeyAcUnkFvhI3opAAyj/w8=
X-Received: by 2002:a17:902:e752:b0:13b:7e90:af8b with SMTP id
 p18-20020a170902e75200b0013b7e90af8bmr1093572plf.12.1632763503267; Mon, 27
 Sep 2021 10:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210925005528.1145584-1-seanjc@google.com> <03f2f5ab-e809-2ba5-bd98-3393c3b843d2@de.ibm.com>
 <YVHcY6y1GmvGJnMg@google.com> <f37ab68c-61ce-b6fb-7a49-831bacfc7424@redhat.com>
 <43e42f5c-9d9f-9e8b-3a61-9a053a818250@de.ibm.com>
In-Reply-To: <43e42f5c-9d9f-9e8b-3a61-9a053a818250@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Mon, 27 Sep 2021 19:24:52 +0200
Message-ID: <CABgObfYtS6wiQe=BhF3t5usr7J6q4PWE4=rwZMMukfC9wT_6fA@mail.gmail.com>
Subject: Re: disabling halt polling broken? (was Re: [PATCH 00/14] KVM:
 Halt-polling fixes, cleanups and a new stat)
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jon Cargille <jcargill@google.com>,
        Jim Mattson <jmattson@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        KVM ARM <kvmarm@lists.cs.columbia.edu>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>, kvm-ppc <kvm-ppc@vger.kernel.org>,
        "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Janosch Frank <frankja@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 5:17 PM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> > So I think there are two possibilities that makes sense:
> >
> > * track what is using KVM_CAP_HALT_POLL, and make writes to halt_poll_ns follow that
>
> what about using halt_poll_ns for those VMs that did not uses KVM_CAP_HALT_POLL and the private number for those that did.

Yes, that's what I meant.  David pointed out that doesn't allow you to
disable halt polling altogether, but for that you can always ask each
VM's userspace one by one, or just not use KVM_CAP_HALT_POLL. (Also, I
don't know about Google's usecase, but mine was actually more about
using KVM_CAP_HALT_POLL to *disable* halt polling on some VMs!).

Paolo

