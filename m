Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9208C37608C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhEGGm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbhEGGmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:42:19 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1ADC061761
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 23:41:17 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso7071087otb.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 23:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3n4fr9dTk5xRx8UuqHEXWcQIVk+nbzaIFIelcFE2hE=;
        b=M7xIUdn7ch+gJjW1FHSOUdQL0R3TC1bcnypTyGGHLc0cY76uZ/GIWoVonMCyVzFbGv
         vNZPMumaBIhYJ9zgZWVfngxBJf/e7uFWIdPgSl1rWCswsask5rmOI15kShycUTA+uViL
         h9gmPCxAsZmKgnMRqOJ+9SOhO3SsVguxcFIqOs2cP8RE3Mtak1lSUX0FQT0WXASAVzdh
         3LOLTfJ3d5LPnBzARHqYKpvNG0VFsBaYjRTvJ6v9/NYbgR2o9/BmSoqaVxL4g25fQGAr
         NrftC/BJzDoSqmWSkwPAL2RYAUkbvSI5FIJuj/QeyvaR8fAkiExWMwS3Q05HmIMuMtTD
         kKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3n4fr9dTk5xRx8UuqHEXWcQIVk+nbzaIFIelcFE2hE=;
        b=WTYqsPX7/COUSYQoHxyDC67jbf17kjpedhUhZ4bDcsEXmZHLrxv2O47Oe9cVnCFPJQ
         mD52yFD64KJXjiNydj37aiS4o5cbONuo/rP9ktPa0WKzrHkdAxivgc+rmdZEo9AUIPvm
         jDkk8hDYeBwQslEB7zcexcLws0PGiA3T3k2/sJrzv0B2xmZfq0tp9D4QqMa9N34UJbSQ
         dMWPjogLrzM02Ph1G5es3m++7ksHjfHhKBZc9NFibBvicPphaqDhGsGFPDCfr90JamP2
         90i6h7hNnLsl9BtuIuuyyJfaWkTx5zUPR8Qek2O9cE27iv/bkCRiAknIqimNJGjTHwxU
         v91w==
X-Gm-Message-State: AOAM532cZMIO6242M+N5p8+mYZEW8tw48EH1ybtoJMnVOYqHt+V+7Ddb
        G5vdUvRx7wdOgbwwI4F//Q6Cd4u1wsB+rBL71Ho8V8okDzpTrA==
X-Google-Smtp-Source: ABdhPJyne8zPKeW8cqCNwfckghTjW6ZFggoSHasJeT5Zz9euA0cLMfZpibRLgdHdyvqBIvLcrBmYp2OM+0h3cPIpy68=
X-Received: by 2002:a9d:4e9a:: with SMTP id v26mr6905085otk.74.1620369676505;
 Thu, 06 May 2021 23:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210507060142.17049-1-sergio.paracuellos@gmail.com> <YJTd4cl6ZsPieC1b@kroah.com>
In-Reply-To: <YJTd4cl6ZsPieC1b@kroah.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 7 May 2021 08:41:05 +0200
Message-ID: <CAMhs-H_4BPmLZiMc1wT+AdhJ7_=ttpu5LhaXtks84brSAxF5mg@mail.gmail.com>
Subject: Re: [PATCH] phy: ralink: phy-mt7621-pci: properly print pointer address
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 7, 2021 at 8:27 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 07, 2021 at 08:01:42AM +0200, Sergio Paracuellos wrote:
> > The way of printing the pointer address for the 'port_base'
> > address got into compile warnings on some architectures
> > [-Wpointer-to-int-cast]. Instead of use '%08x' and cast
> > to an 'unsigned int' just make use of '%px' and avoid the
> > cast.
> >
> > Fixes: d87da32372a0 ("phy: ralink: Add PHY driver for MT7621 PCIe PHY")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  drivers/phy/ralink/phy-mt7621-pci.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/phy/ralink/phy-mt7621-pci.c b/drivers/phy/ralink/phy-mt7621-pci.c
> > index 753cb5bab930..4705931fb072 100644
> > --- a/drivers/phy/ralink/phy-mt7621-pci.c
> > +++ b/drivers/phy/ralink/phy-mt7621-pci.c
> > @@ -272,8 +272,8 @@ static struct phy *mt7621_pcie_phy_of_xlate(struct device *dev,
> >
> >       mt7621_phy->has_dual_port = args->args[0];
> >
> > -     dev_info(dev, "PHY for 0x%08x (dual port = %d)\n",
> > -              (unsigned int)mt7621_phy->port_base, mt7621_phy->has_dual_port);
> > +     dev_info(dev, "PHY for 0x%px (dual port = %d)\n",
> > +              mt7621_phy->port_base, mt7621_phy->has_dual_port);
>
> This whole message should be dropped as drivers should be quiet if all
> is going well, and only print messages when things go wrong.

Got it. Will move this into dev_dbg instead. Thanks.

>
> And why cc: linux-staging?

True, sorry for that. Ctrl + r search for previous git send-mail and I
forgot to drop staging from there.

>
> thanks,
>
> greg k-h

Best regards,
    Sergio Paracuellos
