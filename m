Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E6133C027
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 16:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhCOPjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 11:39:47 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:54458 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231582AbhCOPj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 11:39:27 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12FFFx3k008868;
        Mon, 15 Mar 2021 10:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=0A7AcxMf6UOqUDVa39Cytpo/grM8iUnprLulx9C6ZM4=;
 b=SMSM1Mxvu7Kmi0nvpLeLKc/0rAWiPU+B2tkFjgmIsutlBdJtm5qtZCbs5lFKdxqaQYcU
 XYbkPsSCcvXe+g/2Dum8L7QhZKrhNh1HVrEGmeBDnYj1VPGggVMlCy7rGg4SjkbVZFzs
 n0YBSEM3oUf261Zosc6E/wbmH7fnG25DtWeHZQ+91yYkgYWnL2S08QfReML0rzzccGOW
 7MzyPEwGdutv8vDHDFntXwkKSZ6CU/6oavVCsi9xZJE/7BS1cet9tZMH4Vq6j+uRRTGn
 LZnjb0NIAHMrvXP3QgrXkeUJoy0aQcNbxWw5r98m12WlYd7HSJLsPRSpDcGek/32DVwX 6Q== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3790bs26xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Mar 2021 10:39:18 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 15 Mar
 2021 15:39:16 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 15 Mar 2021 15:39:16 +0000
Received: from [198.90.238.45] (unknown [198.90.238.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C234E11D6;
        Mon, 15 Mar 2021 15:39:14 +0000 (UTC)
Subject: Re: [PATCH v1 4/4] ALSA: hda/cirrus: Make CS8409 driver more generic
 by using fixups.
To:     Takashi Iwai <tiwai@suse.de>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
References: <20210313113410.90088-1-vitalyr@opensource.cirrus.com>
 <20210313113410.90088-5-vitalyr@opensource.cirrus.com>
 <s5hsg4wrh3v.wl-tiwai@suse.de>
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Message-ID: <9dc404d3-9824-ab8a-7b7d-816aa05a5986@opensource.cirrus.com>
Date:   Mon, 15 Mar 2021 15:39:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <s5hsg4wrh3v.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2021 7:49 am, Takashi Iwai wrote:
> On Sat, 13 Mar 2021 12:34:10 +0100,
> Vitaly Rodionov wrote:
>> @@ -1357,6 +1362,22 @@ static const struct hda_verb cs8409_cs42l42_init_verbs[] = {
>>   	{ 0x47, AC_VERB_SET_PROC_COEF,  0x0080 },     /* I2C mode */
>>   	{ 0x47, AC_VERB_SET_COEF_INDEX, 0x005b },     /* Set I2C bus speed */
>>   	{ 0x47, AC_VERB_SET_PROC_COEF,  0x0200 },     /* 100kHz I2C_STO = 2 */
>> +	{ 0x24, AC_VERB_SET_CONFIG_DEFAULT_BYTES_0, 0xF0 }, /* Widget node ASP-1-TX */
>> +	{ 0x24, AC_VERB_SET_CONFIG_DEFAULT_BYTES_1, 0x20 },
>> +	{ 0x24, AC_VERB_SET_CONFIG_DEFAULT_BYTES_2, 0x21 },
>> +	{ 0x24, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3, 0x04 },
>> +	{ 0x34, AC_VERB_SET_CONFIG_DEFAULT_BYTES_0, 0x50 }, /* Widget node ASP-1-RX0 */
>> +	{ 0x34, AC_VERB_SET_CONFIG_DEFAULT_BYTES_1, 0x20 },
>> +	{ 0x34, AC_VERB_SET_CONFIG_DEFAULT_BYTES_2, 0xa1 },
>> +	{ 0x34, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3, 0x04 },
>> +	{ 0x2C, AC_VERB_SET_CONFIG_DEFAULT_BYTES_0, 0xF0 }, /* Widget node ASP-2-TX */
>> +	{ 0x2C, AC_VERB_SET_CONFIG_DEFAULT_BYTES_1, 0x00 },
>> +	{ 0x2C, AC_VERB_SET_CONFIG_DEFAULT_BYTES_2, 0x10 },
>> +	{ 0x2C, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3, 0x90 },
>> +	{ 0x44, AC_VERB_SET_CONFIG_DEFAULT_BYTES_0, 0x90 }, /* Widget node DMIC-1 */
>> +	{ 0x44, AC_VERB_SET_CONFIG_DEFAULT_BYTES_1, 0x00 },
>> +	{ 0x44, AC_VERB_SET_CONFIG_DEFAULT_BYTES_2, 0xA0 },
>> +	{ 0x44, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3, 0x90 },
> Those widgets are all pin widgets, right?  If so, setting via the
> pincfg table would be more suitable, as it's cached and exposed via
> sysfs for debugging.

Yes, you are right, actually we already have these widgets in pincfg 
table, so this code is redundant.

Will fix in next version.

>
>
> thanks,
>
> Takashi


