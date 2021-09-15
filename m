Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B0440C2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbhIOJh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:37:57 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:19536 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhIOJh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:37:56 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18F8RYYa002529;
        Wed, 15 Sep 2021 04:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=7jSSEFSclv8FhsW/JSW/6X0NIoG/uGILNNBtf6HBqDU=;
 b=E0yEV3k/zd2P2kmr7uM+Zr4/5Lpw3NaeWFQT66H3Ntikak+LUBops6ge/r3fChnNqogU
 bcDveTVLxfLs9HFfKoTriI8EAgyPlHJ4Y3Tweh8qw48Fi3ajTyJ+6XcGOXcsP7NHjYEs
 5ebRxdnQcmkfQZIHbRyjW8LQSufj/L74fKVyCxWbgJdLitgSERswxrpGmGvz5fq+7ADU
 Gn98OUkv3BJo9/MiPQm4ilLghZ4JNWE/j8zam9cHrtUB82gELz5ExCL9lckmAMCuHCmC
 iJKNwt7ZiI3+jwJyPRO95knmWq8zED0HLnMAmYVY0Ri3TnWrfa7qD4DVIt6G5+5HqZec mw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3b3287gm7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Sep 2021 04:36:29 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 15 Sep
 2021 10:36:27 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 15 Sep 2021 10:36:27 +0100
Received: from [198.90.238.230] (unknown [198.90.238.230])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7678D45D;
        Wed, 15 Sep 2021 09:36:27 +0000 (UTC)
Subject: Re: [PATCH 1/2] ASoC: cs42l42: Minor fix all errors reported by
 checkpatch.pl script
To:     Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>,
        <patches@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>,
        "James Schulman" <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        <linux-kernel@vger.kernel.org>
References: <20210914165220.752498-1-vitalyr@opensource.cirrus.com>
 <20210914165220.752498-2-vitalyr@opensource.cirrus.com>
 <20210914170516.GG4434@sirena.org.uk>
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Message-ID: <e5686fcb-32ba-8f7d-3e29-113ddb65a141@opensource.cirrus.com>
Date:   Wed, 15 Sep 2021 10:36:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914170516.GG4434@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-GUID: TKicdmKMLmcpd0wGR1l6VnbanSDtgUXn
X-Proofpoint-ORIG-GUID: TKicdmKMLmcpd0wGR1l6VnbanSDtgUXn
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2021 6:05 pm, Mark Brown wrote:
> On Tue, Sep 14, 2021 at 05:52:19PM +0100, Vitaly Rodionov wrote:
>> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
>> ---
>>   sound/soc/codecs/cs42l42.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)

Hi Mark,

Thanks a lot for review. We will fix and push new version.

Thanks,

Vitaly

> This sort of minor cleanup should go after any fixes so that there's no
> dependency created needlessly.


