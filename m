Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D989B455003
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 22:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbhKQWAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 17:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241055AbhKQV7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 16:59:16 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BCFC06122E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:55:09 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id j28so4342138ila.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Hxr69O3bJrzYefrTxgVZfC16APa+v16lfxoy3u13P1s=;
        b=QpE3KxMjhsnLmogPyVojs8AgoyXiIlugpWIViPAv7oiK1aXt5F2T46PeR0VJXEnpCz
         m7v3Ao9VxhEIBD60di2CRpisiRPQNSoPF7NcpFHnujXABezOdIK1zP/UY9sj+8ofWpQT
         gcfhUceItvGTYjnCGDFe9ChfLskStZ6AucPz6AQ+TpywDW+h3lfvuU/oh+zGlhfY8Xee
         taBiu6Od2l3Sywgqnhj8ycQdLaQItwJjpk72zE2va7G3BseM3BIPpHYt/sXHv+8ODP3Q
         Xo1YHwiRjmv3aiuHJPhguGEg/ziKpQTxdHOvsFEumpzmy8th51zMlS3/uyPTpk2C0vXU
         a49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Hxr69O3bJrzYefrTxgVZfC16APa+v16lfxoy3u13P1s=;
        b=0s+ZsgqZqe89wyKzDD7wu4W14SGD9zvkNhYGwjojH3JeibR44445mCJXAlknI3iVI9
         HpjCiF80hIhp3bWGo4JyvW0orrS+eMkHnT7l64V03Ua77j07XLq+LRtgtES8tN9uUs6P
         NnNQGaGYwFJ28dChz/akchJXFqoZqQWO/N/Yk+wjXw/5nnLqeihLhsShWhps5UmnpqcF
         /PIioPzzSVEgZBwZpJueLw0IMAbfbewxxH/37pWpcLN2MaAuJqFYSPPB+vvmXF4GN3FD
         W0iAdC2fjFCF3ClzZJ0xWD7aOdZVMBpModqIWa2mOe5lNqTxDIQBgrS6EY2oL9prVHie
         thvA==
X-Gm-Message-State: AOAM532cu2MUEI3dlEUL6KqOnCBNpKtG9NW4rI46tZk4SUUuJ6GyY002
        9SRdo45gpVZbzwJJSdTcyWEPSA==
X-Google-Smtp-Source: ABdhPJziRfbgGvt+zj01L3LXVaTAP4Q1xpUA/9+Eb4Zh/hXWLeCX1sMr0sPVc/gYLkSCCicB08Nz4Q==
X-Received: by 2002:a92:c5cc:: with SMTP id s12mr12752085ilt.239.1637186108709;
        Wed, 17 Nov 2021 13:55:08 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id a25sm588238ioa.24.2021.11.17.13.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 13:55:07 -0800 (PST)
Message-ID: <b0d2b643-214a-07c5-96b7-4845c54cba72@linaro.org>
Date:   Wed, 17 Nov 2021 15:55:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [greybus-dev] [PATCH] staging: greybus: Add missing rwsem around
 snd_ctl_remove() calls
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     greybus-dev@lists.linaro.org, Alex Elder <elder@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
References: <20211116072027.18466-1-tiwai@suse.de>
 <07e228eb-676a-bdb1-c2ec-a96f691f5a18@linaro.org>
 <s5h5ysqlcm8.wl-tiwai@suse.de>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <s5h5ysqlcm8.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/21 3:02 PM, Takashi Iwai wrote:
> On Wed, 17 Nov 2021 20:56:14 +0100,
> Alex Elder wrote:
>>
>> On 11/16/21 1:20 AM, Takashi Iwai wrote:
>>> snd_ctl_remove() has to be called with card->controls_rwsem held (when
>>> called after the card instantiation).  This patch adds the missing
>>> rwsem calls around it.
>>
>> I see the comment above snd_ctl_remove() that says you must hold
>> the write lock.  And given that, this seems correct to me.
>>
>> I understand why you want to take the lock just once, rather
>> than each time snd_ctl_remove() is called.
>>
>> However I believe the acquisition and release of the lock
>> belongs inside gbaudio_remove_controls(), not in its caller.
>>
>> If you disagree, can you please explain why?
> 
> In general if the function returns an error and has a loop inside,
> taking a lock in the caller side avoids the forgotten unlock.

But taking the lock in the called function makes the
caller not need to take the lock (which would be even
more valuable if there were more than one caller).

I prefer having the lock acquisition in the called
function.  Please send version 2, as I suggested.

					-Alex

> Takashi
> 
> 
>> Otherwise, will you please submit version two, taking the
>> lock inside gbaudio_remove_controls()?
>>
>> Thanks.
>>
>> 					-Alex
>>
>>> Fixes: 510e340efe0c ("staging: greybus: audio: Add helper APIs for dynamic audio modules")
>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>> ---
>>>    drivers/staging/greybus/audio_helper.c | 8 ++++++--
>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
>>> index 1ed4772d2771..843760675876 100644
>>> --- a/drivers/staging/greybus/audio_helper.c
>>> +++ b/drivers/staging/greybus/audio_helper.c
>>> @@ -192,7 +192,11 @@ int gbaudio_remove_component_controls(struct snd_soc_component *component,
>>>    				      unsigned int num_controls)
>>>    {
>>>    	struct snd_card *card = component->card->snd_card;
>>> +	int err;
>>>    -	return gbaudio_remove_controls(card, component->dev, controls,
>>> -				       num_controls, component->name_prefix);
>>> +	down_write(&card->controls_rwsem);
>>> +	err = gbaudio_remove_controls(card, component->dev, controls,
>>> +				      num_controls, component->name_prefix);
>>> +	up_write(&card->controls_rwsem);
>>> +	return err;
>>>    }
>>>
>>

