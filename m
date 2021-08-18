Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6484D3F04E7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbhHRNfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:35:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:35228 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236731AbhHRNfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:35:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629293709; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=D83uvmIKfB3mWVd8vO6++LBuXNB1BJ5IR3kbxJlaHJk=; b=s+i1uotMDOaEd5OcTCMQga8GZ0wnd1SJpKh3SLiz3II6glNAR3o8y3OeUJ/6oX+WGbIWfVQs
 3T80xX/1SaBFynY0BH6/R0YyAVLDcDWU7LWekBV1L+jtmCMJq9o+CtdHXNRIRvgtdtPelV5/
 Z2ji1OJ77hWXkeHBV2TVkJyMrdo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 611d0c79454b7a558fb27d91 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 18 Aug 2021 13:34:49
 GMT
Sender: luoj=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EB928C4360C; Wed, 18 Aug 2021 13:34:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [10.92.1.52] (unknown [180.166.53.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: luoj)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 700F5C4338F;
        Wed, 18 Aug 2021 13:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 700F5C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH] net: phy: add qca8081 ethernet phy driver
To:     Michael Walle <michael@walle.cc>
Cc:     andrew@lunn.ch, davem@davemloft.net, hkallweit1@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, netdev@vger.kernel.org,
        sricharan@codeaurora.org
References: <6856a839-0fa0-1240-47cd-ae8536294bcd@codeaurora.org>
 <20210818074102.78006-1-michael@walle.cc>
From:   Jie Luo <luoj@codeaurora.org>
Message-ID: <9aa1543b-e1b8-fba2-1b93-c954dd2e3e50@codeaurora.org>
Date:   Wed, 18 Aug 2021 21:34:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818074102.78006-1-michael@walle.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/18/2021 3:41 PM, Michael Walle wrote:
>> qca8081 supports IEEE1588 feature, the IEEE1588 code may be submitted in
>> the near future,
>>
>> so it may be a good idea to keep it out from at803x code.
> The AR8031 also supports PTP. Unfortunately, there is no public datasheet
> for the QCA8081, so I can't have a look if both are similar.
>
> See also,
> https://lore.kernel.org/netdev/20200228180226.22986-1-michael@walle.cc/
>
> -michael

Hi Michael,

Thanks for this comment. it is true that AR8031 supports basic PTP 
features.

please refer to the following link for the outline features of qca801.

https://www.qualcomm.com/products/qca8081

