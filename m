Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CAA3B196C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 13:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFWL7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 07:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhFWL7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:59:36 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5F7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 04:57:12 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id f20so994828qtk.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 04:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x5vFMDouVptIPulEUNojaykRsUXUmKi/iqh92tpdGR0=;
        b=YrTFA08Q0hWBW+/9QUt5uzBBOj9vAtbC2nJ58rKgKDropZkwVUx7Os3M/VEdI1vIra
         vuOH615Mq5KTo+cm4yP6yGyx3PlnWukFYYjSzYH7Lj5apXqLFAuZmK60y3PVk/c2nwwo
         +TFPow56qNpfAnjE96x5pI+O4/PT1aZxsXFBwCVcgogm/lu5FWLdP/6AHrPoGbc2+i4a
         NzvIOrYxOsXBBruKnCzfBLCgkmyi/EUPxFGriUFNektERBseBYBdGsn4KWREnOzTdgwW
         7RyyARRyaYh251OYwcoU19LtcTnGWawYOCy4LyrZ7wFY7wSpjoLbhw3Uj1MKlgCcpv9i
         gVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x5vFMDouVptIPulEUNojaykRsUXUmKi/iqh92tpdGR0=;
        b=YKwWvg16/6YNqm1nxuNPZ4Gk2wu0k1fl0bgBcdKrpJeHOMHXycpzg1qRDIybAIE1HY
         ybJeBBPRWKXNszmtvzZED6/6HsWqotDScoVyOPYn4Uo+vIQuVUxPbHK5YnCBJNFI1f9b
         WXyMgRrJdZtVlCPPyA/7Tl6ZbZtSaiaGfRrwJCyetquNGXedLiz12lbdBcOFpIwytPI2
         SxxLsbYvTTXzH1VHdf5FhjpfNp3IFeoCbjuH0a5e3RSJncmaBsRuv9e833QissoZx3fZ
         ovakHjN1Fvr120BD1tdYr0huZd8YIZjSZ9BIZy2Xwb672R/DnGEJELemr+/wHXXL+SWh
         QFfw==
X-Gm-Message-State: AOAM532msFuzt4bISCapRe3zLLgHJRL8AdZefCM3E74gQFkUzYkoHoKY
        w86GIy00EyWSAFasZ8WF6QY8TUybndAur/ZKmwPRky+e/oI=
X-Google-Smtp-Source: ABdhPJxF+m/IP+Y0tPSs974EHf+hK7KOpfuHeWsuOEZszJO5xQhQKQyBrDRkHci4APQa2FbmkAPEf5PZLCiykw+2vrc=
X-Received: by 2002:ac8:46c4:: with SMTP id h4mr3474482qto.343.1624449431095;
 Wed, 23 Jun 2021 04:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210621173028.3541424-1-mw@semihalf.com>
In-Reply-To: <20210621173028.3541424-1-mw@semihalf.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 23 Jun 2021 13:56:59 +0200
Message-ID: <CAPv3WKdtpM+rYFenbCxTGcfb-1wk8jB=mHQJNU3oQB1qENB-PQ@mail.gmail.com>
Subject: Re: [net-next: PATCH v3 0/6] ACPI MDIO support for Marvell controllers
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>, upstream@semihalf.com,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Jon Nettleton <jon@solid-run.com>,
        Tomasz Nowicki <tn@semihalf.com>, rjw@rjwysocki.net,
        lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

pon., 21 cze 2021 o 19:31 Marcin Wojtas <mw@semihalf.com> napisa=C5=82(a):
>
> Hi,
>
> The third version of the patchset main change is
> dropping a clock handling optimisation patch
> for mvmdio driver. Other than that it sets
> explicit dependency on FWNODE_MDIO for CONFIG_FSL_XGMAC_MDIO
> and applies minor cosmetic improvements (please see the
> 'Changelog' below).
>
> The firmware ACPI description is exposed in the public github branch:
> https://github.com/semihalf-wojtas-marcin/edk2-platforms/commits/acpi-mdi=
o-r20210613
> There is also MacchiatoBin firmware binary available for testing:
> https://drive.google.com/file/d/1eigP_aeM4wYQpEaLAlQzs3IN_w1-kQr0
>
> I'm looking forward to the comments or remarks.
>

I would really appreciate if this third revision can possibly get
attention some in coming days. There's still some buffer for
improvements, so that in case of no objections, it can be queued for
v5.14 via net-next tree.

Thanks,
Marcin

Marcin

>
> Changelog:
> v2->v3
> * Rebase on top of net-next/master.
> * Drop "net: mvmdio: simplify clock handling" patch.
> * 1/6 - fix code block comments.
> * 2/6 - unchanged
> * 3/6 - add "depends on FWNODE_MDIO" for CONFIG_FSL_XGMAC_MDIO
> * 4/6 - drop mention about the clocks from the commit message.
> * 5/6 - unchanged
> * 6/6 - add Andrew's RB.
>
> v1->v2
> * 1/7 - new patch
> * 2/7 - new patch
> * 3/7 - new patch
> * 4/7 - new patch
> * 5/7 - remove unnecessary `if (has_acpi_companion())` and rebase onto
>         the new clock handling
> * 6/7 - remove deprecated comment
> * 7/7 - no changes
>
> Marcin Wojtas (6):
>   Documentation: ACPI: DSD: describe additional MAC configuration
>   net: mdiobus: Introduce fwnode_mdbiobus_register()
>   net/fsl: switch to fwnode_mdiobus_register
>   net: mvmdio: add ACPI support
>   net: mvpp2: enable using phylink with ACPI
>   net: mvpp2: remove unused 'has_phy' field
>
>  drivers/net/ethernet/marvell/mvpp2/mvpp2.h      |  3 -
>  include/linux/fwnode_mdio.h                     | 12 ++++
>  drivers/net/ethernet/freescale/xgmac_mdio.c     | 11 +---
>  drivers/net/ethernet/marvell/mvmdio.c           | 14 ++++-
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 23 ++++++--
>  drivers/net/mdio/fwnode_mdio.c                  | 22 ++++++++
>  Documentation/firmware-guide/acpi/dsd/phy.rst   | 59 +++++++++++++++++++=
+
>  drivers/net/ethernet/freescale/Kconfig          |  4 +-
>  8 files changed, 125 insertions(+), 23 deletions(-)
>
> --
> 2.29.0
>
