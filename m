Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DD8325050
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBYNUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhBYNUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:20:35 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D091FC061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 05:19:54 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id w18so3588230pfu.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 05:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MYaVOndqYqRzFcMWeHU+nKNr8k71qXO1KVOhfREMeAw=;
        b=TO16avrGfx98ow4rMCnewYEHt/duYe8C4ZsmuaRCfuXDZU5M8WHcVoA5NHZGN1b9e8
         h1NrZJUqYRL3L0EEnP5VqUN6CCaPsqGGW4J9wqtMS3dgtWdgmFeK/6JBtzy4MuGur0vh
         oa6o9Oz4RiYbVF/AQXdSt0f+QOK0tAhkFA7AAuz2sNCxwkFUAxWcGNZI++hTZF2NzQV8
         o7EmvbCRxJL87Pvobv/6V/xc/JYojRGw4FkxoYLVcTeXBGsCTEwkLpDKkLwK6p3fUYf8
         ORCM/DfTmjjsR2jjGK2ww7PIXOyo90wrVj1BymRDtDpnIKFO1Yqzju8Zf6MtGDWlPvA8
         Pp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MYaVOndqYqRzFcMWeHU+nKNr8k71qXO1KVOhfREMeAw=;
        b=XSnOwmR5kIme1HIfknwfXv0t0B+OSHM/oqREdz4hmQI/HDVWGyo5UToKj869/2z5Vc
         SKYnHKwyL4Fg7k8tlQt/TBQnGvlflMjLJPCMT33eImPDr0bEuhA55OPY2MDNm67GPFps
         bGcnorKH3+KztP7mis5w7rANvxA2Cpwhv+AsusZBU0GNg95bt/bJZ6JAyGwpdBm0JC55
         QfFtDRsOYPrr86vcTzVhomdf9dTxWVoRC3Ww/pwyptvsydXSRKHtJ5HKi1SyA/O4qe4C
         NePmRKeSvEi3F5oNap5pgGVEBnTBobxFwlyri4JJtjpB+KS9O7OmTxPbaVtCNSFtbHz4
         8ySw==
X-Gm-Message-State: AOAM530uk/wF+lM7WbFVjOQle4Ctc63t2V+QlybMadcQeuLX+RM23jkT
        ByJHKu7V+u0EqKihOFuFDVrA
X-Google-Smtp-Source: ABdhPJxhkEfI0s3psqqgzhaH4cXP4KgLt6o7iidjFzncNsP8Dp1PclPkXQbuZYx4j/xM1qSlVLce+Q==
X-Received: by 2002:a62:e708:0:b029:1ed:f93d:e985 with SMTP id s8-20020a62e7080000b02901edf93de985mr3369536pfh.48.1614259194082;
        Thu, 25 Feb 2021 05:19:54 -0800 (PST)
Received: from work ([103.66.79.45])
        by smtp.gmail.com with ESMTPSA id e129sm6561005pfh.87.2021.02.25.05.19.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Feb 2021 05:19:53 -0800 (PST)
Date:   Thu, 25 Feb 2021 18:49:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH v2 3/3] mtd: rawnand: qcom: Add support for secure
 regions in NAND memory
Message-ID: <20210225131948.GA28614@work>
References: <20210225041129.58576-1-manivannan.sadhasivam@linaro.org>
 <20210225041129.58576-4-manivannan.sadhasivam@linaro.org>
 <20210225084702.2c753b99@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210225084702.2c753b99@xps13>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Thu, Feb 25, 2021 at 08:47:02AM +0100, Miquel Raynal wrote:
> Hi Manivannan,
> 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote on Thu,
> 25 Feb 2021 09:41:29 +0530:
> 
> > On a typical end product, a vendor may choose to secure some regions in
> > the NAND memory which are supposed to stay intact between FW upgrades.
> > The access to those regions will be blocked by a secure element like
> > Trustzone. So the normal world software like Linux kernel should not
> > touch these regions (including reading).
> > 
> > The regions are declared using a NAND chip DT property,
> > "nand-secure-regions". So let's make use of this property and skip
> > access to the secure regions present in a system.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> [...]
> 
> >  	config_nand_page_write(nandc);
> > @@ -2830,7 +2865,8 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
> >  	struct nand_chip *chip = &host->chip;
> >  	struct mtd_info *mtd = nand_to_mtd(chip);
> >  	struct device *dev = nandc->dev;
> > -	int ret;
> > +	struct property *prop;
> > +	int ret, length, nr_elem;
> >  
> >  	ret = of_property_read_u32(dn, "reg", &host->cs);
> >  	if (ret) {
> > @@ -2886,6 +2922,24 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * Look for secure regions in the NAND chip. These regions are supposed
> > +	 * to be protected by a secure element like Trustzone. So the read/write
> > +	 * accesses to these regions will be blocked in the runtime by this
> > +	 * driver.
> > +	 */
> > +	prop = of_find_property(dn, "nand-secure-regions", &length);
> 
> I'm not sure the nand- prefix on this property is needed here, but
> whatever.
> 

I was not sure either but added it since most of the other properties
had it. But I can remove it.

> > +	if (prop) {
> > +		nr_elem = length / sizeof(u32);
> > +		host->nr_sec_regions = nr_elem / 2;
> > +
> > +		host->sec_regions = devm_kcalloc(dev, nr_elem, sizeof(u32), GFP_KERNEL);
> > +		if (!host->sec_regions)
> > +			return -ENOMEM;
> > +
> > +		of_property_read_u32_array(dn, "nand-secure-regions", host->sec_regions, nr_elem);
> > +	}
> > +
> 
> I would move this before nand_scan().
> 

Okay, I'll do it.

Thanks,
Mani

> If you don't, you should bail out with a nand_cleanup() upon error.
> 
> >  	ret = mtd_device_parse_register(mtd, probes, NULL, NULL, 0);
> >  	if (ret)
> >  		nand_cleanup(chip);
> 
> 
> Otherwise lgtm.
> 
> Thanks,
> Miquèl
