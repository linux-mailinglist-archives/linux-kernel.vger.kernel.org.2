Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C3E3D95AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhG1S77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:59:59 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:24982 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229565AbhG1S74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:59:56 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16SArwea015791;
        Wed, 28 Jul 2021 13:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=EGSW0TwfIT+GMxavIP78M2ErEcV0sbtlNTgmieySSak=;
 b=RI5Z9RwJz2wSoIcwio8LhoCnsQHohf01Mp4ZF/5fFrmu1NlVxQr3MHfcXHppJidIzEjN
 dNTbrmikP35AwDdDBD3jKyxt4slXLhl4Se+TT31VApGymMAxLcuhpJTwkLzFbr8plhfq
 Ozs7c+LAYo6f+/QUPAYaY6FJQcu3cKshiX75LmrQdqv8Hbf6NLq7c6dh23BALEweKEi+
 9TbApERBPgNtljCp+zHV4Ib2qeBTsAXchwPFYvqmO9FAX+11JBAaR7p9jc14REkhn3iO
 VUktebKqwcDvbafANYqxp6veLEYDrb7mHFzvn867ArmbAfscvAEl9r84F2DsbPi0mIe5 Rw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3a30q20usw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Jul 2021 13:59:39 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 28 Jul
 2021 19:29:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 28 Jul 2021 19:29:30 +0100
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.56])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 57B7A2BA;
        Wed, 28 Jul 2021 18:29:30 +0000 (UTC)
Subject: Re: [PATCH] ASoC: dapm: Revert "use component prefix when checking
 widget names"
To:     Mark Brown <broonie@kernel.org>
CC:     <pierre-louis.bossart@linux.intel.com>,
        <rander.wang@linux.intel.com>, <shumingf@realtek.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20210703125034.24655-1-rf@opensource.cirrus.com>
 <20210705165041.GC4574@sirena.org.uk>
 <a882a9e0-db05-2f89-abb9-8b308ccb56c8@opensource.cirrus.com>
 <20210728160948.GE4670@sirena.org.uk>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <a59d60bf-6bbc-c65f-bd77-2b1bc98b0d22@opensource.cirrus.com>
Date:   Wed, 28 Jul 2021 19:29:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728160948.GE4670@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MQqvYS1TpwSz0d8KkpV4ovc0L2R-oIS4
X-Proofpoint-GUID: MQqvYS1TpwSz0d8KkpV4ovc0L2R-oIS4
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=519 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107280109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2021 17:09, Mark Brown wrote:
> On Thu, Jul 22, 2021 at 10:55:23AM +0100, Richard Fitzgerald wrote:
> 
>> I don't mind if someone wants to change the core dapm functions if that
>> is generally useful, providing that it also updates all callers of those
>> functions to still work.
> 
>> Changing the behaviour of core code to fix the Realtek driver without
>> updating other callers of those functions is a problem.
> 
> The thing here is that nobody would have thought that that any caller
> would have been open coding this stuff like the component things were,

On the contrary, since that was the only way to use these functions with
a prefixed component it's entirely possible that there is code already
adding the prefix. Why would you expect nobody has ever written code
that works?

> it's simply the wrong abstraction level to be implementing something

Ok, but that doesn't mean that it could never have happened.

> like this so people wouldn't think of auditing the callers to find uses

I don't think that it's either safe or desirable to skip checking how
callers use functionality that you want to change. My understanding of
Linux development protocol was that if you make a change that affects
other code, you are responsible for updating that other code to match.
Regardless of whether you agree with how that other code was
implemented. It creates a lot of overhead for everyone if it's ok to
make changes without trying to fix up other code that is affected by
that change.
