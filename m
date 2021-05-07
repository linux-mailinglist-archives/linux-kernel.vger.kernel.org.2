Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEFC37612D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbhEGHdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhEGHdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:33:17 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC415C061763
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 00:32:16 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id j128so4251760vsc.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 00:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ISEXijb9zAgrvpvMxtfDW4VYLgxl60uo+zvkmzN/jGE=;
        b=pXhFA1jEqZJaRIZVlnRs0aUOrebek2H8j845n+HDFcVCw5vGyKpYYB+QFcL9wukt/C
         B9qNi4HcSR+oT3ZfK3bzN9u5rwU6AUMGA3L7xYfXTLdUPWJKzuhdGIMSZ2iRWc5AHVvb
         E6twcSMxbDPdf3jo4szNAq1kHmobM3cyE5XKWvfCVGej1ROstVdxPV7jAVC2C3Hdn1TL
         B7nUtisJ2lQJOFkpeuvwYmxtkbwmSBBV4+usU4lV2WCF3kw4H1PUuvPh+kOeggh3c2IO
         asWop5e/apV8/5IJlMysgfNTIeIF2SpwffIUpDk2R9XlnVLehZjrmswrCMbB+2AKCP0E
         MYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ISEXijb9zAgrvpvMxtfDW4VYLgxl60uo+zvkmzN/jGE=;
        b=giZgJED8F/7ABOJKpKWhkV1DAFr7+xaaOSjHHao1yLsnxagCFTgW0mk0WU5wmpz//F
         JUeTxdaY6cyWApVD44wXBI4edd0zyPhOXul82b6FdjdUFhT0jtpuctKF09Wj4pCjt2iD
         EcopvXk7JTBTVRnefytx7frCb93y6391HkSIRuvj2J3+wXavfJXT7Rc67haZEfH0wo4R
         QPKnESkgQ8ejdG1fLQtcuJm37zdELI5seeU6TQlPX3SeGN5G0X5iBx41a6LzRLOx4Go1
         LkNs5lMx07Fyes/yj2rYcoOkrujTO5ki2w+vIdxoXDXiylAGNzwVIDED5appA5/Jjsdx
         r3/w==
X-Gm-Message-State: AOAM531pz6xFKQ8o9rNZoO0T6jGMVD77mWmErSPCJH9rhp8nJhXSYUdG
        HjXlv2D+vNcxCHmiWE8BjC9ZHGqfeIp2eaS+0ECKSLA9ntHKQg==
X-Google-Smtp-Source: ABdhPJwLuWMccR2AOfG9xSWs0t4E/w5MuX7GyZjU0lUjJwUaV2uz7yjaF801ZDGaifxU9CR+3Remi0hA4aEYUcsnuQs=
X-Received: by 2002:a05:6102:7c1:: with SMTP id y1mr7177715vsg.34.1620372736198;
 Fri, 07 May 2021 00:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <DM6PR04MB65750A91FDC869FD3ABFE27AFC579@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65750A91FDC869FD3ABFE27AFC579@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 May 2021 09:31:39 +0200
Message-ID: <CAPDyKFoifq5Dv1HiHpF2QcfO8ZTuf+OL0Uyo7fGr1gDVfdw+Tw@mail.gmail.com>
Subject: Re: [PATCH 00/11] Initital support for new power/perf features for SD cards
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2021 at 08:44, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> >
> > In the SD spec v4.x the SD function extension registers were introduced=
,
> > together with a new set of commands (CMD48/49 and CMD58/59) to read
> > and write
> > to them.
> >
> > Moreover, in v4.x a new standard function for power management features
> > were
> > added, while in v6.x a new standard function for performance
> > enhancements
> > features were added.
> >
> > This series implement the basics to add support for these new features =
(and
> > includes some additional preparations in patch 1->7), by adding support=
 for
> > reading and parsing these new SD registers. In the final patch we add
> > support
> > for the SD poweroff notification feature, which also add a function to =
write
> > to
> > these registers.
> >
> > Note that, there are no HW updates need for the host to support
> > reading/parsing
> > of the these new SD registers. This has been tested with a 64GB Sandisk
> > Extreme
> > PRO UHS-I A2 card.
> >
> > Tests and reviews are of course greatly appreciated!
> Echoing an internal discussion about this series:
> "...
> That is very good that there will be a support of the extension registers=
 of SD spec .   It may allow existing and future features to be very easily=
 supported by hosts (like existing power off control and future TCG/RPMB re=
lated spec which is currently under definition and is going to use those re=
gisters as well..).

Thanks for sharing. I am happy to help!

> ..."
> Therefore for entire series: Acked-by: Avri Altman <avri.altman@wdc.com>

Thanks for reviewing!

Kind regards
Uffe
