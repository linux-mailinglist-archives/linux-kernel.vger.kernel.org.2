Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3DB390CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 01:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhEYXSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 19:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhEYXSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 19:18:00 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2FBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 16:16:27 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so5939373otl.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 16:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kRJQsbr4UUik0+tRstjeKX41a8OCpXExPGyFvaZBojo=;
        b=S6AlfPL+fzQsW5ZhJXqX6HilwyQpM0VVd4UGRsd4EWTTxINvJTxex+kdlEBu5CBzG0
         +RBWxaHB9Py9EK54p3ps7VTypiJ6pHMwQYh7BmaylgxU8ZABz9+D65de+m3xN1nscyrK
         HJ/+vT70ggO8bet/hswCbgsbyKw6B1NftmW5ZSdGbonrGR5Wie8cpKaXwZ+fwGDd/fGA
         OMECgWdd4S94g23go+HyKqjV/hL5lzgMNfZPTvvj2sAaanAm8skW31heVNujm4w8Vuh1
         1nmJQ5mPfD0EKlBHJeydrnKSBci/2AwD0Z1+EFR43V3pLT48sGCSOJI1uxfg4RUmkaBz
         gOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kRJQsbr4UUik0+tRstjeKX41a8OCpXExPGyFvaZBojo=;
        b=YOB+i1yPX73ZIpPGvcwTehF0FW3MdPfz98Ebl9egSFxWGVweI2pZDi6wi39wNLcfQu
         A61pCNSoPEn1tibLEZKu/iVpKhv1aN9OZhyxMT5erFwK5ztdkqpLI60wTJHkW0+oCG6l
         avJuTJ2YVVBt4sfu12gzfD6AL1MK1pp/0f1JDdX/XcneS68TxTMx68NsljdQJJT0nWKV
         NWRTQaSeFxr3Uk5GKIUgndVq1heyK3adS8fSTNA8k3gRDd7VRmeT+wZgjgRMmKzFflfG
         WkBUPkb3GN8E3WsLpu2g+1lERUBXQr8PO3a1z/kGl8M5WU495gfI8vV8KX15zb17VX7o
         SAjQ==
X-Gm-Message-State: AOAM532o46wM4dIcxVZDO9ox7dBs2i2UtHdB/Dvgj6ZPyC+4Jsm6h04y
        afmq5YbqhFgDf35K+1AvOb2/NQ==
X-Google-Smtp-Source: ABdhPJw9o+Oklb8frPMTtU40dTfwPoeGJOz2hCTCxQw/e0eWfUHbRnHaeS2PfEOGSn57ftpNNrXmBg==
X-Received: by 2002:a9d:728b:: with SMTP id t11mr73613otj.230.1621984587274;
        Tue, 25 May 2021 16:16:27 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i17sm1237661oou.37.2021.05.25.16.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 16:16:26 -0700 (PDT)
Date:   Tue, 25 May 2021 18:16:24 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: parsers: qcom: Fix leaking of partition name
Message-ID: <YK2FSM5UDZhGQN0n@yoga>
References: <20210525230931.30013-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525230931.30013-1-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 May 18:09 CDT 2021, Ansuel Smith wrote:

> Add cleanup function as the name variable for the partition name was
> allocaed but never freed after the use as the add mtd function
> duplicate the name and free the pparts struct as the partition name is
> assumed to be static.
> The leak was found using kmemleak.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Fixes: 803eb124e1a6 ("mtd: parsers: Add Qcom SMEM parser")
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/mtd/parsers/qcomsmempart.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mtd/parsers/qcomsmempart.c b/drivers/mtd/parsers/qcomsmempart.c
> index d9083308f6ba..06a818cd2433 100644
> --- a/drivers/mtd/parsers/qcomsmempart.c
> +++ b/drivers/mtd/parsers/qcomsmempart.c
> @@ -159,6 +159,15 @@ static int parse_qcomsmem_part(struct mtd_info *mtd,
>  	return ret;
>  }
>  
> +static void parse_qcomsmem_cleanup(const struct mtd_partition *pparts,
> +				   int nr_parts)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_parts; i++)
> +		kfree(pparts[i].name);
> +}
> +
>  static const struct of_device_id qcomsmem_of_match_table[] = {
>  	{ .compatible = "qcom,smem-part" },
>  	{},
> @@ -167,6 +176,7 @@ MODULE_DEVICE_TABLE(of, qcomsmem_of_match_table);
>  
>  static struct mtd_part_parser mtd_parser_qcomsmem = {
>  	.parse_fn = parse_qcomsmem_part,
> +	.cleanup = parse_qcomsmem_cleanup,
>  	.name = "qcomsmem",
>  	.of_match_table = qcomsmem_of_match_table,
>  };
> -- 
> 2.31.1
> 
