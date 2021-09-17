Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A9940F342
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbhIQHa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbhIQHa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:30:26 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ABCC061574;
        Fri, 17 Sep 2021 00:29:04 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y28so29176675lfb.0;
        Fri, 17 Sep 2021 00:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmHkW0s9+t/ONd+yDxBn//RRzbrXvdLqidVR1RkmYM0=;
        b=Y6iqwhp+URme2AkzCH6L9p/AD3OAkrXgDg2Hd/frLGzetlzUbIKV6+bnRjZGnvshpy
         /l8JJ277oOtCeGJJ+DIERy4c4FADZE2AqvdS92eFtq/8iEmpcFZinGXcBomIteSyN1Os
         H3zJHZMJpwnkl7B7C0uAOdR7Xs1mVHHWqQlFZ2m9sX4BgjcX3cXxbOXpD8sEky+cBYuQ
         eQfK/R7Xt5X8Pg5GjhjLBy5p8YD7AEDm12cjWqdvDAIYFnAudALwgNruuGmwu5zBUfSA
         vEukpaGJ7dGG4X8IEUpFe3U3uBvfYSpn9dWoQ0hv64jo7eyWAWFBU38H0V2URk/a0sfW
         ZLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmHkW0s9+t/ONd+yDxBn//RRzbrXvdLqidVR1RkmYM0=;
        b=QQefVU8HDeVsPRKG/srJnRn1Vn+AINLWD6wLvwNd0s3W0SwKUW8ns10eg4V5/OuJ0E
         FVXUvRXuR0dvdntF3y6z7ryHa8XmthU1aOyBIzYJ771sq46xXRbPzs7sKb3+ajPK+2sZ
         PhPikh/pOQLew93AglQtsGq3cYd6UZ8BiMFphhCR1lSXQhYY09KydSz6xnbaHUGOh3aw
         QSnjPDzh2SNoZR3OD92Zka7O1ctb7oYMDv2AWeANIx4vR+v7iw6W5wbi3XDHqEgg3M6z
         btDw2BCNqruw7kkVYIuOcAMgTSIqjApY7gvHA8HHZQBXUnCe+5ixxovYfktNMl11dhUC
         lK9w==
X-Gm-Message-State: AOAM533w+baypzddOkjoxUc5iQNSYKy+UJwPHk9Irr/sIM1FH0UHftTa
        xwgTXKlF6qMHCs0caC6Azb7zDi9A4BuFfPGYZps=
X-Google-Smtp-Source: ABdhPJzGxQQwBhhrtEaweLkfzFUJA40jcPwllFvwIuOzWW6Oa+Fg+WH65jNMZ9ivUDYbeVPe3h9sKPNiDRJJGM8HZp4=
X-Received: by 2002:a19:6512:: with SMTP id z18mr7266098lfb.106.1631863742007;
 Fri, 17 Sep 2021 00:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210915120325.20248-1-heiko.thiery@gmail.com>
 <7e7ee4244ababc0a46e0875222c7e37d@walle.cc> <898fd5e0-2073-3689-89b6-2c5071773786@kontron.de>
In-Reply-To: <898fd5e0-2073-3689-89b6-2c5071773786@kontron.de>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Fri, 17 Sep 2021 09:28:51 +0200
Message-ID: <CAEyMn7ZbJr0_2Phc2rW7sDYQu4AABWPZ1F7xDgaS5U7ha7iqzA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm-kontron-n801x-som: do not allow to
 switch off buck2
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

Am Mi., 15. Sept. 2021 um 14:09 Uhr schrieb Frieder Schrempf
<frieder.schrempf@kontron.de>:
>
> On 15.09.21 14:05, Michael Walle wrote:
> > Am 2021-09-15 14:03, schrieb Heiko Thiery:
> >> The buck2 output of the PMIC is the VDD core voltage of the cpu.
> >> Switching off this will poweroff the CPU. Add the 'regulator-always-on'
> >> property to avoid this.
> >
> > Mh, have this ever worked? Is there a commit which introduced a regression?
>
> Yes, this did work before, even without 'regulator-always-on'. I
> currently don't understand why this is needed. The regulator is
> referenced in the CPU nodes as 'cpu-supply'. This should be enough to
> not disable it as long as the CPU is up.

I rechecked that with 5.11, 5.10 and 5.9 and I see on all of them the
same issue:

[ 31.716031] vdd-5v: disabling
[ 31.719032] rst-usb-eth2: disabling
[ 31.722553] buck2: disabling

While on that I tried to compare with other boards and see that they
also have the cpu-voltage marked as "regulator-always-on". The only
exception in dts/freescale is in imx8mq-librem5-devkit.dts [1] that
has not set this property.

I agree with you and don't understand why this is happening. Has
anyone else an explanation?

[1] https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts#L319

-- 
Heiko
