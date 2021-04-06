Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF22B355624
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbhDFOMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236139AbhDFOMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:12:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E4CB613A7;
        Tue,  6 Apr 2021 14:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617718327;
        bh=SkeXr6kmO3TRWmCpzmcCYhbhUeaQPRXZtA7DPBw4ur4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qos20xoLQTARUM1v/Ei2vOg66CGij/FyTkAVkAI6ODbCzRLzX13fgfKsTNgjhGS5w
         DCOxLHSoVndSuhNPi7PTFbOmH4DImO9rovmmISMaeVH3mPzZYRJWVFSj/QXPRG9NxH
         5tVPuUZhoir9WI97DMFKcL83iVv+Tm6aIeTI/IU0=
Date:   Tue, 6 Apr 2021 16:12:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: hal: Add spaces
 around operators
Message-ID: <YGxsNVs+sexiPMJS@kroah.com>
References: <20210406130138.30744-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406130138.30744-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 03:01:38PM +0200, Fabio M. De Francesco wrote:
> Added spaces around operators in file HalBtc8723b1Ant.c. Issue detected
> by checkpatch.pl. Spaces are preferred to improve readibility.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c   | 98 +++++++++----------
>  1 file changed, 49 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
> index 3e794093092b..b2b872016e45 100644
> --- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
> +++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
> @@ -38,7 +38,7 @@ static u8 halbtc8723b1ant_BtRssiState(
>  			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_LOW) ||
>  			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_LOW)
>  		) {
> -			if (btRssi >= (rssiThresh+BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
> +			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
>  
>  				btRssiState = BTC_RSSI_STATE_HIGH;
>  				BTC_PRINT(
> @@ -85,7 +85,7 @@ static u8 halbtc8723b1ant_BtRssiState(
>  			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_LOW) ||
>  			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_LOW)
>  		) {
> -			if (btRssi >= (rssiThresh+BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
> +			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
>  				btRssiState = BTC_RSSI_STATE_MEDIUM;
>  				BTC_PRINT(
>  					BTC_MSG_ALGORITHM,
> @@ -104,7 +104,7 @@ static u8 halbtc8723b1ant_BtRssiState(
>  			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_MEDIUM) ||
>  			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_MEDIUM)
>  		) {
> -			if (btRssi >= (rssiThresh1+BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
> +			if (btRssi >= (rssiThresh1 + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
>  				btRssiState = BTC_RSSI_STATE_HIGH;
>  				BTC_PRINT(
>  					BTC_MSG_ALGORITHM,
> @@ -353,11 +353,11 @@ static void halbtc8723b1ant_MonitorBtCtr(struct btc_coexist *pBtCoexist)
>  
>  	u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, regHPTxRx);
>  	regHPTx = u4Tmp & bMaskLWord;
> -	regHPRx = (u4Tmp & bMaskHWord)>>16;
> +	regHPRx = (u4Tmp & bMaskHWord) >> 16;
>  
>  	u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, regLPTxRx);
>  	regLPTx = u4Tmp & bMaskLWord;
> -	regLPRx = (u4Tmp & bMaskHWord)>>16;
> +	regLPRx = (u4Tmp & bMaskHWord) >> 16;
>  
>  	pCoexSta->highPriorityTx = regHPTx;
>  	pCoexSta->highPriorityRx = regHPRx;
> @@ -1317,7 +1317,7 @@ static void halbtc8723b1ant_SetFwPstdma(
>  	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_AP_MODE_ENABLE, &bApEnable);
>  
>  	if (bApEnable) {
> -		if (byte1&BIT4 && !(byte1&BIT5)) {
> +		if (byte1 & BIT4 && !(byte1 & BIT5)) {
>  			BTC_PRINT(
>  				BTC_MSG_INTERFACE,
>  				INTF_NOTIFY,
> @@ -1349,9 +1349,9 @@ static void halbtc8723b1ant_SetFwPstdma(
>  		(
>  			"[BTCoex], PS-TDMA H2C cmd = 0x%x%08x\n",
>  			H2C_Parameter[0],
> -			H2C_Parameter[1]<<24|
> -			H2C_Parameter[2]<<16|
> -			H2C_Parameter[3]<<8|
> +			H2C_Parameter[1] << 24 |
> +			H2C_Parameter[2] << 16 |
> +			H2C_Parameter[3]<< 8 |

Why did you miss the space that is needed here too?

Did you run this patch through checkpatch.pl?

Please do so.

thanks,

greg k-h
