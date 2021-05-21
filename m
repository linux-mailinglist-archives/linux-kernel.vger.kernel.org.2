Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A7838C89A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbhEUNsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20829 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232641AbhEUNr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621604795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pxEOV+Bz/B1tAe8FeS+TqChUcoqHhutaFnjDp8o1QJQ=;
        b=KeNHVcRVT58onkahgRnGTqmZtrTznEsFOgUHylGzCH9uHS0L8SvF9pbsHHzFWDSPKU/Rjc
        24Q6PtNJ1VDlSXDE6htWiX1E91iat0K77ARBw9w2UApjVhpniKREqcnDpgRvyfgj/hRCqD
        nJSPZJoNVKZxafkwLg0WyUPDpWiwr/M=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-f3m45at8Ou-50RN_VkldcQ-1; Fri, 21 May 2021 09:46:33 -0400
X-MC-Unique: f3m45at8Ou-50RN_VkldcQ-1
Received: by mail-lj1-f199.google.com with SMTP id j2-20020a2e6e020000b02900f2f75a122aso8811012ljc.19
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxEOV+Bz/B1tAe8FeS+TqChUcoqHhutaFnjDp8o1QJQ=;
        b=Ce3wMdLl3g1Ae5/Dofuq7m2OinVVg15XKk0v50TMCx1u3ifa0Rka9W2uDLJGaGvEur
         I/RFwUUM1mE6WY1RLUE8XIouEBByYVh/SE6+au0fNBYqZmBR44lZ6lbPaE8+aoUKJaNU
         l2/Y/mXdv38r8wP/lxdJeYOh2chaEcZpVc8hLY63zwxnYO4EOT70GXVZURg2jgOnRZSS
         FmPv1cxGfugQ9KFH1Subj77t6KQeOWz7fFeMLAu9cTnAVDShp8vdiiU/AY/6HZG02uCR
         ZmBi5qo4z7FlHQGYB+0AKgEvc4IaAZWe/jkyGDg/C83wsg1OOywICSUAIQrlXGcvJE0/
         8zHw==
X-Gm-Message-State: AOAM530PFXrItm/mWHCyBGxvMhHS0GCzlVrG4XQxbdUp90JMz8rB/6FL
        QRT3mIxy0x/6PGUdx32IhGtQzftb3lcZ9GekSp/6C2T/kScaIG2iXn5B0dDl9yVIdfOuyGTG7EV
        ZmNjs9d2vk3h6snMWGI28f4xhkEAL46SHWvKtUZYg
X-Received: by 2002:a2e:9802:: with SMTP id a2mr6897007ljj.232.1621604792285;
        Fri, 21 May 2021 06:46:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlGxBda5A/LzKGja1+OEN8tx6PjZF4MfUkV3JmKj4AkWLhF+MPQT6UkdSN2h3rzdDqbYrS1zrIy9/RGgGSqN4=
X-Received: by 2002:a2e:9802:: with SMTP id a2mr6896994ljj.232.1621604792081;
 Fri, 21 May 2021 06:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210504092340.00006c61@intel.com> <87pmxpdr32.ffs@nanos.tec.linutronix.de>
 <CAFki+Lkjn2VCBcLSAfQZ2PEkx-TR0Ts_jPnK9b-5ne3PUX37TQ@mail.gmail.com>
 <87im3gewlu.ffs@nanos.tec.linutronix.de> <CAFki+L=gp10W1ygv7zdsee=BUGpx9yPAckKr7pyo=tkFJPciEg@mail.gmail.com>
 <CAFki+L=eQoMq+mWhw_jVT-biyuDXpxbXY5nO+F6HvCtpbG9V2w@mail.gmail.com>
 <CAFki+LkB1sk3mOv4dd1D-SoPWHOs28ZwN-PqL_6xBk=Qkm40Lw@mail.gmail.com> <87zgwo9u79.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87zgwo9u79.ffs@nanos.tec.linutronix.de>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Fri, 21 May 2021 09:46:20 -0400
Message-ID: <CAFki+LnKycMFYTGTswX9vpMepNiCW6BL5TFMTuKZSniab5=4SA@mail.gmail.com>
Subject: Re: [PATCH tip:irq/core v1] genirq: remove auto-set of the mask when
 setting the hint
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, jbrandeb@kernel.org,
        "frederic@kernel.org" <frederic@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "jinyuqi@huawei.com" <jinyuqi@huawei.com>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        netdev@vger.kernel.org, chris.friesen@windriver.com,
        Marc Zyngier <maz@kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>, pjwaskiewicz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 7:56 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Nitesh,
>
> On Thu, May 20 2021 at 20:03, Nitesh Lal wrote:
> > On Thu, May 20, 2021 at 5:57 PM Nitesh Lal <nilal@redhat.com> wrote:
> >> I think here to ensure that we are not breaking any of the drivers we have
> >> to first analyze all the existing drivers and understand how they are using
> >> this API.
> >> AFAIK there are three possible scenarios:
> >>
> >> - A driver use this API to spread the IRQs
> >>   + For this case we should be safe considering the spreading is naturally
> >>     done from the IRQ subsystem itself.
> >
> > Forgot to mention another thing in the above case is to determine whether
> > it is true for all architectures or not as Thomas mentioned.
>
> Yes.
>
> >>
> >> - A driver use this API to actually set the hint
> >>   + These drivers should have no functional impact because of this revert
>
> Correct.
>
>
> >> - Driver use this API to force a certain affinity mask
> >>   + In this case we have to replace the API with the irq_force_affinity()
>
> irq_set_affinity() or irq_set_affinity_and_hint()

Ah yes! my bad. _force_ doesn't check the mask against the online CPUs.
Hmm, I didn't realize that you also added irq_set_affinity_and_hint()
in your last patchset.

>
> >> I can start looking into the individual drivers, however, testing them will
> >> be a challenge.
>
> The only way to do that is to have the core infrastructure added and

Right.

> then send patches changing it in the way you think. The relevant
> maintainers/developers should be able to tell you when your analysis
> went south. :)

Ack will start looking into this.


--
Thanks
Nitesh

