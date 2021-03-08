Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE398330F54
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhCHNen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCHNeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:34:18 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E306BC061760
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 05:34:17 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o38so6415574pgm.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 05:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jy+hRDRm2a3VhiF/cs63pR4L32THWqr6aYcveYB2mrQ=;
        b=bObl2OR2UbbO1eDS8jfL7Hky/K4KNAyBpwniRxvXmAERkH1cRZ4GPve3nPTy8aCs2f
         Yj8apeib6trmavOAMKqQIhSb85BQQTlp6p8LdII6sBAXtO8vlOj4MIHs71rkVInqWoe5
         q5kKtR2uHBb8PZZ7Y7e+/o3dg42SYAp3z4i99bYLZsWPYc5ejiRE8uLU8kWIhIpxf65f
         WrEO3Pjd1Ajkz68YvBYRQOlQrAgCuMjIeRU0V8A38J6tQhu4VLLLzm80QuXbZofCDP7y
         6A55D8HaMhXHbpFpQDP5VJA/29Gdf0yk5bTaf9rz5P1Ofry2pvbEUplzeNZdk3euxIVS
         mDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jy+hRDRm2a3VhiF/cs63pR4L32THWqr6aYcveYB2mrQ=;
        b=dEiYzB42ovRM8fPHl9695X+Nipi792hkKBiTENAVWyum2ePK5V517A8JBqvghrJcCD
         Sod348PgkYq5L/gaB9DZU4a93/k08yo9LjrF2P0NKKSgZi9FV0eHxsUWrYN22JHM4tnz
         xrPIN/3S4fr8r34vEjkUEmosJ3zDYB8n8a4UJ1DIRQ2FILF++Y9QD5dVDXbi7TeyYH7M
         LgpfFIJLdp10gdZGnBcl/JcePpjTNz7Gtq4Hf87njQhL27yNKBfri4o9l6f5mMhY/rEU
         nU3MM0cqeW2E9AiU8A/qOumcsuRyJ2JPzzUAfdNvca9f+XkD3/xdiVGd32aZZ9Uq6tus
         cX4Q==
X-Gm-Message-State: AOAM532z18R2zB0T+XvTkNDxukT+UGjPaFpdxaCBnGwy5u020mwjJQeY
        uyFLfE8KNeOxsIV60yq59NQW
X-Google-Smtp-Source: ABdhPJyP8D/RldetyJSotxDhgrg6Y9E/d7Zz09BvAbcE0LiRJPFsyFWc8VbdLCp3yaiSAiipxO1rzQ==
X-Received: by 2002:aa7:9182:0:b029:1de:e96f:a866 with SMTP id x2-20020aa791820000b02901dee96fa866mr20695396pfa.67.1615210457298;
        Mon, 08 Mar 2021 05:34:17 -0800 (PST)
Received: from thinkpad ([2409:4072:638a:aee8:50fe:f77:990e:395b])
        by smtp.gmail.com with ESMTPSA id i22sm11439401pjz.56.2021.03.08.05.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 05:34:16 -0800 (PST)
Date:   Mon, 8 Mar 2021 19:04:10 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH v4 3/3] mtd: rawnand: qcom: Add support for secure
 regions in NAND memory
Message-ID: <20210308133410.GD5457@thinkpad>
References: <20210308054447.28418-1-manivannan.sadhasivam@linaro.org>
 <20210308054447.28418-4-manivannan.sadhasivam@linaro.org>
 <20210308100247.4aba657c@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308100247.4aba657c@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 10:02:47AM +0100, Boris Brezillon wrote:
> On Mon,  8 Mar 2021 11:14:47 +0530
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> 

[...]

> >  /* helper to configure address register values */
> > -static void set_address(struct qcom_nand_host *host, u16 column, int page)
> > +static int set_address(struct qcom_nand_host *host, u16 column, int page)
> >  {
> >  	struct nand_chip *chip = &host->chip;
> >  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> > +	u32 offs = page << chip->page_shift;
> > +	int i, j;
> > +
> > +	/* Skip touching the secure regions if present */
> > +	for (i = 0, j = 0; i < host->nr_sec_regions; i++, j += 2) {
> > +		if (offs >= host->sec_regions[j] &&
> > +		    (offs <= host->sec_regions[j] + host->sec_regions[j + 1]))
> > +			return -EIO;
> > +	}
> 
> Hm, not sure that's a good idea to make this check part of
> set_address(). Looks like set_address() can be used for ONFI page
> access too, and you definitely don't want to block those
> requests. I'd recommend having a separate helper that you can call from
> qcom_nandc_{read,write}_{oob,page,page_raw}().
> 

Right but I went for the code simplicity :/ Anyway, since you're favoring
towards moving this check into code, I'll incorporate your suggestion
accordingly.

Thanks,
Mani
