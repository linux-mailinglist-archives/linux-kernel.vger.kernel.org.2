Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA00383C29
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 20:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbhEQSXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 14:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41659 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234500AbhEQSXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 14:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621275722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Ohvz0veaN5YV4OnEyJTkyNbce7kLNQOfav9z5UAAmk=;
        b=DJ/fNjnO4+bRJXuyaTn10Ml8NJvlql17Xr0kijfoiKNmGtQmqXFUq/TMwy6dsbfQzqx0us
        0HDmQVrzOLzJ6UXkCHpmQgwjZc55u6MkwEF864GVIxb3EI2ZVw4RP6TA7n5uasPBivQY/n
        lH7RY6uSxIyxDORHevneLUsviY+S8aI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-rSMqP3ONO7Kv8mSZEjN2HA-1; Mon, 17 May 2021 14:22:01 -0400
X-MC-Unique: rSMqP3ONO7Kv8mSZEjN2HA-1
Received: by mail-lj1-f199.google.com with SMTP id b44-20020a05651c0b2cb02900ec3242ba00so3438890ljr.17
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 11:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Ohvz0veaN5YV4OnEyJTkyNbce7kLNQOfav9z5UAAmk=;
        b=gROuGaLTHa/PtcQkCc6MLm3j0E0hX0COfJjLlnTeFEIGNAEX9frf6EZV4N4sYJgVGG
         83Lr24sTBtC9fvnm8N35znS7Nm/4nqEgAzqTAcOKi0qNHbLhqPNYBHbKjRmLfBo15OWG
         UHrOoisHheoQbJG0ng0jNtBCYVTpkVMD0GwU+183dwfXIYQu6Pv4esww1i4eamMxn1JJ
         2/t7YPG8KEnerbN/nFYuvR7EVnmy3pdBfHbp53mxKuo42q0OjhAK4Qp4USdbMWC2C5GL
         HBQf8EkW2cH5V6341pevhKE162nSVuRWZWWn3Mzk0yKXRr5YgBPucNj/zLYPfMBOK+3Z
         CT7Q==
X-Gm-Message-State: AOAM53077P45np86uM3SEdII0Vc0rt3HFq3oz/wCiABjhS5RRH3nqivY
        3lb4m5RlEKTMvFotrHpJdfGlgkVA8Uecu6ynvv0XSXBMIebqVZEHE/hfBfbn5H+XZtUoytSbHBJ
        3XNKQgjPsuFH3zvuI7IQMVV+XO72Kl4nno3oPUZ2i
X-Received: by 2002:a05:6512:2302:: with SMTP id o2mr773388lfu.647.1621275719149;
        Mon, 17 May 2021 11:21:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrzOCPhmlYUdV7MidYS7zax5+JMdj0yOGQTWafj9uEJx26idggzqb+1uILAInTM0kZZW7u6CfEAVSGwFUPCng=
X-Received: by 2002:a05:6512:2302:: with SMTP id o2mr773377lfu.647.1621275718883;
 Mon, 17 May 2021 11:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210501021832.743094-1-jesse.brandeburg@intel.com>
 <16d8ca67-30c6-bb4b-8946-79de8629156e@arm.com> <20210504092340.00006c61@intel.com>
 <CAFki+LmR-o+Fng21ggy48FUX7RhjjpjO87dn3Ld+L4BK2pSRZg@mail.gmail.com> <bf1d4892-0639-0bbf-443e-ba284a8ed457@arm.com>
In-Reply-To: <bf1d4892-0639-0bbf-443e-ba284a8ed457@arm.com>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Mon, 17 May 2021 14:21:47 -0400
Message-ID: <CAFki+L=LDizBJmFUieMDg9J=U6mn6XxTPPkAaWiyppTouTzaqw@mail.gmail.com>
Subject: Re: [PATCH tip:irq/core v1] genirq: remove auto-set of the mask when
 setting the hint
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, jbrandeb@kernel.org,
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
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 1:26 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-05-17 17:57, Nitesh Lal wrote:
> > On Tue, May 4, 2021 at 12:25 PM Jesse Brandeburg
> > <jesse.brandeburg@intel.com> wrote:
> >>
> >> Robin Murphy wrote:
> >>
> >>> On 2021-05-01 03:18, Jesse Brandeburg wrote:
> >>>> It was pointed out by Nitesh that the original work I did in 2014
> >>>> to automatically set the interrupt affinity when requesting a
> >>>> mask is no longer necessary. The kernel has moved on and no
> >>>> longer has the original problem, BUT the original patch
> >>>> introduced a subtle bug when booting a system with reserved or
> >>>> excluded CPUs. Drivers calling this function with a mask value
> >>>> that included a CPU that was currently or in the future
> >>>> unavailable would generally not update the hint.
> >>>>
> >>>> I'm sure there are a million ways to solve this, but the simplest
> >>>> one is to just remove a little code that tries to force the
> >>>> affinity, as Nitesh has shown it fixes the bug and doesn't seem
> >>>> to introduce immediate side effects.
> >>>
> >>> Unfortunately, I think there are quite a few other drivers now relying
> >>> on this behaviour, since they are really using irq_set_affinity_hint()
> >>> as a proxy for irq_set_affinity(). Partly since the latter isn't
> >>> exported to modules, but also I have a vague memory of it being said
> >>> that it's nice to update the user-visible hint to match when the
> >>> affinity does have to be forced to something specific.
> >>>
> >>> Robin.
> >>
> >> Thanks for your feedback Robin, but there is definitely a bug here that
> >> is being exposed by this code. The fact that people are using this
> >> function means they're all exposed to this bug.
> >>
> >> Not sure if you saw, but this analysis from Nitesh explains what
> >> happened chronologically to the kernel w.r.t this code, it's a useful
> >> analysis! [1]
> >>
> >> I'd add in addition that irqbalance daemon *stopped* paying attention
> >> to hints quite a while ago, so I'm not quite sure what purpose they
> >> serve.
> >>
> >> [1]
> >> https://lore.kernel.org/lkml/CAFki+Lm0W_brLu31epqD3gAV+WNKOJfVDfX2M8ZM__aj3nv9uA@mail.gmail.com/
> >>
> >
> > Wanted to follow up to see if there are any more objections or even
> > suggestions to take this forward?
>
> Oops, sorry, seems I got distracted before getting round to actually
> typing up my response :)

No worries.

>
> I'm not implying that there isn't a bug, or that this code ever made
> sense in the first place, just that fixing it will unfortunately be a
> bit more involved than a simple revert.

Fair point.

> This patch as-is *will* subtly
> break at least the system PMU drivers currently using
> irq_set_affinity_hint() - those I know require the IRQ affinity to
> follow whichever CPU the PMU context is bound to, in order to meet perf
> core's assumptions about mutual exclusion.

Thanks for bringing this up.
Please correct me if I am wrong, so the PMU driver(s) is/are written
in a way that
it uses the hint API to overwrite the previously set affinity mask with a
CPU to which the PMU context is bound to?

Is this context information exposed in the userspace and can we modify the
IRQ affinity mask from the userspace based on that?
I do understand that this is a behavior change from the PMU drivers
perspective.

>
> As far as the consistency argument goes, maybe that's just backwards and
> it should be irq_set_affinity() that also sets the hint, to indicate to
> userspace that the affinity has been forced by the kernel? Either way
> we'll need to do a little more diligence to figure out which callers
> actually care about more than just the hint, and sort them out first.
>

We can use irq_set_affinity() to set the hint mask as well, however, maybe
there is a specific reason behind separating those two in the
first place (maybe not?).
But even in this case, we have to either modify the PMU drivers' IRQs
affinity from the userspace or we will have to make changes in the existing
request_irq code path.
I am not sure about the latter because we already have the required controls
to adjust the device IRQ mask (by using default_smp_affinity or by modifying
them manually).

-- 
Thanks
Nitesh

