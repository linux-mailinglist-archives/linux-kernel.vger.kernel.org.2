Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927DA33DC59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbhCPSPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239839AbhCPSOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:14:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF3CC06174A;
        Tue, 16 Mar 2021 11:14:41 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o19so22693227edc.3;
        Tue, 16 Mar 2021 11:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1281BEyC1N/sT0yDV1ajNVpUCqqu0ZuaYNj98TiHdxs=;
        b=Ma6frPA12KuX2NdGrfivrV6AEKXf4Czg2U6M5tAJ9qOqAIT0iBHLP5bR/FdRCdzhD2
         Pe23/e0EIDYbdsK41mWnugxrZj+ss1W1xiXA6zEK8d0EFPV2L0DI5u/H+yzN9Zsw1ch7
         FNgXLuk1RIcEfC2QMWi6jl6VYWEkoNfe52iF0vswYhDTTqlPDo3v2jXgEd3q/vEB5gZT
         HZIuWI0nCHo3MOnBVZzt1XasjtqNpbiOvGHTLIqsuJZBPtgM0jPlzYr1OZvJCeRW5naV
         AueELZZ8JyW/5Klgx6YxKcItM89Va+2/Ev3dDCdfN4Vh8EhddwuJj9bqfQ/vt20jMQCn
         Qq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1281BEyC1N/sT0yDV1ajNVpUCqqu0ZuaYNj98TiHdxs=;
        b=ETp/4URa5YKwx0BxVG6i8Tic3EDesfHh+rCLF/egUwWCRfPyfJo3bU4G1R267jW19C
         2px/9ouakYD1VjwGL6VpNeUCu1Vx+DK5Ib+n1+uJtjYyB/j+F6XpfGV9vQtV6CR5dcGm
         7suZX1Sub3DCtmrKwMxSryzxCh5mZ+rUdUREkpxtHRKZSe/qixKhdlBXsH6B+TSFYCsL
         +N/eVVjixN6RHwMNhfFCH9xhcgHlkP9RZ6/wqgwNC5/4EQj3W8hS1FWQZygKwWRhdTK/
         L9S8QoAf0iM2wRjbpQPf1kzvO/ZUJ288yvQdt8yg+Zb980YzRJn6Z5Vt6uKC5HYuMPHI
         GkYA==
X-Gm-Message-State: AOAM532XELiQXE43fGcmGdTvgo5VrecSwEP4edw1zzRmel20f9tZTG5A
        WvE/3pmoepw9mVbmz4Pix6I=
X-Google-Smtp-Source: ABdhPJy8qZ/Cu2VDNKCPnDxtC3JYXd3ZuKHkEtvTp8zsQo8ZWZQ0NiR8EUdREsP9WiMpngWnZ78V2Q==
X-Received: by 2002:a05:6402:2695:: with SMTP id w21mr37578680edd.99.1615918480553;
        Tue, 16 Mar 2021 11:14:40 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id g20sm9797574ejz.54.2021.03.16.11.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:14:39 -0700 (PDT)
Date:   Tue, 16 Mar 2021 20:14:37 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/6] clk: actions: Fix SD clocks factor table on Owl S500
 SoC
Message-ID: <20210316181437.GB1111731@BV030612LT>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
 <973b08fe414321ba4ade096a4917cadc2013426e.1615221459.git.cristian.ciocaltea@gmail.com>
 <20210316035845.GB1798@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316035845.GB1798@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

Thanks for reviewing this patch series!

On Tue, Mar 16, 2021 at 09:28:45AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 08, 2021 at 07:18:27PM +0200, Cristian Ciocaltea wrote:
> > Drop the unsupported entries in the factor table used for the SD[0-2]
> > clocks definitions on the Actions Semi Owl S500 SoC.
> > 
> > Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> >  drivers/clk/actions/owl-s500.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
> > index 75b7186185b0..69cd959205f5 100644
> > --- a/drivers/clk/actions/owl-s500.c
> > +++ b/drivers/clk/actions/owl-s500.c
> > @@ -127,8 +127,6 @@ static struct clk_factor_table sd_factor_table[] = {
> >  	{ 12, 1, 13 }, { 13, 1, 14 }, { 14, 1, 15 }, { 15, 1, 16 },
> >  	{ 16, 1, 17 }, { 17, 1, 18 }, { 18, 1, 19 }, { 19, 1, 20 },
> >  	{ 20, 1, 21 }, { 21, 1, 22 }, { 22, 1, 23 }, { 23, 1, 24 },
> > -	{ 24, 1, 25 }, { 25, 1, 26 }, { 26, 1, 27 }, { 27, 1, 28 },
> > -	{ 28, 1, 29 }, { 29, 1, 30 }, { 30, 1, 31 }, { 31, 1, 32 },
> 
> How did you determine that these values are not supported?
> 
> I've seen cases where the datasheet has the incomplete information about the
> supported ranges but the downstream driver has everything.

My primary source of information is the xapp-le kernel source code:
https://github.com/xapp-le/kernel

I always try to double check the implementation with the information
in the datasheet, but sometimes, as you already pointed out, it is
incomplete.

For the SD clocks, it is even worse: there is absolutely no information
related to the CMU_SD[0-2]CLK registers. Therefore I had to rely
exclusively on the downstream driver code.

Hence, for the SD1 clock, I identified the following code snippets:

static struct owl_clkreq divbit_PRESD0_CLK          = BITMAP(CMU_SD0CLK,                0x0000001f, 0);
static struct owl_clkreq divbit_SD0_CLK_2X          = BITMAP(CMU_SD0CLK,                0x00000100, 8);
static struct owl_refertab T_sdx2   = {{1, 128, -1}, 0};

static struct owl_div divider_PRESD0_CLK = {
    .type = DIV_T_NATURE,
    .range_from = 0,
    .range_to = 24,
    .reg = &divbit_PRESD0_CLK,
};

static struct owl_div divider_SD0_CLK_2X = {
    .type = DIV_T_TABLE,
    .range_from = 0,
    .range_to = 1,
    .ext = {.tab = &T_sdx2,},
    .reg = &divbit_SD0_CLK_2X,
};

This is basically what gets translated to sd_factor_table and I removed
the extra entries 25..31. Actually I also dropped the 24th one, since
that would give us an odd number of items, although I'm not quite sure
this is a bug in the xapp-le code or the HW is really supposed to work
like that.

Kind regards,
Cristi

> Thanks,
> Mani
> 
> >  
> >  	/* bit8: /128 */
> >  	{ 256, 1, 1 * 128 }, { 257, 1, 2 * 128 }, { 258, 1, 3 * 128 }, { 259, 1, 4 * 128 },
> > @@ -137,8 +135,6 @@ static struct clk_factor_table sd_factor_table[] = {
> >  	{ 268, 1, 13 * 128 }, { 269, 1, 14 * 128 }, { 270, 1, 15 * 128 }, { 271, 1, 16 * 128 },
> >  	{ 272, 1, 17 * 128 }, { 273, 1, 18 * 128 }, { 274, 1, 19 * 128 }, { 275, 1, 20 * 128 },
> >  	{ 276, 1, 21 * 128 }, { 277, 1, 22 * 128 }, { 278, 1, 23 * 128 }, { 279, 1, 24 * 128 },
> > -	{ 280, 1, 25 * 128 }, { 281, 1, 26 * 128 }, { 282, 1, 27 * 128 }, { 283, 1, 28 * 128 },
> > -	{ 284, 1, 29 * 128 }, { 285, 1, 30 * 128 }, { 286, 1, 31 * 128 }, { 287, 1, 32 * 128 },
> >  	{ 0, 0, 0 },
> >  };
> >  
> > -- 
> > 2.30.1
> > 
