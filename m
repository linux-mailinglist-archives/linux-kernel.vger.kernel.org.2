Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFD13AE95F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFUMrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25320 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229663AbhFUMrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624279540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vQ/JoBU3/ybJjboMbT+AxZ6V14EwkLkTT4g/erlEUpg=;
        b=Hcn1wiV4SPhm+aAXaCgReCYCztmavLAtrpioMda654FCJZi1pLko9lMRUoMMRZWi8AcPx/
        dhViPfA8kApcwZfJ3npam8pnHJ34F+9HkTGTUGkxoJhH3qfZCV/lsu2SCaKZspNk7sikah
        knEIM0e/VGc5zOETPwv2DUONVKkoXOs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-kfQfbN_NPRueX_Af9U-Mdw-1; Mon, 21 Jun 2021 08:45:39 -0400
X-MC-Unique: kfQfbN_NPRueX_Af9U-Mdw-1
Received: by mail-ej1-f71.google.com with SMTP id p5-20020a17090653c5b02903db1cfa514dso6296851ejo.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vQ/JoBU3/ybJjboMbT+AxZ6V14EwkLkTT4g/erlEUpg=;
        b=LLhnkV38pEPYF/533uFa0wAa37K78GQm4M05X1i08VpMWfg4d3zYLUmwxgq2EC/ypc
         T97xs38xVpFEhjvmNuNnH0vISbYNk1MxgHJE5GIFLC92Lh0eugl61R6TNE+455Fi70b8
         IQKtTqRGNQtrLd0LC1AxhCXEwFOhIxSyxh4wdg9qyf0IyzvR1JulaUNWO/6wORfEzerJ
         CH7Y3dQCCEprvXKT8N9QGOwavZO8JqwBfRnnGtj35usewhmKpD4p7O0CfFlwFEvdhikL
         vR91h3bwDW3ufXx1/pRvV/Ukq9NT2ZUa/vkugMAk0HVNpLwB3do4ajVfT4gecJEzmFev
         PTyQ==
X-Gm-Message-State: AOAM530Q5nYay0rNm5fYmHPRfLqcusR6LM3U6ID2VumoXHu9RA19OQMp
        smTYFilZ+Uk528WLNGvMnnUD2KrvEkB0b9SWDfNXAv+m1++JlgGbDlYQrox7le8JdkgMlF0pjCZ
        /7yuB36PLcEl67jiH0r777wlyZwZf2IWT6doXpvGRqK9GEtiP/Tg8ssVG3p65hTo2wT6Uwt9X8q
        Ix
X-Received: by 2002:a17:907:9691:: with SMTP id hd17mr7173744ejc.51.1624279538101;
        Mon, 21 Jun 2021 05:45:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwL49ZQEnBJ0vvPawH8xlMMwBG+a72/WxP9+PZ90pOU1U7nJcp/uCzEcpercJWMw6OTHUOyDA==
X-Received: by 2002:a17:907:9691:: with SMTP id hd17mr7173733ejc.51.1624279537918;
        Mon, 21 Jun 2021 05:45:37 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t17sm11007712edv.75.2021.06.21.05.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 05:45:37 -0700 (PDT)
Subject: Re: [PATCH 12/18] staging: rtl8723bs: remove VHT dead code
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
 <d3f79570088ad339bd80fe9d6b24604ac91ea8d3.1624099126.git.fabioaiuto83@gmail.com>
 <dd0332d7-5d9f-49e5-3fc6-8ae3e623f29c@redhat.com>
 <20210621124102.GB1408@agape.jhs>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <38b8ae09-22a2-79cd-c5c8-9b1fa1e557b8@redhat.com>
Date:   Mon, 21 Jun 2021 14:45:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210621124102.GB1408@agape.jhs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/21/21 2:41 PM, Fabio Aiuto wrote:
> On Mon, Jun 21, 2021 at 11:45:39AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 6/19/21 12:47 PM, Fabio Aiuto wrote:
>>> remove VHT dead code, as the device doesn't support
>>> VHT (which is a 802.11ac capability).
>>>
>>> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
>>> ---
>>>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |   1 -
>>>  drivers/staging/rtl8723bs/hal/hal_com.c       | 241 -----------
>>>  .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 383 +-----------------
>>>  drivers/staging/rtl8723bs/include/hal_com.h   |  62 +--
>>>  .../rtl8723bs/include/hal_com_phycfg.h        |   4 -
>>>  drivers/staging/rtl8723bs/include/ieee80211.h |  45 --
>>>  .../staging/rtl8723bs/include/rtl8723b_xmit.h |  21 -
>>>  drivers/staging/rtl8723bs/include/rtw_ht.h    |   4 -
>>>  8 files changed, 9 insertions(+), 752 deletions(-)
>>>
>>> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
>>> index 285acd3d843b..c128d462c6c7 100644
>>> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
>>> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
>>> @@ -46,7 +46,6 @@ static struct action_handler OnAction_tbl[] = {
>>>  	{RTW_WLAN_CATEGORY_UNPROTECTED_WNM, "ACTION_UNPROTECTED_WNM", &DoReserved},
>>>  	{RTW_WLAN_CATEGORY_SELF_PROTECTED, "ACTION_SELF_PROTECTED", &DoReserved},
>>>  	{RTW_WLAN_CATEGORY_WMM, "ACTION_WMM", &DoReserved},
>>> -	{RTW_WLAN_CATEGORY_VHT, "ACTION_VHT", &DoReserved},
>>>  	{RTW_WLAN_CATEGORY_P2P, "ACTION_P2P", &DoReserved},
>>>  };
>>>  
>>> diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
>>> index 7a88447f8294..eebd48438733 100644
>>> --- a/drivers/staging/rtl8723bs/hal/hal_com.c
>>> +++ b/drivers/staging/rtl8723bs/hal/hal_com.c
>>> @@ -295,126 +295,6 @@ u8 MRateToHwRate(u8 rate)
>>>  	case MGN_MCS31:
>>>  		ret = DESC_RATEMCS31;
>>>  		break;
>>> -	case MGN_VHT1SS_MCS0:
>>> -		ret = DESC_RATEVHTSS1MCS0;
>>> -		break;
>>> -	case MGN_VHT1SS_MCS1:
>>> -		ret = DESC_RATEVHTSS1MCS1;
>>> -		break;
>>> -	case MGN_VHT1SS_MCS2:
>>> -		ret = DESC_RATEVHTSS1MCS2;
>>> -		break;
>>> -	case MGN_VHT1SS_MCS3:
>>> -		ret = DESC_RATEVHTSS1MCS3;
>>> -		break;
>>> -	case MGN_VHT1SS_MCS4:
>>> -		ret = DESC_RATEVHTSS1MCS4;
>>> -		break;
>>> -	case MGN_VHT1SS_MCS5:
>>> -		ret = DESC_RATEVHTSS1MCS5;
>>> -		break;
>>> -	case MGN_VHT1SS_MCS6:
>>> -		ret = DESC_RATEVHTSS1MCS6;
>>> -		break;
>>> -	case MGN_VHT1SS_MCS7:
>>> -		ret = DESC_RATEVHTSS1MCS7;
>>> -		break;
>>> -	case MGN_VHT1SS_MCS8:
>>> -		ret = DESC_RATEVHTSS1MCS8;
>>> -		break;
>>> -	case MGN_VHT1SS_MCS9:
>>> -		ret = DESC_RATEVHTSS1MCS9;
>>> -		break;
>>> -	case MGN_VHT2SS_MCS0:
>>> -		ret = DESC_RATEVHTSS2MCS0;
>>> -		break;
>>> -	case MGN_VHT2SS_MCS1:
>>> -		ret = DESC_RATEVHTSS2MCS1;
>>> -		break;
>>> -	case MGN_VHT2SS_MCS2:
>>> -		ret = DESC_RATEVHTSS2MCS2;
>>> -		break;
>>> -	case MGN_VHT2SS_MCS3:
>>> -		ret = DESC_RATEVHTSS2MCS3;
>>> -		break;
>>> -	case MGN_VHT2SS_MCS4:
>>> -		ret = DESC_RATEVHTSS2MCS4;
>>> -		break;
>>> -	case MGN_VHT2SS_MCS5:
>>> -		ret = DESC_RATEVHTSS2MCS5;
>>> -		break;
>>> -	case MGN_VHT2SS_MCS6:
>>> -		ret = DESC_RATEVHTSS2MCS6;
>>> -		break;
>>> -	case MGN_VHT2SS_MCS7:
>>> -		ret = DESC_RATEVHTSS2MCS7;
>>> -		break;
>>> -	case MGN_VHT2SS_MCS8:
>>> -		ret = DESC_RATEVHTSS2MCS8;
>>> -		break;
>>> -	case MGN_VHT2SS_MCS9:
>>> -		ret = DESC_RATEVHTSS2MCS9;
>>> -		break;
>>> -	case MGN_VHT3SS_MCS0:
>>> -		ret = DESC_RATEVHTSS3MCS0;
>>> -		break;
>>> -	case MGN_VHT3SS_MCS1:
>>> -		ret = DESC_RATEVHTSS3MCS1;
>>> -		break;
>>> -	case MGN_VHT3SS_MCS2:
>>> -		ret = DESC_RATEVHTSS3MCS2;
>>> -		break;
>>> -	case MGN_VHT3SS_MCS3:
>>> -		ret = DESC_RATEVHTSS3MCS3;
>>> -		break;
>>> -	case MGN_VHT3SS_MCS4:
>>> -		ret = DESC_RATEVHTSS3MCS4;
>>> -		break;
>>> -	case MGN_VHT3SS_MCS5:
>>> -		ret = DESC_RATEVHTSS3MCS5;
>>> -		break;
>>> -	case MGN_VHT3SS_MCS6:
>>> -		ret = DESC_RATEVHTSS3MCS6;
>>> -		break;
>>> -	case MGN_VHT3SS_MCS7:
>>> -		ret = DESC_RATEVHTSS3MCS7;
>>> -		break;
>>> -	case MGN_VHT3SS_MCS8:
>>> -		ret = DESC_RATEVHTSS3MCS8;
>>> -		break;
>>> -	case MGN_VHT3SS_MCS9:
>>> -		ret = DESC_RATEVHTSS3MCS9;
>>> -		break;
>>> -	case MGN_VHT4SS_MCS0:
>>> -		ret = DESC_RATEVHTSS4MCS0;
>>> -		break;
>>> -	case MGN_VHT4SS_MCS1:
>>> -		ret = DESC_RATEVHTSS4MCS1;
>>> -		break;
>>> -	case MGN_VHT4SS_MCS2:
>>> -		ret = DESC_RATEVHTSS4MCS2;
>>> -		break;
>>> -	case MGN_VHT4SS_MCS3:
>>> -		ret = DESC_RATEVHTSS4MCS3;
>>> -		break;
>>> -	case MGN_VHT4SS_MCS4:
>>> -		ret = DESC_RATEVHTSS4MCS4;
>>> -		break;
>>> -	case MGN_VHT4SS_MCS5:
>>> -		ret = DESC_RATEVHTSS4MCS5;
>>> -		break;
>>> -	case MGN_VHT4SS_MCS6:
>>> -		ret = DESC_RATEVHTSS4MCS6;
>>> -		break;
>>> -	case MGN_VHT4SS_MCS7:
>>> -		ret = DESC_RATEVHTSS4MCS7;
>>> -		break;
>>> -	case MGN_VHT4SS_MCS8:
>>> -		ret = DESC_RATEVHTSS4MCS8;
>>> -		break;
>>> -	case MGN_VHT4SS_MCS9:
>>> -		ret = DESC_RATEVHTSS4MCS9;
>>> -		break;
>>>  	default:
>>>  		break;
>>>  	}
>>> @@ -559,127 +439,6 @@ u8 HwRateToMRate(u8 rate)
>>>  	case DESC_RATEMCS31:
>>>  		ret_rate = MGN_MCS31;
>>>  		break;
>>> -	case DESC_RATEVHTSS1MCS0:
>>> -		ret_rate = MGN_VHT1SS_MCS0;
>>> -		break;
>>> -	case DESC_RATEVHTSS1MCS1:
>>> -		ret_rate = MGN_VHT1SS_MCS1;
>>> -		break;
>>> -	case DESC_RATEVHTSS1MCS2:
>>> -		ret_rate = MGN_VHT1SS_MCS2;
>>> -		break;
>>> -	case DESC_RATEVHTSS1MCS3:
>>> -		ret_rate = MGN_VHT1SS_MCS3;
>>> -		break;
>>> -	case DESC_RATEVHTSS1MCS4:
>>> -		ret_rate = MGN_VHT1SS_MCS4;
>>> -		break;
>>> -	case DESC_RATEVHTSS1MCS5:
>>> -		ret_rate = MGN_VHT1SS_MCS5;
>>> -		break;
>>> -	case DESC_RATEVHTSS1MCS6:
>>> -		ret_rate = MGN_VHT1SS_MCS6;
>>> -		break;
>>> -	case DESC_RATEVHTSS1MCS7:
>>> -		ret_rate = MGN_VHT1SS_MCS7;
>>> -		break;
>>> -	case DESC_RATEVHTSS1MCS8:
>>> -		ret_rate = MGN_VHT1SS_MCS8;
>>> -		break;
>>> -	case DESC_RATEVHTSS1MCS9:
>>> -		ret_rate = MGN_VHT1SS_MCS9;
>>> -		break;
>>> -	case DESC_RATEVHTSS2MCS0:
>>> -		ret_rate = MGN_VHT2SS_MCS0;
>>> -		break;
>>> -	case DESC_RATEVHTSS2MCS1:
>>> -		ret_rate = MGN_VHT2SS_MCS1;
>>> -		break;
>>> -	case DESC_RATEVHTSS2MCS2:
>>> -		ret_rate = MGN_VHT2SS_MCS2;
>>> -		break;
>>> -	case DESC_RATEVHTSS2MCS3:
>>> -		ret_rate = MGN_VHT2SS_MCS3;
>>> -		break;
>>> -	case DESC_RATEVHTSS2MCS4:
>>> -		ret_rate = MGN_VHT2SS_MCS4;
>>> -		break;
>>> -	case DESC_RATEVHTSS2MCS5:
>>> -		ret_rate = MGN_VHT2SS_MCS5;
>>> -		break;
>>> -	case DESC_RATEVHTSS2MCS6:
>>> -		ret_rate = MGN_VHT2SS_MCS6;
>>> -		break;
>>> -	case DESC_RATEVHTSS2MCS7:
>>> -		ret_rate = MGN_VHT2SS_MCS7;
>>> -		break;
>>> -	case DESC_RATEVHTSS2MCS8:
>>> -		ret_rate = MGN_VHT2SS_MCS8;
>>> -		break;
>>> -	case DESC_RATEVHTSS2MCS9:
>>> -		ret_rate = MGN_VHT2SS_MCS9;
>>> -		break;
>>> -	case DESC_RATEVHTSS3MCS0:
>>> -		ret_rate = MGN_VHT3SS_MCS0;
>>> -		break;
>>> -	case DESC_RATEVHTSS3MCS1:
>>> -		ret_rate = MGN_VHT3SS_MCS1;
>>> -		break;
>>> -	case DESC_RATEVHTSS3MCS2:
>>> -		ret_rate = MGN_VHT3SS_MCS2;
>>> -		break;
>>> -	case DESC_RATEVHTSS3MCS3:
>>> -		ret_rate = MGN_VHT3SS_MCS3;
>>> -		break;
>>> -	case DESC_RATEVHTSS3MCS4:
>>> -		ret_rate = MGN_VHT3SS_MCS4;
>>> -		break;
>>> -	case DESC_RATEVHTSS3MCS5:
>>> -		ret_rate = MGN_VHT3SS_MCS5;
>>> -		break;
>>> -	case DESC_RATEVHTSS3MCS6:
>>> -		ret_rate = MGN_VHT3SS_MCS6;
>>> -		break;
>>> -	case DESC_RATEVHTSS3MCS7:
>>> -		ret_rate = MGN_VHT3SS_MCS7;
>>> -		break;
>>> -	case DESC_RATEVHTSS3MCS8:
>>> -		ret_rate = MGN_VHT3SS_MCS8;
>>> -		break;
>>> -	case DESC_RATEVHTSS3MCS9:
>>> -		ret_rate = MGN_VHT3SS_MCS9;
>>> -		break;
>>> -	case DESC_RATEVHTSS4MCS0:
>>> -		ret_rate = MGN_VHT4SS_MCS0;
>>> -		break;
>>> -	case DESC_RATEVHTSS4MCS1:
>>> -		ret_rate = MGN_VHT4SS_MCS1;
>>> -		break;
>>> -	case DESC_RATEVHTSS4MCS2:
>>> -		ret_rate = MGN_VHT4SS_MCS2;
>>> -		break;
>>> -	case DESC_RATEVHTSS4MCS3:
>>> -		ret_rate = MGN_VHT4SS_MCS3;
>>> -		break;
>>> -	case DESC_RATEVHTSS4MCS4:
>>> -		ret_rate = MGN_VHT4SS_MCS4;
>>> -		break;
>>> -	case DESC_RATEVHTSS4MCS5:
>>> -		ret_rate = MGN_VHT4SS_MCS5;
>>> -		break;
>>> -	case DESC_RATEVHTSS4MCS6:
>>> -		ret_rate = MGN_VHT4SS_MCS6;
>>> -		break;
>>> -	case DESC_RATEVHTSS4MCS7:
>>> -		ret_rate = MGN_VHT4SS_MCS7;
>>> -		break;
>>> -	case DESC_RATEVHTSS4MCS8:
>>> -		ret_rate = MGN_VHT4SS_MCS8;
>>> -		break;
>>> -	case DESC_RATEVHTSS4MCS9:
>>> -		ret_rate = MGN_VHT4SS_MCS9;
>>> -		break;
>>> -
>>>  	default:
>>>  		break;
>>>  	}
>>> diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
>>> index 395eb3b5af71..bb7941aee0c4 100644
>>> --- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
>>> +++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
>>> @@ -39,18 +39,6 @@ u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 RfPath,
>>>  	case HT_MCS24_MCS31:
>>>  		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][5];
>>>  		break;
>>> -	case VHT_1SSMCS0_1SSMCS9:
>>> -		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][6];
>>> -		break;
>>> -	case VHT_2SSMCS0_2SSMCS9:
>>> -		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][7];
>>> -		break;
>>> -	case VHT_3SSMCS0_3SSMCS9:
>>> -		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][8];
>>> -		break;
>>> -	case VHT_4SSMCS0_4SSMCS9:
>>> -		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][9];
>>> -		break;
>>>  	default:
>>>  		break;
>>>  	}
>>> @@ -91,18 +79,6 @@ phy_SetTxPowerByRateBase(
>>>  	case HT_MCS24_MCS31:
>>>  		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][5] = Value;
>>>  		break;
>>> -	case VHT_1SSMCS0_1SSMCS9:
>>> -		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][6] = Value;
>>> -		break;
>>> -	case VHT_2SSMCS0_2SSMCS9:
>>> -		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][7] = Value;
>>> -		break;
>>> -	case VHT_3SSMCS0_3SSMCS9:
>>> -		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][8] = Value;
>>> -		break;
>>> -	case VHT_4SSMCS0_4SSMCS9:
>>> -		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][9] = Value;
>>> -		break;
>>>  	default:
>>>  		break;
>>>  	}
>>> @@ -131,14 +107,6 @@ struct adapter *padapter
>>>  		base = PHY_GetTxPowerByRate(padapter, path, RF_3TX, MGN_MCS23);
>>>  		phy_SetTxPowerByRateBase(padapter, path, HT_MCS16_MCS23, RF_3TX, base);
>>>  
>>> -		base = PHY_GetTxPowerByRate(padapter, path, RF_1TX, MGN_VHT1SS_MCS7);
>>> -		phy_SetTxPowerByRateBase(padapter, path, VHT_1SSMCS0_1SSMCS9, RF_1TX, base);
>>> -
>>> -		base = PHY_GetTxPowerByRate(padapter, path, RF_2TX, MGN_VHT2SS_MCS7);
>>> -		phy_SetTxPowerByRateBase(padapter, path, VHT_2SSMCS0_2SSMCS9, RF_2TX, base);
>>> -
>>> -		base = PHY_GetTxPowerByRate(padapter, path, RF_3TX, MGN_VHT3SS_MCS7);
>>> -		phy_SetTxPowerByRateBase(padapter, path, VHT_3SSMCS0_3SSMCS9, RF_3TX, base);
>>
>> You are removing a bunch of register writes from a block here, while keeping others,
>> so this does not seem like it is just dead-code removal it feels like you are
>> actually making a functional change.
> 
> You are right, I will fix the changelog in next v2.
> 
>>
>> Perhaps this entire block can never be executed ?
> 
> It think it's executed during hal initialization
> 
>>
>> Or maybe the VHT name used here is misleading and this is also relevant for 2.4 GHZ
>> 40Mhz use ?  Did you test with an access point configured to use 40 MHz channels
>> and then checked that you were actually using a 40MHz channel ?   Note these are
>> quite rare AFAIK because 40 MHz tends to cause even more collosion issues in the
>> already quite full 2.4G spectrum, still if possible you should test this and make
>> sure that it does not regress (with out specifically testing this we might not
>> note regressions for a long time because of 40MHz usage being rare).
>>
> 
> The MCS section involved is from 0 to 9 in a set of up to 4 spatial streams,
> but rtl8723bs works only with 0-7 and 32 MCS rates in both 20 and 40 Mhz
> and multiple spatial streams are not supported.
> 
> So setting something like VHT_{1,2,3}SSMCS0_{1,2,3}SSMCS9 in our case does
> something odd.

Right, but since we don't know what it is actually doing, it would be best
IMHO to just leave this as is. Esp. when the changes cannot be tested
with 40MHZ channel width.

Regards,

Hans

