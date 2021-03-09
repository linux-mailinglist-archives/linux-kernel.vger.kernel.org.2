Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67ACF33276A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCINm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:42:58 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:5644 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230035AbhCINmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:42:37 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 129DbMJr024533;
        Tue, 9 Mar 2021 07:41:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=texA9NDJALCUe6j3oIFUZZLHkRFvVH330/+VJwmvh0g=;
 b=Vl8OhgwkjozwUC2zl7zu5B4g5d4Vb0KM3bFkHuGnYX1z99mPQFx5n66Ppp6Rvo3irUd5
 l8zDU2eAdrXUqOI/uG2TeOCFClbph5Lw8/ComLV7q/yAqnvyfEAxKIn3ugfGDBu/bq02
 1woBrWJ5YTko5wkLRNZUDuzw/mN5Rb9++T5Ol2KSs2zrpX3+WAOo36UD69KxZyFX8muK
 fmiYf9japTCVhTojwM5oAlKlXimejd3YdD9iKxxZG3PNkflXq7EuImg52LQMVxXGMb3O
 elhri9DPTcoMHXMuk+hWyVO8U7SWyw6hPbbcAGKACnMKVz1sVb0csj3T4a1mcSAfx0CU Qg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 37471vud9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Mar 2021 07:41:50 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 9 Mar 2021
 13:41:48 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 9 Mar 2021 13:41:48 +0000
Received: from [198.90.238.45] (unknown [198.90.238.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AEDD411CF;
        Tue,  9 Mar 2021 13:41:48 +0000 (UTC)
Subject: Re: [PATCH v3 3/4] ALSA: hda/cirrus: Add jack detect interrupt
 support from CS42L42 companion codec.
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20210306111934.4832-1-vitalyr@opensource.cirrus.com>
 <20210306111934.4832-4-vitalyr@opensource.cirrus.com>
 <3ddc27d5-7d6d-e244-51fa-6ac17ee9779a@linux.intel.com>
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Message-ID: <00537bf3-926c-eb2f-98ed-3d0242ecd8fd@opensource.cirrus.com>
Date:   Tue, 9 Mar 2021 13:41:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <3ddc27d5-7d6d-e244-51fa-6ac17ee9779a@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=518 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2021 3:35 pm, Pierre-Louis Bossart wrote:
>
>
>
>> @@ -38,6 +39,15 @@ struct cs_spec {
>>       /* for MBP SPDIF control */
>>       int (*spdif_sw_put)(struct snd_kcontrol *kcontrol,
>>                   struct snd_ctl_elem_value *ucontrol);
>> +
>> +    unsigned int cs42l42_hp_jack_in:1;
>> +    unsigned int cs42l42_mic_jack_in:1;
>> +
>> +    struct mutex cs8409_i2c_mux;
>
> what does this protect? there isn't any comment or explanations in the 
> commit message.
>
>
we are protecting sequences of i2c transactions.

for example,  when we are writing sequence to activate jack detect, as a 
result of interrupt via gpio4

unsolicited response can be called by framework at the same time. we 
want to finish first sequence.

