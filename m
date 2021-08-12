Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA253E9C29
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 04:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbhHLCQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 22:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhHLCQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 22:16:22 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0678BC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 19:15:58 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 108-20020a9d01750000b029050e5cc11ae3so5875423otu.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 19:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yHBUTxTHh5etw1vpA2zdDNr4B6ghSnDojS518C3Ms94=;
        b=TQWd7BNzXwFs4/OmOKeHKSQ2/ahN1uow6hc95GeLPRcVHycp23tA9iDp/KdzaqsLo2
         F7n7nUrUpoyIJjmE0lfStHlDd00EaiafDQ7SNX2fOTH5KEiud1wAbJI51Zo5ms9mx/2X
         37YXPjPOiS1dmaVfLHWUGH4YW+FhLbolGywTUTesrVJSI08ivzONZCBqe0r8ZtizMS+D
         lWbtWSDfr/QfcM34t2FhsB9iGcduuTzLSMK2A+nd1GqYWHOLA4ujvlJ54eO65nQWifMU
         TTASKeAuK7sDAxJ8dKipgR3UQoVY7UyZzHZdF/rJBR6iFldPZwVtK4YXDRfKTcrwvrj4
         qcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yHBUTxTHh5etw1vpA2zdDNr4B6ghSnDojS518C3Ms94=;
        b=JZ1GziXjajK6Mvg032EP+hdM0giqw8PhJTS5DvFwMI363vnJEt2bUTiSu/mW6KdC7B
         pRjYAYSXNbilNpgLAQemsuwONzY56Q/mOZRQQwVkq5LwMT4GflIhGif87aCyCjXn5KPU
         ZDppx4kq1BcLFJgtRuCJ/EyYzxTbRkNo3QSBBbj8XCiYOUq7boqvSBo7o+e64X2hX8RS
         nBz4beLGD1GzckYBCHnOg4nxMt/RSk5JH8krSMkRq9jiXWJx5+y0LL4dmyY2iTQvQehT
         PbSlLxKc4QO6MJiDYEj/up25DifSoXJt7Iw2z55ZoGi4KT3yP97nT5XTNx6a7GIfaThg
         auWA==
X-Gm-Message-State: AOAM532K2shm2CGA+wEhnfyYXLjVGqmbIbDvH3Sv/RGfW/5r2n+MwPO/
        qGmR9MjdiRImh2dHooNH8cOLVaPci2s=
X-Google-Smtp-Source: ABdhPJyexTOoq250RFgwAT2FEbUA5eQD4qLSuU9xE/MGa9q4LwgYQWC4hP2vYKjV95pwXBjpw/pAzg==
X-Received: by 2002:a05:6830:9c8:: with SMTP id y8mr1574710ott.258.1628734557149;
        Wed, 11 Aug 2021 19:15:57 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id j18sm334398ots.10.2021.08.11.19.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 19:15:56 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH 3/3] staging: r8188eu: Remove no more necessary
 definitions and code
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210812002519.23678-1-fmdefrancesco@gmail.com>
 <20210812002519.23678-4-fmdefrancesco@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <d2651174-84b4-1716-ebe3-3de2cb0115e1@lwfinger.net>
Date:   Wed, 11 Aug 2021 21:15:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812002519.23678-4-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 7:25 PM, Fabio M. De Francesco wrote:
> Remove no more necessary further 5GHz related code, along with no
> more used definitions of macro and variables.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_debug.c      | 25 +------------------
>   drivers/staging/r8188eu/core/rtw_ioctl_set.c  |  2 +-
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 13 +++-------
>   drivers/staging/r8188eu/hal/odm.c             | 19 +++-----------
>   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  3 ---
>   .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  4 ---
>   drivers/staging/r8188eu/include/odm.h         |  5 ----
>   .../staging/r8188eu/include/rtl8188e_spec.h   |  5 ----
>   .../staging/r8188eu/include/rtw_mlme_ext.h    |  1 -
>   9 files changed, 8 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_debug.c b/drivers/staging/r8188eu/core/rtw_debug.c
> index e7b088563738..771f62452498 100644
> --- a/drivers/staging/r8188eu/core/rtw_debug.c
> +++ b/drivers/staging/r8188eu/core/rtw_debug.c
> @@ -876,13 +876,11 @@ int proc_get_best_channel(char *page, char **start,
>   	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>   	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
>   	int len = 0;
> -	u32 i, best_channel_24G = 1, best_channel_5G = 36, index_24G = 0, index_5G = 0;
> +	u32 i, best_channel_24G = 1, index_24G = 0;
>   
>   	for (i = 0; pmlmeext->channel_set[i].ChannelNum != 0; i++) {
>   		if (pmlmeext->channel_set[i].ChannelNum == 1)
>   			index_24G = i;
> -		if (pmlmeext->channel_set[i].ChannelNum == 36)
> -			index_5G = i;
>   	}
>   
>   	for (i = 0; pmlmeext->channel_set[i].ChannelNum != 0; i++) {
> @@ -894,32 +892,11 @@ int proc_get_best_channel(char *page, char **start,
>   			}
>   		}
>   
> -		/*  5G */
> -		if (pmlmeext->channel_set[i].ChannelNum >= 36 &&
> -		    pmlmeext->channel_set[i].ChannelNum < 140) {
> -			 /*  Find primary channel */
> -			if (((pmlmeext->channel_set[i].ChannelNum - 36) % 8 == 0) &&
> -			    (pmlmeext->channel_set[i].rx_count < pmlmeext->channel_set[index_5G].rx_count)) {
> -				index_5G = i;
> -				best_channel_5G = pmlmeext->channel_set[i].ChannelNum;
> -			}
> -		}
> -
> -		if (pmlmeext->channel_set[i].ChannelNum >= 149 &&
> -		    pmlmeext->channel_set[i].ChannelNum < 165) {
> -			 /*  find primary channel */
> -			if (((pmlmeext->channel_set[i].ChannelNum - 149) % 8 == 0) &&
> -			    (pmlmeext->channel_set[i].rx_count < pmlmeext->channel_set[index_5G].rx_count)) {
> -				index_5G = i;
> -				best_channel_5G = pmlmeext->channel_set[i].ChannelNum;
> -			}
> -		}
>   		/*  debug */
>   		len += snprintf(page + len, count - len, "The rx cnt of channel %3d = %d\n",
>   					pmlmeext->channel_set[i].ChannelNum, pmlmeext->channel_set[i].rx_count);
>   	}
>   
> -	len += snprintf(page + len, count - len, "best_channel_5G = %d\n", best_channel_5G);
>   	len += snprintf(page + len, count - len, "best_channel_24G = %d\n", best_channel_24G);
>   
>   	*eof = 1;
> diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> index 8b2f5ace1d86..edcac238076a 100644
> --- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> +++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> @@ -870,7 +870,7 @@ int rtw_set_channel_plan(struct adapter *adapter, u8 channel_plan)
>   */
>   int rtw_set_country(struct adapter *adapter, const char *country_code)
>   {
> -	int channel_plan = RT_CHANNEL_DOMAIN_WORLD_WIDE_5G;
> +	int channel_plan = RT_CHANNEL_DOMAIN_GLOBAL_DOAMIN_2G;
>   
>   	DBG_88E("%s country_code:%s\n", __func__, country_code);
>   
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index 967c7574215a..17e7d33a80c4 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -104,7 +104,6 @@ static struct rt_channel_plan_map	RTW_ChannelPlanMap[RT_CHANNEL_DOMAIN_MAX] = {
>   	{0x01},	/* 0x10, RT_CHANNEL_DOMAIN_JAPAN */
>   	{0x02},	/* 0x11, RT_CHANNEL_DOMAIN_FCC_NO_DFS */
>   	{0x01},	/* 0x12, RT_CHANNEL_DOMAIN_JAPAN_NO_DFS */
> -	{0x00},	/* 0x13, RT_CHANNEL_DOMAIN_WORLD_WIDE_5G */
>   	{0x02},	/* 0x14, RT_CHANNEL_DOMAIN_TAIWAN_NO_DFS */
>   	{0x00},	/* 0x15, RT_CHANNEL_DOMAIN_ETSI_NO_DFS */
>   	{0x00},	/* 0x16, RT_CHANNEL_DOMAIN_KOREA_NO_DFS */
> @@ -116,7 +115,6 @@ static struct rt_channel_plan_map	RTW_ChannelPlanMap[RT_CHANNEL_DOMAIN_MAX] = {
>   	{0x00},	/* 0x1C, */
>   	{0x00},	/* 0x1D, */
>   	{0x00},	/* 0x1E, */
> -	{0x05},	/* 0x1F, RT_CHANNEL_DOMAIN_WORLD_WIDE_ONLY_5G */
>   	/*  0x20 ~ 0x7F , New Define ===== */
>   	{0x00},	/* 0x20, RT_CHANNEL_DOMAIN_WORLD_NULL */
>   	{0x01},	/* 0x21, RT_CHANNEL_DOMAIN_ETSI1_NULL */
> @@ -6813,11 +6811,7 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
>   			p++;
>   
>   			for (j = 0; j < noc; j++) {
> -				if (fcn <= 14)
> -					channel = fcn + j; /*  2.4 GHz */
> -				else
> -					channel = fcn + j*4; /*  5 GHz */
> -
> +				channel = fcn + j;
>   				chplan_ap.Channel[i++] = channel;
>   			}
>   		}
> @@ -6834,11 +6828,10 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
>   		if (pregistrypriv->wireless_mode & WIRELESS_11G) {
>   			do {
>   				if ((i == MAX_CHANNEL_NUM) ||
> -				    (chplan_sta[i].ChannelNum == 0) ||
> -				    (chplan_sta[i].ChannelNum > 14))
> +				    (chplan_sta[i].ChannelNum == 0))
>   					break;
>   
> -				if ((j == chplan_ap.Len) || (chplan_ap.Channel[j] > 14))
> +				if (j == chplan_ap.Len)
>   					break;
>   
>   				if (chplan_sta[i].ChannelNum == chplan_ap.Channel[j]) {
> diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
> index 2fd20339460f..3c793852939d 100644
> --- a/drivers/staging/r8188eu/hal/odm.c
> +++ b/drivers/staging/r8188eu/hal/odm.c
> @@ -621,15 +621,9 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
>   				FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_1);
>   			}
>   		} else {
> -			if (*pDM_Odm->pBandType == ODM_BAND_5G) {
> -				DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_0;
> -				FirstConnect = (pDM_Odm->bLinked) && (!pDM_DigTable->bMediaConnect_0);
> -				FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_0);
> -			} else {
> -				DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_1;
> -				FirstConnect = (pDM_Odm->bLinked) && (!pDM_DigTable->bMediaConnect_1);
> -				FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_1);
> -			}
> +			DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_1;
> +			FirstConnect = (pDM_Odm->bLinked) && (!pDM_DigTable->bMediaConnect_1);
> +			FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_1);
>   		}
>   	} else {
>   		DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_0;
> @@ -1094,12 +1088,6 @@ u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid, u32 ra_mask, u
>   		else
>   			rate_bitmap = 0x0000000f;
>   		break;
> -	case (ODM_WM_A|ODM_WM_G):
> -		if (rssi_level == DM_RATR_STA_HIGH)
> -			rate_bitmap = 0x00000f00;
> -		else
> -			rate_bitmap = 0x00000ff0;
> -		break;
>   	case (ODM_WM_B|ODM_WM_G):
>   		if (rssi_level == DM_RATR_STA_HIGH)
>   			rate_bitmap = 0x00000f00;
> @@ -1109,7 +1097,6 @@ u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid, u32 ra_mask, u
>   			rate_bitmap = 0x00000ff5;
>   		break;
>   	case (ODM_WM_B|ODM_WM_G|ODM_WM_N24G):
> -	case (ODM_WM_A|ODM_WM_B|ODM_WM_G|ODM_WM_N24G):
>   		if (pDM_Odm->RFType == ODM_1T2R || pDM_Odm->RFType == ODM_1T1R) {
>   			if (rssi_level == DM_RATR_STA_HIGH) {
>   				rate_bitmap = 0x000f0000;
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
> index f7b6402e1cd2..02955b8c4005 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
> @@ -1026,9 +1026,6 @@ _PHY_SetBWMode92C(
>   	case RF_8256:
>   		/*  Please implement this function in Hal8190PciPhy8256.c */
>   		break;
> -	case RF_8258:
> -		/*  Please implement this function in Hal8190PciPhy8258.c */
> -		break;
>   	case RF_PSEUDO_11N:
>   		break;
>   	case RF_6052:
> diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
> index 96888d66d28c..4370ec2fa981 100644
> --- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
> +++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
> @@ -67,13 +67,10 @@ enum rf_radio_path {
>   
>   enum wireless_mode {
>   	WIRELESS_MODE_UNKNOWN = 0x00,
> -	WIRELESS_MODE_A			= BIT(2),
>   	WIRELESS_MODE_B			= BIT(0),
>   	WIRELESS_MODE_G			= BIT(1),
>   	WIRELESS_MODE_AUTO		= BIT(5),
>   	WIRELESS_MODE_N_24G		= BIT(3),
> -	WIRELESS_MODE_N_5G		= BIT(4),
> -	WIRELESS_MODE_AC		= BIT(6)
>   };
>   
>   enum phy_rate_tx_offset_area {
> @@ -91,7 +88,6 @@ enum RF_TYPE_8190P {
>   	RF_TYPE_MIN,		/*  0 */
>   	RF_8225 = 1,		/*  1 11b/g RF for verification only */
>   	RF_8256 = 2,		/*  2 11b/g/n */
> -	RF_8258 = 3,		/*  3 11a/b/g/n RF */
>   	RF_6052 = 4,		/*  4 11b/g/n RF */
>   	/*  TODO: We should remove this psudo PHY RF after we get new RF. */
>   	RF_PSEUDO_11N = 5,	/*  5, It is a temporality RF. */
> diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
> index 4dadb22bcc89..19458e66603c 100644
> --- a/drivers/staging/r8188eu/include/odm.h
> +++ b/drivers/staging/r8188eu/include/odm.h
> @@ -531,17 +531,13 @@ enum odm_wireless_mode {
>   	ODM_WM_UNKNOW	= 0x0,
>   	ODM_WM_B	= BIT(0),
>   	ODM_WM_G	= BIT(1),
> -	ODM_WM_A	= BIT(2),
>   	ODM_WM_N24G	= BIT(3),
> -	ODM_WM_N5G	= BIT(4),
>   	ODM_WM_AUTO	= BIT(5),
> -	ODM_WM_AC	= BIT(6),
>   };
>   
>   /*  ODM_CMNINFO_BAND */
>   enum odm_band_type {
>   	ODM_BAND_2_4G	= BIT(0),
> -	ODM_BAND_5G	= BIT(1),
>   };
>   
>   /*  ODM_CMNINFO_SEC_CHNL_OFFSET */
> @@ -933,7 +929,6 @@ enum odm_bb_config_type {
>       CONFIG_BB_PHY_REG,
>       CONFIG_BB_AGC_TAB,
>       CONFIG_BB_AGC_TAB_2G,
> -    CONFIG_BB_AGC_TAB_5G,
>       CONFIG_BB_PHY_REG_PG,
>   };
>   
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
> index 5fdc6aac917c..1c96f7b81245 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
> @@ -523,7 +523,6 @@ Default: 00b.
>   
>   /*        8192C BW_OPMODE bits		(Offset 0x203, 8bit) */
>   #define	BW_OPMODE_20MHZ			BIT(2)
> -#define	BW_OPMODE_5G			BIT(1)
>   
>   /*        8192C CAM Config Setting (offset 0x250, 1 byte) */
>   #define	CAM_VALID			BIT(15)
> @@ -1343,10 +1342,6 @@ Current IOREG MAP
>   #define		EEPROM_DEFAULT_24G_HT20_DIFF	0X02
>   #define		EEPROM_DEFAULT_24G_OFDM_DIFF	0X04
>   
> -#define		EEPROM_DEFAULT_5G_INDEX		0X2A
> -#define		EEPROM_DEFAULT_5G_HT20_DIFF	0X00
> -#define		EEPROM_DEFAULT_5G_OFDM_DIFF	0X04
> -
>   #define		EEPROM_DEFAULT_DIFF		0XFE
>   #define	EEPROM_DEFAULT_CHANNEL_PLAN		0x7F
>   #define	EEPROM_DEFAULT_BOARD_OPTION		0x00
> diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
> index 3b6e3ae92c9f..d2f4d3ce7b90 100644
> --- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
> +++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
> @@ -112,7 +112,6 @@ enum RT_CHANNEL_DOMAIN {
>   	RT_CHANNEL_DOMAIN_JAPAN = 0x10,
>   	RT_CHANNEL_DOMAIN_FCC_NO_DFS = 0x11,
>   	RT_CHANNEL_DOMAIN_JAPAN_NO_DFS = 0x12,
> -	RT_CHANNEL_DOMAIN_WORLD_WIDE_5G = 0x13,
>   	RT_CHANNEL_DOMAIN_TAIWAN_NO_DFS = 0x14,
>   
>   	/*  new channel plan mapping, (2GDOMAIN_5GDOMAIN) ===== */
> 

Looks good.

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

