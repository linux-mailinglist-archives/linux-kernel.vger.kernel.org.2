Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A60241EB66
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 13:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353740AbhJALIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 07:08:51 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:44220
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353454AbhJALIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 07:08:49 -0400
Received: from [10.172.193.212] (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6C30E4199E;
        Fri,  1 Oct 2021 11:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633086423;
        bh=MKQMNrTSMw8rMSA9wt8sZInaKcQhtrgdLt8Y5PCva+M=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pI0I4TTo8596Mi+AGA//j25xo3txLmpXOKVAwJoCZusJxSxjyEb+m5DZ8uvFIqLRB
         17Qbc0xIE3OFDfdYDtb+gdqEy0snRSjseYEQvBA2nNLx1RYyBoEyrFBLjln+5Mqf6n
         kJRIF0yByasuj2cAGZqxkuB+GLqWUK108djbnu4HKVZzhILA9UBzkQ80JJ6S0kDxXa
         kxf6QTn7KE/rWczv7IspF9eJfHFZEVrypiMkYnsi1uXCc1R/BHOkH7lyTYKSfUAWI7
         ma7QgBqlj3gYjKyodCcUp9GlPq4+uNSw86FsaW+B1hQTsafcggK72q6ki2yf2tufkg
         kxqzSE/JiEPrw==
Message-ID: <0bce4268-cac5-4dee-451d-cfafb5efdb8b@canonical.com>
Date:   Fri, 1 Oct 2021 12:07:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH][next] ALSA: usb-audio: Fix sum of uninitialized variable
 sample_accum
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alexander Tsoy <alexander@tsoy.me>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211001104417.14291-1-colin.king@canonical.com>
 <s5htui1hvgi.wl-tiwai@suse.de>
From:   Colin Ian King <colin.king@canonical.com>
In-Reply-To: <s5htui1hvgi.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2021 11:48, Takashi Iwai wrote:
> On Fri, 01 Oct 2021 12:44:17 +0200,
> Colin King wrote:
>>
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Variable sample_accum is not being intialized and then has
>> ep->sample_rem added to it, leading to a bogus value. One solution
>> is to initialize it to zero at declaration time, but it is probably
>> best to just assign it to ep->sample_rem on first use.
>>
>> Addresses-Coveriry: ("Uninitialized scalar variable")
>> Fixes: f0bd62b64016 ("ALSA: usb-audio: Improve frames size computation")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Thanks for the patch, but it's no right fix.  The Fixes tag points to
> a wrong commit, it was d215f63d49da9a8803af3e81acd6cad743686573
>      ALSA: usb-audio: Check available frames for the next packet size
>    
> And sample_accum has to be initialized from ep->sample_accum instead.
> I'll post the proper fix.

Thanks Takshi.

Colin

> 
> 
> Takashi
> 
> 
>> ---
>>   sound/usb/endpoint.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
>> index 42c0d2db8ba8..c6a33732db3f 100644
>> --- a/sound/usb/endpoint.c
>> +++ b/sound/usb/endpoint.c
>> @@ -182,7 +182,7 @@ static int next_packet_size(struct snd_usb_endpoint *ep, unsigned int avail)
>>   	if (ep->fill_max)
>>   		return ep->maxframesize;
>>   
>> -	sample_accum += ep->sample_rem;
>> +	sample_accum = ep->sample_rem;
>>   	if (sample_accum >= ep->pps) {
>>   		sample_accum -= ep->pps;
>>   		ret = ep->packsize[1];
>> -- 
>> 2.32.0
>>

