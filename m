Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCFA33A424
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 11:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhCNKT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 06:19:28 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:37238 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235126AbhCNKTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 06:19:07 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12EAIqRf000371;
        Sun, 14 Mar 2021 05:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=UyEKzuzXX6Bk054SMR2fNK/9VqqSA0lao6vxZ6vCYfU=;
 b=HOmxilYKKnz5YElDny6N5x27VXkSYKzOSoyMYCwGrIoOc3IMfidZPmndZEoe/2jvntF5
 sOshVujfRt4fkLzRJKz1eBqn1eUWfpwLvE88TtmHFX1qVTBidBPnl4CL5Tv9qbmUkQmD
 GmKr5ReOcIVkmlLyfh+FkgIbs+nX/nm9Z2ZB1lx9irMsT1aq23dcyRc3BvR6pQLQofsC
 4ss2wLcDNd69Qgca1NtGD9xU1kWWTomP85LBupC48bvLcVc2F/HYFcKIyI0GBmugAbuy
 1J5KvigLfHr6w8ZpAuoAkhexU6b7G5UzwrOnrDD3uID422etgKCB9YfcYoHVgiB7dNNU 0A== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 378tpv161p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 14 Mar 2021 05:18:52 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sun, 14 Mar
 2021 10:18:51 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sun, 14 Mar 2021 10:18:51 +0000
Received: from [198.90.238.45] (unknown [198.90.238.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1BA1711CB;
        Sun, 14 Mar 2021 10:18:51 +0000 (UTC)
Subject: Re: [PATCH v1 0/4] ALSA: hda/cirrus: Make CS8409 driver more generic
 by using fixups
To:     Takashi Iwai <tiwai@suse.de>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
References: <20210313113410.90088-1-vitalyr@opensource.cirrus.com>
 <s5h1rcirv2a.wl-tiwai@suse.de>
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Message-ID: <0e3a2304-7945-0d80-91cc-b6b551f7c3f4@opensource.cirrus.com>
Date:   Sun, 14 Mar 2021 10:18:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <s5h1rcirv2a.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=555 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103140076
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2021 8:36 am, Takashi Iwai wrote:
> On Sat, 13 Mar 2021 12:34:06 +0100,
> Vitaly Rodionov wrote:
>> This series of patches will address comments by Pierre-Louis Bossart,
>> cleans up patch_cirrus.c source, reducing checkpatch.pl warnings from 19 to 0,
>> fixing an issue reported by Canonical: BugLink: https://bugs.launchpad.net/bugs/1918378,
>> and makes the CS8409 patch more generic by using fixups.
>>
>> Stefan Binding (4):
>>    ALSA: hda/cirrus: Add error handling into CS8409 I2C functions
>>    ALSA: hda/cirrus: Cleanup patch_cirrus.c code.
>>    ALSA: hda/cirrus: Fix CS42L42 Headset Mic volume control name
>>    ALSA: hda/cirrus: Make CS8409 driver more generic by using fixups.
> Is this the same content as the series you've already submitted in
> 20210312184452.3288-1-vitalyr@opensource.cirrus.com ?

Hi Takashi,

Yes, this is second version of same series, where we have fixed warnings 
from 0-day bot.

Thanks,

Vitaly

>
>
> thanks,
>
> Takashi


