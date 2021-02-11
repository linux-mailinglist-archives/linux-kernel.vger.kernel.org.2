Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F783187CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhBKKIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:08:53 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:42450 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230353AbhBKKHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:07:42 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11BA6n7U010983;
        Thu, 11 Feb 2021 04:06:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=eeMJSCblT1p0TOiBEUAjvfSv8ttwzy/lb6Th6n73F0o=;
 b=Qpwm6jQfNhjEu8H9Vy3AG3Rbzle6lBhHY9gqHGXeAG0x7qun4oBTfhnkcKx5qnC4Ezvn
 3VohhYXS2AHPtG+4NhtdQLhbtDS87JVy1wicacUiQTZRKyzA3yytiOpDrQakMtQwr9Qv
 0XyZv36sjiGa/r8jtgP9k69vQcZDRrchJXITde6Xwov3k4nyRp80lULtEWVXjMPdlp6J
 2Bwyh4wXIUjh2vBDxyiBiqnHgMlpFfRaJWl/cim50p+H00FBL0nE6+LVyxKcyq60o2PT
 jwEcX3GoJI1lyw4ZhV8c/wbzTENbisyEes0Xqc1tPUq5CvX3nVB1B4gW5O6E9V7uAwK6 5g== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 36hrv2efce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 11 Feb 2021 04:06:49 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 11 Feb
 2021 10:06:47 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 11 Feb 2021 10:06:47 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A908611CF;
        Thu, 11 Feb 2021 10:06:47 +0000 (UTC)
Date:   Thu, 11 Feb 2021 10:06:47 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
CC:     Hulk Robot <hulkci@huawei.com>, Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mfd: arizona: Make some symbols static
Message-ID: <20210211100647.GY106851@ediswmail.ad.cirrus.com>
References: <20210210075626.1096193-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210210075626.1096193-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=815 suspectscore=0
 impostorscore=0 clxscore=1011 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 07:56:26AM +0000, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/mfd/arizona-spi.c:28:31: warning:
>  symbol 'reset_gpios' was not declared. Should it be static?
> drivers/mfd/arizona-spi.c:29:31: warning:
>  symbol 'ldoena_gpios' was not declared. Should it be static?
> 
> Those symbols are not used outside of arizona-spi.c, so this
> commit marks them static.
> 
> Fixes: e933836744a2 ("mfd: arizona: Add support for ACPI enumeration of WM5102 connected over SPI")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
