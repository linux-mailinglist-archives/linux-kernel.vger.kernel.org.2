Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D5D3B0A85
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 18:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhFVQnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 12:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhFVQnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:43:09 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDD5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 09:40:53 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id e20so7873104ual.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cnIT4Uu6v7OErIw/h3MHSRjA8siJIWWdRBRj8QBPlgw=;
        b=TdfJPlJ2SdcEgU78Q5teRSDl0nj+gX7ShrwD+p+EUe1jbMCKiZz6IWSde2kIMCuGbk
         s2ZibuUr/AvviD8Z9vJcmWBR3ZXPAyIsLRVvtJLIx5CIwfCEuvftXqZBKCxyIQ3JUjW4
         zY94UAAq7PdYvRB09/WPx5cR4lSyh9TgZLz2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cnIT4Uu6v7OErIw/h3MHSRjA8siJIWWdRBRj8QBPlgw=;
        b=Q+gs2XaWsOwAHJMIgsAeHlCtEFfFIhf0Tl/gWlmr3rCI8Iq8B92y7gPxnbnjenp02q
         ToItk7ReidpF+rFRTG8+WItwk+IYg7kY1Hfd2QPezpHQEtdaz3Fx06YNGAftNroX/q1y
         CjV5GPEs9pE1OOZ6tq+wbvj7qAUxzjX5c/RSyxcKaBaQrGfraawIpTVcCmpGNOAb7oWU
         94D3VDRfEFqtmBejTAdvKaw7ffZRha0gIDC8WE1lnEx7EOD6VxorpabsyG79hwfqG4qb
         1odfV7RAirZs2rO8fIAkiUPjHMJ2aljiSGP/Ws190SFlRdFDa03ASehPqQMjGAi+511o
         wt8A==
X-Gm-Message-State: AOAM533uLGDqv6O+FNtPeVQ30228XSBygDiq3a/IPfj4rRoJBd7UEci9
        bomNuzS4oz8tRt/AMOmedDZ5bJGUXdQadA==
X-Google-Smtp-Source: ABdhPJwPmTzL9tRxsqZ3y2+ljmlaepF95XRoP68OJR/djeCtqUO6LrCDttPBcNmowDW3yRuR7iCzCQ==
X-Received: by 2002:ab0:5962:: with SMTP id o31mr4597575uad.89.1624380052335;
        Tue, 22 Jun 2021 09:40:52 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id j11sm414260vkd.18.2021.06.22.09.40.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 09:40:52 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id x22so7877376uap.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 09:40:52 -0700 (PDT)
X-Received: by 2002:a25:80d4:: with SMTP id c20mr6016912ybm.345.1624380041368;
 Tue, 22 Jun 2021 09:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid> <CAGETcx-dZ_Wwjafk+5akWJwbrFx2rYNKZAU8tWhFUunEyn8sqQ@mail.gmail.com>
In-Reply-To: <CAGETcx-dZ_Wwjafk+5akWJwbrFx2rYNKZAU8tWhFUunEyn8sqQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Jun 2021 09:40:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VCgugY6veyqs09Owc72FSeuCJkNZEb93Or1Ud2jmfExw@mail.gmail.com>
Message-ID: <CAD=FV=VCgugY6veyqs09Owc72FSeuCJkNZEb93Or1Ud2jmfExw@mail.gmail.com>
Subject: Re: [PATCH 4/6] iommu: Combine device strictness requests with the
 global default
To:     Saravana Kannan <saravanak@google.com>
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
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 21, 2021 at 7:56 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Jun 21, 2021 at 4:53 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > In the patch ("drivers: base: Add bits to struct device to control
> > iommu strictness") we add the ability for devices to tell us about
> > their IOMMU strictness requirements. Let's now take that into account
> > in the IOMMU layer.
> >
> > A few notes here:
> > * Presumably this is always how iommu_get_dma_strict() was intended to
> >   behave. Had this not been the intention then it never would have
> >   taken a domain as a parameter.
> > * The iommu_set_dma_strict() feels awfully non-symmetric now. That
> >   function sets the _default_ strictness globally in the system
> >   whereas iommu_get_dma_strict() returns the value for a given domain
> >   (falling back to the default). Presumably, at least, the fact that
> >   iommu_set_dma_strict() doesn't take a domain makes this obvious.
> >
> > The function iommu_get_dma_strict() should now make it super obvious
> > where strictness comes from and who overides who. Though the function
> > changed a bunch to make the logic clearer, the only two new rules
> > should be:
> > * Devices can force strictness for themselves, overriding the cmdline
> >   "iommu.strict=0" or a call to iommu_set_dma_strict(false)).
> > * Devices can request non-strictness for themselves, assuming there
> >   was no cmdline "iommu.strict=1" or a call to
> >   iommu_set_dma_strict(true).
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/iommu/iommu.c | 56 +++++++++++++++++++++++++++++++++----------
> >  include/linux/iommu.h |  2 ++
> >  2 files changed, 45 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 808ab70d5df5..0c84a4c06110 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -28,8 +28,19 @@
> >  static struct kset *iommu_group_kset;
> >  static DEFINE_IDA(iommu_group_ida);
> >
> > +enum iommu_strictness {
> > +       IOMMU_DEFAULT_STRICTNESS = -1,
> > +       IOMMU_NOT_STRICT = 0,
> > +       IOMMU_STRICT = 1,
> > +};
> > +static inline enum iommu_strictness bool_to_strictness(bool strictness)
> > +{
> > +       return (enum iommu_strictness)strictness;
> > +}
> > +
> >  static unsigned int iommu_def_domain_type __read_mostly;
> > -static bool iommu_dma_strict __read_mostly = true;
> > +static enum iommu_strictness cmdline_dma_strict __read_mostly = IOMMU_DEFAULT_STRICTNESS;
> > +static enum iommu_strictness driver_dma_strict __read_mostly = IOMMU_DEFAULT_STRICTNESS;
> >  static u32 iommu_cmd_line __read_mostly;
> >
> >  struct iommu_group {
> > @@ -69,7 +80,6 @@ static const char * const iommu_group_resv_type_string[] = {
> >  };
> >
> >  #define IOMMU_CMD_LINE_DMA_API         BIT(0)
> > -#define IOMMU_CMD_LINE_STRICT          BIT(1)
> >
> >  static int iommu_alloc_default_domain(struct iommu_group *group,
> >                                       struct device *dev);
> > @@ -336,25 +346,38 @@ early_param("iommu.passthrough", iommu_set_def_domain_type);
> >
> >  static int __init iommu_dma_setup(char *str)
> >  {
> > -       int ret = kstrtobool(str, &iommu_dma_strict);
> > +       bool strict;
> > +       int ret = kstrtobool(str, &strict);
> >
> >         if (!ret)
> > -               iommu_cmd_line |= IOMMU_CMD_LINE_STRICT;
> > +               cmdline_dma_strict = bool_to_strictness(strict);
> >         return ret;
> >  }
> >  early_param("iommu.strict", iommu_dma_setup);
> >
> >  void iommu_set_dma_strict(bool strict)
> >  {
> > -       if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
> > -               iommu_dma_strict = strict;
> > +       /* A driver can request strictness but not the other way around */
> > +       if (driver_dma_strict != IOMMU_STRICT)
> > +               driver_dma_strict = bool_to_strictness(strict);
> >  }
> >
> >  bool iommu_get_dma_strict(struct iommu_domain *domain)
> >  {
> > -       /* only allow lazy flushing for DMA domains */
> > -       if (domain->type == IOMMU_DOMAIN_DMA)
> > -               return iommu_dma_strict;
> > +       /* Non-DMA domains or anyone forcing it to strict makes it strict */
> > +       if (domain->type != IOMMU_DOMAIN_DMA ||
> > +           cmdline_dma_strict == IOMMU_STRICT ||
> > +           driver_dma_strict == IOMMU_STRICT ||
> > +           domain->force_strict)
> > +               return true;
> > +
> > +       /* Anyone requesting non-strict (if no forces) makes it non-strict */
> > +       if (cmdline_dma_strict == IOMMU_NOT_STRICT ||
> > +           driver_dma_strict == IOMMU_NOT_STRICT ||
> > +           domain->request_non_strict)
> > +               return false;
> > +
> > +       /* Nobody said anything, so it's strict by default */
>
> If iommu.strict is not set in the command line, upstream treats it as
> iommu.strict=1. Meaning, no drivers can override it.
>
> If I understand it correctly, with your series, if iommu.strict=1 is
> not set, drivers can override the "default strict mode" and ask for
> non-strict mode for their domain. So if this series gets in and future
> driver changes start asking for non-strict mode, systems that are
> expected to operate in fully strict mode will now have devices
> operating in non-strict mode.
>
> That's breaking backward compatibility for the kernel command line
> param. It looks like what you really need is to change iommu.strict
> from 0/1 to lazy (previously 0), strict preferred, strict enforced
> (previously 1) and you need to default it to "enforced".

I'm not quite sure I'd agree, but certainly it could be up for debate.
I think I'm keeping full compatibility with the kernel command line
parameter, specifically:

* iommu.strict=0: default to non-strict mode unless a driver overrides

* iommu.strict=1: force everything to strict no matter what

...both of those two things are the same before and after my patchset.

You're arguing that I'm changing the behavior of the system when no
command line parameter is present. To me this seems a little bit of a
stretch. If no command line parameter is present I'd assert that the
kernel should do some sort of sane behavior and that we don't have to
force 100% strictness if the command line parameter isn't present at
all.

I would also note that your assertion that the system is 100% strict
under the "no command line parameter" case isn't actually true as far
as I can tell. The code in mainline is a little hard to follow (for me
the code after my patch is easier to follow), but you can see that
even before my patch a call to iommu_set_dma_strict() could be used to
make the system non-strict if no command-line parameter was passed.


> Alternately (and potentially a better option?), you really should be
> changing/extending dev_is_untrusted() so that it applies for any
> struct device (not just PCI device) and then have this overridden in
> DT (or ACPI or any firmware) to indicate a specific device is safe to
> use non-strict mode on.

I was really trying _not_ to do that. I believe this has been talked
about several times, including at last year's Linux Plumbers
conference. As far as I can tell it always ends in a shouting match w/
no forward progress. There are a bunch of problems here, namely:

* Trust isn't necessarily binary. There might be peripherals that you
sort-of trust, others that you really trust, and others that you don't
trust at all. For the ones you sort-of trust there may be some things
you trust about them and other things you don't trust about them.

* The firmware isn't necessarily the best arbitrar of trust. For
instance, if the company that employs me (Google) compiled their own
firmware for a given peripheral device and they were convinced that
the peripheral firmware couldn't be compromised any more easily than
code running in the kernel itself, they might assert that the
peripheral device should be "trusted". An individual Linux hacker,
however, might not really trust the firmware blob that Google provides
and might want the device to be "untrusted".

* In the PCI subsystem I believe that "trusted" vs "untrusted" is
generally associated with whether a device is soldered down onto the
board or in some type of slot (the "external" concept). That's been
working OK for them, I think, but I'm not convinced it'd be easy to
apply everywhere. One example problem: what do you do about SD cards?
The thing doing the DMA (the SDHCI controller) is certainly "internal"
but the cards are "external". I'm making the argument in my series
that SDHCI should be considered at least trusted enough to use
non-strict DMA, but it's still technically "external" and you wouldn't
necessarily, for instance, trust the filesystem structure not to be
crafted in a malicious way so as to exploit the kernel.

> What you are trying to capture (if the device
> safe enough) really isn't a function of the DMA device's driver, but a
> function of the DMA device.

It's a function of the DMA device, but the entity in the kernel with
the most knowledge about this is the device's driver. The driver also
has the best ability to make informed decisions, perhaps looking at
the device's properties (like the "non-removable" one for SD/MMC) to
help make decisions without us having to create a new property to
describe trust and then argue about who sets it and when.

-Doug
