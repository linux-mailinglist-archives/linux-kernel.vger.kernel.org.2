Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB28F3B0E62
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhFVUNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhFVUNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:13:13 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6008FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:10:57 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id bl4so6917918qkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FEaj5TzKzhC7h9IFSKKjMs8DSuzea5RNxJgmYoQLtDo=;
        b=gAVB6WdGFfSF8M3fXNSIPpQmdJeqZQsRwA717UsvPbCaHtHJwO67jeInsCAEu8fZ9h
         uHT5p2OxZYu2RG7C998+c+PSzH1bWfNmR/AKE4JJasXBiXiAvt9eghjBffcqzfsWT6O8
         itPCAH6dnbArXOZBiLxZWkyFcZYrakdwz1qMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FEaj5TzKzhC7h9IFSKKjMs8DSuzea5RNxJgmYoQLtDo=;
        b=mG0uNa+EbDBHsOrfNA02RfqRuWvxMyZLk1bQfX7CvcIOjV3KAMXq5o6l5HtCKR1G1s
         1Y2XVpK6HpQCEK3XMkoy0KfLhK2ABKaRANUe/KNCHvQmNkkc+Z5nAkEmX27XiPWTYZRT
         kP+7iw4dbs5RnPkFZPvm7Khl8ip0tJmVL2jLlfwIk5su9Nu0TS4XwkNRimZuu2JWREUc
         0/LNU+Wi64reL40FYmbvspOI5gY6gxeFcdEFj8xm8hTzCHblJTtG7hulLeoS0j0Lv9VW
         UtdS8ftCkoPGGgd3MsxBfh0fgZk1HHby7kZYgQvAGN0DH4R/rqUYlCNdAGVYcfivobLF
         g3lg==
X-Gm-Message-State: AOAM5328hphxc6T2FoI2I9f8SSniYf2F2sxjPVleftmtjMaZdMyEZsyz
        OITBT0LMmnEKlSMyrs0zH1d2BOm7ZlnXWQ==
X-Google-Smtp-Source: ABdhPJy5Tu/jWuDItYYuQc4qsZPVOcYz7aOhNuPb8Oko2jwht42nFdZQqIdVBIHqH2GnHeTM8Q0YFA==
X-Received: by 2002:a37:9b02:: with SMTP id d2mr6257953qke.404.1624392656489;
        Tue, 22 Jun 2021 13:10:56 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id d9sm8174974qko.110.2021.06.22.13.10.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 13:10:56 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id w21so28995719qkb.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:10:56 -0700 (PDT)
X-Received: by 2002:a25:80d4:: with SMTP id c20mr7216839ybm.345.1624392645386;
 Tue, 22 Jun 2021 13:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <067dd86d-da7f-ac83-6ce6-b8fd5aba0b6f@arm.com> <CAD=FV=Vg7kqhgxZppHXwMPMc0xATZ+MqbrXx-FB0eg7pHhNE8w@mail.gmail.com>
 <20210622200219.GA28722@robh.at.kernel.org> <CAGETcx8Cpjvsr2K6f2oDNJDcGiu2T1fEf3D_2S4THduH4cPzKQ@mail.gmail.com>
In-Reply-To: <CAGETcx8Cpjvsr2K6f2oDNJDcGiu2T1fEf3D_2S4THduH4cPzKQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Jun 2021 13:10:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xw=NBkozOb4d4TM5DwBCSOG7v3ZA5ZgpcZqtQXE5UPsg@mail.gmail.com>
Message-ID: <CAD=FV=Xw=NBkozOb4d4TM5DwBCSOG7v3ZA5ZgpcZqtQXE5UPsg@mail.gmail.com>
Subject: Re: [PATCH 0/6] iommu: Enable devices to request non-strict DMA,
 starting with QCom SD/MMC
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pci@vger.kernel.org, quic_c_gdjako@quicinc.com,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Rajat Jain <rajatja@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Gross <agross@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 22, 2021 at 1:06 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Jun 22, 2021 at 1:02 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Jun 22, 2021 at 09:06:02AM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Tue, Jun 22, 2021 at 4:35 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > > >
> > > > Hi Doug,
> > > >
> > > > On 2021-06-22 00:52, Douglas Anderson wrote:
> > > > >
> > > > > This patch attempts to put forward a proposal for enabling non-strict
> > > > > DMA on a device-by-device basis. The patch series requests non-strict
> > > > > DMA for the Qualcomm SDHCI controller as a first device to enable,
> > > > > getting a nice bump in performance with what's believed to be a very
> > > > > small drop in security / safety (see the patch for the full argument).
> > > > >
> > > > > As part of this patch series I am end up slightly cleaning up some of
> > > > > the interactions between the PCI subsystem and the IOMMU subsystem but
> > > > > I don't go all the way to fully remove all the tentacles. Specifically
> > > > > this patch series only concerns itself with a single aspect: strict
> > > > > vs. non-strict mode for the IOMMU. I'm hoping that this will be easier
> > > > > to talk about / reason about for more subsystems compared to overall
> > > > > deciding what it means for a device to be "external" or "untrusted".
> > > > >
> > > > > If something like this patch series ends up being landable, it will
> > > > > undoubtedly need coordination between many maintainers to land. I
> > > > > believe it's fully bisectable but later patches in the series
> > > > > definitely depend on earlier ones. Sorry for the long CC list. :(
> > > >
> > > > Unfortunately, this doesn't work. In normal operation, the default
> > > > domains should be established long before individual drivers are even
> > > > loaded (if they are modules), let alone anywhere near probing. The fact
> > > > that iommu_probe_device() sometimes gets called far too late off the
> > > > back of driver probe is an unfortunate artefact of the original
> > > > probe-deferral scheme, and causes other problems like potentially
> > > > malformed groups - I've been forming a plan to fix that for a while now,
> > > > so I for one really can't condone anything trying to rely on it.
> > > > Non-deterministic behaviour based on driver probe order for multi-device
> > > > groups is part of the existing problem, and your proposal seems equally
> > > > vulnerable to that too.
> > >
> > > Doh! :( I definitely can't say I understand the iommu subsystem
> > > amazingly well. It was working for me, but I could believe that I was
> > > somehow violating a rule somewhere.
> > >
> > > I'm having a bit of a hard time understanding where the problem is
> > > though. Is there any chance that you missed the part of my series
> > > where I introduced a "pre_probe" step? Specifically, I see this:
> > >
> > > * really_probe() is called w/ a driver and a device.
> > > * -> calls dev->bus->dma_configure() w/ a "struct device *"
> > > * -> eventually calls iommu_probe_device() w/ the device.
> > > * -> calls iommu_alloc_default_domain() w/ the device
> > > * -> calls iommu_group_alloc_default_domain()
> > > * -> always allocates a new domain
> > >
> > > ...so we always have a "struct device" when a domain is allocated if
> > > that domain is going to be associated with a device.
> > >
> > > I will agree that iommu_probe_device() is called before the driver
> > > probe, but unless I missed something it's after the device driver is
> > > loaded.  ...and assuming something like patch #1 in this series looks
> > > OK then iommu_probe_device() will be called after "pre_probe".
> > >
> > > So assuming I'm not missing something, I'm not actually relying the
> > > IOMMU getting init off the back of driver probe.
> > >
> > >
> > > > FWIW we already have a go-faster knob for people who want to tweak the
> > > > security/performance compromise for specific devices, namely the sysfs
> > > > interface for changing a group's domain type before binding the relevant
> > > > driver(s). Is that something you could use in your application, say from
> > > > an initramfs script?
> > >
> > > We've never had an initramfs script in Chrome OS. I don't know all the
> > > history of why (I'm trying to check), but I'm nearly certain it was a
> > > conscious decision. Probably it has to do with the fact that we're not
> > > trying to build a generic distribution where a single boot source can
> > > boot a huge variety of hardware. We generally have one kernel for a
> > > class of devices. I believe avoiding the initramfs just keeps things
> > > simpler.
> > >
> > > I think trying to revamp Chrome OS to switch to an initramfs type
> > > system would be a pretty big undertaking since (as I understand it)
> > > you can't just run a little command and then return to the normal boot
> > > flow. Once you switch to initramfs you're committing to finding /
> > > setting up the rootfs yourself and on Chrome OS I believe that means a
> > > whole bunch of dm-verity work.
> > >
> > >
> > > ...so probably the initramfs is a no-go for me, but I'm still crossing
> > > my fingers that the pre_probe() might be legit if you take a second
> > > look at it?
> >
> > Couldn't you have a driver flag that has the same effect as twiddling
> > sysfs? At the being of probe, check the flag and go set the underlying
> > sysfs setting in the device.
>
> My understanding of what Robin is saying is that we'd need this info
> well before the driver is even available. The pre_probe() is
> effectively doing the same thing you are suggesting.

Right, I was just about to respond with the same. ;-) So overall right
now we're blocked waiting for someone to point out the error in my
logic. ;-)


> > Though you may want this to be per device, not per driver. To do that
> > early, I think you'd need a DT property. I wouldn't be totally opposed
> > to that and I appreciate you not starting there. :)
>
> Which is what I'm suggest elsewhere in the thread:
>
> https://lore.kernel.org/lkml/CAGETcx83qCZF5JN5cqXxdSFiEgfc4jYESJg-RepL2wJXJv0Eww@mail.gmail.com/

Rob: I'd be happy if you wanted to comment on that thread. If you say
that it's fine to add a generic device tree property to control
strictness then I'm more than happy to add support for it. I've been
going on the theory that you'd NAK such a property but I'm totally
good with being wrong. ;-)

I'd be more than happy if you could suggest what you'd envision such a
property to be named.


-Doug
