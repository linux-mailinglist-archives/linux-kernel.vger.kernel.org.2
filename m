Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06BD40C562
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhIOMi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:38:27 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:9274 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232824AbhIOMi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:38:26 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18F8RYeL002529;
        Wed, 15 Sep 2021 07:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=GuXmOKINF94sanfaEMy7G+fKYNg88pTomxYW5zW3REo=;
 b=HrywS4nB201TDpU8923zBOrHFzcXYGC0vLq/NpUNlyUM8E22vw1ve6XqcvtIgaOY6WPE
 lzWOUSFbsQSvdRhw6myRopJJIBOka8tAfR5V7JZkw3Pc3RkVH5b9Id60yhAHTki0hJJ3
 Q83LeR4w2BTPw0xV32Yv6fm66AuoTJXtJ5p0heKUtdWiflnp5EPYvdXVFqyYE2hulkPC
 2v/hnJbe303W3HfyfOH7cr+7dXdcLIolz8TVWd+FZHs4/Bb1Pk+loAOuSjq0X3SJ0PDZ
 9MfkJNHREae5gtYSDfbh3vv8cHSj8dceI38Mgh63P59uxTNDzikqX896O9KRuFwhcCQv ww== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3b3287gsay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Sep 2021 07:37:05 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 15 Sep
 2021 13:37:04 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 15 Sep 2021 13:37:04 +0100
Received: from [198.61.64.203] (unknown [198.61.64.203])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 090E8B2F;
        Wed, 15 Sep 2021 12:37:04 +0000 (UTC)
Message-ID: <ef63110f-a579-aaca-9bde-549392a0628c@opensource.cirrus.com>
Date:   Wed, 15 Sep 2021 13:37:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 1/2] regmap: spi: Set regmap max raw r/w from
 max_transfer_size
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20210915120951.29907-1-tanureal@opensource.cirrus.com>
 <20210915123453.GD5389@sirena.org.uk>
From:   Lucas tanure <tanureal@opensource.cirrus.com>
In-Reply-To: <20210915123453.GD5389@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ps7CZpY5HtIn9l1Q0wrsnGQ43dEAmdSq
X-Proofpoint-ORIG-GUID: Ps7CZpY5HtIn9l1Q0wrsnGQ43dEAmdSq
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 13:34, Mark Brown wrote:
> On Wed, Sep 15, 2021 at 01:09:50PM +0100, Lucas Tanure wrote:
>> Set regmap raw read/write from spi max_transfer_size
>> so regmap_raw_read/write can split the access into chunks
>>
>> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
>> ---
>>
>> Changes v2:
>> New series
>>
>> Changes v3:
>> None
> 
> How does this relate to the previous free standing copy of this patch
> you sent only two days ago on Monday?  You've dropped Charles'
> Reviewed-by so I guess there must be some change but this changelog
> claims there's nothing (and appears to claim that v2 was the first
> version...).
> 
Hi,

Yes, its exactly the same, I forgot to add the second patch the previous 
one.
I will resend with Charles review-by.

Thanks
