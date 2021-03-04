Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34AC32D9E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbhCDTAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:00:36 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:44402 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232474AbhCDTAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:00:18 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124IujVs026128;
        Thu, 4 Mar 2021 12:59:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=AlTMCerrUAg3Nk6mF7nb9+dbxC8AujF2woftsi5XpLo=;
 b=H9Jzk0IkTw0QC7TJIxI9AFo74X8gPwZqgcxNZ5PpvZyoci5rEIeRnKA4uaJzrKnJ2GpO
 HhqiJznVHRc4oGjm7RiPPKK8ZUqcY3nPRb5TdzE0/pW5sTLWZG0DJLFhhBq+NeduOTx2
 8otyhuOYdFU1K3+LYXvcGJBzdK7ck9ir1zOOmwvxYp/+a95hLWobHE1O/6A+S1xzQJbT
 EjIsBvOkhtyNF9HVIR4ElQ+kMAN/ff7O6AXcdI+d4KCmj3753El4H9k0OENE6uM+0R4s
 pPWehXzy/JFf71Diet6fJ1E9goBK6c2NpE4VvypHLhImdpjnunK7Q635yp8niAoH2ZOo mw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 36ykctq0vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Mar 2021 12:59:19 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 4 Mar 2021
 18:44:15 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 4 Mar 2021 18:44:15 +0000
Received: from [198.90.238.45] (unknown [198.90.238.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4D3EA11CB;
        Thu,  4 Mar 2021 18:44:15 +0000 (UTC)
Subject: Re: [PATCH 3/4] ALSA: hda/cirrus: Add jack detect interrupt support
 from CS42L42 companion codec.
To:     Takashi Iwai <tiwai@suse.de>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
References: <20210303182959.5322-1-vitalyr@opensource.cirrus.com>
 <20210303182959.5322-4-vitalyr@opensource.cirrus.com>
 <s5h7dmn9gmo.wl-tiwai@suse.de>
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Message-ID: <d5387324-6eb3-1cb1-e8e1-1fb9604a6149@opensource.cirrus.com>
Date:   Thu, 4 Mar 2021 18:44:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <s5h7dmn9gmo.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2021 1:45 pm, Takashi Iwai wrote:
> On Wed, 03 Mar 2021 19:29:58 +0100,
> Vitaly Rodionov wrote:
>> @@ -1243,6 +1258,8 @@ static int patch_cs4213(struct hda_codec *codec)
>>   #define CIR_I2C_QWRITE	0x005D
>>   #define CIR_I2C_QREAD	0x005E
>>   
>> +static struct mutex cs8409_i2c_mux;
> Any reason that this must be the global mutex?  I suppose it can fit
> in own spec->i2c_mutex instead?
No,  there is no reason to have global mutex, will move it out to spec.
>
>
>> +static void cs8409_cs42l42_cap_sync_hook(struct hda_codec *codec,
>> +					 struct snd_kcontrol *kcontrol,
>> +					 struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct cs_spec *spec = codec->spec;
>> +	unsigned int curval, expval;
>> +	/* CS8409 DMIC Pin only allows the setting of the Stream Parameters in
>> +	 * Power State D0. When a headset is unplugged, and the path is switched to
>> +	 * the DMIC, the Stream is restarted with the new ADC, but this is done in
>> +	 * Power State D3. Restart the Stream now DMIC is in D0.
>> +	 */
>> +	if (spec->gen.cur_adc == CS8409_CS42L42_DMIC_ADC_PIN_NID) {
>> +		curval = snd_hda_codec_read(codec, spec->gen.cur_adc,
>> +			0, AC_VERB_GET_CONV, 0);
>> +		expval = (spec->gen.cur_adc_stream_tag << 4) | 0;
>> +		if (curval != expval) {
>> +			codec_dbg(codec, "%s Restarting Stream after DMIC switch\n", __func__);
>> +			__snd_hda_codec_cleanup_stream(codec, spec->gen.cur_adc, 1);
>> +			snd_hda_codec_setup_stream(codec, spec->gen.cur_adc,
>> +					   spec->gen.cur_adc_stream_tag, 0,
>> +					   spec->gen.cur_adc_format);
> Hrm, this looks a big scary.  We may need to reconsider how to handle
> this better later, but it's OK as long as you've tested with this
> code...

We have been thinking about this code, and we have some ideas , it was 
tested by us, DELL and Canonical and works.

But we would like to change it a bit later, and handle it in a more 
generic way.

>
>> +static int cs8409_cs42l42_init(struct hda_codec *codec)
>> +{
>> +	int ret = 0;
>> +
>> +	ret = snd_hda_gen_init(codec);
>> +
>> +	if (!ret) {
>> +		/* On Dell platforms with suspend D3 mode support we
>> +		 * have to re-initialise cs8409 bridge and companion
>> +		 * cs42l42 codec
>> +		 */
>> +		snd_hda_sequence_write(codec, cs8409_cs42l42_init_verbs);
>> +		snd_hda_sequence_write(codec, cs8409_cs42l42_add_verbs);
>> +
>> +		cs8409_cs42l42_hw_init(codec);
> Ah... the init stuff at resume appears finally here.  This part should
> be in the second patch instead.
Yes, moving this into second patch.
>
>> +static int cs8409_cs42l42_exec_verb(struct hdac_device *dev,
>> +		unsigned int cmd, unsigned int flags, unsigned int *res)
>> +{
>> +	struct hda_codec *codec = container_of(dev, struct hda_codec, core);
>> +	struct cs_spec *spec = codec->spec;
>> +
>> +	unsigned int nid = 0;
>> +	unsigned int verb = 0;
> The blank line above should be removed.
>
>> +	case CS8409_CS42L42_HP_PIN_NID:
>> +		if (verb == AC_VERB_GET_PIN_SENSE) {
>> +			*res = (spec->cs42l42_hp_jack_in)?AC_PINSENSE_PRESENCE:0;
> The spaces are needed around operators.
> Similar coding-style issues are seen other places.  Please try to run
> scripts/checkpatch.pl.

Fixed, and checked with scripts/checkpatch.pl. Base has 19 warnings. 
This patch will not introduce any new.

>
>
> thanks,
>
> Takashi

Thanks,

Vitaly


