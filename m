Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D99133DD0D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbhCPTCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhCPTCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:02:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F72EC06174A;
        Tue, 16 Mar 2021 12:02:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id p7so62669295eju.6;
        Tue, 16 Mar 2021 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qFBhBN1yONQEPO410hIh3UpTMwleQYs7kA4kb54O5Ck=;
        b=L86As8EpxwOV1JW/wPMSMwzrPG5IW8NoYbOzLBYZc6g0SVG/ApgUJ1dxTei3Rz8sBX
         fYwRyiJJ4AENe8mA3qD+7bQSLxu15mG/Oa9hUVzfkAxdcctFRa0Vf4uqU+BEYWoOZmFy
         Hbm1/vSk5i//pi1bUWqtT08v7HDcLP7lmcUgI9oYUPOJLwfzJbWrssO7BJST690hO8ic
         wleH3+b77WuNI63hNZ1Ylknma7Su+VF3BQngLup5pcarDJFt+g+rafMEYPKeQ47fzQ6M
         v2Fz7XKhAVXA/ctPbPdsgkf8dOIytnwZs0WJMO8fEID5bRNfxuPt0KYK4KkRTJAHMgxb
         lU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qFBhBN1yONQEPO410hIh3UpTMwleQYs7kA4kb54O5Ck=;
        b=qoHjP0O9jhNsPY6dELFnCuNIXLCjQ/AP5DkvxhYdWV1kVWT1UbiXb/rgNgLaMVZhad
         ww0y4nMupeQ1NjfsLJWfk8frDRo+ALi3QWEb/jmJgaAImYCBMO3bsFu7JKaEL5pQGJhu
         CUIYqUW2Cn7GT/+pCtMFUdcJH63y6KJfGHy+A/G1S6gK4KNYLxZIMOXOmSGI068gigOx
         2MoHdaaCIf/xLm5wqS7ChwMhPNCi1TSJHHpsxCqfvZgS1vhhZwzTqgm/sQCeaEbKLtHl
         P62JM/bREdJQOza2I6tPG01E+pCa24lmc7sTZ/7tBHkkB3Aw2ZMJZCkmAtP7WIAm8wXU
         15BQ==
X-Gm-Message-State: AOAM532PHvHg5ZzlfoQzzfwekVvEFZhYQzhSE1xPI8WWcdfnartLMx7+
        Ny14ZMuLd/4G2i6sGQ7E9f4=
X-Google-Smtp-Source: ABdhPJxVueNvtGbxRg3YfrgB7C448w3zGcxkiK+XtXlQYCVJfUI4m+Chx7jKMRpgmk3DpR2SC6t3Yg==
X-Received: by 2002:a17:907:75c2:: with SMTP id jl2mr31734646ejc.334.1615921351189;
        Tue, 16 Mar 2021 12:02:31 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id q25sm7003226edt.51.2021.03.16.12.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:02:30 -0700 (PDT)
Date:   Tue, 16 Mar 2021 21:02:28 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 6/6] clk: actions: Add NIC and ETHERNET clock support for
 Actions S500 SoC
Message-ID: <20210316190228.GE1111731@BV030612LT>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
 <ddafbffafe48fc55bed050728e2ce2610c934e7b.1615221459.git.cristian.ciocaltea@gmail.com>
 <20210316055240.GE1798@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316055240.GE1798@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 11:22:40AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 08, 2021 at 07:18:31PM +0200, Cristian Ciocaltea wrote:
> > Add support for the missing NIC and ETHERNET clocks in the Actions Semi
> > Owl S500 SoC clock driver.
> > 
> > Additionally, change APB clock parent from AHB to the newly added NIC.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> >  drivers/clk/actions/owl-s500.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
> > index b9e434173b4f..0ccc9619b302 100644
> > --- a/drivers/clk/actions/owl-s500.c
> > +++ b/drivers/clk/actions/owl-s500.c
> > @@ -112,6 +112,7 @@ static const char * const bisp_clk_mux_p[] = { "display_pll_clk", "dev_clk" };
> >  static const char * const sensor_clk_mux_p[] = { "hosc", "bisp_clk" };
> >  static const char * const sd_clk_mux_p[] = { "dev_clk", "nand_pll_clk" };
> >  static const char * const pwm_clk_mux_p[] = { "losc", "hosc" };
> > +static const char * const nic_clk_mux_p[] = { "dev_clk", "display_pll_clk", "nand_pll_clk", "ddr_pll_clk" };
> 
> As per the reg field order, this should come after "ahbprediv_clk_mux_p"

Fixed, thanks!

> Rest looks good.
> 
> Thanks,
> Mani
> 
[...]
