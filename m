Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A4632D997
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 19:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhCDSqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 13:46:47 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:59602 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234697AbhCDSqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 13:46:42 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124IWCCx016648;
        Thu, 4 Mar 2021 12:45:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=9YnOQSjZf3bbcOgBfkersI4f1qMN4YhWlYOh/26S/JE=;
 b=LYe1luI6zW5yjuK19/Gm5UTOpk2Pe2yyIg8ljE+UgJ8C7KLnHR4dDEzEW6LgYHMpFGTF
 alU+pjZbppWp6MYQnR2DMqPR7H52UlgkwVtXm5BR45rS30Vk0DWH37i0TPx+3j2KtGpr
 7vux2BwTOEwsegrh6Zp1aPyFYjprCS02TMrONyNB7ENMY+xQO94xz6E9r37R6a62hF2U
 j8q5V10bzTy72gpF8LdRLlsPvfPK2pfgmOcp/aqAb8PqPTXcDHKhoNzxHeUlLEW2e++k
 Mm6tXZ/fj6K1jUGbyuJEHEQQumgBcalYtmUamzUmKpIf7gNWfXkaP9/8/+iyZcqzbdX+ lQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36ymc6y49m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Mar 2021 12:45:16 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 4 Mar 2021
 18:45:14 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 4 Mar 2021 18:45:14 +0000
Received: from [198.90.238.45] (unknown [198.90.238.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DF55711D0;
        Thu,  4 Mar 2021 18:45:13 +0000 (UTC)
Subject: Re: [PATCH 4/4] ALSA: hda/cirrus: Add Headphone and Headset MIC
 Volume Control
To:     Takashi Iwai <tiwai@suse.de>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
References: <20210303182959.5322-1-vitalyr@opensource.cirrus.com>
 <20210303182959.5322-5-vitalyr@opensource.cirrus.com>
 <s5h5z279ggk.wl-tiwai@suse.de>
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Message-ID: <d2b64cb9-895e-f6ab-d95d-8c2d5962d64c@opensource.cirrus.com>
Date:   Thu, 4 Mar 2021 18:45:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <s5h5z279ggk.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=975 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2021 1:49 pm, Takashi Iwai wrote:
> On Wed, 03 Mar 2021 19:29:59 +0100,
> Vitaly Rodionov wrote:
>> +static int cs8409_cs42l42_volume_get(struct snd_kcontrol *kcontrol,
>> +				 struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
>> +	hda_nid_t nid = get_amp_nid(kcontrol);
>> +	int chs = get_amp_channels(kcontrol);
>> +	long *valp = ucontrol->value.integer.value;
>> +	char vol = 0;
>> +
>> +	codec_dbg(codec, "%s() nid: %d\n", __func__, nid);
>> +	snd_hda_power_up(codec);
>> +	switch (nid) {
>> +	case CS8409_CS42L42_HP_PIN_NID:
>> +		mutex_lock(&cs8409_i2c_mux);
>> +		if (chs & 1) {
>> +			vol = -(cs8409_i2c_read(codec, CS42L42_I2C_ADDR,
>> +				CS8409_CS42L42_REG_HS_VOLUME_CHA, 1));
> Better to cache the values instead of i2c read at each time?
> Then the unnecessary power up/down sequence can be avoided, too.
Yes, agree. Will be fixed in next version of patch.
>
>
> thanks,
>
> Takashi

Thank you,

Vitaly

