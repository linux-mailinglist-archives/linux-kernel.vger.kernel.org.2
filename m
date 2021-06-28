Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7903B5A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 10:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhF1IQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 04:16:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11596 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229692AbhF1IQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 04:16:10 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S8BDEn026612;
        Mon, 28 Jun 2021 08:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=KRojVssgRNCVXcgoVfDbbD51UHD1Mv55AN0oXr9yipw=;
 b=ExwgNOSrpbKvThyFhn23pdtN/Tb4sa9fNu9lTZEgJXfZbFAjKioaNrOYj6YEFs/tYeTz
 BI3MwbXwC9S7vP1BjPcMAh+Am4rdcD68oxy85EAzSiSLLB8cFDy8o9/koHxgw8D7TroQ
 fb7wLnpkYxzCMenT5X711VY53c5IINH0tlkrXWmqCxLzcNRPQ+FPJWtcL6iFzXwTrugC
 gKiTUT3QZa7d87W02cbSgm5W3qwvvmiwh4wX8W1+qZnTL9D0sJbwO/j6Kys/0eUip7Oi
 Bo4jjFP2lJfpI9hZUcDEa4OffQ71N3m7x46G+BTl/JMw+Uc55xwSb1cJIiDqRkfWJfV9 gA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f1hcgnyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 08:13:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15S89kEC046396;
        Mon, 28 Jun 2021 08:13:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 39dv238yyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 08:13:28 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15S8BagB052618;
        Mon, 28 Jun 2021 08:13:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 39dv238yyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 08:13:27 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15S8DP0b004205;
        Mon, 28 Jun 2021 08:13:25 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jun 2021 01:13:25 -0700
Date:   Mon, 28 Jun 2021 11:13:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v9 3/5] mfd: hi6421-spmi-pmic: move driver from staging
Message-ID: <20210628081318.GL2040@kadam>
References: <cover.1624640087.git.mchehab+huawei@kernel.org>
 <6cdd91b60115dae8a62bea01ca7548c0a6642448.1624640087.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cdd91b60115dae8a62bea01ca7548c0a6642448.1624640087.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: x_uiqtmPqccxgPP7Y1T8i9ldqkCtVCod
X-Proofpoint-GUID: x_uiqtmPqccxgPP7Y1T8i9ldqkCtVCod
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 07:06:12PM +0200, Mauro Carvalho Chehab wrote:
> +static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +	struct hi6421_spmi_pmic *ddata;
> +	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);

No blank line.  Checkpatch.

> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	ddata->regmap = devm_regmap_init_spmi_ext(pdev, &regmap_config);
> +	if (IS_ERR(ddata->regmap))
> +		return PTR_ERR(ddata->regmap);
> +
> +	mutex_init(&ddata->enable_mutex);
> +
> +	dev_set_drvdata(&pdev->dev, ddata);
> +
> +	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> +				   hi6421v600_devs, ARRAY_SIZE(hi6421v600_devs),
> +				   NULL, 0, NULL);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to add child devices: %d\n", ret);
> +
> +	return ret;
> +}

regards,
dan carpenter
