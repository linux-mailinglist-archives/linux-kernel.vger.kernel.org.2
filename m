Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D13B0DD0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 21:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhFVTw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 15:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhFVTw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 15:52:56 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6A0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 12:50:39 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id q64so36308775qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 12:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N93FQS54KNMw/RWZd3sdd1/c5zsgaKSRIH5cGtG3wLQ=;
        b=nKSDq/oCJcM6qZHdPsZIzNgBCyluw3srCscilwpHd/8GiydqZY43q/T3vv2Nn2jbKD
         jegHEFKq7oKJUZmrnbp2L6fkE3vgH2JXF/RfOrax19gy3NpN1urkxXl0RO3exPK9Eg/i
         cQzl2nnV7iu4Ug4cNN87vHMj6sK4LHNEdz+OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N93FQS54KNMw/RWZd3sdd1/c5zsgaKSRIH5cGtG3wLQ=;
        b=p7av23Xrne9X9h/8KmrNx7CpNuydMf7UJ8cMrCtZVWwmNZ85cZ1hYgNB3fVOCUReEe
         /Ak8fu6iM19rTxbxH3y/sPbg7Re0eUGiynlXBpXbqXQ0J+ZWKcRU5F1wsC7xfRD9s4Sa
         oHogcwzLvxwvGCmyGoIaIWLWJhlQoFjJ66jPF/UyjN+59oEqCcHNcb2YauNv5u+MLPdh
         edR59gbWt5oB4XaAXB2WzsyPcPUPZV3cTk26u8esupqVglLUOdlNcQFQSJoZuKcnRhL4
         p3HV8exlYubvgUotmiSOcD08yULcB6fTyCjJi6j1bTE29wzUjOrwN+iOoZsmp83fpAgr
         S2Wg==
X-Gm-Message-State: AOAM532aN7Z8zWyqR85ag7+Ll8yMr+F1/KMzgKPrYY0sp8CR/6IeN4i5
        FBbN1GRqFnfS3wSCOaSZqzHP4PcY6UmOpA==
X-Google-Smtp-Source: ABdhPJwG82UKENrc7HLvNHGNAojftwsEi2NyF9zGsaDC6heO/QPgYR9R/5T5Vgvr/IdUBEvz0Q8FIg==
X-Received: by 2002:a05:620a:1182:: with SMTP id b2mr6081156qkk.408.1624391438199;
        Tue, 22 Jun 2021 12:50:38 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id c20sm2531908qtm.52.2021.06.22.12.50.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 12:50:37 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id i68so42698274qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 12:50:37 -0700 (PDT)
X-Received: by 2002:a25:2405:: with SMTP id k5mr6836288ybk.405.1624391426495;
 Tue, 22 Jun 2021 12:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org> <f3078ff2-97a6-6029-b584-1589ed184579@huawei.com>
In-Reply-To: <f3078ff2-97a6-6029-b584-1589ed184579@huawei.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Jun 2021 12:50:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WyicdP+czVyMPFpuSDHcB_jF3ikjSjqu_X0qVsUReiOA@mail.gmail.com>
Message-ID: <CAD=FV=WyicdP+czVyMPFpuSDHcB_jF3ikjSjqu_X0qVsUReiOA@mail.gmail.com>
Subject: Re: [PATCH 0/6] iommu: Enable devices to request non-strict DMA,
 starting with QCom SD/MMC
To:     John Garry <john.garry@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
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
        Saravana Kannan <saravanak@google.com>,
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

On Tue, Jun 22, 2021 at 10:46 AM John Garry <john.garry@huawei.com> wrote:
>
> On 22/06/2021 00:52, Douglas Anderson wrote:
> >
> > This patch attempts to put forward a proposal for enabling non-strict
> > DMA on a device-by-device basis. The patch series requests non-strict
> > DMA for the Qualcomm SDHCI controller as a first device to enable,
> > getting a nice bump in performance with what's believed to be a very
> > small drop in security / safety (see the patch for the full argument).
> >
> > As part of this patch series I am end up slightly cleaning up some of
> > the interactions between the PCI subsystem and the IOMMU subsystem but
> > I don't go all the way to fully remove all the tentacles. Specifically
> > this patch series only concerns itself with a single aspect: strict
> > vs. non-strict mode for the IOMMU. I'm hoping that this will be easier
> > to talk about / reason about for more subsystems compared to overall
> > deciding what it means for a device to be "external" or "untrusted".
> >
> > If something like this patch series ends up being landable, it will
> > undoubtedly need coordination between many maintainers to land. I
> > believe it's fully bisectable but later patches in the series
> > definitely depend on earlier ones. Sorry for the long CC list. :(
> >
>
> JFYI, In case to missed it, and I know it's not the same thing as you
> want, above, but the following series will allow you to build the kernel
> to default to lazy mode:
>
> https://lore.kernel.org/linux-iommu/1624016058-189713-1-git-send-email-john.garry@huawei.com/T/#m21bc07b9353b3ba85f2a40557645c2bcc13cbb3e
>
> So iommu.strict=0 would be no longer always required for arm64.

Excellent! I'm never a fan of command line parameters as a replacement
for Kconfig. They are great for debugging or for cases where the user
of the kernel and the person compiling the kernel are not the same
(like with off-the-shelf Linux distros) but aren't great for setting a
default for embedded environments.

I actually think that something like my patchset may be even more
important atop yours. Do you agree? If the default is non-strict it
could be extra important to be able to mark a certain device to be in
"strict" mode.

...also, unfortunately I probably won't be able to use your patchest
for my use case. I think we want the extra level of paranoia by
default and really only want to allow non-strict mode for devices that
we're really convinced are safe.

-Doug
