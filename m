Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4353333C01E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 16:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhCOPiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 11:38:10 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:63178 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231785AbhCOPhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 11:37:47 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12FFFxwn008883;
        Mon, 15 Mar 2021 10:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=g8rloe0vgTg2LzKu5YWaK0xwsmf5wmO0oYcImlEhJtw=;
 b=L9UFULicz1nA5C15zBeRwN6+6FTHDu41/15vwQxqkgvHsTSGBmk3f7vNXS6o//R4qaF4
 7XxW8Scu3Iv0UDLzLzNfAXGy07A2hHanugY7x+tDx3pIeX7sN+eoUQLchaMydEQzYoIY
 QPajqtBR9HKaZc7ot1fk8v23eveUaEcibeQVI9dhTera16bGhoeMJvl9KDJTkxSmHTCk
 BOUuzErKplCYahFhfxI3bGp5f12Na3r7A8WOK5Ue6g9Hyz+cEpwA8Zl/W4UwfG07fLTf
 KKdnRlcScSKFGvN9hVcNnLUmA0T2CAAZbWJOjet60sbw3lgQG9+qExdgkriNd9vO7WtQ kQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3790bs26vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Mar 2021 10:37:35 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 15 Mar
 2021 15:37:33 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 15 Mar 2021 15:37:33 +0000
Received: from [198.90.238.45] (unknown [198.90.238.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1F19B11D6;
        Mon, 15 Mar 2021 15:37:33 +0000 (UTC)
Subject: Re: [PATCH v1 1/4] ALSA: hda/cirrus: Add error handling into CS8409
 I2C functions
To:     Takashi Iwai <tiwai@suse.de>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
References: <20210313113410.90088-1-vitalyr@opensource.cirrus.com>
 <20210313113410.90088-2-vitalyr@opensource.cirrus.com>
 <s5htupcrhc3.wl-tiwai@suse.de>
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Message-ID: <f9306811-5b69-ac11-2311-55656d11bddb@opensource.cirrus.com>
Date:   Mon, 15 Mar 2021 15:37:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <s5htupcrhc3.wl-tiwai@suse.de>
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

On 15/03/2021 7:45 am, Takashi Iwai wrote:

Hi Takashi,
Thanks a lot for your comments.

> On Sat, 13 Mar 2021 12:34:07 +0100,
> Vitaly Rodionov wrote:
>> @@ -1508,7 +1508,7 @@ static void cs8409_enable_i2c_clock(struct hda_codec *codec, unsigned int flag)
>>   static int cs8409_i2c_wait_complete(struct hda_codec *codec)
>>   {
>>   	int repeat = 5;
>> -	unsigned int retval = 0;
>> +	unsigned int retval;
>>   
>>   	do {
>>   		retval = cs_vendor_coef_get(codec, CIR_I2C_STATUS);
>> @@ -1520,78 +1520,82 @@ static int cs8409_i2c_wait_complete(struct hda_codec *codec)
>>   
>>   	} while (repeat);
>>   
>> -	return repeat > 0 ? 0 : -1;
>> +	return !!repeat;
>>   }
> If the return value of the function has changed, it's nicer to
> comment, e.g. a brief function description would be helpful.
> Also now this looks rather like a bool?
Yes, agreed , we will add comments to describe parameters and return values
>
>
>> @@ -1881,13 +1896,15 @@ static void cs8409_jack_unsol_event(struct hda_codec *codec, unsigned int res)
>>   	reg_hs_status = cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1124, 1);
>>   	reg_ts_status = cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x130f, 1);
>>   
>> -	/* Clear interrupts */
>> +	/* Clear interrupts, by reading interrupt status registers */
>>   	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1b7b, 1);
>> -	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1308, 1);
>> -	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x130f, 1);
> Why those two calls are removed?
This 2 call are redundant as we already did read these 2 registers in a 
code few lines above.
>
>>   	mutex_unlock(&spec->cs8409_i2c_mux);
>>   
>> +	/* If status values are < 0, read error has occurred. */
>> +	if ((reg_cdc_status < 0) || (reg_hs_status < 0) || (reg_ts_status < 0))
>> +		return;
> Parentheses around the comparison are superfluous, you can remove
> them.
Will fix.
>
> thanks,
>
> Takashi


