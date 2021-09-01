Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642CF3FE5CB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244935AbhIAWog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241890AbhIAWof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:44:35 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01088C061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 15:43:38 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id k65so1663193yba.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 15:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+r4CwgKG+yEodhHzC7nFI5Y9Wnbyo4zL9qFFX9zlnM=;
        b=JOkMP8RXO6jdIjIDD6ZH3jrv9UvB6l279lUpP6filw3CBk6k1N1Hwj4bB+HLyMDRma
         boD3ZbnLqtdnNwuqesuS2HLMkqRyrZHeaia+pvNPCT5BKtEqWOmyEyiXQxJAyJC7Tf9q
         4ZnqybnkHfs+Ms/08GdCeE+nkY2Z4/6wD9jZtk51UPliBiGeD3r02osFUGdJfXWK+37N
         Rh2HJkrC41dh2GjZCh7Y9ajtEv3CGhIGQOw3dol55gzG/dj6A8DAPpPCYb1Sl+W+o/jy
         0sCXMnz+HIYSyDRFWFsuXdBSq+fQWnvW9N3oN7tIEn+y26OGONWz2qjuMjcUCQuC9gw/
         GLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+r4CwgKG+yEodhHzC7nFI5Y9Wnbyo4zL9qFFX9zlnM=;
        b=AEUxf0rgb2NMJzYMXxLDQnueJYaitOzAnM/+WBjwf/lNFekRdmcqja9TgQDxzPn5aG
         T3IJI61TMkNIfA7CEFwNAOyCOPFFlBNNyUWLxfEJy1kh/XAF/Bbapq40GChcOPiJ9YYc
         3RwsazoEMZqFBljrfh+BHXPpZcL8mJR49kq6BO/EQLRFsadmdb4DIdYb2s4wmlU6P7/a
         70D4QnYURA+TTYd6hAAY9DKwLp+qzgv/gprJy6dZ0r356vrby+nKEcRjMZfk22I7+ST+
         XX9yZfOCoR9gcUUTGjD+xts2aEgHjuYpmCawW8LFy3IwXVFnrhZOaC/HzXv8ojkF2gi8
         fzEQ==
X-Gm-Message-State: AOAM531z10ewW/uuJRrbcnT4wXtk3V8V5fqT8MSyWFNr2zCaO4MYitIJ
        Oekm89hrSfrcFew34k9DIlBUS862j3Pyqopz5mWlRA==
X-Google-Smtp-Source: ABdhPJzi+Lf0Xejnkm0ckXhh2uNvzEvpcGrgx17PRpTaVpfoZFF6sLe4mbguXZjsOTaBLHIIADIlXq1Ey2THBjkzhnc=
X-Received: by 2002:a25:6507:: with SMTP id z7mr276648ybb.439.1630536217085;
 Wed, 01 Sep 2021 15:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210901211412.4171835-1-rananta@google.com> <20210901211412.4171835-2-rananta@google.com>
 <YS/vTVPi7Iam+ZXX@google.com>
In-Reply-To: <YS/vTVPi7Iam+ZXX@google.com>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Wed, 1 Sep 2021 15:43:24 -0700
Message-ID: <CAJHc60wx=ZN_5e9Co_s_GyFs4ytLxncbYr2-CzmTUh5DvvuuNQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] KVM: arm64: selftests: Add MMIO readl/writel support
To:     Oliver Upton <oupton@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 2:23 PM Oliver Upton <oupton@google.com> wrote:
>
> On Wed, Sep 01, 2021 at 09:14:01PM +0000, Raghavendra Rao Ananta wrote:
> > Define the readl() and writel() functions for the guests to
> > access (4-byte) the MMIO region.
> >
> > The routines, and their dependents, are inspired from the kernel's
> > arch/arm64/include/asm/io.h and arch/arm64/include/asm/barrier.h.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >  .../selftests/kvm/include/aarch64/processor.h | 45 ++++++++++++++++++-
> >  1 file changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
> > index c0273aefa63d..3cbaf5c1e26b 100644
> > --- a/tools/testing/selftests/kvm/include/aarch64/processor.h
> > +++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
> > @@ -130,6 +130,49 @@ void vm_install_sync_handler(struct kvm_vm *vm,
> >       val;                                                              \
> >  })
> >
> > -#define isb()        asm volatile("isb" : : : "memory")
> > +#define isb()                asm volatile("isb" : : : "memory")
>
> Is this a stray diff?
>
Oh no, that's intentional. Just trying to align with others below.

Regards,
Raghavendra
> Otherwise:
>
> Reviewed-by: Oliver Upton <oupton@google.com>
