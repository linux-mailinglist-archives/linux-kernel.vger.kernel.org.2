Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9603B22D8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 23:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFWWAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 18:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhFWWAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 18:00:45 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF53C061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 14:58:25 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id w26so3299004qto.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 14:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r/MN36zXLdNsjoAEGu6m1LiJpjInqCbgz6NsqthKVEQ=;
        b=x/CV2npe7wDi6T0xQ3JhizA5sk4Y9x3fWAakMUZFQmDa4VVQTpnqKAvTiFXR3tCAJ5
         GlmWxvM6BfHPRQ4z0zOF+o6WXdgNp6Qwx6scGfl0pIgCaLyFNR6Klg/ieJSOxb1M0ePj
         RUtRJmEPNIndulg7moetEeSb8UPpieeiWjyh9uq6WOcdWhb0ITl/7tJo4hKP2gXTyAt1
         zUFkq/QZjDyZd+icauQx0t4v3dThIQFmPZU/b8DE5iDlQPam+S/wjefYuk6cpinmFunZ
         sugeswh88niYsGAipcN4QbOo5N1ihhOu7vONZUAsl7CpwnjuqkpttB2RdiA4vVG4Qvdu
         USaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r/MN36zXLdNsjoAEGu6m1LiJpjInqCbgz6NsqthKVEQ=;
        b=rmhcfdeTUuOpegyhE9sF3ixyEakSUCHG+3/SJmh2WFCoIMnhDp0TZYksznKFd5mKcr
         NomuFdhRN9OTLJMuE83JR+mNGUuLHCfLw4GZonfoEoS0LR3jA0Tz46w0tiz5BTwKnu2E
         GmugRd8KoE7crgeMrh2uqSq1WYbtqWL6ncdYlGHUwFMx7rto7rK0/lbFNTaYz7Y6sAbC
         gLhuoSdeVIPIbWZkhEOnJVpm/JRH0aajnwkPfFObRUIQ4L1BgG0rRczbWF8LoRgbxXbI
         brfizIqr1ajXlWodUuD+weFMqr0tslgpeAQdWElp2/MFD6SoZ2xU0RCTra14BuFuQseK
         RMLA==
X-Gm-Message-State: AOAM531l9yrQm+V1HJ8WkBZI+shv6phHcMLl6gJVflK+dufbVutinjR2
        YgaJJHP0d12kgFssnLBsOL0Kau8jzdfbhCmteOQkjQ==
X-Google-Smtp-Source: ABdhPJxSvJ7TpynFxZzKD7X+xlm1ajpwRHLijqAwnuzKavaXB5t7Go+wmidIrlF0Zq9zHunTgCCBvNrDSBH4KqdjE6w=
X-Received: by 2002:ac8:6e8e:: with SMTP id c14mr1999470qtv.216.1624485504204;
 Wed, 23 Jun 2021 14:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210621173028.3541424-1-mw@semihalf.com> <20210621173028.3541424-5-mw@semihalf.com>
 <YNOZfB4pBRrOYETA@lunn.ch>
In-Reply-To: <YNOZfB4pBRrOYETA@lunn.ch>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 23 Jun 2021 23:58:14 +0200
Message-ID: <CAPv3WKc5G07Te2yK+zJo=M0w-fmPVDZ3_YgNoO-BbssWHLtU7Q@mail.gmail.com>
Subject: Re: [net-next: PATCH v3 4/6] net: mvmdio: add ACPI support
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
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

=C5=9Br., 23 cze 2021 o 22:28 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> On Mon, Jun 21, 2021 at 07:30:26PM +0200, Marcin Wojtas wrote:
> > This patch introducing ACPI support for the mvmdio driver by adding
> > acpi_match_table with two entries:
> >
> > * "MRVL0100" for the SMI operation
> > * "MRVL0101" for the XSMI mode
>
> Same as the freescale MDIO bus driver, you should add
>
> depends on FWNODE_MDIO
>
> Otherwise you might find randconfig builds end up with it disabled,
> and then linker errors.
>

The CONFIG_MVMDIO is selected by CONFIG_MV643XX_ETH and actually there
is a real example of the previously discussed fallback to the
mdiobus_register() (without DT/ACPI and now FWNODE_MDIO). I just
checked and successfully built the kernel out of the dove_defconfig. I
only needed below fix, that will be submitted in v4:

--- a/include/linux/fwnode_mdio.h
+++ b/include/linux/fwnode_mdio.h
@@ -40,7 +40,7 @@ static inline int fwnode_mdiobus_register(struct mii_bus =
*bus,
         * This way, we don't have to keep compat bits around in drivers.
         */

-       return mdiobus_register(mdio);
+       return mdiobus_register(bus);
 }
 #endif

In order to leave dove_defconfig intact, I'd keep the current Kconfig
shape for this driver.

Thanks,
Marcin
