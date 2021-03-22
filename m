Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447B2343EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhCVLGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:06:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhCVLFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:05:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A044E61879;
        Mon, 22 Mar 2021 11:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616411131;
        bh=9PoZ2UOAkMcPPEoghhVL5b7gkf7yE9xH1RgjLaPzkno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V59K6zDFWymyp9QUxzwsidE+vdao8WL9jfLDqvUnzP1Bw6NWUx8SoOCNYizS3o9ep
         j8EJhCp56mRpfs+cASmFJRUoxCofOcIuhRskcKo0beTF0nBD7Qb5fOqrGM0noW17d2
         jjinYW3wnDZNoCxX7mV0o/rQtfVDjEPq9juhKOyuI13iTW8rbVUN9TEL0Q0vLf6oWV
         ps3SZQfAJosZCvVn/224d9O780yAAnfNIcFRiHfYrdvRZqmPYEgeF8uMe/PpE9qvGR
         wZgMgAEFN+I7t00zLsCLtY3K8VXWisHZo0l5XxA1xcRykgTfeMOAmKsQDqmLkTTPT3
         ElWDyHmxaTYmw==
Date:   Mon, 22 Mar 2021 13:05:26 +0200
From:   Abel Vesa <abelvesa@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-clk <linux-clk@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH V4] clk: imx: Fix reparenting of UARTs not associated
 with stdout
Message-ID: <YFh59k4LJQ964Q/u@ryzen.lan>
References: <20210313122818.445228-1-aford173@gmail.com>
 <e754a185-4aa2-295a-37a8-dd0c7ebc289f@pengutronix.de>
 <0361ab5b-a26e-7631-9bae-8909715f6354@pengutronix.de>
 <CAHCN7xLSMGOe6E0YQU=n0aKX53_CV2cz9BgqO2OA96S1-eTMgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xLSMGOe6E0YQU=n0aKX53_CV2cz9BgqO2OA96S1-eTMgg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-20 18:00:25, Adam Ford wrote:
> On Sun, Mar 14, 2021 at 4:40 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >
> > On 13.03.21 16:16, Ahmad Fatoum wrote:
> > >> +/* i.MX boards use device trees now.  For build tests without CONFIG_OF, do nothing */
> > >> +#ifdef CONFIG_OF
> > >>      if (imx_keep_uart_clocks) {
> > >>              int i;
> > >>
> > >> -            imx_uart_clocks = clks;
> > >> -            for (i = 0; imx_uart_clocks[i]; i++)
> > >> -                    clk_prepare_enable(*imx_uart_clocks[i]);
> > >> +            imx_uart_clocks = kcalloc(clk_count, sizeof(struct clk *), GFP_KERNEL);
> > >> +
> > >> +            if (!of_stdout)
> > >> +                    return;
> > >
> > > Memory leak. Just do if (imx_keep_uart_clocks && of_stdout)
> >
> > Please dismiss. I overlooked that you free it in a later initcall.
> 
> Abel,
> 
> Are you OK with this?  I also have a V5 posted [1] which does what
> Ahmad suggested.
> 

I'm OK with this version. Applied it on my clk/imx branch:
git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git

Thanks a lot for all the effort.

> Either of these will fix reparenting issues, but I need this for
> Bluetooth to operate correctly, because both beacon imx8mn and imx8mn
> kits switch the UART parent to an 80MHz clock in order to run at
> 4Mbps.
> 
> thank you,
> 
> adam
> >
> > >>  static int __init imx_clk_disable_uart(void)
> > >>  {
> > >> -    if (imx_keep_uart_clocks && imx_uart_clocks) {
> > >> +    if (imx_keep_uart_clocks && imx_enabled_uart_clocks) {
> > >>              int i;
> > >>
> > >> -            for (i = 0; imx_uart_clocks[i]; i++)
> > >> -                    clk_disable_unprepare(*imx_uart_clocks[i]);
> > >> +            for (i = 0; i < imx_enabled_uart_clocks; i++) {
> > >> +                    clk_disable_unprepare(imx_uart_clocks[i]);
> > >> +                    clk_put(imx_uart_clocks[i]);
> > >> +            };
> > >> +            kfree(imx_uart_clocks);
> > >>      }
> >
> > --
> > Pengutronix e.K.                           |                             |
> > Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
