Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D9A44F485
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 19:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhKMSYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 13:24:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:46490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhKMSYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 13:24:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76915610A8;
        Sat, 13 Nov 2021 18:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636827682;
        bh=RJWyVk7zeO4pwTgZnA9PPiSscqWlv3wNVa+yWv4ZXFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oOPVKlRwgTaK+ri3slRKVvBW8ITSwI4tlEjbUCNe4YcH81/Z7seTr9kzbTGIXBk2P
         LNoHnB9KQO6aDc+wnDW6OpsVtzkeBAyiKC62w1eqwY2XE+HCYhVw7gyloknoNH6RL3
         LusG8MORobCqXV65LxHhEpe4uupdT2McQgV/aJkU=
Date:   Sat, 13 Nov 2021 19:21:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        forest@alittletooquiet.net
Subject: Re: [PATCH] staging: vt6655: fix camelcase in wCurrentRate
Message-ID: <YZACH7a6XWmJHMi1@kroah.com>
References: <20211113170942.GA118262@t470p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211113170942.GA118262@t470p>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 06:09:42PM +0100, Alberto Merciai wrote:
> Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
> ---
>  drivers/staging/vt6655/device.h      |   2 +-
>  drivers/staging/vt6655/device_main.c |  12 +--
>  drivers/staging/vt6655/rxtx.c        | 134 +++++++++++++--------------
>  3 files changed, 74 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
> index 29f354ced563..f5dee7ad99cd 100644
> --- a/drivers/staging/vt6655/device.h
> +++ b/drivers/staging/vt6655/device.h
> @@ -208,7 +208,7 @@ struct vnt_private {
>  	unsigned char byPreambleType;
>  	unsigned char byShortPreamble;
>  
> -	unsigned short wCurrentRate;
> +	unsigned short current_rate;
>  	unsigned char byShortRetryLimit;
>  	unsigned char byLongRetryLimit;
>  	enum nl80211_iftype op_mode;
> diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> index 41cbec4134b0..2c5398b128df 100644
> --- a/drivers/staging/vt6655/device_main.c
> +++ b/drivers/staging/vt6655/device_main.c
> @@ -213,7 +213,7 @@ static void device_init_registers(struct vnt_private *priv)
>  
>  	priv->bNonERPPresent = false;
>  	priv->bBarkerPreambleMd = false;
> -	priv->wCurrentRate = RATE_1M;
> +	priv->current_rate = RATE_1M;
>  	priv->byTopOFDMBasicRate = RATE_24M;
>  	priv->byTopCCKBasicRate = RATE_1M;
>  
> @@ -369,7 +369,7 @@ static void device_init_registers(struct vnt_private *priv)
>  
>  	/* Set BB and packet type at the same time. */
>  	/* Set Short Slot Time, xIFS, and RSPINF. */
> -	priv->wCurrentRate = RATE_54M;
> +	priv->current_rate = RATE_54M;
>  
>  	priv->bRadioOff = false;
>  
> @@ -1382,11 +1382,11 @@ static int vnt_config(struct ieee80211_hw *hw, u32 changed)
>  
>  	if (changed & IEEE80211_CONF_CHANGE_POWER) {
>  		if (priv->byBBType == BB_TYPE_11B)
> -			priv->wCurrentRate = RATE_1M;
> +			priv->current_rate = RATE_1M;
>  		else
> -			priv->wCurrentRate = RATE_54M;
> +			priv->current_rate = RATE_54M;
>  
> -		RFbSetPower(priv, priv->wCurrentRate,
> +		RFbSetPower(priv, priv->current_rate,
>  			    conf->chandef.chan->hw_value);
>  	}
>  
> @@ -1448,7 +1448,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
>  	}
>  
>  	if (changed & BSS_CHANGED_TXPOWER)
> -		RFbSetPower(priv, priv->wCurrentRate,
> +		RFbSetPower(priv, priv->current_rate,
>  			    conf->chandef.chan->hw_value);
>  
>  	if (changed & BSS_CHANGED_BEACON_ENABLED) {
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index cfab64d2b312..17795ebcdfbc 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -97,7 +97,7 @@ s_vFillRTSHead(
>  	bool bNeedAck,
>  	bool bDisCRC,
>  	struct ieee80211_hdr *hdr,
> -	unsigned short wCurrentRate,
> +	unsigned short current_rate,
>  	unsigned char byFBOption
>  );
>  
> @@ -114,7 +114,7 @@ s_vGenerateTxParameter(
>  	bool bNeedACK,
>  	unsigned int	uDMAIdx,
>  	void *psEthHeader,
> -	unsigned short wCurrentRate
> +	unsigned short current_rate
>  );
>  
>  static unsigned int
> @@ -136,7 +136,7 @@ s_uFillDataHead(
>  	unsigned int cbLastFragmentSize,
>  	unsigned int uMACfragNum,
>  	unsigned char byFBOption,
> -	unsigned short wCurrentRate,
> +	unsigned short current_rate,
>  	bool is_pspoll
>  );
>  
> @@ -197,7 +197,7 @@ s_uGetRTSCTSRsvTime(
>  	unsigned char byRTSRsvType,
>  	unsigned char byPktType,
>  	unsigned int cbFrameLength,
> -	unsigned short wCurrentRate
> +	unsigned short current_rate
>  )
>  {
>  	unsigned int uRrvTime = 0;
> @@ -206,7 +206,7 @@ s_uGetRTSCTSRsvTime(
>  	unsigned int uAckTime = 0;
>  	unsigned int uDataTime = 0;
>  
> -	uDataTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, cbFrameLength, wCurrentRate);
> +	uDataTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, cbFrameLength, current_rate);
>  	if (byRTSRsvType == 0) { /* RTSTxRrvTime_bb */
>  		uRTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 20, pDevice->byTopCCKBasicRate);
>  		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
> @@ -440,7 +440,7 @@ s_uFillDataHead(
>  	unsigned int cbLastFragmentSize,
>  	unsigned int uMACfragNum,
>  	unsigned char byFBOption,
> -	unsigned short wCurrentRate,
> +	unsigned short current_rate,
>  	bool is_pspoll
>  )
>  {
> @@ -451,7 +451,7 @@ s_uFillDataHead(
>  		if (byFBOption == AUTO_FB_NONE) {
>  			struct vnt_tx_datahead_g *buf = pTxDataHead;
>  			/* Get SignalField, ServiceField & Length */
> -			vnt_get_phy_field(pDevice, cbFrameLength, wCurrentRate,
> +			vnt_get_phy_field(pDevice, cbFrameLength, current_rate,
>  					  byPktType, &buf->a);
>  
>  			vnt_get_phy_field(pDevice, cbFrameLength,
> @@ -467,7 +467,7 @@ s_uFillDataHead(
>  				/* Get Duration and TimeStamp */
>  				buf->duration_a =
>  					cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength,
> -									    byPktType, wCurrentRate, bNeedAck, uFragIdx,
> +									    byPktType, current_rate, bNeedAck, uFragIdx,
>  									    cbLastFragmentSize, uMACfragNum,
>  									    byFBOption));
>  				buf->duration_b =
> @@ -477,7 +477,7 @@ s_uFillDataHead(
>  									    uMACfragNum, byFBOption));
>  			}
>  
> -			buf->time_stamp_off_a = vnt_time_stamp_off(pDevice, wCurrentRate);
> +			buf->time_stamp_off_a = vnt_time_stamp_off(pDevice, current_rate);
>  			buf->time_stamp_off_b = vnt_time_stamp_off(pDevice, pDevice->byTopCCKBasicRate);
>  
>  			return buf->duration_a;
> @@ -485,7 +485,7 @@ s_uFillDataHead(
>  			/* Auto Fallback */
>  			struct vnt_tx_datahead_g_fb *buf = pTxDataHead;
>  			/* Get SignalField, ServiceField & Length */
> -			vnt_get_phy_field(pDevice, cbFrameLength, wCurrentRate,
> +			vnt_get_phy_field(pDevice, cbFrameLength, current_rate,
>  					  byPktType, &buf->a);
>  
>  			vnt_get_phy_field(pDevice, cbFrameLength,
> @@ -493,15 +493,15 @@ s_uFillDataHead(
>  					  PK_TYPE_11B, &buf->b);
>  			/* Get Duration and TimeStamp */
>  			buf->duration_a = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength, byPktType,
> -									      wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
> +									      current_rate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
>  			buf->duration_b = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B, cbFrameLength, PK_TYPE_11B,
>  									       pDevice->byTopCCKBasicRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
>  			buf->duration_a_f0 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0, cbFrameLength, byPktType,
> -										  wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
> +										  current_rate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
>  			buf->duration_a_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1, cbFrameLength, byPktType,
> -										 wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
> +										 current_rate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
>  
> -			buf->time_stamp_off_a = vnt_time_stamp_off(pDevice, wCurrentRate);
> +			buf->time_stamp_off_a = vnt_time_stamp_off(pDevice, current_rate);
>  			buf->time_stamp_off_b = vnt_time_stamp_off(pDevice, pDevice->byTopCCKBasicRate);
>  
>  			return buf->duration_a;
> @@ -511,22 +511,22 @@ s_uFillDataHead(
>  			/* Auto Fallback */
>  			struct vnt_tx_datahead_a_fb *buf = pTxDataHead;
>  			/* Get SignalField, ServiceField & Length */
> -			vnt_get_phy_field(pDevice, cbFrameLength, wCurrentRate,
> +			vnt_get_phy_field(pDevice, cbFrameLength, current_rate,
>  					  byPktType, &buf->a);
>  
>  			/* Get Duration and TimeStampOff */
>  			buf->duration = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength, byPktType,
> -									    wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
> +									    current_rate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
>  			buf->duration_f0 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0, cbFrameLength, byPktType,
> -									       wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
> +									       current_rate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
>  			buf->duration_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1, cbFrameLength, byPktType,
> -										wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
> -			buf->time_stamp_off = vnt_time_stamp_off(pDevice, wCurrentRate);
> +										current_rate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
> +			buf->time_stamp_off = vnt_time_stamp_off(pDevice, current_rate);
>  			return buf->duration;
>  		} else {
>  			struct vnt_tx_datahead_ab *buf = pTxDataHead;
>  			/* Get SignalField, ServiceField & Length */
> -			vnt_get_phy_field(pDevice, cbFrameLength, wCurrentRate,
> +			vnt_get_phy_field(pDevice, cbFrameLength, current_rate,
>  					  byPktType, &buf->ab);
>  
>  			if (is_pspoll) {
> @@ -537,18 +537,18 @@ s_uFillDataHead(
>  				/* Get Duration and TimeStampOff */
>  				buf->duration =
>  					cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength, byPktType,
> -									    wCurrentRate, bNeedAck, uFragIdx,
> +									    current_rate, bNeedAck, uFragIdx,
>  									    cbLastFragmentSize, uMACfragNum,
>  									    byFBOption));
>  			}
>  
> -			buf->time_stamp_off = vnt_time_stamp_off(pDevice, wCurrentRate);
> +			buf->time_stamp_off = vnt_time_stamp_off(pDevice, current_rate);
>  			return buf->duration;
>  		}
>  	} else {
>  		struct vnt_tx_datahead_ab *buf = pTxDataHead;
>  		/* Get SignalField, ServiceField & Length */
> -		vnt_get_phy_field(pDevice, cbFrameLength, wCurrentRate,
> +		vnt_get_phy_field(pDevice, cbFrameLength, current_rate,
>  				  byPktType, &buf->ab);
>  
>  		if (is_pspoll) {
> @@ -559,12 +559,12 @@ s_uFillDataHead(
>  			/* Get Duration and TimeStampOff */
>  			buf->duration =
>  				cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B, cbFrameLength, byPktType,
> -								    wCurrentRate, bNeedAck, uFragIdx,
> +								    current_rate, bNeedAck, uFragIdx,
>  								    cbLastFragmentSize, uMACfragNum,
>  								    byFBOption));
>  		}
>  
> -		buf->time_stamp_off = vnt_time_stamp_off(pDevice, wCurrentRate);
> +		buf->time_stamp_off = vnt_time_stamp_off(pDevice, current_rate);
>  		return buf->duration;
>  	}
>  	return 0;
> @@ -580,7 +580,7 @@ s_vFillRTSHead(
>  	bool bNeedAck,
>  	bool bDisCRC,
>  	struct ieee80211_hdr *hdr,
> -	unsigned short wCurrentRate,
> +	unsigned short current_rate,
>  	unsigned char byFBOption
>  )
>  {
> @@ -620,12 +620,12 @@ s_vFillRTSHead(
>  			buf->duration_aa =
>  				s_uGetRTSCTSDuration(pDevice, RTSDUR_AA,
>  						     cbFrameLength, byPktType,
> -						     wCurrentRate, bNeedAck,
> +						     current_rate, bNeedAck,
>  						     byFBOption);
>  			buf->duration_ba =
>  				s_uGetRTSCTSDuration(pDevice, RTSDUR_BA,
>  						     cbFrameLength, byPktType,
> -						     wCurrentRate, bNeedAck,
> +						     current_rate, bNeedAck,
>  						     byFBOption);
>  
>  			buf->data.duration = buf->duration_aa;
> @@ -655,32 +655,32 @@ s_vFillRTSHead(
>  			buf->duration_aa =
>  				s_uGetRTSCTSDuration(pDevice, RTSDUR_AA,
>  						     cbFrameLength, byPktType,
> -						     wCurrentRate, bNeedAck,
> +						     current_rate, bNeedAck,
>  						     byFBOption);
>  			buf->duration_ba =
>  				s_uGetRTSCTSDuration(pDevice, RTSDUR_BA,
>  						     cbFrameLength, byPktType,
> -						     wCurrentRate, bNeedAck,
> +						     current_rate, bNeedAck,
>  						     byFBOption);
>  			buf->rts_duration_ba_f0 =
>  				s_uGetRTSCTSDuration(pDevice, RTSDUR_BA_F0,
>  						     cbFrameLength, byPktType,
> -						     wCurrentRate, bNeedAck,
> +						     current_rate, bNeedAck,
>  						     byFBOption);
>  			buf->rts_duration_aa_f0 =
>  				s_uGetRTSCTSDuration(pDevice, RTSDUR_AA_F0,
>  						     cbFrameLength, byPktType,
> -						     wCurrentRate, bNeedAck,
> +						     current_rate, bNeedAck,
>  						     byFBOption);
>  			buf->rts_duration_ba_f1 =
>  				s_uGetRTSCTSDuration(pDevice, RTSDUR_BA_F1,
>  						     cbFrameLength, byPktType,
> -						     wCurrentRate, bNeedAck,
> +						     current_rate, bNeedAck,
>  						     byFBOption);
>  			buf->rts_duration_aa_f1 =
>  				s_uGetRTSCTSDuration(pDevice, RTSDUR_AA_F1,
>  						     cbFrameLength, byPktType,
> -						     wCurrentRate, bNeedAck,
> +						     current_rate, bNeedAck,
>  						     byFBOption);
>  			buf->data.duration = buf->duration_aa;
>  			/* Get RTS Frame body */
> @@ -702,7 +702,7 @@ s_vFillRTSHead(
>  			buf->duration =
>  				s_uGetRTSCTSDuration(pDevice, RTSDUR_AA,
>  						     cbFrameLength, byPktType,
> -						     wCurrentRate, bNeedAck,
> +						     current_rate, bNeedAck,
>  						     byFBOption);
>  			buf->data.duration = buf->duration;
>  			/* Get RTS Frame body */
> @@ -722,17 +722,17 @@ s_vFillRTSHead(
>  			buf->duration =
>  				s_uGetRTSCTSDuration(pDevice, RTSDUR_AA,
>  						     cbFrameLength, byPktType,
> -						     wCurrentRate, bNeedAck,
> +						     current_rate, bNeedAck,
>  						     byFBOption);
>  			buf->rts_duration_f0 =
>  				s_uGetRTSCTSDuration(pDevice, RTSDUR_AA_F0,
>  						     cbFrameLength, byPktType,
> -						     wCurrentRate, bNeedAck,
> +						     current_rate, bNeedAck,
>  						     byFBOption);
>  			buf->rts_duration_f1 =
>  				s_uGetRTSCTSDuration(pDevice, RTSDUR_AA_F1,
>  						     cbFrameLength, byPktType,
> -						     wCurrentRate, bNeedAck,
> +						     current_rate, bNeedAck,
>  						     byFBOption);
>  			buf->data.duration = buf->duration;
>  			/* Get RTS Frame body */
> @@ -752,7 +752,7 @@ s_vFillRTSHead(
>  		/* Get Duration */
>  		buf->duration =
>  			s_uGetRTSCTSDuration(pDevice, RTSDUR_BB, cbFrameLength,
> -					     byPktType, wCurrentRate, bNeedAck,
> +					     byPktType, current_rate, bNeedAck,
>  					     byFBOption);
>  
>  		buf->data.duration = buf->duration;
> @@ -775,7 +775,7 @@ s_vFillCTSHead(
>  	unsigned int cbFrameLength,
>  	bool bNeedAck,
>  	bool bDisCRC,
> -	unsigned short wCurrentRate,
> +	unsigned short current_rate,
>  	unsigned char byFBOption
>  )
>  {
> @@ -803,21 +803,21 @@ s_vFillCTSHead(
>  			buf->duration_ba =
>  				s_uGetRTSCTSDuration(pDevice, CTSDUR_BA,
>  						     cbFrameLength, byPktType,
> -						     wCurrentRate, bNeedAck,
> +						     current_rate, bNeedAck,
>  						     byFBOption);
>  
>  			/* Get CTSDuration_ba_f0 */
>  			buf->cts_duration_ba_f0 =
>  				s_uGetRTSCTSDuration(pDevice, CTSDUR_BA_F0,
>  						     cbFrameLength, byPktType,
> -						     wCurrentRate, bNeedAck,
> +						     current_rate, bNeedAck,
>  						     byFBOption);
>  
>  			/* Get CTSDuration_ba_f1 */
>  			buf->cts_duration_ba_f1 =
>  				s_uGetRTSCTSDuration(pDevice, CTSDUR_BA_F1,
>  						     cbFrameLength, byPktType,
> -						     wCurrentRate, bNeedAck,
> +						     current_rate, bNeedAck,
>  						     byFBOption);
>  
>  			/* Get CTS Frame body */
> @@ -842,7 +842,7 @@ s_vFillCTSHead(
>  			buf->duration_ba =
>  				s_uGetRTSCTSDuration(pDevice, CTSDUR_BA,
>  						     cbFrameLength, byPktType,
> -						     wCurrentRate, bNeedAck,
> +						     current_rate, bNeedAck,
>  						     byFBOption);
>  
>  			/* Get CTS Frame body */
> @@ -896,14 +896,14 @@ s_vGenerateTxParameter(
>  	bool bNeedACK,
>  	unsigned int uDMAIdx,
>  	void *psEthHeader,
> -	unsigned short wCurrentRate
> +	unsigned short current_rate
>  )
>  {
>  	u16 fifo_ctl = le16_to_cpu(tx_buffer_head->fifo_ctl);
>  	bool bDisCRC = false;
>  	unsigned char byFBOption = AUTO_FB_NONE;
>  
> -	tx_buffer_head->current_rate = cpu_to_le16(wCurrentRate);
> +	tx_buffer_head->current_rate = cpu_to_le16(current_rate);
>  
>  	if (fifo_ctl & FIFOCTL_CRCDIS)
>  		bDisCRC = true;
> @@ -921,50 +921,50 @@ s_vGenerateTxParameter(
>  			/* Fill RsvTime */
>  			struct vnt_rrv_time_rts *buf = pvRrvTime;
>  
> -			buf->rts_rrv_time_aa = s_uGetRTSCTSRsvTime(pDevice, 2, byPktType, cbFrameSize, wCurrentRate);
> -			buf->rts_rrv_time_ba = s_uGetRTSCTSRsvTime(pDevice, 1, byPktType, cbFrameSize, wCurrentRate);
> -			buf->rts_rrv_time_bb = s_uGetRTSCTSRsvTime(pDevice, 0, byPktType, cbFrameSize, wCurrentRate);
> -			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> +			buf->rts_rrv_time_aa = s_uGetRTSCTSRsvTime(pDevice, 2, byPktType, cbFrameSize, current_rate);
> +			buf->rts_rrv_time_ba = s_uGetRTSCTSRsvTime(pDevice, 1, byPktType, cbFrameSize, current_rate);
> +			buf->rts_rrv_time_bb = s_uGetRTSCTSRsvTime(pDevice, 0, byPktType, cbFrameSize, current_rate);
> +			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, current_rate, bNeedACK);
>  			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
>  
> -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> +			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, current_rate, byFBOption);
>  		} else {/* RTS_needless, PCF mode */
>  			struct vnt_rrv_time_cts *buf = pvRrvTime;
>  
> -			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> +			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, current_rate, bNeedACK);
>  			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
> -			buf->cts_rrv_time_ba = s_uGetRTSCTSRsvTime(pDevice, 3, byPktType, cbFrameSize, wCurrentRate);
> +			buf->cts_rrv_time_ba = s_uGetRTSCTSRsvTime(pDevice, 3, byPktType, cbFrameSize, current_rate);
>  
>  			/* Fill CTS */
> -			s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK, bDisCRC, wCurrentRate, byFBOption);
> +			s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK, bDisCRC, current_rate, byFBOption);
>  		}
>  	} else if (byPktType == PK_TYPE_11A) {
>  		if (pvRTS) {/* RTS_need, non PCF mode */
>  			struct vnt_rrv_time_ab *buf = pvRrvTime;
>  
> -			buf->rts_rrv_time = s_uGetRTSCTSRsvTime(pDevice, 2, byPktType, cbFrameSize, wCurrentRate);
> -			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> +			buf->rts_rrv_time = s_uGetRTSCTSRsvTime(pDevice, 2, byPktType, cbFrameSize, current_rate);
> +			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, current_rate, bNeedACK);
>  
>  			/* Fill RTS */
> -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> +			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, current_rate, byFBOption);
>  		} else if (!pvRTS) {/* RTS_needless, non PCF mode */
>  			struct vnt_rrv_time_ab *buf = pvRrvTime;
>  
> -			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11A, cbFrameSize, wCurrentRate, bNeedACK);
> +			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11A, cbFrameSize, current_rate, bNeedACK);
>  		}
>  	} else if (byPktType == PK_TYPE_11B) {
>  		if (pvRTS) {/* RTS_need, non PCF mode */
>  			struct vnt_rrv_time_ab *buf = pvRrvTime;
>  
> -			buf->rts_rrv_time = s_uGetRTSCTSRsvTime(pDevice, 0, byPktType, cbFrameSize, wCurrentRate);
> -			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
> +			buf->rts_rrv_time = s_uGetRTSCTSRsvTime(pDevice, 0, byPktType, cbFrameSize, current_rate);
> +			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, current_rate, bNeedACK);
>  
>  			/* Fill RTS */
> -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> +			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, current_rate, byFBOption);
>  		} else { /* RTS_needless, non PCF mode */
>  			struct vnt_rrv_time_ab *buf = pvRrvTime;
>  
> -			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
> +			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, current_rate, bNeedACK);
>  		}
>  	}
>  }
> @@ -1126,10 +1126,10 @@ s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
>  
>  	/* Fill FIFO,RrvTime,RTS,and CTS */
>  	s_vGenerateTxParameter(pDevice, byPktType, tx_buffer_head, pvRrvTime, pvRTS, pvCTS,
> -			       cbFrameSize, bNeedACK, uDMAIdx, hdr, pDevice->wCurrentRate);
> +			       cbFrameSize, bNeedACK, uDMAIdx, hdr, pDevice->current_rate);
>  	/* Fill DataHead */
>  	uDuration = s_uFillDataHead(pDevice, byPktType, pvTxDataHd, cbFrameSize, uDMAIdx, bNeedACK,
> -				    0, 0, uMACfragNum, byFBOption, pDevice->wCurrentRate, is_pspoll);
> +				    0, 0, uMACfragNum, byFBOption, pDevice->current_rate, is_pspoll);
>  
>  	hdr->duration_id = uDuration;
>  
> @@ -1240,11 +1240,11 @@ int vnt_generate_fifo_header(struct vnt_private *priv, u32 dma_idx,
>  	rate = ieee80211_get_tx_rate(priv->hw, info);
>  
>  	current_rate = rate->hw_value;
> -	if (priv->wCurrentRate != current_rate &&
> +	if (priv->current_rate != current_rate &&
>  	    !(priv->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)) {
> -		priv->wCurrentRate = current_rate;
> +		priv->current_rate = current_rate;
>  
> -		RFbSetPower(priv, priv->wCurrentRate,
> +		RFbSetPower(priv, priv->current_rate,
>  			    priv->hw->conf.chandef.chan->hw_value);
>  	}
>  
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
