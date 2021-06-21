Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787143AE967
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhFUMxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhFUMxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:53:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BCCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:51:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i94so19522248wri.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MMEEfUgtslqPXM/ugM1R/x28x+zUCx8TzVeuaDNTqL4=;
        b=nXYn+BSCVW4cb+CI0bs9x0kqR9Q7zSZeMgx4jQe5mf7h58WEPmiFVUISLhj0PAD/67
         tmIlDV6GYbO+Pfzl31BSc0e6jPpsU3A2ou1rlES6iqQLYwfoSZftcrdY2Q6aELBK+972
         bk7c7lntpLUZ2UfpZZmynTCb3FTIGwyHsEJ/BXCLGRAY9ino+NGFS4YJ3jzWxyDJXWEs
         8F4j/TctDT0G5u1qsFU9QjrO+c3vI6m9RDy1pBDO9FluMwPoWf4x9L6QufgNyA3ym+Nm
         p3T6mtryaA8TDCqdygJX6aF1Fz9WMQs0xEqByVlPCSq7sbpn00tkkG+zKaG7PMG6BCoR
         Ul2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MMEEfUgtslqPXM/ugM1R/x28x+zUCx8TzVeuaDNTqL4=;
        b=CHkFQ0M/XudStgvqcavgFKfYitW85vMJO+W/mzQHJzfkW8xhDJs/xfSCaC2bBI9EC4
         g2ihXjuSJbkb9R8d6BpzW6zjLaaY8ClxOY5zDvsFfg2G/INY5V4uFtQzjadel0qnRr6+
         6z+VGGbS+8eYSLZtYWlPYDjjej1G7FCrDNcGpIb5yRKxOlffWc5P2Lrytali+dMi4qjV
         Ko6M5VBWvaVYa/fvgemLFmax8rYkAqphrivOZDIbv8+fElGak1/9EBnmBNjvf/bVm883
         AO/tN18+3D6/O7s+JHjqcP51UTAsl3beeMVHbkxDMMQLfjsWvZopG8GAASzIuP3wGJP8
         CnXg==
X-Gm-Message-State: AOAM5327pK5AlRKqHIA7UZ5T+TZBFNfiNgaa7d9InK5YadeaVCJV8aSN
        xPgCGempjIvw9RyitawkcgE=
X-Google-Smtp-Source: ABdhPJyBGurYgzak6Qx/Z0UiF4JPixKlm7xgbN8SJe7xdV4X4P4uXG9j8fuElmSRzstAy7VUch1iWw==
X-Received: by 2002:adf:fc43:: with SMTP id e3mr28051264wrs.212.1624279863381;
        Mon, 21 Jun 2021 05:51:03 -0700 (PDT)
Received: from agape.jhs ([5.171.73.54])
        by smtp.gmail.com with ESMTPSA id s23sm488988wmh.5.2021.06.21.05.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 05:51:03 -0700 (PDT)
Date:   Mon, 21 Jun 2021 14:51:00 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/18] staging: rtl8723bs: remove VHT dead code
Message-ID: <20210621125100.GE1408@agape.jhs>
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
 <d3f79570088ad339bd80fe9d6b24604ac91ea8d3.1624099126.git.fabioaiuto83@gmail.com>
 <dd0332d7-5d9f-49e5-3fc6-8ae3e623f29c@redhat.com>
 <20210621124102.GB1408@agape.jhs>
 <38b8ae09-22a2-79cd-c5c8-9b1fa1e557b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b8ae09-22a2-79cd-c5c8-9b1fa1e557b8@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 02:45:37PM +0200, Hans de Goede wrote:

Hello Hans,

> Hi,
> 
> On 6/21/21 2:41 PM, Fabio Aiuto wrote:
> > On Mon, Jun 21, 2021 at 11:45:39AM +0200, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 6/19/21 12:47 PM, Fabio Aiuto wrote:
> >>> remove VHT dead code, as the device doesn't support
> >>> VHT (which is a 802.11ac capability).
> >>>
> >>> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> >>> ---
> >>>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |   1 -
> >>>  drivers/staging/rtl8723bs/hal/hal_com.c       | 241 -----------
> >>>  .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 383 +-----------------
> >>>  drivers/staging/rtl8723bs/include/hal_com.h   |  62 +--
> >>>  .../rtl8723bs/include/hal_com_phycfg.h        |   4 -
> >>>  drivers/staging/rtl8723bs/include/ieee80211.h |  45 --
> >>>  .../staging/rtl8723bs/include/rtl8723b_xmit.h |  21 -
> >>>  drivers/staging/rtl8723bs/include/rtw_ht.h    |   4 -
> >>>  8 files changed, 9 insertions(+), 752 deletions(-)
> >>>
> >>> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> >>> index 285acd3d843b..c128d462c6c7 100644
> >>> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> >>> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> >>> @@ -46,7 +46,6 @@ static struct action_handler OnAction_tbl[] = {
> >>>  	{RTW_WLAN_CATEGORY_UNPROTECTED_WNM, "ACTION_UNPROTECTED_WNM", &DoReserved},
> >>>  	{RTW_WLAN_CATEGORY_SELF_PROTECTED, "ACTION_SELF_PROTECTED", &DoReserved},
> >>>  	{RTW_WLAN_CATEGORY_WMM, "ACTION_WMM", &DoReserved},
> >>> -	{RTW_WLAN_CATEGORY_VHT, "ACTION_VHT", &DoReserved},
> >>>  	{RTW_WLAN_CATEGORY_P2P, "ACTION_P2P", &DoReserved},
> >>>  };
> >>>  
> >>> diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
> >>> index 7a88447f8294..eebd48438733 100644
> >>> --- a/drivers/staging/rtl8723bs/hal/hal_com.c
> >>> +++ b/drivers/staging/rtl8723bs/hal/hal_com.c
> >>> @@ -295,126 +295,6 @@ u8 MRateToHwRate(u8 rate)
> >>>  	case MGN_MCS31:
> >>>  		ret = DESC_RATEMCS31;
> >>>  		break;
> >>> -	case MGN_VHT1SS_MCS0:
> >>> -		ret = DESC_RATEVHTSS1MCS0;
> >>> -		break;
> >>> -	case MGN_VHT1SS_MCS1:
> >>> -		ret = DESC_RATEVHTSS1MCS1;
> >>> -		break;
> >>> -	case MGN_VHT1SS_MCS2:
> >>> -		ret = DESC_RATEVHTSS1MCS2;
> >>> -		break;
> >>> -	case MGN_VHT1SS_MCS3:
> >>> -		ret = DESC_RATEVHTSS1MCS3;
> >>> -		break;
> >>> -	case MGN_VHT1SS_MCS4:
> >>> -		ret = DESC_RATEVHTSS1MCS4;
> >>> -		break;
> >>> -	case MGN_VHT1SS_MCS5:
> >>> -		ret = DESC_RATEVHTSS1MCS5;
> >>> -		break;
> >>> -	case MGN_VHT1SS_MCS6:
> >>> -		ret = DESC_RATEVHTSS1MCS6;
> >>> -		break;
> >>> -	case MGN_VHT1SS_MCS7:
> >>> -		ret = DESC_RATEVHTSS1MCS7;
> >>> -		break;
> >>> -	case MGN_VHT1SS_MCS8:
> >>> -		ret = DESC_RATEVHTSS1MCS8;
> >>> -		break;
> >>> -	case MGN_VHT1SS_MCS9:
> >>> -		ret = DESC_RATEVHTSS1MCS9;
> >>> -		break;
> >>> -	case MGN_VHT2SS_MCS0:
> >>> -		ret = DESC_RATEVHTSS2MCS0;
> >>> -		break;
> >>> -	case MGN_VHT2SS_MCS1:
> >>> -		ret = DESC_RATEVHTSS2MCS1;
> >>> -		break;
> >>> -	case MGN_VHT2SS_MCS2:
> >>> -		ret = DESC_RATEVHTSS2MCS2;
> >>> -		break;
> >>> -	case MGN_VHT2SS_MCS3:
> >>> -		ret = DESC_RATEVHTSS2MCS3;
> >>> -		break;
> >>> -	case MGN_VHT2SS_MCS4:
> >>> -		ret = DESC_RATEVHTSS2MCS4;
> >>> -		break;
> >>> -	case MGN_VHT2SS_MCS5:
> >>> -		ret = DESC_RATEVHTSS2MCS5;
> >>> -		break;
> >>> -	case MGN_VHT2SS_MCS6:
> >>> -		ret = DESC_RATEVHTSS2MCS6;
> >>> -		break;
> >>> -	case MGN_VHT2SS_MCS7:
> >>> -		ret = DESC_RATEVHTSS2MCS7;
> >>> -		break;
> >>> -	case MGN_VHT2SS_MCS8:
> >>> -		ret = DESC_RATEVHTSS2MCS8;
> >>> -		break;
> >>> -	case MGN_VHT2SS_MCS9:
> >>> -		ret = DESC_RATEVHTSS2MCS9;
> >>> -		break;
> >>> -	case MGN_VHT3SS_MCS0:
> >>> -		ret = DESC_RATEVHTSS3MCS0;
> >>> -		break;
> >>> -	case MGN_VHT3SS_MCS1:
> >>> -		ret = DESC_RATEVHTSS3MCS1;
> >>> -		break;
> >>> -	case MGN_VHT3SS_MCS2:
> >>> -		ret = DESC_RATEVHTSS3MCS2;
> >>> -		break;
> >>> -	case MGN_VHT3SS_MCS3:
> >>> -		ret = DESC_RATEVHTSS3MCS3;
> >>> -		break;
> >>> -	case MGN_VHT3SS_MCS4:
> >>> -		ret = DESC_RATEVHTSS3MCS4;
> >>> -		break;
> >>> -	case MGN_VHT3SS_MCS5:
> >>> -		ret = DESC_RATEVHTSS3MCS5;
> >>> -		break;
> >>> -	case MGN_VHT3SS_MCS6:
> >>> -		ret = DESC_RATEVHTSS3MCS6;
> >>> -		break;
> >>> -	case MGN_VHT3SS_MCS7:
> >>> -		ret = DESC_RATEVHTSS3MCS7;
> >>> -		break;
> >>> -	case MGN_VHT3SS_MCS8:
> >>> -		ret = DESC_RATEVHTSS3MCS8;
> >>> -		break;
> >>> -	case MGN_VHT3SS_MCS9:
> >>> -		ret = DESC_RATEVHTSS3MCS9;
> >>> -		break;
> >>> -	case MGN_VHT4SS_MCS0:
> >>> -		ret = DESC_RATEVHTSS4MCS0;
> >>> -		break;
> >>> -	case MGN_VHT4SS_MCS1:
> >>> -		ret = DESC_RATEVHTSS4MCS1;
> >>> -		break;
> >>> -	case MGN_VHT4SS_MCS2:
> >>> -		ret = DESC_RATEVHTSS4MCS2;
> >>> -		break;
> >>> -	case MGN_VHT4SS_MCS3:
> >>> -		ret = DESC_RATEVHTSS4MCS3;
> >>> -		break;
> >>> -	case MGN_VHT4SS_MCS4:
> >>> -		ret = DESC_RATEVHTSS4MCS4;
> >>> -		break;
> >>> -	case MGN_VHT4SS_MCS5:
> >>> -		ret = DESC_RATEVHTSS4MCS5;
> >>> -		break;
> >>> -	case MGN_VHT4SS_MCS6:
> >>> -		ret = DESC_RATEVHTSS4MCS6;
> >>> -		break;
> >>> -	case MGN_VHT4SS_MCS7:
> >>> -		ret = DESC_RATEVHTSS4MCS7;
> >>> -		break;
> >>> -	case MGN_VHT4SS_MCS8:
> >>> -		ret = DESC_RATEVHTSS4MCS8;
> >>> -		break;
> >>> -	case MGN_VHT4SS_MCS9:
> >>> -		ret = DESC_RATEVHTSS4MCS9;
> >>> -		break;
> >>>  	default:
> >>>  		break;
> >>>  	}
> >>> @@ -559,127 +439,6 @@ u8 HwRateToMRate(u8 rate)
> >>>  	case DESC_RATEMCS31:
> >>>  		ret_rate = MGN_MCS31;
> >>>  		break;
> >>> -	case DESC_RATEVHTSS1MCS0:
> >>> -		ret_rate = MGN_VHT1SS_MCS0;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS1MCS1:
> >>> -		ret_rate = MGN_VHT1SS_MCS1;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS1MCS2:
> >>> -		ret_rate = MGN_VHT1SS_MCS2;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS1MCS3:
> >>> -		ret_rate = MGN_VHT1SS_MCS3;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS1MCS4:
> >>> -		ret_rate = MGN_VHT1SS_MCS4;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS1MCS5:
> >>> -		ret_rate = MGN_VHT1SS_MCS5;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS1MCS6:
> >>> -		ret_rate = MGN_VHT1SS_MCS6;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS1MCS7:
> >>> -		ret_rate = MGN_VHT1SS_MCS7;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS1MCS8:
> >>> -		ret_rate = MGN_VHT1SS_MCS8;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS1MCS9:
> >>> -		ret_rate = MGN_VHT1SS_MCS9;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS2MCS0:
> >>> -		ret_rate = MGN_VHT2SS_MCS0;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS2MCS1:
> >>> -		ret_rate = MGN_VHT2SS_MCS1;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS2MCS2:
> >>> -		ret_rate = MGN_VHT2SS_MCS2;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS2MCS3:
> >>> -		ret_rate = MGN_VHT2SS_MCS3;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS2MCS4:
> >>> -		ret_rate = MGN_VHT2SS_MCS4;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS2MCS5:
> >>> -		ret_rate = MGN_VHT2SS_MCS5;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS2MCS6:
> >>> -		ret_rate = MGN_VHT2SS_MCS6;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS2MCS7:
> >>> -		ret_rate = MGN_VHT2SS_MCS7;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS2MCS8:
> >>> -		ret_rate = MGN_VHT2SS_MCS8;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS2MCS9:
> >>> -		ret_rate = MGN_VHT2SS_MCS9;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS3MCS0:
> >>> -		ret_rate = MGN_VHT3SS_MCS0;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS3MCS1:
> >>> -		ret_rate = MGN_VHT3SS_MCS1;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS3MCS2:
> >>> -		ret_rate = MGN_VHT3SS_MCS2;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS3MCS3:
> >>> -		ret_rate = MGN_VHT3SS_MCS3;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS3MCS4:
> >>> -		ret_rate = MGN_VHT3SS_MCS4;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS3MCS5:
> >>> -		ret_rate = MGN_VHT3SS_MCS5;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS3MCS6:
> >>> -		ret_rate = MGN_VHT3SS_MCS6;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS3MCS7:
> >>> -		ret_rate = MGN_VHT3SS_MCS7;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS3MCS8:
> >>> -		ret_rate = MGN_VHT3SS_MCS8;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS3MCS9:
> >>> -		ret_rate = MGN_VHT3SS_MCS9;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS4MCS0:
> >>> -		ret_rate = MGN_VHT4SS_MCS0;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS4MCS1:
> >>> -		ret_rate = MGN_VHT4SS_MCS1;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS4MCS2:
> >>> -		ret_rate = MGN_VHT4SS_MCS2;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS4MCS3:
> >>> -		ret_rate = MGN_VHT4SS_MCS3;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS4MCS4:
> >>> -		ret_rate = MGN_VHT4SS_MCS4;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS4MCS5:
> >>> -		ret_rate = MGN_VHT4SS_MCS5;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS4MCS6:
> >>> -		ret_rate = MGN_VHT4SS_MCS6;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS4MCS7:
> >>> -		ret_rate = MGN_VHT4SS_MCS7;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS4MCS8:
> >>> -		ret_rate = MGN_VHT4SS_MCS8;
> >>> -		break;
> >>> -	case DESC_RATEVHTSS4MCS9:
> >>> -		ret_rate = MGN_VHT4SS_MCS9;
> >>> -		break;
> >>> -
> >>>  	default:
> >>>  		break;
> >>>  	}
> >>> diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
> >>> index 395eb3b5af71..bb7941aee0c4 100644
> >>> --- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
> >>> +++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
> >>> @@ -39,18 +39,6 @@ u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 RfPath,
> >>>  	case HT_MCS24_MCS31:
> >>>  		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][5];
> >>>  		break;
> >>> -	case VHT_1SSMCS0_1SSMCS9:
> >>> -		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][6];
> >>> -		break;
> >>> -	case VHT_2SSMCS0_2SSMCS9:
> >>> -		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][7];
> >>> -		break;
> >>> -	case VHT_3SSMCS0_3SSMCS9:
> >>> -		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][8];
> >>> -		break;
> >>> -	case VHT_4SSMCS0_4SSMCS9:
> >>> -		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][9];
> >>> -		break;
> >>>  	default:
> >>>  		break;
> >>>  	}
> >>> @@ -91,18 +79,6 @@ phy_SetTxPowerByRateBase(
> >>>  	case HT_MCS24_MCS31:
> >>>  		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][5] = Value;
> >>>  		break;
> >>> -	case VHT_1SSMCS0_1SSMCS9:
> >>> -		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][6] = Value;
> >>> -		break;
> >>> -	case VHT_2SSMCS0_2SSMCS9:
> >>> -		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][7] = Value;
> >>> -		break;
> >>> -	case VHT_3SSMCS0_3SSMCS9:
> >>> -		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][8] = Value;
> >>> -		break;
> >>> -	case VHT_4SSMCS0_4SSMCS9:
> >>> -		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][9] = Value;
> >>> -		break;
> >>>  	default:
> >>>  		break;
> >>>  	}
> >>> @@ -131,14 +107,6 @@ struct adapter *padapter
> >>>  		base = PHY_GetTxPowerByRate(padapter, path, RF_3TX, MGN_MCS23);
> >>>  		phy_SetTxPowerByRateBase(padapter, path, HT_MCS16_MCS23, RF_3TX, base);
> >>>  
> >>> -		base = PHY_GetTxPowerByRate(padapter, path, RF_1TX, MGN_VHT1SS_MCS7);
> >>> -		phy_SetTxPowerByRateBase(padapter, path, VHT_1SSMCS0_1SSMCS9, RF_1TX, base);
> >>> -
> >>> -		base = PHY_GetTxPowerByRate(padapter, path, RF_2TX, MGN_VHT2SS_MCS7);
> >>> -		phy_SetTxPowerByRateBase(padapter, path, VHT_2SSMCS0_2SSMCS9, RF_2TX, base);
> >>> -
> >>> -		base = PHY_GetTxPowerByRate(padapter, path, RF_3TX, MGN_VHT3SS_MCS7);
> >>> -		phy_SetTxPowerByRateBase(padapter, path, VHT_3SSMCS0_3SSMCS9, RF_3TX, base);
> >>
> >> You are removing a bunch of register writes from a block here, while keeping others,
> >> so this does not seem like it is just dead-code removal it feels like you are
> >> actually making a functional change.
> > 
> > You are right, I will fix the changelog in next v2.
> > 
> >>
> >> Perhaps this entire block can never be executed ?
> > 
> > It think it's executed during hal initialization
> > 
> >>
> >> Or maybe the VHT name used here is misleading and this is also relevant for 2.4 GHZ
> >> 40Mhz use ?  Did you test with an access point configured to use 40 MHz channels
> >> and then checked that you were actually using a 40MHz channel ?   Note these are
> >> quite rare AFAIK because 40 MHz tends to cause even more collosion issues in the
> >> already quite full 2.4G spectrum, still if possible you should test this and make
> >> sure that it does not regress (with out specifically testing this we might not
> >> note regressions for a long time because of 40MHz usage being rare).
> >>
> > 
> > The MCS section involved is from 0 to 9 in a set of up to 4 spatial streams,
> > but rtl8723bs works only with 0-7 and 32 MCS rates in both 20 and 40 Mhz
> > and multiple spatial streams are not supported.
> > 
> > So setting something like VHT_{1,2,3}SSMCS0_{1,2,3}SSMCS9 in our case does
> > something odd.
> 
> Right, but since we don't know what it is actually doing, it would be best
> IMHO to just leave this as is. Esp. when the changes cannot be tested
> with 40MHZ channel width.
> 
> Regards,
> 
> Hans
> 

you are right, will drop this patch as well.

Thank you,

fabio.
