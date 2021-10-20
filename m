Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B969F4345B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhJTHKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:10:05 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:28579 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhJTHKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:10:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634713668; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=LYXNK56VnUPKwkD/Q/0iGPAE63E7ZSvi9gqsmGRi4QQ=; b=n0f+fNvMG1kNQgWobtZx4shAp6vwRnyAzELhl8aOG2SmovHRPPGhKwcdNYiwlHAefujU9Y1Z
 3/sQ0aUE8MqTAktlYQ9vZHBwDKgNViNE8kgLW1LX9eNpo/Usr6bZEcMU/FXJanSq6WPnT0S3
 CSR8Cqfy8jfihQXiQ1f6nbxavVk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 616fc02d5ca800b6c1dc0a51 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Oct 2021 07:07:25
 GMT
Sender: quic_luoj=quicinc.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6B788C4360C; Wed, 20 Oct 2021 07:07:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.92.1.38] (unknown [180.166.53.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: luoj)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93D3EC4338F;
        Wed, 20 Oct 2021 07:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 93D3EC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=quicinc.com
Subject: Re: [PATCH v3 10/13] net: phy: add qca8081 config_init
To:     Andrew Lunn <andrew@lunn.ch>, Luo Jie <luoj@codeaurora.org>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
References: <20211018033333.17677-1-luoj@codeaurora.org>
 <20211018033333.17677-11-luoj@codeaurora.org> <YW3riurwBofqOmUL@lunn.ch>
From:   Jie Luo <quic_luoj@quicinc.com>
Message-ID: <32e72ff0-b540-a459-de07-09cfb3216143@quicinc.com>
Date:   Wed, 20 Oct 2021 15:07:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YW3riurwBofqOmUL@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/19/2021 5:47 AM, Andrew Lunn wrote:
>> +static int qca808x_phy_fast_retrain_config(struct phy_device *phydev)
>> +{
>> +	int ret;
>> +
>> +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
>> +			MDIO_AN_10GBT_CTRL_ADV2_5G |
>> +			MDIO_AN_10GBT_CTRL_ADVFSRT2_5G |
>> +			MDIO_AN_10GBT_CTRL_ADVLPTIMING);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_10GBR_FSRT_CSR,
>> +			MDIO_PMA_10GBR_FSRT_ENABLE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_CTRL2, MDIO_AN_THP_BP2_5GT);
>> +	if (ret)
>> +		return ret;
> Could that be made generic and put into phy-c45.c? Is there anything
> specific to your PHY here?
>
> 	 Andrew

Hi Andrew,

Thanks for the comments, there is no specific to the PHY, will put it 
into phy-c45.c in the next patch set.

