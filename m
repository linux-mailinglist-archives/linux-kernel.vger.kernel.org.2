Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0224C343D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCVJlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhCVJkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:40:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD61AC061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:40:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so2877667pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ADfJ8XxZaIUTO4Shw2feZhZGB3RwS6NXo/0ZVYfJyEI=;
        b=vuCGKMIjlS5UYwQqxhmr8nPtU1ChMMs+B1J5ZbQQJAJvUGi96AXtA7v8UH2UkJdPqR
         kyXJ+beER2DmMnUfKDrE9VkGyp68GHtOUDb1Ax26rtGr92ZVJFj79oq5Xn8yJLtkqJTf
         1UFshpI3ZPuFpoNsrkOj0SpQyeDf/z4qh3Biu8+B71vrNpRkQqdTJG+4/lCEJVyqS3jN
         dlBKqKJevbrE/8sgOESiZUmU/jTqkmiYV3B4d5UsjPf5VTSN1QZrxELExjKsxbi3HYtN
         vDZzOZyIRiKE/UmclwbDgoxdt5hoNlcHEPyldTSq048iLKvz81kwJfmneW+1IrSZF4Nl
         Ftwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ADfJ8XxZaIUTO4Shw2feZhZGB3RwS6NXo/0ZVYfJyEI=;
        b=RrnOTvf4b5Iy0U8h2s7lceVQuYXqJ4C1x2MJ7DXCwNcaI+JLXeBa4NmjXPiJdBoA11
         277aMh1qX+rSgFB5uyAzjocKxjvzQm5cVYKYXfMoe4FnZAzb9znB62+fyvRkJXsFMvwR
         m4h1mVRTGr815+kALj3N66BsQd0e+WAzQfWZDFBGIf17jr6mcOZ3iL6aaqPp8/nazCBT
         6FHG7C2M6OIrkute1yjAQR0U4yfUU0ElxeSNiJrBH+9r+cbNIDyuwjPn7CNizhzskhse
         KQ57F4rBwK3Zx4Ea4UxQHh5tQ1dqU/KBfsTAE9MAgfOrTuUox1w9UPyP3Xdfmaae3nnt
         s5iQ==
X-Gm-Message-State: AOAM530+ePPDir8P0oqwNev8htuubNtnjc879qPiNfJf1V+D3IoMcC+B
        EpDbIcqecxP+bARD4zeOX1E/
X-Google-Smtp-Source: ABdhPJxXYjtqadurjjAFkFFRifdEFnG3qdB33Q8mykdETZt453Mf2F1NvB7ZmqzgOrmLaz2phIhYtg==
X-Received: by 2002:a17:90a:5284:: with SMTP id w4mr12092419pjh.29.1616406050218;
        Mon, 22 Mar 2021 02:40:50 -0700 (PDT)
Received: from thinkpad ([2409:4072:88e:ef5e:dccf:398f:4151:2e02])
        by smtp.gmail.com with ESMTPSA id l25sm3616113pgu.72.2021.03.22.02.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 02:40:49 -0700 (PDT)
Date:   Mon, 22 Mar 2021 15:10:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH v7 3/3] mtd: rawnand: Add support for secure regions in
 NAND memory
Message-ID: <20210322094040.GB70634@thinkpad>
References: <20210319150010.32122-1-manivannan.sadhasivam@linaro.org>
 <20210319150010.32122-4-manivannan.sadhasivam@linaro.org>
 <20210319175659.17c9e8e6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319175659.17c9e8e6@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 05:56:59PM +0100, Boris Brezillon wrote:
> On Fri, 19 Mar 2021 20:30:10 +0530
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> 
> > @@ -2737,6 +2783,11 @@ static int nand_read_page_swecc(struct nand_chip *chip, uint8_t *buf,
> >  	uint8_t *ecc_code = chip->ecc.code_buf;
> >  	unsigned int max_bitflips = 0;
> >  
> > +	/* Check if the region is secured */
> > +	ret = nand_check_secure_region(chip, ((loff_t)page << chip->page_shift), 0);
> > +	if (ret)
> > +		return ret;
> > +
> 
> I'm lost. Why do you need to do that here if it's already done in
> nand_do_read_{ops,oob}()?
> 

I think that's a mistake. Will remove it.

Thanks,
Mani

> >  	chip->ecc.read_page_raw(chip, buf, 1, page);
> >  
> >  	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
