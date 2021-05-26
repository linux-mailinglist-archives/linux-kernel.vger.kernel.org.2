Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD51B391479
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbhEZKJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbhEZKJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:09:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD8BC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 03:07:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k5so525960pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 03:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iPLF4+a0+7osNgqIih0t63HrK/7cIyUQjVdMCaByTx4=;
        b=McT6WvIIhYAITiYiVmvf9diDdxUIeXVUj80svSmWGZkKzERBTUuSJICT+1aesu0rp6
         lr80GxhsP2CYf5+Lw6jVHyvsQFNY8zWtYKk8qr+J2a08R8+xAAAhuyNthUrYDEUHSLar
         bZK+isSOTBLoqPBpXTUSRBlE4gZRemVynfwxuq7PqcQ6EqzMDe+0asg3YL5NbA3tHVAw
         AK/trgfEAqzrGO5b68L32EIpaomzB2jSVCI1OFzs5WBBx/zAOb+DdAk9itkr711JC7eP
         4EVN6K6LceUbBdPd7hJMMCIuVTRgEF5sUXjwoS113it4WpU2qgqCokQ4cO60j/aT0bce
         lzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iPLF4+a0+7osNgqIih0t63HrK/7cIyUQjVdMCaByTx4=;
        b=akGP11jUTzdKwDZHDW70h+AEzH+wLT8vRpJnuRPM5IdUx5bVYPytbTQBW4Yn1TW+55
         W1WvOcLlrifWf7dM3smwC66UnwPwoeKOWoYewXHZnx1oBCEx5KISv/naIYwY7rp82acP
         xTwUfIVR9hdcwoVkixYV7+JPxMLRdmaTdMCOD8/J4fAtphty3oda4UFGT64ZhA66mh/B
         +e3em5AZfl8MO+XLFOaLVw00GuZV9S0MMPDi/52euhD4M+Hs8SPqK36kHvqXJabD7png
         xxQE9pbVygVxRCUGs/PCDUra5fOitrPHZ4y6NxAy0qRYk85QzsHjkR6XIEd82zEmKeAv
         wShQ==
X-Gm-Message-State: AOAM532G45sb8WwdWR4MLuiOzpZsO6dsg3AAkU/XN99XlYsssr2uBMJj
        cQtZGqcpFivCcaBA0GcO+MDm
X-Google-Smtp-Source: ABdhPJxzbNRZCM/TUHJmvxFI6Zega3duBzCjyNdGs7pP8S8t49WpLEQQCp9uUr72qRdzGtzi1G/axA==
X-Received: by 2002:a17:90a:8902:: with SMTP id u2mr35505244pjn.143.1622023676967;
        Wed, 26 May 2021 03:07:56 -0700 (PDT)
Received: from work ([120.138.12.4])
        by smtp.gmail.com with ESMTPSA id 184sm14858556pfv.38.2021.05.26.03.07.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 May 2021 03:07:55 -0700 (PDT)
Date:   Wed, 26 May 2021 15:37:43 +0530
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
Message-ID: <20210526100719.GC10723@work>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
 <973b08fe414321ba4ade096a4917cadc2013426e.1615221459.git.cristian.ciocaltea@gmail.com>
 <20210316035845.GB1798@thinkpad>
 <20210316181437.GB1111731@BV030612LT>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316181437.GB1111731@BV030612LT>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 08:14:37PM +0200, Cristian Ciocaltea wrote:
> Hi Mani,
> 
> Thanks for reviewing this patch series!
> 
> On Tue, Mar 16, 2021 at 09:28:45AM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Mar 08, 2021 at 07:18:27PM +0200, Cristian Ciocaltea wrote:
> > > Drop the unsupported entries in the factor table used for the SD[0-2]
> > > clocks definitions on the Actions Semi Owl S500 SoC.
> > > 
> > > Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
> > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > ---
> > >  drivers/clk/actions/owl-s500.c | 4 ----
> > >  1 file changed, 4 deletions(-)
> > > 
> > > diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
> > > index 75b7186185b0..69cd959205f5 100644
> > > --- a/drivers/clk/actions/owl-s500.c
> > > +++ b/drivers/clk/actions/owl-s500.c
> > > @@ -127,8 +127,6 @@ static struct clk_factor_table sd_factor_table[] = {
> > >  	{ 12, 1, 13 }, { 13, 1, 14 }, { 14, 1, 15 }, { 15, 1, 16 },
> > >  	{ 16, 1, 17 }, { 17, 1, 18 }, { 18, 1, 19 }, { 19, 1, 20 },
> > >  	{ 20, 1, 21 }, { 21, 1, 22 }, { 22, 1, 23 }, { 23, 1, 24 },
> > > -	{ 24, 1, 25 }, { 25, 1, 26 }, { 26, 1, 27 }, { 27, 1, 28 },
> > > -	{ 28, 1, 29 }, { 29, 1, 30 }, { 30, 1, 31 }, { 31, 1, 32 },
> > 

[...]

> This is basically what gets translated to sd_factor_table and I removed
> the extra entries 25..31. Actually I also dropped the 24th one, since
> that would give us an odd number of items, although I'm not quite sure
> this is a bug in the xapp-le code or the HW is really supposed to work
> like that.
> 

In my datasheet I can see the factor values till 24. So let's remove the
entries from 25-31.

Thanks,
Mani

> Kind regards,
> Cristi
> 
> > Thanks,
> > Mani
> > 
> > >  
> > >  	/* bit8: /128 */
> > >  	{ 256, 1, 1 * 128 }, { 257, 1, 2 * 128 }, { 258, 1, 3 * 128 }, { 259, 1, 4 * 128 },
> > > @@ -137,8 +135,6 @@ static struct clk_factor_table sd_factor_table[] = {
> > >  	{ 268, 1, 13 * 128 }, { 269, 1, 14 * 128 }, { 270, 1, 15 * 128 }, { 271, 1, 16 * 128 },
> > >  	{ 272, 1, 17 * 128 }, { 273, 1, 18 * 128 }, { 274, 1, 19 * 128 }, { 275, 1, 20 * 128 },
> > >  	{ 276, 1, 21 * 128 }, { 277, 1, 22 * 128 }, { 278, 1, 23 * 128 }, { 279, 1, 24 * 128 },
> > > -	{ 280, 1, 25 * 128 }, { 281, 1, 26 * 128 }, { 282, 1, 27 * 128 }, { 283, 1, 28 * 128 },
> > > -	{ 284, 1, 29 * 128 }, { 285, 1, 30 * 128 }, { 286, 1, 31 * 128 }, { 287, 1, 32 * 128 },
> > >  	{ 0, 0, 0 },
> > >  };
> > >  
> > > -- 
> > > 2.30.1
> > > 
