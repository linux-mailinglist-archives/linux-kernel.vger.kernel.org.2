Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E87B34EDF9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhC3QeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhC3QeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:34:02 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87015C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:34:02 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id w2so14199436ilj.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nje1T/G+t6hpF+M6xKmlqJ4sXlhEHlEmMXpbr+5r7EI=;
        b=w5zegObIU4UdRDDNIDyPb1PJe9jF/a2tq7uzqV0LP/98xFY+/SGvNR1X0B6xNHdQFl
         5Ii102xSkWWELWBQsaA1CCFXSZAerivA310MXxtY2tooT3roSmfd9X5fn/lSKnVlJIE/
         xCtIgWSrl+LJfEn6mkohy0SNqAmYzjHYRRAGpFsFSEJkbqY7D7Ufd8Lii5dXuasalkeF
         fdkMudYSMVO/UuPd12ebPgixyYI3oNTYCAP+H1JW7KoiQmFQdLqBWnjSWJmdC5bDmh62
         cYN6c/iwmOfWtLtgX3ESsgyd88dA1jYbJK60lNpZLM/hsEhHjbGdFAR6mzgR3Jifhbym
         HKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nje1T/G+t6hpF+M6xKmlqJ4sXlhEHlEmMXpbr+5r7EI=;
        b=JGNWCK6Ws0YFHUSOB+alRPaY4uo2Xu6C/nFn+HmJOFax5cH1aVs86uE0uifL9oflAm
         Ezoso2to14JpPdohFN/Wya9FiMCuImZcS9QIa8wcwv2TE2YdV1EveDECz2Hpq7rCtVc0
         ZyWt6g2D7Ie53Mm8EkyoLwyowwUJdehXSgt+QOXUAOr+ZBJPFj3Ln6rsnodtlhRBq73G
         VhpD+mhqh6fdRzhNRRM7bgws6aFRR69hIPaIFaxHRUacHBFjVSHeVZeqnOBKnIDvVaIz
         ge61Xs2eZW08Axg5DZ1fb9UiY4raCbz89X7nZsCGGkdj0qgIyLF1Lyrl39Bg8LlqPpfm
         MLfw==
X-Gm-Message-State: AOAM532gRcma4aK/hNqwKSrvi1kLiQiXXt50iT3BqX34J1sR06yFSQVj
        hs903NlKunZLWa6mOsUedCmgYY0wmZwj2tH8tvFuZw==
X-Google-Smtp-Source: ABdhPJy9JgK247GLSOHiHPPeUamjo5z/kSmFr+r7CZh1+5Zj8PWeCB0VhhmE6vF+nkvr2DYU6F5T8PhSPrDaQ46iudA=
X-Received: by 2002:a92:c568:: with SMTP id b8mr19347387ilj.50.1617122041936;
 Tue, 30 Mar 2021 09:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210323120647.454211-1-suzuki.poulose@arm.com>
 <20210323120647.454211-8-suzuki.poulose@arm.com> <20210326165550.GC2009902@xps15>
 <bc1adc62-55ce-303d-b029-0fa02958998e@arm.com> <20210330152314.GA2329603@xps15>
 <YGNFKlIkNzchBqDK@kroah.com>
In-Reply-To: <YGNFKlIkNzchBqDK@kroah.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 30 Mar 2021 10:33:51 -0600
Message-ID: <CANLsYkwaiDDyQQWB2eEBHMi0NcOchAMwXnW71=ipVAXc9qvkLw@mail.gmail.com>
Subject: Re: [PATCH v5 07/19] arm64: kvm: Enable access to TRBE support for host
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 at 09:35, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 30, 2021 at 09:23:14AM -0600, Mathieu Poirier wrote:
> > On Tue, Mar 30, 2021 at 11:38:18AM +0100, Suzuki K Poulose wrote:
> > > On 26/03/2021 16:55, Mathieu Poirier wrote:
> > > > On Tue, Mar 23, 2021 at 12:06:35PM +0000, Suzuki K Poulose wrote:
> > > > > For a nvhe host, the EL2 must allow the EL1&0 translation
> > > > > regime for TraceBuffer (MDCR_EL2.E2TB == 0b11). This must
> > > > > be saved/restored over a trip to the guest. Also, before
> > > > > entering the guest, we must flush any trace data if the
> > > > > TRBE was enabled. And we must prohibit the generation
> > > > > of trace while we are in EL1 by clearing the TRFCR_EL1.
> > > > >
> > > > > For vhe, the EL2 must prevent the EL1 access to the Trace
> > > > > Buffer.
> > > > >
> > > > > Cc: Will Deacon <will@kernel.org>
> > > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > > > > Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > > > ---
> > > > >   arch/arm64/include/asm/el2_setup.h | 13 +++++++++
> > > > >   arch/arm64/include/asm/kvm_arm.h   |  2 ++
> > > > >   arch/arm64/include/asm/kvm_host.h  |  2 ++
> > > > >   arch/arm64/kernel/hyp-stub.S       |  3 ++-
> > > > >   arch/arm64/kvm/debug.c             |  6 ++---
> > > > >   arch/arm64/kvm/hyp/nvhe/debug-sr.c | 42 ++++++++++++++++++++++++++++++
> > > > >   arch/arm64/kvm/hyp/nvhe/switch.c   |  1 +
> > > > >   7 files changed, 65 insertions(+), 4 deletions(-)
> > > > >
> > > >
> > > > Marc - do you want me to pick up this one?
> > >
> > > I think the kvmarm tree is the best route for this patch, given the amount
> > > of changes the tree is going through, in the areas this patch
> > > touches. Or else there would be conflicts with merging. And this patch
> > > depends on the patches from this series that were queued.
> > >
> > > Here is the depency tree :
> > >
> > > a) kvm-arm fixes for debug (Patch 1, 2) & SPE save-restore fix (queued in
> > > v5.12-rc3)
> > >
> > > b) TRBE defintions and Trace synchronization barrier (Patches 5 & 6)
> > >
> > > c) kvm-arm TRBE host support (Patch 7)
> > >
> > > d) TRBE driver support (and the ETE changes)
> > >
> > >
> > > (c) code merge depends on -> (a) + (b)
> > > (d) build (no conflicts) depends on -> (b)
> > >
> > >
> > > Now (d) has an indirect dependency on (c) for operational correctness at
> > > runtime.
> > > So, if :
> > >
> > > kvmarm tree picks up : b + c
> > > coresight tree picksup : b + d
> > >
> > > and if we could ensure the merge order of the trees are in
> > > kvmarm
> > > greg-kh (device-misc tree) (coresight goes via this tree)
> > >
> >
> > Greg's char-misc tree is based on the rc releases rather than next.  As such it
> > is a while before other branches like kvmarm get merged, causing all sort of
> > compilation breakage.
>
> My tree can not be based on -next, and neither can any other
> maintainer's tree, as next is composed of maintainer trees :)
>

Exactly

> > > we should be fine.
> > >
> > > Additionally, we could rip out the Kconfig changes from the TRBE patch
> > > and add it only at the rc1, once we verify both the trees are in to make
> > > sure the runtime operation dependency is not triggered.
> > >
> >
> > We could also do that but Greg might frown at the tactic, and rightly so.  The
> > usual way to work with complex merge dependencies is to proceed in steps, which
> > would mean that all KVM related patches go in the v5.13 merge window.  When that
> > is done we add the ETE/TRBE for the v5.14 merge window.  I agree that we waste
> > an entire cycle but it guarantees to avoid breaking builds and follows the
> > conventional way to do things.
>
> Or someone creates a single branch with a signed tag and it gets pulled
> into multiple maintainer's trees and never rebased.  We've done that
> lots of time, nothing new there.  Or everything goes through one tree,
> or you wait a release cycle.
>
> You have 3 choices, pick one :)

I'm perfectly happy with getting this entire set merged via Marc's
kvmarm tree, as long as you are fine with it.

>
> thanks,
>
> greg k-h
