Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521D83E4606
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhHINFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:05:13 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:52093 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhHINFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:05:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628514290; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=LAQRtP7j9ghQHXta768r1JJ4i+LsERs04nmNlxYwUoU=; b=NtdCv9nGWeP/J8qAk0w34szpxTYPnMgnCHyeNO8LSUoy1g3TFjIHxHNhJWZTd8RsJ78+l9fP
 TQa5c52FuulThPbdg1GIadbMr5JU3+15u4nLmjhjYb6LSeEvsSKcHpl5+BJKjC8l99CNOiMq
 Jl6iEczmvBXiz3wPWrhnNAlKISA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 611127d791487ad520bb3c2a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 09 Aug 2021 13:04:23
 GMT
Sender: luoj=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0CDC0C4338A; Mon,  9 Aug 2021 13:04:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.92.0.248] (unknown [180.166.53.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: luoj)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05C5CC43217;
        Mon,  9 Aug 2021 13:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05C5CC43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=luoj@codeaurora.org
Subject: Re: [Resend v1 0/2] net: mdio: Add IPQ MDIO reset related function
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
References: <20210808120018.2480-1-luoj@codeaurora.org>
 <YQ/6xmRplrWUUQB/@lunn.ch>
From:   Jie Luo <luoj@codeaurora.org>
Message-ID: <32542ee7-bba6-ae76-18e9-323b24086bd5@codeaurora.org>
Date:   Mon, 9 Aug 2021 21:04:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQ/6xmRplrWUUQB/@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/8/2021 11:39 PM, Andrew Lunn wrote:
> On Sun, Aug 08, 2021 at 08:00:16PM +0800, Luo Jie wrote:
>> This patch series add the MDIO reset features, which includes
>> configuring MDIO clock source frequency and indicating CMN_PLL that
>> ethernet LDO has been ready, this ethernet LDO is dedicated in the
>> IPQ5018 platform.
>>
>> Specify more chipset IPQ40xx, IPQ807x, IPQ60xx and IPQ50xx supported by
>> this MDIO driver.
>>
>> The PHY reset with GPIO and PHY reset with reset controller are covered
>> by the phylib code, so remove the PHY reset related code from the
>> initial patch series.
> Why did you resend?
>
> To the patchbot: I replied with comments on the first send. Do not
> merge.
>
> 	Andrew

Hi Andrew,

     i resent the patch series for fixing some format warning.

