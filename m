Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CB13554C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhDFNOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhDFNOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:14:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03627C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 06:14:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso7300591wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 06:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Jyc4XzYiplxZKJWr8stiFiY4OI9641o8fprPOPnJi5M=;
        b=LCfQYoiia24DPIO9J78E90nCCMkNt6x11pCJsnL0tapjZR070TKPSOmVtOednCoRGC
         Ox279dPM63l8hpj+b2p38FmvWvw2J78yc0557EgNIbUA2eVg55NVAZASkJSfuoH72VTn
         7urg2n+aFT/TbDhiFtCqOROyRC15XTEssCCQqMvk3UmCcwgvWEBWdot6MSm7bgwCb+ed
         inCO6A6sC/sBejU4DunzSLTtNDvw3fUfVRqAMuzL5chafhoYuGaXtHhdEqBrwJA1DVmI
         9vwJBTx12ydslUiQBhyQ2CVbmvcsHYTJPKfeGvBC+18OG+M3pJmuR6zlI0mRnGwYLfhH
         Ei8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Jyc4XzYiplxZKJWr8stiFiY4OI9641o8fprPOPnJi5M=;
        b=ZupUOhmR9VmFtuWfE9DeQkvLuSLsx/nwMZWqSaHXqaT1Okxew/UnM4eaHqiRLm4+VD
         iLOuoMmLGfjnyjN4HuE1UHZSJ25YhAxDiD+4HlBDniLC8439eTh3KGZcC1Fkd+YYR71M
         O3h7/k9EsgGbqwL6VlEYyc7Ghyc/Vcvd0BDTu0zYZ3ehoTvluuO8pSWz4wU/PhKkzzsQ
         XC+UhMRJ3mKqux+Li8UBONJBqNXPca24KBwTy5RQnrUxikqOW5JHutxsqvEI3DZ7fFVQ
         goOc5LV/knM7QuSA8lbVHAGdV/LMl5EPo/UGTXxgdC/8kCuCop5t+ac4muMcqR5E4Oih
         EY8Q==
X-Gm-Message-State: AOAM533jWHvQv6HYLbgNTE8Xr1w3RRBd3hgGbtdZahMoajsLto7QxzgI
        7btdGu5YTfFPeB5GlZ+0dsg=
X-Google-Smtp-Source: ABdhPJzDs/Ff7ae+dmQpa+Wj6Xp8TqaXa2G75GP5fM56uoTOV5ZMpuD0jPlPvq0L2oEp6vIFEUnCzQ==
X-Received: by 2002:a05:600c:4d13:: with SMTP id u19mr4062099wmp.16.1617714864689;
        Tue, 06 Apr 2021 06:14:24 -0700 (PDT)
Received: from ?IPv6:2001:818:de85:7e00:ad13:af9b:f63b:bc4b? ([2001:818:de85:7e00:ad13:af9b:f63b:bc4b])
        by smtp.gmail.com with ESMTPSA id s83sm2909188wms.16.2021.04.06.06.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 06:14:24 -0700 (PDT)
Subject: Re: [PATCH 3/4] staging: rtl8723bs: core: reorganize characters so
 the lines are under 100 ch
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <cover.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
 <6ce5f20399f2bea9f08bb37150fc67fe3c2b2a55.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
 <YGxQcEvmxHrNz2US@kroah.com>
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Message-ID: <2103809f-fc6d-be31-a57a-6d65914d8cf3@gmail.com>
Date:   Tue, 6 Apr 2021 14:14:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YGxQcEvmxHrNz2US@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Em 06/04/21 13:13, Greg KH escreveu:
> On Mon, Apr 05, 2021 at 06:29:19PM +0100, Beatriz Martins de Carvalho wrote:
>> Cleans up warnings of "line over 100 characters" but avoinding
>> more than 90 characters in file rtw_ap.c
>>
>> Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
>> ---
>>   drivers/staging/rtl8723bs/core/rtw_ap.c | 22 ++++++++++++++--------
>>   1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
>> index 4dab4d741675..ca6fec52d213 100644
>> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
>> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
>> @@ -278,11 +278,13 @@ void expire_timeout_chk(struct adapter *padapter)
>>   
>>   			if (psta->state & WIFI_SLEEP_STATE) {
>>   				if (!(psta->state & WIFI_STA_ALIVE_CHK_STATE)) {
>> -					/* to check if alive by another methods if station is at ps mode. */
>> +					/* to check if alive by another methods */
>> +					/* if station is at ps mode. */
>>   					psta->expire_to = pstapriv->expire_to;
>>   					psta->state |= WIFI_STA_ALIVE_CHK_STATE;
>>   
>> -					/* DBG_871X("alive chk, sta:%pM is at ps mode!\n", MAC_ARG(psta->hwaddr)); */
>> +					/* DBG_871X("alive chk, sta:%pM is at ps */
>> +					/* mode!\n", MAC_ARG(psta->hwaddr)); */
> You just wrapped a code line :(
>
> Just remove it, it's not needed.
Sorry! Yesterday I didn't realize that it was a code line. I will remove it.
>
>
>>   
>>   					/* to update bcn with tim_bitmap for this station */
>>   					pstapriv->tim_bitmap |= BIT(psta->aid);
>> @@ -309,7 +311,8 @@ void expire_timeout_chk(struct adapter *padapter)
>>   			);
>>   			updated = ap_free_sta(padapter, psta, false, WLAN_REASON_DEAUTH_LEAVING);
>>   		} else {
>> -			/* TODO: Aging mechanism to digest frames in sleep_q to avoid running out of xmitframe */
>> +			/* TODO: Aging mechanism to digest frames in sleep_q to */
>> +			/* avoid running out of xmitframe */
>>   			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt)
>>   				&& padapter->xmitpriv.free_xmitframe_cnt < ((
>>   					NR_XMITFRAME / pstapriv->asoc_list_cnt
>> @@ -375,7 +378,8 @@ void expire_timeout_chk(struct adapter *padapter)
>>   			if (list_empty(&psta->asoc_list) == false) {
>>   				list_del_init(&psta->asoc_list);
>>   				pstapriv->asoc_list_cnt--;
>> -				updated = ap_free_sta(padapter, psta, false, WLAN_REASON_DEAUTH_LEAVING);
>> +				updated = ap_free_sta(padapter, psta, false,
>> +						      WLAN_REASON_DEAUTH_LEAVING);
>>   			}
>>   			spin_unlock_bh(&pstapriv->asoc_list_lock);
>>   		}
>> @@ -469,7 +473,8 @@ void update_bmc_sta(struct adapter *padapter)
>>   
>>   		memset((void *)&psta->sta_stats, 0, sizeof(struct stainfo_stats));
>>   
>> -		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, because it has been set before this. */
>> +		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, */
>> +		/* because it has been set before this. */
> Again, look at what you are changing to see if it makes sense.
Yesterday had to make sense, but now I saw that was wrong. I will remove it.
>>   
>>   		/* prepare for add_RATid */
>>   		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->SupportedRates);
>> @@ -748,8 +753,8 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
>>   	cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
>>   
>>   	/* check if there is wps ie, */
>> -	/* if there is wpsie in beacon, the hostapd will update beacon twice when stating hostapd, */
>> -	/* and at first time the security ie (RSN/WPA IE) will not include in beacon. */
>> +	/* if there is wpsie in beacon, the hostapd will update beacon twice when stating */
>> +	/* hostapd, and at first time the security ie (RSN/WPA IE) will not include in beacon. */
> These changes do not look correct, you made them longer?

No, I only rearranged the block comment, where I sent the last word in 
the sentence to the next line,

and with that, each sentence stays with less than 100 characters. But I 
will remove it.

>
> thanks,
Thank you for to review, once more I will have more attention to my changes.
> greg k-h
Beatriz Martins de Carvalho
