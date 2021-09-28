Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3219741BA5B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 00:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243091AbhI1WaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 18:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243072AbhI1WaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:30:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A502613A0;
        Tue, 28 Sep 2021 22:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632868120;
        bh=CpoB/AQaiB5lLCqB8ho11PEAW2+8Qw4aT/GKC1JnWBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NWHhMqyqu5ZeEo7veyI0DPB8sfx/QCj+Q6/4ri8A+3eKcgUBjZ2OSX1rCewPb226Y
         IzDq987TbzOv2e1SuaxsSPVI4471heZdrf3Yu1oJHcUukxwQXqv7v2Z/Via9w5kfG8
         c2D3Pt6Tk9p/qwZDK1kSi6Fdr9/FpF0CZrmHLDeE1xI9neyG3KgK2rAwo3Mf/A/x6q
         jpMcuhdfzW2xeHYcHLMWmHHnJ+2fFXEF/aeZTtLIfn+Reb0S8q4/fru1L3wKcvo2kN
         sRB6UvFq1i2+o/tmhodQdcJFeA8cfLTvsQ3H5hSAomDnY5QVoiR4xnXE0EA+l9EOz5
         S0Amq1sMI7KzA==
Received: by mail-ed1-f54.google.com with SMTP id v18so842755edc.11;
        Tue, 28 Sep 2021 15:28:40 -0700 (PDT)
X-Gm-Message-State: AOAM5327P3KjnrP/IK8jq45xlur3TnDrPhzuwsJ0xoOo5QnogXUEPdzr
        lN0roiMtVTtQ9lnsQdXRULlu+siTz53qGyw92Q==
X-Google-Smtp-Source: ABdhPJwf3T2vDvRzn1kn4EttNExbUJlEkqp3unlYwOfhx9E5xNV/zF/ODC8gDrpuUojJrEloyRNMxi7elthKPR3Tgus=
X-Received: by 2002:a50:d903:: with SMTP id t3mr10809492edj.70.1632868118869;
 Tue, 28 Sep 2021 15:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
 <20210922103116.30652-11-chin-ting_kuo@aspeedtech.com> <YVIUf7/4ukMcrOb9@robh.at.kernel.org>
 <HK0PR06MB2786DAAA2D6E58EA2E2FCB6BB2A89@HK0PR06MB2786.apcprd06.prod.outlook.com>
In-Reply-To: <HK0PR06MB2786DAAA2D6E58EA2E2FCB6BB2A89@HK0PR06MB2786.apcprd06.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 28 Sep 2021 17:28:27 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+TZFXrvfJTjofVcnT6jJat-3SvWj+jAq0QST8ndfeUMA@mail.gmail.com>
Message-ID: <CAL_Jsq+TZFXrvfJTjofVcnT6jJat-3SvWj+jAq0QST8ndfeUMA@mail.gmail.com>
Subject: Re: [PATCH 10/10] dt-bindings: mmc: aspeed: Add a new compatible string
To:     Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc:     "joel@jms.id.au" <joel@jms.id.au>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        Steven Lee <steven_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 9:51 PM Chin-Ting Kuo
<chin-ting_kuo@aspeedtech.com> wrote:
>
> Hi Rob,
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Tuesday, September 28, 2021 2:59 AM
> > To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> > Subject: Re: [PATCH 10/10] dt-bindings: mmc: aspeed: Add a new compatible
> > string
> >
> > On Wed, Sep 22, 2021 at 06:31:16PM +0800, Chin-Ting Kuo wrote:
> > > Add "aspeed,ast2600-emmc" compatible string for the sake of
> > > distinguishing between SD and eMMC device.
> >
> > Why?
> >
> > Is the h/w block different? We already have properties to handle some of the
> > eMMC specifics. Also, you can have a child node for the eMMC device if you
> > need that.
>
> There are two SD/SDIO controllers in a AST2600 SoC.
> One is for SD card and the other is for eMMC.
> Although both of them are embedded in the same SoC, the design of delay cell and
> the manufacture process are different. The delay phase is definitely different and, thus,
> we need a flag, compatible, to distinguish the device, SD or eMMC.
>
> Without "aspeed,ast2600-emmc" compatible, of course, eMMC device can work with original
> sdhci driver and device tree setting. But, for ultra-speed or HS200 case, AST2600 SoC needs some
> phase delay which (maximum) value is different between SD and eMMC device.

This is quite common as tweaking the timing is also need per board.
Look at what other bindings have done. A property is more appropriate
here.

Rob
