Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9481C3829DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbhEQKeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236420AbhEQKeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:34:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E69C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:32:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id p24so7180906ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qf8vuYD4VdxU2US+goXw7yg5VQymM6TIpwpzoZxgSZA=;
        b=TGs0Hsk1FLUi5Gwpfaf1AxAqjbJDkPb9+YOxk4BlgkjtDLtb08zof8qPcfxuAMlHCq
         jPPlYiTXx/AzjpbjzdhM+jtDHW6T4/JoJPp8L4X3gOlKuJEvy8US2woMb0YKVSG/OO5l
         /xyhvQSl7PYZrZ7HVTi+vCUUaf45RYkJaotiZS/NgJXiKwhy1zgNp4H+AgDXd+TsCV5w
         ztUeTBeN53ZAVtzlmnbzZ0hX9ZstoFRm+MR97B5EW1ul6zDCPtRubVY7Eq3vTLisKKu/
         CIoq+UWGmwSu0fTa6G42RI5PqhEDdwtG5bKI/DG0TJXk1BYa/UUvYia7NKjfJPTr8Sfx
         FI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=qf8vuYD4VdxU2US+goXw7yg5VQymM6TIpwpzoZxgSZA=;
        b=Z4Ja5Vpb79eVRvAELzk90wR5JXTG8O5/5gjKnffu+VAw6Nbp4IWkJHXhAFbU62fsQj
         X6S6mci2N2O04xcemqm2ZW9Cdg4x5rKekhKfhEMaTTdPr90RM614C9dJuhp29tjrwTGs
         J4HeqO3lObRJORqAxR88jA/3fbxJx/D7k+sruJ/0QC+mxwAteRzMjgDrJ2fW6jYOqYu/
         ki2GmaTu2XzU4H1I9mVwIGulOccGOpC4SXTrxllV4BHOsO7bPKSgTAHragKvWMGEtnYa
         reetoS0UfsKruL5cvmVSKwcoKHe2Qup8e3nkqyMguADIDLQmNOjE3m22PwPr2fbuhUQx
         YBbA==
X-Gm-Message-State: AOAM533SZLbRBI+lL24ePlwAiNcPH5TIz6ePYBW43WKcesQ6+OE455G9
        Iu8R9s8LOwD8MDtnl1dgoLY=
X-Google-Smtp-Source: ABdhPJx+SUq7uM4fNb/FMYOYZIH+NEaARaNFlmls3SxHB7aooaVcIpYL6kQRsI/C5YK9tpFMjDoCwA==
X-Received: by 2002:a17:906:8504:: with SMTP id i4mr8287261ejx.515.1621247570334;
        Mon, 17 May 2021 03:32:50 -0700 (PDT)
Received: from mars.fritz.box ([2a02:8070:b9d:f200:bee0:f4e2:68f9:3d11])
        by smtp.gmail.com with ESMTPSA id p9sm10747638edu.79.2021.05.17.03.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 03:32:49 -0700 (PDT)
Message-ID: <7352b791a85b2ebaae50ae26c73b4fa0c224b467.camel@googlemail.com>
Subject: Re: [PATCH 1/2] regulator: fan53880: Fix missing n_voltages setting
From:   Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Date:   Mon, 17 May 2021 12:32:49 +0200
In-Reply-To: <20210517004831.1016177-1-axel.lin@ingics.com>
References: <20210517004831.1016177-1-axel.lin@ingics.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

 thanks for your input. Please see my comments below.

On Mon, 2021-05-17 at 08:48 +0800, Axel Lin wrote:
> Fixes: e6dea51e2d41 ("regulator: fan53880: Add initial support")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Could you add a simple explanation? "Necessary for list_voltage() ops"?

> ---
>  drivers/regulator/fan53880.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/regulator/fan53880.c b/drivers/regulator/fan53880.c
> index e83eb4fb1876..e26a1420c6c5 100644
> --- a/drivers/regulator/fan53880.c
> +++ b/drivers/regulator/fan53880.c
> @@ -51,6 +51,7 @@ static const struct regulator_ops fan53880_ops = {
>  		      REGULATOR_LINEAR_RANGE(800000, 0xf, 0x73, 25000),	\
>  		},							\
>  		.n_linear_ranges = 2,					\
> +		.n_voltages = 0x74,					\

Could you add a tab and spaces to keep the alignment?

>  		.vsel_reg =	   FAN53880_LDO ## _num ## VOUT,	\
>  		.vsel_mask =	   0x7f,				\
>  		.enable_reg =	   FAN53880_ENABLE,			\
> @@ -76,6 +77,7 @@ static const struct regulator_desc
> fan53880_regulators[] = {
>  		      REGULATOR_LINEAR_RANGE(600000, 0x1f, 0xf7, 12500),
>  		},
>  		.n_linear_ranges = 2,
> +		.n_voltages = 0xf8,

dito

>  		.vsel_reg =	   FAN53880_BUCKVOUT,
>  		.vsel_mask =	   0x7f,
>  		.enable_reg =	   FAN53880_ENABLE,
> @@ -95,6 +97,7 @@ static const struct regulator_desc
> fan53880_regulators[] = {
>  		      REGULATOR_LINEAR_RANGE(3000000, 0x4, 0x70, 25000),
>  		},
>  		.n_linear_ranges = 2,
> +		.n_voltages = 0x71,

dito

>  		.vsel_reg =	   FAN53880_BOOSTVOUT,
>  		.vsel_mask =	   0x7f,
>  		.enable_reg =	   FAN53880_ENABLE_BOOST,


