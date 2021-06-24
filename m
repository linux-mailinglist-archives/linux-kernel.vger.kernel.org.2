Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110FE3B304D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 15:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhFXNor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 09:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhFXNop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:44:45 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E4AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 06:42:26 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id d21-20020a9d72d50000b02904604cda7e66so3811894otk.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 06:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRRpyknNOYu61oOPsy3QfFe0DlnKqFXOFR/ODDvOpRA=;
        b=UtHXwFYLTrHgPc145mL3C9UB4ey+/nLdjIs7pvzujRNmQ5EAW+afyVO5yMkpxhaiYq
         EaZ0co1eAfBn5+AQMs9Q4Do4a1gFTjywNfS2sa9OFA0yAfKs040r9gAZmmies4dijQrQ
         9P1VJDPAdAgvB5owtJUn6dZ/rn754Mfv82gBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRRpyknNOYu61oOPsy3QfFe0DlnKqFXOFR/ODDvOpRA=;
        b=eAR8zlXaI9IbU/s3Ww6OuFNL1D39ChAWJbPlZcNghAvalq2VJpRtwqA4gg12t2Ku0j
         59b8/3OH3S/Tif0bs+8uBcRSnXeVgdkEWwLW2CP7mnaa6iTFAyLSyOQfi/y73gRxVNB4
         UVXpL45f19aoo4cOe9rfDrBcNNEhIvU0NTsdKKPXzM7SFgB75RMcFik8mXmYbD7N8vMs
         7YKxC/C9ghUuravVvnbUKCgcjM3OSJUzluS9v/e2Wl0wX3HM4zed4D6unEBaSL9PCJ4F
         4Hv296G93HC8MnPyGZkmnBKudL0BEIl931gWQlO1UmBjmVcL7+q7FHvUN4KRgUWhtQdQ
         FtgQ==
X-Gm-Message-State: AOAM533crohs4LdqmE94kUthu+OC5DcFTr71Bp68Acc0gKVORF1b4xMo
        /xsEg1hDeJe0q0El7OqXvXpin+jt5d7F8w==
X-Google-Smtp-Source: ABdhPJwCs5XyB1LMl90ABnHQaI12JX3ULZ3l20kKcJzvsoIdfIetahPOU68SB+DcFL2++T6eb3x8vw==
X-Received: by 2002:a9d:628:: with SMTP id 37mr4668956otn.120.1624542146113;
        Thu, 24 Jun 2021 06:42:26 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id v3sm609043oon.11.2021.06.24.06.42.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 06:42:26 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id d21-20020a9d72d50000b02904604cda7e66so3811819otk.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 06:42:25 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr5223275ybb.257.1624542133615;
 Thu, 24 Jun 2021 06:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.2.Icfe7cbb2cc86a38dde0ee5ba240e0580a0ec9596@changeid> <YNSKdhMACa9LFuVN@kroah.com>
In-Reply-To: <YNSKdhMACa9LFuVN@kroah.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 24 Jun 2021 06:42:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X1XSFRLfHOtA7Nk1NDqdBWHTOtPhdXVXk-+e_y9a=Rkg@mail.gmail.com>
Message-ID: <CAD=FV=X1XSFRLfHOtA7Nk1NDqdBWHTOtPhdXVXk-+e_y9a=Rkg@mail.gmail.com>
Subject: Re: [PATCH 2/6] drivers: base: Add bits to struct device to control
 iommu strictness
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 24, 2021 at 6:37 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 21, 2021 at 04:52:44PM -0700, Douglas Anderson wrote:
> > How to control the "strictness" of an IOMMU is a bit of a mess right
> > now. As far as I can tell, right now:
> > * You can set the default to "non-strict" and some devices (right now,
> >   only PCI devices) can request to run in "strict" mode.
> > * You can set the default to "strict" and no devices in the system are
> >   allowed to run as "non-strict".
> >
> > I believe this needs to be improved a bit. Specifically:
> > * We should be able to default to "strict" mode but let devices that
> >   claim to be fairly low risk request that they be run in "non-strict"
> >   mode.
> > * We should allow devices outside of PCIe to request "strict" mode if
> >   the system default is "non-strict".
> >
> > I believe the correct way to do this is two bits in "struct
> > device". One allows a device to force things to "strict" mode and the
> > other allows a device to _request_ "non-strict" mode. The asymmetry
> > here is on purpose. Generally if anything in the system makes a
> > request for strictness of something then we want it strict. Thus
> > drivers can only request (but not force) non-strictness.
> >
> > It's expected that the strictness fields can be filled in by the bus
> > code like in the patch ("PCI: Indicate that we want to force strict
> > DMA for untrusted devices") or by using the new pre_probe concept
> > introduced in the patch ("drivers: base: Add the concept of
> > "pre_probe" to drivers").
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  include/linux/device.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index f1a00040fa53..c1b985e10c47 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -449,6 +449,15 @@ struct dev_links_info {
> >   *           and optionall (if the coherent mask is large enough) also
> >   *           for dma allocations.  This flag is managed by the dma ops
> >   *           instance from ->dma_supported.
> > + * @force_strict_iommu: If set to %true then we should force this device to
> > + *                   iommu.strict regardless of the other defaults in the
> > + *                   system. Only has an effect if an IOMMU is in place.
>
> Why would you ever NOT want to do this?
>
> > + * @request_non_strict_iommu: If set to %true and there are no other known
> > + *                         reasons to make the iommu.strict for this device,
> > + *                         then default to non-strict mode. This implies
> > + *                         some belief that the DMA master for this device
> > + *                         won't abuse the DMA path to compromise the kernel.
> > + *                         Only has an effect if an IOMMU is in place.
>
> This feels in contrast to the previous field you just added, how do they
> both interact?  Would an enum work better?

Right that it never makes sense to set both bits so an enum could work
better, essentially it would be { dont_care, request_non_strict,
force_strict }.

In any case the whole idea of doing this at the device level looks
like it's not the right way to go anyway, so this patch and the
previous pre_probe one are essentially abandoned and I need to send
out a v2 with some different approaches.

-Doug
