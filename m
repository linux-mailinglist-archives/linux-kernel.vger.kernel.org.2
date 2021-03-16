Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36A233CC60
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhCPD64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhCPD6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:58:52 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C7DC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 20:58:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so708493pjg.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 20:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SzXlqLikayDej+9/WrhYQCMKO1vcITmBgVXKNGZ0bAs=;
        b=zcIUpwKXaw9vakDsmOY9jbUuRQ9QiW/B6ZxkuPPh2Eher8WapBraPgcs5LoltOkLW4
         BebV6XUdvP/TgwEvBa8gAnNPBZlbuEix1nkjEArrgf/1Ng6AmP/QlVvJmiVQLgJYusDv
         CXLGEyNnOe20cykU0evYfKl0rXta3czGG+CFuAlACZ2eEmIZ+wNmi1TmmpbMfDmUPavC
         UpSORVz/6EtbSEPiWRTP6y8/stOdTxIkpAubJpLiAkRk+91BZzqT/ZJmKTB4dBO+b7TV
         WAm2G9hUV5wRkVuybbIljyn4Uoby4whwfDRfaY2weFzfUi+novhxqpkGxKWvy8zVIHLF
         aNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SzXlqLikayDej+9/WrhYQCMKO1vcITmBgVXKNGZ0bAs=;
        b=PBjlZNMGbMs5lKVH9tyJYREbMT5apqGtYBM+LVu4QdAHklqHnOYzn321kprT1XWLfY
         fDNTny5TBP4jpjpgTHyhpv7wv9qAMkkLE0pRupUSKCpWYCPEPLetLEi/aqiTsOdeoitI
         K/VDttBZSzImk4SGYBQbZ7vyoZLhb9rtYRovXJMSvkFci8WrLmol/EyXWa/Qm2MSUyg3
         zSG817yMtk6BB2z1rGJjtrOps67OBJOfL4jwfIjZkNPKx/d0XLSGqlwuae/WxHR0/RfE
         7tfJ9YAkch4rF0Ts6RwNvmowenA18TYpfvv3OjYqsGtylMqQXr3aoiccbocbUpDgpaGi
         O+KQ==
X-Gm-Message-State: AOAM530ocOE3iuh1EcIxh8Pr1dtKRHETmFiIgd3rKBvpwSq9gYex4ank
        8HXGB7ZOOFIBg5mxlnr+TxFu
X-Google-Smtp-Source: ABdhPJwiP6/+R4rhjKOCBg0O/VVBWzkj9vXCgcnKPWE/zir8dyBqI1gn3LPSdppyytdItwMFhZsZaQ==
X-Received: by 2002:a17:902:e906:b029:e5:c6d2:7dd0 with SMTP id k6-20020a170902e906b02900e5c6d27dd0mr14963791pld.12.1615867132156;
        Mon, 15 Mar 2021 20:58:52 -0700 (PDT)
Received: from thinkpad ([103.66.79.72])
        by smtp.gmail.com with ESMTPSA id g21sm1085109pjl.28.2021.03.15.20.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 20:58:51 -0700 (PDT)
Date:   Tue, 16 Mar 2021 09:28:45 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/6] clk: actions: Fix SD clocks factor table on Owl S500
 SoC
Message-ID: <20210316035845.GB1798@thinkpad>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
 <973b08fe414321ba4ade096a4917cadc2013426e.1615221459.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <973b08fe414321ba4ade096a4917cadc2013426e.1615221459.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 07:18:27PM +0200, Cristian Ciocaltea wrote:
> Drop the unsupported entries in the factor table used for the SD[0-2]
> clocks definitions on the Actions Semi Owl S500 SoC.
> 
> Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  drivers/clk/actions/owl-s500.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
> index 75b7186185b0..69cd959205f5 100644
> --- a/drivers/clk/actions/owl-s500.c
> +++ b/drivers/clk/actions/owl-s500.c
> @@ -127,8 +127,6 @@ static struct clk_factor_table sd_factor_table[] = {
>  	{ 12, 1, 13 }, { 13, 1, 14 }, { 14, 1, 15 }, { 15, 1, 16 },
>  	{ 16, 1, 17 }, { 17, 1, 18 }, { 18, 1, 19 }, { 19, 1, 20 },
>  	{ 20, 1, 21 }, { 21, 1, 22 }, { 22, 1, 23 }, { 23, 1, 24 },
> -	{ 24, 1, 25 }, { 25, 1, 26 }, { 26, 1, 27 }, { 27, 1, 28 },
> -	{ 28, 1, 29 }, { 29, 1, 30 }, { 30, 1, 31 }, { 31, 1, 32 },

How did you determine that these values are not supported?

I've seen cases where the datasheet has the incomplete information about the
supported ranges but the downstream driver has everything.

Thanks,
Mani

>  
>  	/* bit8: /128 */
>  	{ 256, 1, 1 * 128 }, { 257, 1, 2 * 128 }, { 258, 1, 3 * 128 }, { 259, 1, 4 * 128 },
> @@ -137,8 +135,6 @@ static struct clk_factor_table sd_factor_table[] = {
>  	{ 268, 1, 13 * 128 }, { 269, 1, 14 * 128 }, { 270, 1, 15 * 128 }, { 271, 1, 16 * 128 },
>  	{ 272, 1, 17 * 128 }, { 273, 1, 18 * 128 }, { 274, 1, 19 * 128 }, { 275, 1, 20 * 128 },
>  	{ 276, 1, 21 * 128 }, { 277, 1, 22 * 128 }, { 278, 1, 23 * 128 }, { 279, 1, 24 * 128 },
> -	{ 280, 1, 25 * 128 }, { 281, 1, 26 * 128 }, { 282, 1, 27 * 128 }, { 283, 1, 28 * 128 },
> -	{ 284, 1, 29 * 128 }, { 285, 1, 30 * 128 }, { 286, 1, 31 * 128 }, { 287, 1, 32 * 128 },
>  	{ 0, 0, 0 },
>  };
>  
> -- 
> 2.30.1
> 
