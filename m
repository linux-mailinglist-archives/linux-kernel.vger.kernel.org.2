Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08054433DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 19:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhJSRlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 13:41:21 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:60295 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbhJSRlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:41:20 -0400
Received: from [192.168.1.18] ([92.140.161.106])
        by smtp.orange.fr with ESMTPA
        id ct4qmJ5v2PNphct4qm4mlQ; Tue, 19 Oct 2021 19:39:06 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 19 Oct 2021 19:39:06 +0200
X-ME-IP: 92.140.161.106
Subject: Re: [PATCH] ASoC: codecs: Fix WCD_MBHC_HPH_PA_EN usage
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, yang.lee@linux.alibaba.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <988948f7f266aa00698704687537335b7e6a67b2.1634455711.git.christophe.jaillet@wanadoo.fr>
 <3ff34912-19e6-4d52-e9da-0e78ceb1d2ff@linaro.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <c01b6669-d0f7-aab5-3aca-02f19be8a319@wanadoo.fr>
Date:   Tue, 19 Oct 2021 19:39:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3ff34912-19e6-4d52-e9da-0e78ceb1d2ff@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 19/10/2021 à 15:47, Srinivas Kandagatla a écrit :
> 
> 
> On 17/10/2021 08:31, Christophe JAILLET wrote:
>> 'hphpa_on' is known to be false, so the if block at the end of the 
>> function
>> is dead code.
> 
> Yes, this is a dead code we should remove it.

Ok, thanks for the clarification.

> 
> This code was part of moisture detection logic which is not enabled in 
> upstream code yet.

If 'yet' is the important word of the sentence, maybe the best is to 
leave the code as-is.
If you prefer it to be removed, I can send a patch if it helps.

> 
> During Moisture detection if the PA is on then we switch it off and do 
> moisture measurements and at the end of the function we restore the 
> state of PA.
> 
>>
>> Turn it into a meaningful code by having 'hphpa_on' be static. Use is 
>> as a
>> flip-flop variable.
> 
> No, It does not.
> 
> Have you even tested this patch in anyway?

No, as said below the ---, the purpose of this patch was not to be 
correct (or tested). It was only to draw attention on odd things.

CJ



> 
>>
>> Fixes: 0e5c9e7ff899 ("ASoC: codecs: wcd: add multi button Headset 
>> detection support")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> The purpose of this patch is not to be correct (!) but to draw attention
>> on several points:
>>     - in 'wcd_mbhc_adc_hs_rem_irq()', the "if (hphpa_on)" path is dead 
>> code
>>       because 'hphpa_on' is known to be false
>>     - What is this magic number '3'?
>>       All 'wcd_mbhc_read_field()' look for 0 or non-0
>>     - a 'mutex_[un]lock()' in an IRQ handler looks spurious to me
>>
>> Instead of this (likely broken) patch, it is likely that something is
>> missing elsewhere. Maybe in 'wcd_mbhc_adc_hs_ins_irq()'.
>> I also guess that 'hphpa_on' should be read for somewhere else.
>> ---
>>   sound/soc/codecs/wcd-mbhc-v2.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/codecs/wcd-mbhc-v2.c 
>> b/sound/soc/codecs/wcd-mbhc-v2.c
>> index 405128ccb4b0..783d8c35bc1b 100644
>> --- a/sound/soc/codecs/wcd-mbhc-v2.c
>> +++ b/sound/soc/codecs/wcd-mbhc-v2.c
>> @@ -1176,7 +1176,7 @@ static irqreturn_t wcd_mbhc_adc_hs_rem_irq(int 
>> irq, void *data)
>>       struct wcd_mbhc *mbhc = data;
>>       unsigned long timeout;
>>       int adc_threshold, output_mv, retry = 0;
>> -    bool hphpa_on = false;
>> +    static bool hphpa_on = false;
>>       mutex_lock(&mbhc->lock);
>>       timeout = jiffies + 
>> msecs_to_jiffies(WCD_FAKE_REMOVAL_MIN_PERIOD_MS);
>> @@ -1212,6 +1212,9 @@ static irqreturn_t wcd_mbhc_adc_hs_rem_irq(int 
>> irq, void *data)
>>       if (hphpa_on) {
>>           hphpa_on = false;
>> +        wcd_mbhc_write_field(mbhc, WCD_MBHC_HPH_PA_EN, 0);
>> +    } else {
>> +        hphpa_on = true;
>>           wcd_mbhc_write_field(mbhc, WCD_MBHC_HPH_PA_EN, 3);
> 
> Just remove this dead code.
> 
> --srini
>>       }
>>   exit:
>>
> 

