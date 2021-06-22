Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D043B0562
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhFVNCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhFVNCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:02:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85227C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:59:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i94so23541132wri.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZjFhi+3hCr1IhUK/E7TFs3mWD3PYiXYCwiG6KSekop8=;
        b=eB5TYGcLLnUxCE6/3QydIN0vqDg9dmJOh8avkkZlLLEdRtlkAVzYkYADh7Ve3TQO/O
         2Eiu5XTiB8DKUpOt/8OUNf5JUbL4jpUa905pQk+27FeHZcf92f0Z02wwhYm3cvCvl9df
         okAZNDWZx5u+RIQGsRe+1zpic3QFqHigbXXPR9TMNe9+z2KMryJZYnL7sQb2WxHslPIx
         4Ugv2y2YKZGnC27DLMs+sE+cWFthpcdkvBmPiKU6DPifeA8O02ftj3E/q4t9kZ0I1isI
         kBNlos2NjuWULDH95KOq0yHbHboeaC5GusaRVaznpwmrX+KhWdBK4ke8jmB5mn4ECjIW
         Gxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZjFhi+3hCr1IhUK/E7TFs3mWD3PYiXYCwiG6KSekop8=;
        b=HJtCexTQpRSPhUpKcUP6kU7VUGlp4sPUTcu6eCRQpIeJEnqVVKpIyl5cuBRXBNIErg
         3f0QSYBbg925kU6jnXrJiwmWHGt6BUghxkwcErWfzI4zOK1V3XQx621XiW+QMcwdbu/h
         xl7Zb4vbbafohvzXhbJju8bV7MdVpoZJ0ix+HG1R5lstUIM0zKg6sNw+ryu2npg8D2QW
         fTld/DgTkWfcoP9NWM5RcxWoMBa6okcgrUgidJzepSj7pMFsYCTJx7eUhpv7qvwASh2Y
         BoGfhPsTL+ouqr7C8cQWi5EcIlABrv4VjxmLpiG2gOxpqWa3FuDuWXYhKH5SzBs1QgT/
         Sb0w==
X-Gm-Message-State: AOAM530SfDPtAb2JDWHN42tc2f8oy7tpnoVCP61JxfsurEW6v7Than+N
        WS1AnPyV/D4B0kD2uhA8iTI=
X-Google-Smtp-Source: ABdhPJw4DBUNAsYuPpBclreMgeIo6wLuXBHJ3v/5g7QzRs9HjZTBkSBdPQvSq4gmf80JWSregKQjOg==
X-Received: by 2002:adf:de12:: with SMTP id b18mr4622152wrm.322.1624366786116;
        Tue, 22 Jun 2021 05:59:46 -0700 (PDT)
Received: from agape.jhs ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id u15sm2241477wmq.1.2021.06.22.05.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:59:45 -0700 (PDT)
Date:   Tue, 22 Jun 2021 14:59:39 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/17] staging: rtl8723bs: remove all 5Ghz network
 types
Message-ID: <20210622125937.GA1410@agape.jhs>
References: <cover.1624364582.git.fabioaiuto83@gmail.com>
 <96b241e97e425a3115305b3d6658037e1e4c862c.1624364582.git.fabioaiuto83@gmail.com>
 <56ec67b9-a4a3-48ec-efe0-493ddc30365d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ec67b9-a4a3-48ec-efe0-493ddc30365d@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Tue, Jun 22, 2021 at 02:41:02PM +0200, Hans de Goede wrote:
> Hi,
> 
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> > index 23bbdf084631..b0abadd4b4dd 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> > @@ -343,10 +343,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
> >  
> >  	if (pcur_network->Configuration.DSConfig > 14) {
> >  		if (tx_ra_bitmap & 0xffff000)
> > -			sta_band |= WIRELESS_11_5N;
> > -
> > -		if (tx_ra_bitmap & 0xff0)
> > -			sta_band |= WIRELESS_11A;
> > +			sta_band |= WIRELESS_INVALID;
> 
> sta_band will now not be touched if tx_ra_bitmap is say 0x20, where as
> before it would be ore-d with WIRELESS_11A. Please make the or-ing with
> WIRELESS_INVALID unconditional (removing both "if (tx_ra_bitmap & 0x...)"
> checks). Also make sure to reduce the indentation level of the
> sta_band |= WIRELESS_INVALID; by 1 tab when dropping the if.
> 
> Regards,
> 
> Hans

oops, you're right, will fix soon...

thank you,

fabio

> 
> 
> 
> >  	} else {
> >  		if (tx_ra_bitmap & 0xffff000)
> >  			sta_band |= WIRELESS_11_24N;
> > @@ -412,7 +409,7 @@ void update_bmc_sta(struct adapter *padapter)
> >  		} else if (network_type == WIRELESS_INVALID) { /*  error handling */
> >  
> >  			if (pcur_network->Configuration.DSConfig > 14)
> > -				network_type = WIRELESS_11A;
> > +				network_type = WIRELESS_INVALID;
> >  			else
> >  				network_type = WIRELESS_11B;
> >  		}
> > @@ -1115,9 +1112,6 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
> >  	case WIRELESS_11BG_24N:
> >  		pbss_network->NetworkTypeInUse = Ndis802_11OFDM24;
> >  		break;
> > -	case WIRELESS_11A:
> > -		pbss_network->NetworkTypeInUse = Ndis802_11OFDM5;
> > -		break;
> >  	default:
> >  		pbss_network->NetworkTypeInUse = Ndis802_11OFDM24;
> >  		break;
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > index e341789954b9..0f0fcd9dc652 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > @@ -96,10 +96,7 @@ bool rtw_is_cckratesonly_included(u8 *rate)
> >  int rtw_check_network_type(unsigned char *rate, int ratelen, int channel)
> >  {
> >  	if (channel > 14) {
> > -		if (rtw_is_cckrates_included(rate))
> > -			return WIRELESS_INVALID;
> > -		else
> > -			return WIRELESS_11A;
> > +		return WIRELESS_INVALID;
> >  	} else { /*  could be pure B, pure G, or B/G */
> >  		if (rtw_is_cckratesonly_included(rate))
> >  			return WIRELESS_11B;
> > @@ -266,10 +263,6 @@ void rtw_set_supported_rate(u8 *SupportedRates, uint mode)
> >  		break;
> >  
> >  	case WIRELESS_11G:
> > -	case WIRELESS_11A:
> > -	case WIRELESS_11_5N:
> > -	case WIRELESS_11A_5N:/* Todo: no basic rate for ofdm ? */
> > -	case WIRELESS_11_5AC:
> >  		memcpy(SupportedRates, WIFI_OFDMRATES, IEEE80211_NUM_OFDM_RATESLEN);
> >  		break;
> >  
> > @@ -327,14 +320,7 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
> >  	ie = rtw_set_ie(ie, WLAN_EID_SSID, pdev_network->Ssid.SsidLength, pdev_network->Ssid.Ssid, &sz);
> >  
> >  	/* supported rates */
> > -	if (pregistrypriv->wireless_mode == WIRELESS_11ABGN) {
> > -		if (pdev_network->Configuration.DSConfig > 14)
> > -			wireless_mode = WIRELESS_11A_5N;
> > -		else
> > -			wireless_mode = WIRELESS_11BG_24N;
> > -	} else {
> > -		wireless_mode = pregistrypriv->wireless_mode;
> > -	}
> > +	wireless_mode = pregistrypriv->wireless_mode;
> >  
> >  	rtw_set_supported_rate(pdev_network->SupportedRates, wireless_mode);
> >  
> > @@ -359,8 +345,8 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
> >  	}
> >  
> >  	/* HT Cap. */
> > -	if (((pregistrypriv->wireless_mode&WIRELESS_11_5N) || (pregistrypriv->wireless_mode&WIRELESS_11_24N))
> > -		&& (pregistrypriv->ht_enable == true)) {
> > +	if ((pregistrypriv->wireless_mode & WIRELESS_11_24N) &&
> > +	    (pregistrypriv->ht_enable == true)) {
> >  		/* todo: */
> >  	}
> >  
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > index 158f92d4d882..2dd75e007239 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > @@ -2184,16 +2184,6 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
> >  	case WIRELESS_11BG_24N:
> >  		pdev_network->NetworkTypeInUse = (Ndis802_11OFDM24);
> >  		break;
> > -	case WIRELESS_11A:
> > -	case WIRELESS_11A_5N:
> > -		pdev_network->NetworkTypeInUse = (Ndis802_11OFDM5);
> > -		break;
> > -	case WIRELESS_11ABGN:
> > -		if (pregistrypriv->channel > 14)
> > -			pdev_network->NetworkTypeInUse = (Ndis802_11OFDM5);
> > -		else
> > -			pdev_network->NetworkTypeInUse = (Ndis802_11OFDM24);
> > -		break;
> >  	default:
> >  		/*  TODO */
> >  		break;
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> > index 4df3cba97f42..106779fb9fef 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> > @@ -4478,61 +4478,6 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
> >  			}
> >  		}
> >  
> > -		if (pregistrypriv->wireless_mode & WIRELESS_11A) {
> > -			do {
> > -				if ((i == MAX_CHANNEL_NUM) ||
> > -					(chplan_sta[i].ChannelNum == 0))
> > -					break;
> > -
> > -				if ((j == chplan_ap.Len) || (chplan_ap.Channel[j] == 0))
> > -					break;
> > -
> > -				if (chplan_sta[i].ChannelNum == chplan_ap.Channel[j]) {
> > -					chplan_new[k].ChannelNum = chplan_ap.Channel[j];
> > -					chplan_new[k].ScanType = SCAN_ACTIVE;
> > -					i++;
> > -					j++;
> > -					k++;
> > -				} else if (chplan_sta[i].ChannelNum < chplan_ap.Channel[j]) {
> > -					chplan_new[k].ChannelNum = chplan_sta[i].ChannelNum;
> > -/* 					chplan_new[k].ScanType = chplan_sta[i].ScanType; */
> > -					chplan_new[k].ScanType = SCAN_PASSIVE;
> > -					i++;
> > -					k++;
> > -				} else if (chplan_sta[i].ChannelNum > chplan_ap.Channel[j]) {
> > -					chplan_new[k].ChannelNum = chplan_ap.Channel[j];
> > -					chplan_new[k].ScanType = SCAN_ACTIVE;
> > -					j++;
> > -					k++;
> > -				}
> > -			} while (1);
> > -
> > -			/*  change AP not support channel to Passive scan */
> > -			while ((i < MAX_CHANNEL_NUM) && (chplan_sta[i].ChannelNum != 0)) {
> > -				chplan_new[k].ChannelNum = chplan_sta[i].ChannelNum;
> > -/* 				chplan_new[k].ScanType = chplan_sta[i].ScanType; */
> > -				chplan_new[k].ScanType = SCAN_PASSIVE;
> > -				i++;
> > -				k++;
> > -			}
> > -
> > -			/*  add channel AP supported */
> > -			while ((j < chplan_ap.Len) && (chplan_ap.Channel[j] != 0)) {
> > -				chplan_new[k].ChannelNum = chplan_ap.Channel[j];
> > -				chplan_new[k].ScanType = SCAN_ACTIVE;
> > -				j++;
> > -				k++;
> > -			}
> > -		} else {
> > -			/*  keep original STA 5G channel plan */
> > -			while ((i < MAX_CHANNEL_NUM) && (chplan_sta[i].ChannelNum != 0)) {
> > -				chplan_new[k].ChannelNum = chplan_sta[i].ChannelNum;
> > -				chplan_new[k].ScanType = chplan_sta[i].ScanType;
> > -				i++;
> > -				k++;
> > -			}
> > -		}
> > -
> >  		pmlmeext->update_channel_plan_by_ap_done = 1;
> >  	}
> >  
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> > index afabb9d48021..2a47d678de01 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> > @@ -55,9 +55,6 @@ u8 networktype_to_raid_ex(struct adapter *adapter, struct sta_info *psta)
> >  
> >  	if (cur_rf_type == RF_1T1R) {
> >  		rf_type = RF_1T1R;
> > -	} else if (IsSupportedVHT(psta->wireless_mode)) {
> > -		if (psta->ra_mask & 0xffc00000)
> > -			rf_type = RF_2T2R;
> >  	} else if (IsSupportedHT(psta->wireless_mode)) {
> >  		if (psta->ra_mask & 0xfff00000)
> >  			rf_type = RF_2T2R;
> > @@ -67,7 +64,6 @@ u8 networktype_to_raid_ex(struct adapter *adapter, struct sta_info *psta)
> >  	case WIRELESS_11B:
> >  		raid = RATEID_IDX_B;
> >  		break;
> > -	case WIRELESS_11A:
> >  	case WIRELESS_11G:
> >  		raid = RATEID_IDX_G;
> >  		break;
> > @@ -75,8 +71,6 @@ u8 networktype_to_raid_ex(struct adapter *adapter, struct sta_info *psta)
> >  		raid = RATEID_IDX_BG;
> >  		break;
> >  	case WIRELESS_11_24N:
> > -	case WIRELESS_11_5N:
> > -	case WIRELESS_11A_5N:
> >  	case WIRELESS_11G_24N:
> >  		if (rf_type == RF_2T2R)
> >  			raid = RATEID_IDX_GN_N2SS;
> > @@ -827,7 +821,7 @@ void WMMOnAssocRsp(struct adapter *padapter)
> >  
> >  		AIFS = aSifsTime + (2 * pmlmeinfo->slotTime);
> >  
> > -		if (pmlmeext->cur_wireless_mode & (WIRELESS_11G | WIRELESS_11A)) {
> > +		if (pmlmeext->cur_wireless_mode & WIRELESS_11G) {
> >  			ECWMin = 4;
> >  			ECWMax = 10;
> >  		} else if (pmlmeext->cur_wireless_mode & WIRELESS_11B) {
> > @@ -1623,7 +1617,7 @@ void update_capinfo(struct adapter *Adapter, u16 updateCap)
> >  		pmlmeinfo->slotTime = NON_SHORT_SLOT_TIME;
> >  	} else {
> >  		/* Filen: See 802.11-2007 p.90 */
> > -		if (pmlmeext->cur_wireless_mode & (WIRELESS_11_24N | WIRELESS_11A | WIRELESS_11_5N | WIRELESS_11AC)) {
> > +		if (pmlmeext->cur_wireless_mode & (WIRELESS_11_24N)) {
> >  			pmlmeinfo->slotTime = SHORT_SLOT_TIME;
> >  		} else if (pmlmeext->cur_wireless_mode & (WIRELESS_11G)) {
> >  			if ((updateCap & cShortSlotTime) /* && (!(pMgntInfo->pHTInfo->RT2RT_HT_Mode & RT_HT_CAP_USE_LONG_PREAMBLE)) */)
> > @@ -1653,9 +1647,7 @@ void update_wireless_mode(struct adapter *padapter)
> >  	if ((pmlmeinfo->HT_info_enable) && (pmlmeinfo->HT_caps_enable))
> >  		pmlmeinfo->HT_enable = 1;
> >  
> > -	if (pmlmeinfo->VHT_enable)
> > -		network_type = WIRELESS_11AC;
> > -	else if (pmlmeinfo->HT_enable)
> > +	if (pmlmeinfo->HT_enable)
> >  		network_type = WIRELESS_11_24N;
> >  
> >  	if (rtw_is_cckratesonly_included(rate))
> > diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
> > index fa275138c983..bfe0c3a773af 100644
> > --- a/drivers/staging/rtl8723bs/hal/odm.c
> > +++ b/drivers/staging/rtl8723bs/hal/odm.c
> > @@ -377,7 +377,6 @@ u32 ODM_Get_Rate_Bitmap(
> >  		break;
> >  
> >  	case (ODM_WM_G):
> > -	case (ODM_WM_A):
> >  		if (rssi_level == DM_RATR_STA_HIGH)
> >  			rate_bitmap = 0x00000f00;
> >  		else
> > @@ -396,7 +395,6 @@ u32 ODM_Get_Rate_Bitmap(
> >  	case (ODM_WM_B|ODM_WM_G|ODM_WM_N24G):
> >  	case (ODM_WM_B|ODM_WM_N24G):
> >  	case (ODM_WM_G|ODM_WM_N24G):
> > -	case (ODM_WM_A|ODM_WM_N5G):
> >  		if (pDM_Odm->RFType == ODM_1T2R || pDM_Odm->RFType == ODM_1T1R) {
> >  			if (rssi_level == DM_RATR_STA_HIGH)
> >  				rate_bitmap = 0x000f0000;
> > @@ -422,34 +420,6 @@ u32 ODM_Get_Rate_Bitmap(
> >  		}
> >  		break;
> >  
> > -	case (ODM_WM_AC|ODM_WM_G):
> > -		if (rssi_level == 1)
> > -			rate_bitmap = 0xfc3f0000;
> > -		else if (rssi_level == 2)
> > -			rate_bitmap = 0xfffff000;
> > -		else
> > -			rate_bitmap = 0xffffffff;
> > -		break;
> > -
> > -	case (ODM_WM_AC|ODM_WM_A):
> > -
> > -		if (pDM_Odm->RFType == RF_1T1R) {
> > -			if (rssi_level == 1)				/*  add by Gary for ac-series */
> > -				rate_bitmap = 0x003f8000;
> > -			else if (rssi_level == 2)
> > -				rate_bitmap = 0x003ff000;
> > -			else
> > -				rate_bitmap = 0x003ff010;
> > -		} else {
> > -			if (rssi_level == 1)				/*  add by Gary for ac-series */
> > -				rate_bitmap = 0xfe3f8000;       /*  VHT 2SS MCS3~9 */
> > -			else if (rssi_level == 2)
> > -				rate_bitmap = 0xfffff000;       /*  VHT 2SS MCS0~9 */
> > -			else
> > -				rate_bitmap = 0xfffff010;       /*  All */
> > -		}
> > -		break;
> > -
> >  	default:
> >  		if (pDM_Odm->RFType == RF_1T2R)
> >  			rate_bitmap = 0x000fffff;
> > diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
> > index 950e7850bac2..7e2d3679c7d0 100644
> > --- a/drivers/staging/rtl8723bs/hal/odm.h
> > +++ b/drivers/staging/rtl8723bs/hal/odm.h
> > @@ -455,11 +455,8 @@ enum { /* tag_Wireless_Mode_Definition */
> >  	ODM_WM_UNKNOWN    = 0x0,
> >  	ODM_WM_B          = BIT0,
> >  	ODM_WM_G          = BIT1,
> > -	ODM_WM_A          = BIT2,
> >  	ODM_WM_N24G       = BIT3,
> > -	ODM_WM_N5G        = BIT4,
> >  	ODM_WM_AUTO       = BIT5,
> > -	ODM_WM_AC         = BIT6,
> >  };
> >  
> >  /*  ODM_CMNINFO_BAND */
> > diff --git a/drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c b/drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c
> > index f3856e47bfd3..578d5712645c 100644
> > --- a/drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c
> > +++ b/drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c
> > @@ -124,12 +124,10 @@ void odm_EdcaTurboCheckCE(void *pDM_VOID)
> >  		} else if ((iot_peer == HT_IOT_PEER_CISCO) &&
> >  			   ((wirelessmode == ODM_WM_G) ||
> >  			    (wirelessmode == (ODM_WM_B | ODM_WM_G)) ||
> > -			    (wirelessmode == ODM_WM_A) ||
> >  			    (wirelessmode == ODM_WM_B))) {
> >  			EDCA_BE_DL = edca_setting_DL_GMode[iot_peer];
> >  		} else if ((iot_peer == HT_IOT_PEER_AIRGO) &&
> > -			   ((wirelessmode == ODM_WM_G) ||
> > -			    (wirelessmode == ODM_WM_A))) {
> > +			   (wirelessmode == ODM_WM_G)) {
> >  			EDCA_BE_DL = 0xa630;
> >  		} else if (iot_peer == HT_IOT_PEER_MARVELL) {
> >  			EDCA_BE_DL = edca_setting_DL[iot_peer];
> > diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > index 3738727feb60..a07a6dacec42 100644
> > --- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > +++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > @@ -512,8 +512,6 @@ static void _InitOperationMode(struct adapter *padapter)
> >  	case WIRELESS_MODE_B:
> >  		regBwOpMode = BW_OPMODE_20MHZ;
> >  		break;
> > -	case WIRELESS_MODE_A:
> > -		break;
> >  	case WIRELESS_MODE_G:
> >  		regBwOpMode = BW_OPMODE_20MHZ;
> >  		break;
> > @@ -525,9 +523,6 @@ static void _InitOperationMode(struct adapter *padapter)
> >  		/*  CCK rate will be filtered out only when associated AP does not support it. */
> >  		regBwOpMode = BW_OPMODE_20MHZ;
> >  		break;
> > -	case WIRELESS_MODE_N_5G:
> > -		regBwOpMode = BW_OPMODE_5G;
> > -		break;
> >  
> >  	default: /* for MacOSX compiler warning. */
> >  		break;
> > diff --git a/drivers/staging/rtl8723bs/include/hal_phy.h b/drivers/staging/rtl8723bs/include/hal_phy.h
> > index 19221289b8ce..6417d1b758d2 100644
> > --- a/drivers/staging/rtl8723bs/include/hal_phy.h
> > +++ b/drivers/staging/rtl8723bs/include/hal_phy.h
> > @@ -51,13 +51,10 @@ enum rf_path {
> >  
> >  enum wireless_mode {
> >  	WIRELESS_MODE_UNKNOWN = 0x00,
> > -	WIRELESS_MODE_A = 0x01,
> >  	WIRELESS_MODE_B = 0x02,
> >  	WIRELESS_MODE_G = 0x04,
> >  	WIRELESS_MODE_AUTO = 0x08,
> >  	WIRELESS_MODE_N_24G = 0x10,
> > -	WIRELESS_MODE_N_5G = 0x20,
> > -	WIRELESS_MODE_AC_5G = 0x40,
> >  	WIRELESS_MODE_AC_24G  = 0x80,
> >  	WIRELESS_MODE_AC_ONLY  = 0x100,
> >  };
> > diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
> > index 6540c7a22938..ac88bd30b097 100644
> > --- a/drivers/staging/rtl8723bs/include/ieee80211.h
> > +++ b/drivers/staging/rtl8723bs/include/ieee80211.h
> > @@ -144,33 +144,20 @@ enum network_type {
> >  	/* Sub-Element */
> >  	WIRELESS_11B = BIT(0), /*  tx: cck only , rx: cck only, hw: cck */
> >  	WIRELESS_11G = BIT(1), /*  tx: ofdm only, rx: ofdm & cck, hw: cck & ofdm */
> > -	WIRELESS_11A = BIT(2), /*  tx: ofdm only, rx: ofdm only, hw: ofdm only */
> >  	WIRELESS_11_24N = BIT(3), /*  tx: MCS only, rx: MCS & cck, hw: MCS & cck */
> > -	WIRELESS_11_5N = BIT(4), /*  tx: MCS only, rx: MCS & ofdm, hw: ofdm only */
> >  	WIRELESS_AUTO = BIT(5),
> > -	WIRELESS_11AC = BIT(6),
> >  
> >  	/* Combination */
> >  	/* Type for current wireless mode */
> >  	WIRELESS_11BG = (WIRELESS_11B|WIRELESS_11G), /*  tx: cck & ofdm, rx: cck & ofdm & MCS, hw: cck & ofdm */
> >  	WIRELESS_11G_24N = (WIRELESS_11G|WIRELESS_11_24N), /*  tx: ofdm & MCS, rx: ofdm & cck & MCS, hw: cck & ofdm */
> > -	WIRELESS_11A_5N = (WIRELESS_11A|WIRELESS_11_5N), /*  tx: ofdm & MCS, rx: ofdm & MCS, hw: ofdm only */
> >  	WIRELESS_11B_24N = (WIRELESS_11B|WIRELESS_11_24N), /*  tx: ofdm & cck & MCS, rx: ofdm & cck & MCS, hw: ofdm & cck */
> >  	WIRELESS_11BG_24N = (WIRELESS_11B|WIRELESS_11G|WIRELESS_11_24N), /*  tx: ofdm & cck & MCS, rx: ofdm & cck & MCS, hw: ofdm & cck */
> > -	WIRELESS_11_24AC = (WIRELESS_11G|WIRELESS_11AC),
> > -	WIRELESS_11_5AC = (WIRELESS_11A|WIRELESS_11AC),
> > -
> > -
> > -	/* Type for registry default wireless mode */
> > -	WIRELESS_11AGN = (WIRELESS_11A|WIRELESS_11G|WIRELESS_11_24N|WIRELESS_11_5N), /*  tx: ofdm & MCS, rx: ofdm & MCS, hw: ofdm only */
> > -	WIRELESS_11ABGN = (WIRELESS_11A|WIRELESS_11B|WIRELESS_11G|WIRELESS_11_24N|WIRELESS_11_5N),
> > -	WIRELESS_MODE_24G = (WIRELESS_11B|WIRELESS_11G|WIRELESS_11_24N|WIRELESS_11AC),
> > -	WIRELESS_MODE_MAX = (WIRELESS_11A|WIRELESS_11B|WIRELESS_11G|WIRELESS_11_24N|WIRELESS_11_5N|WIRELESS_11AC),
> >  };
> >  
> >  #define SUPPORTED_24G_NETTYPE_MSK (WIRELESS_11B | WIRELESS_11G | WIRELESS_11_24N)
> >  
> > -#define IsLegacyOnly(NetType)  ((NetType) == ((NetType) & (WIRELESS_11BG|WIRELESS_11A)))
> > +#define IsLegacyOnly(NetType)  ((NetType) == ((NetType) & (WIRELESS_11BG)))
> >  
> >  #define IsSupported24G(NetType) ((NetType) & SUPPORTED_24G_NETTYPE_MSK ? true : false)
> >  
> > @@ -182,11 +169,8 @@ enum network_type {
> >  #define IsSupportedRxHT(NetType) IsEnableHWOFDM(NetType)
> >  
> >  #define IsSupportedTxCCK(NetType) (((NetType) & (WIRELESS_11B)) ? true : false)
> > -#define IsSupportedTxOFDM(NetType) (((NetType) & (WIRELESS_11G|WIRELESS_11A)) ? true : false)
> > -#define IsSupportedHT(NetType) (((NetType) & (WIRELESS_11_24N|WIRELESS_11_5N)) ? true : false)
> > -
> > -#define IsSupportedVHT(NetType) (((NetType) & (WIRELESS_11AC)) ? true : false)
> > -
> > +#define IsSupportedTxOFDM(NetType) (((NetType) & (WIRELESS_11G) ? true : false)
> > +#define IsSupportedHT(NetType) (((NetType) & (WIRELESS_11_24N)) ? true : false)
> >  
> >  struct ieee_param {
> >  	u32 cmd;
> > diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
> > index 23de3ab87f9c..0bd7b662b972 100644
> > --- a/drivers/staging/rtl8723bs/include/wifi.h
> > +++ b/drivers/staging/rtl8723bs/include/wifi.h
> > @@ -336,7 +336,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
> >  #define _PRE_ALLOCICVHDR_		5
> >  #define _PRE_ALLOCMICHDR_		6
> >  
> > -#define _SIFSTIME_				((priv->pmib->dot11BssType.net_work_type&WIRELESS_11A)?16:10)
> >  #define _ACKCTSLNG_				14	/* 14 bytes long, including crclng */
> >  #define _CRCLNG_				4
> >  
> > diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> > index 11b9a5919da4..4e7c115c8bc1 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> > @@ -22,7 +22,7 @@ static int rtw_lbkmode;/* RTL8712_AIR_TRX; */
> >  static int rtw_network_mode = Ndis802_11IBSS;/* Ndis802_11Infrastructure;infra, ad-hoc, auto */
> >  /* struct ndis_802_11_ssid	ssid; */
> >  static int rtw_channel = 1;/* ad-hoc support requirement */
> > -static int rtw_wireless_mode = WIRELESS_MODE_MAX;
> > +static int rtw_wireless_mode = WIRELESS_11BG_24N;
> >  static int rtw_vrtl_carrier_sense = AUTO_VCS;
> >  static int rtw_vcs_type = RTS_CTS;/*  */
> >  static int rtw_rts_thresh = 2347;/*  */
> > 
> 
