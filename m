Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1834B3559F0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346756AbhDFRFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:05:14 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:1988 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232822AbhDFRFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:05:12 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A4wvUjqA9sjoqaXXlHeiItseALOonbusQ8zAX?=
 =?us-ascii?q?/mh6QxBNb4i8n8ehgPwU2XbP+VEscVsL8OruBICrR3TA+ZlppawYOrm/VAfr0V?=
 =?us-ascii?q?HYSr1Kx43k3jHmBmnC5vdQvJ0QBJRWJdXsATFB/KXHySaiFdJI+rS62YCuwdzT?=
 =?us-ascii?q?1nJ8CTxtApsQiztRLia+PglISBJdBZw/faDskPZvgza7Y3wYYoCaKxA+Lor+ju?=
 =?us-ascii?q?bGnp7nfhIKbiRPgGLlsRqS5LH3CBSe1BsFOgk/pIsKy3TPkADy+8yY3c2T9x7G?=
 =?us-ascii?q?22ffq7RQldfxo+EiOOWwi9MYIjiptwCwZI4JYdy/lQ0yydvC1H8a1P335zswNc?=
 =?us-ascii?q?V67H3cOkuvpwH24hLt1DY152Wn4UOEgFP4yPaJBw4SOo5kv8Z0YxHZ400vsJVX?=
 =?us-ascii?q?y6RQxVuDu55WFx/b2Azg+tntWxtqnk21u35Kq59Qs1VvFa8lLJNBp40W+01YVL?=
 =?us-ascii?q?0aGjjh0ZsqFOl1ANuZzOpKcGmdc2vSsgBUsZmRd0V2Oi3DblkJu8ST3TQTtmt+?=
 =?us-ascii?q?1VEg38Aanm0N7tYXYbMs3ZWcDo1Y0JV1CuMGZ6N0A+kMBeGtDHbWeAnBNGKJLU?=
 =?us-ascii?q?6iLosjUki97KLf0fEQ3qWHaZYIxJw9lNDqS1VDr1cod0bvE8GVmKBR+hfWWWOn?=
 =?us-ascii?q?QAn3ws5Q55JFqqTxLYCbdRGreRQLqY+Nsv8fCsrUV7KYI5RNGcb5IW/vA4pSmw?=
 =?us-ascii?q?X4RplJMHEbFNcestEwXVWSrtPXQ7ea7NDzQbL2Hv7AADwkUmTwDj8oRz7oPvxa?=
 =?us-ascii?q?4kSqQHPjxBzcQWnkdEDk+45qGqSyxZlU9KE9cql39iQFg1Ww4c+GbRdYtLYtRV?=
 =?us-ascii?q?BzJLP8nrn+o3K382bO52BiPxpQCVtU+b3sXmhHvxViCTKtTZ8z//GkPUxC1nqO?=
 =?us-ascii?q?IRFyC+nMFhREnk96/aKsI4bV3DslAd68KG6Wy3AC4HGNU4wakqiC4smNQOJkMr?=
 =?us-ascii?q?8WHIhKUSnbHR18nghn7E1ZbhUff1TSEjP1hb/gkYcdA/vHccJgnRyiLsFVo2/O?=
 =?us-ascii?q?rEn0n7B1elIrGxqVFeKHiwcnQDRZwndr9bUEvbaGkTGzbUMineURKjR3GSyqKY?=
 =?us-ascii?q?MDKD7ASJRfm7jtdg01Z3yNnyamhxY6fXev31kOh1bmMTafdZjwcxFgk0Ed9pyv?=
 =?us-ascii?q?3EJ/d22bcU41QGt9q5dBGWPPvWs29uOXeKyp0S+0ZkEZyu8QdBHJCAFiaD9G9p?=
 =?us-ascii?q?SS7lq4iTyCHXIpytEFJerGFokudLnVxzejM4uNmaYaH+JF/ZpsOdz029V7Hd63?=
 =?us-ascii?q?SkuwFnfVGukp0wuaqjIOIy9vskQplvvuxVnk4QGDrTECKMuXBG4ja6AQItma4W?=
 =?us-ascii?q?Shbe2Pyo9FgdU8uvb1Nm3wb9WB2LzGdjIrEGKcnUeGC8UT7bxEt6M7s7V+W7PB?=
 =?us-ascii?q?VyHT6X1B1BIiaMHulE0fR6x/6KvbOpBmetETfy4xxCtlqP2/aG8Q9iDmCO43el?=
 =?us-ascii?q?8gy1XBOcmS3rbOob0zRlGaqBDoIlmZ+S1F9/LDVy+OvIRqSp4YECBzUgwR+X5i?=
 =?us-ascii?q?9OSNe8nsEw2sbfhE50f/GGS6aqVhRK+MHqgwoh5278qTpfKeczP11WnrzHtGC5?=
 =?us-ascii?q?ML11ziYMupRCqQBOZD8rWBSC2xq5rvxPT2sRDaZn+QbV8CiYhMaEoKB/4z8gUK?=
 =?us-ascii?q?vckQySa7Tazlql8klVx+7TlrmkX245Or+mvBAk1KWDep3ql+bH10KXiHjcPM7O?=
 =?us-ascii?q?6C8m/yiQI1kKXrHFtMf91IBtgbRpX2KSArMsQLoLu05cMU819+SQZrAGgmhD/n?=
 =?us-ascii?q?2eR6mb+/xfXJQuXnTWzlIFQb5Fd+d/xJtz1urGwFatO5556meAkbf9R4fccX98?=
 =?us-ascii?q?RTkDhzrEL04EBZZxJxthYw3oWlFC2WA11sUazvl5Dxmh4WueyL7EBvvmxZnhei?=
 =?us-ascii?q?hEuHs1b428aztHxclRyvkiZ37aGGADchiidQsQBqhaRnL3qWSGbpBXeIKkn+wq?=
 =?us-ascii?q?ckMWBsYFpfvtkDnV7GNe0Gh5q+x21roXAnGSA22aisDXuaRjOIF9H8RQraYOid?=
 =?us-ascii?q?EZp3ebJWNWUCJXLta0iBlZQ0Ux7SeNBukh+rgWwDAKCSOqWgJAKRZaN9gJA4Ku?=
 =?us-ascii?q?jpWcqZg8yLyw1Ss3cVpIj/gWaenP1r4diATzQMwO4VYuxsIEOy4Cx80tGPRgrB?=
 =?us-ascii?q?MIgc/THNowXamFllDc5Txx5Q3FITqigREj65Ht+/Rkluozgd1p/iLRdotvqpWJ?=
 =?us-ascii?q?JSqmfOoVmopXnQOkSVKSCXKscw304=3D?=
X-IronPort-AV: E=Sophos;i="5.82,201,1613430000"; 
   d="scan'208";a="501851157"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 19:05:03 +0200
Date:   Tue, 6 Apr 2021 19:05:03 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy-kernel@googlegroups.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: hal: Add spaces
 around operators in HalBtc8723b2Ant.c
In-Reply-To: <20210406170011.20753-1-fmdefrancesco@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2104061903380.16498@hadrien>
References: <20210406170011.20753-1-fmdefrancesco@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-138773298-1617728703=:16498"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-138773298-1617728703=:16498
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 6 Apr 2021, Fabio M. De Francesco wrote:

> Added spaces around operators in file HalBtc8723b2Ant.c. Issue detected
> by checkpatch.pl. Spaces are preferred to improve readibility.

You don't usually need the file name in the subject line or the commit
message.  One can easily see the file from the diffstat below.  The
subject line should be concise, and the log message should focus on what
you have done (briefly) and why.

julia

>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  .../staging/rtl8723bs/hal/HalBtc8723b2Ant.c   | 78 +++++++++----------
>  1 file changed, 39 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
> index 6edaefa47af1..4b570ec75e67 100644
> --- a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
> +++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
> @@ -44,7 +44,7 @@ static u8 halbtc8723b2ant_BtRssiState(
>  			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_LOW) ||
>  			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_LOW)
>  		) {
> -			if (btRssi >= (rssiThresh+BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT)) {
> +			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT)) {
>  				btRssiState = BTC_RSSI_STATE_HIGH;
>  				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_BT_RSSI_STATE, ("[BTCoex], BT Rssi state switch to High\n"));
>  			} else {
> @@ -70,7 +70,7 @@ static u8 halbtc8723b2ant_BtRssiState(
>  			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_LOW) ||
>  			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_LOW)
>  		) {
> -			if (btRssi >= (rssiThresh+BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT)) {
> +			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT)) {
>  				btRssiState = BTC_RSSI_STATE_MEDIUM;
>  				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_BT_RSSI_STATE, ("[BTCoex], BT Rssi state switch to Medium\n"));
>  			} else {
> @@ -81,7 +81,7 @@ static u8 halbtc8723b2ant_BtRssiState(
>  			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_MEDIUM) ||
>  			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_MEDIUM)
>  		) {
> -			if (btRssi >= (rssiThresh1+BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT)) {
> +			if (btRssi >= (rssiThresh1 + BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT)) {
>  				btRssiState = BTC_RSSI_STATE_HIGH;
>  				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_BT_RSSI_STATE, ("[BTCoex], BT Rssi state switch to High\n"));
>  			} else if (btRssi < rssiThresh) {
> @@ -125,7 +125,7 @@ static u8 halbtc8723b2ant_WifiRssiState(
>  			(pCoexSta->preWifiRssiState[index] == BTC_RSSI_STATE_LOW) ||
>  			(pCoexSta->preWifiRssiState[index] == BTC_RSSI_STATE_STAY_LOW)
>  		) {
> -			if (wifiRssi >= (rssiThresh+BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT)) {
> +			if (wifiRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT)) {
>  				wifiRssiState = BTC_RSSI_STATE_HIGH;
>  				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_WIFI_RSSI_STATE, ("[BTCoex], wifi RSSI state switch to High\n"));
>  			} else {
> @@ -151,7 +151,7 @@ static u8 halbtc8723b2ant_WifiRssiState(
>  			(pCoexSta->preWifiRssiState[index] == BTC_RSSI_STATE_LOW) ||
>  			(pCoexSta->preWifiRssiState[index] == BTC_RSSI_STATE_STAY_LOW)
>  		) {
> -			if (wifiRssi >= (rssiThresh+BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT)) {
> +			if (wifiRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT)) {
>  				wifiRssiState = BTC_RSSI_STATE_MEDIUM;
>  				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_WIFI_RSSI_STATE, ("[BTCoex], wifi RSSI state switch to Medium\n"));
>  			} else {
> @@ -162,7 +162,7 @@ static u8 halbtc8723b2ant_WifiRssiState(
>  			(pCoexSta->preWifiRssiState[index] == BTC_RSSI_STATE_MEDIUM) ||
>  			(pCoexSta->preWifiRssiState[index] == BTC_RSSI_STATE_STAY_MEDIUM)
>  		) {
> -			if (wifiRssi >= (rssiThresh1+BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT)) {
> +			if (wifiRssi >= (rssiThresh1 + BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT)) {
>  				wifiRssiState = BTC_RSSI_STATE_HIGH;
>  				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_WIFI_RSSI_STATE, ("[BTCoex], wifi RSSI state switch to High\n"));
>  			} else if (wifiRssi < rssiThresh) {
> @@ -222,11 +222,11 @@ static void halbtc8723b2ant_MonitorBtCtr(struct btc_coexist *pBtCoexist)
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
> @@ -1173,9 +1173,9 @@ static void halbtc8723b2ant_SetFwPstdma(
>  		(
>  			"[BTCoex], FW write 0x60(5bytes) = 0x%x%08x\n",
>  			H2C_Parameter[0],
> -			H2C_Parameter[1]<<24|
> -			H2C_Parameter[2]<<16|
> -			H2C_Parameter[3]<<8|
> +			H2C_Parameter[1] << 24 |
> +			H2C_Parameter[2] << 16 |
> +			H2C_Parameter[3] << 8 |
>  			H2C_Parameter[4]
>  		)
>  	);
> @@ -1691,7 +1691,7 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
>  				if (m >= 20) /* m 最大值 = 20 ' 最大120秒 recheck是否調整 WiFi duration. */
>  					m = 20;
>
> -				n = 3*m;
> +				n = 3 * m;
>  				up = 0;
>  				dn = 0;
>  				WaitCount = 0;
> @@ -1707,7 +1707,7 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
>  			if (m >= 20) /* m 最大值 = 20 ' 最大120秒 recheck是否調整 WiFi duration. */
>  				m = 20;
>
> -			n = 3*m;
> +			n = 3 * m;
>  			up = 0;
>  			dn = 0;
>  			WaitCount = 0;
> @@ -2824,7 +2824,7 @@ void EXhalbtc8723b2ant_PowerOnSetting(struct btc_coexist *pBtCoexist)
>
>  	/*  enable BB, REG_SYS_FUNC_EN such that we can write 0x948 correctly. */
>  	u2Tmp = pBtCoexist->fBtcRead2Byte(pBtCoexist, 0x2);
> -	pBtCoexist->fBtcWrite2Byte(pBtCoexist, 0x2, u2Tmp|BIT0|BIT1);
> +	pBtCoexist->fBtcWrite2Byte(pBtCoexist, 0x2, u2Tmp | BIT0 | BIT1);
>
>  	/*  set GRAN_BT = 1 */
>  	pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x765, 0x18);
> @@ -3019,7 +3019,7 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
>  		cliBuf,
>  		BT_TMP_BUF_SIZE,
>  		"\r\n %-35s = %s", "BT Info A2DP rate", \
> -		(btInfoExt&BIT0) ? "Basic rate" : "EDR rate"
> +		(btInfoExt & BIT0) ? "Basic rate" : "EDR rate"
>  	);
>  	CL_PRINTF(cliBuf);
>
> @@ -3126,7 +3126,7 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
>  		BT_TMP_BUF_SIZE,
>  		"\r\n %-35s = 0x%x/ 0x%x", "0x778/0x880[29:25]", \
>  		u1Tmp[0],
> -		(u4Tmp[0]&0x3e000000) >> 25
> +		(u4Tmp[0] & 0x3e000000) >> 25
>  	);
>  	CL_PRINTF(cliBuf);
>
> @@ -3139,7 +3139,7 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
>  		BT_TMP_BUF_SIZE,
>  		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x948/ 0x67[5] / 0x765", \
>  		u4Tmp[0],
> -		((u1Tmp[0]&0x20)>>5),
> +		((u1Tmp[0] & 0x20) >> 5),
>  		u1Tmp[1]
>  	);
>  	CL_PRINTF(cliBuf);
> @@ -3151,9 +3151,9 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
>  		cliBuf,
>  		BT_TMP_BUF_SIZE,
>  		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x92c[1:0]/ 0x930[7:0]/0x944[1:0]", \
> -		u4Tmp[0]&0x3,
> -		u4Tmp[1]&0xff,
> -		u4Tmp[2]&0x3
> +		u4Tmp[0] & 0x3,
> +		u4Tmp[1] & 0xff,
> +		u4Tmp[2] & 0x3
>  	);
>  	CL_PRINTF(cliBuf);
>
> @@ -3166,10 +3166,10 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
>  		cliBuf,
>  		BT_TMP_BUF_SIZE,
>  		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x/ 0x%x", "0x38[11]/0x40/0x4c[24:23]/0x64[0]", \
> -		((u1Tmp[0] & 0x8)>>3),
> +		((u1Tmp[0] & 0x8) >> 3),
>  		u1Tmp[1],
> -		((u4Tmp[0]&0x01800000)>>23),
> -		u1Tmp[2]&0x1
> +		((u4Tmp[0] & 0x01800000) >> 23),
> +		u1Tmp[2] & 0x1
>  	);
>  	CL_PRINTF(cliBuf);
>
> @@ -3190,7 +3190,7 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
>  		cliBuf,
>  		BT_TMP_BUF_SIZE,
>  		"\r\n %-35s = 0x%x/ 0x%x", "0xc50(dig)/0x49c(null-drop)", \
> -		u4Tmp[0]&0xff,
> +		u4Tmp[0] & 0xff,
>  		u1Tmp[0]
>  	);
>  	CL_PRINTF(cliBuf);
> @@ -3204,10 +3204,10 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
>  	u1Tmp[1] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0xa5c);
>
>  	faOfdm =
> -		((u4Tmp[0]&0xffff0000) >> 16) +
> -		((u4Tmp[1]&0xffff0000) >> 16) +
> +		((u4Tmp[0] & 0xffff0000) >> 16) +
> +		((u4Tmp[1] & 0xffff0000) >> 16) +
>  		(u4Tmp[1] & 0xffff) +  (u4Tmp[2] & 0xffff) + \
> -		((u4Tmp[3]&0xffff0000) >> 16) +
> +		((u4Tmp[3] & 0xffff0000) >> 16) +
>  		(u4Tmp[3] & 0xffff);
>
>  	faCck = (u1Tmp[0] << 8) + u1Tmp[1];
> @@ -3216,7 +3216,7 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
>  		cliBuf,
>  		BT_TMP_BUF_SIZE,
>  		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "OFDM-CCA/OFDM-FA/CCK-FA", \
> -		u4Tmp[0]&0xffff,
> +		u4Tmp[0] & 0xffff,
>  		faOfdm,
>  		faCck
>  	);
> @@ -3344,7 +3344,7 @@ void EXhalbtc8723b2ant_MediaStatusNotify(struct btc_coexist *pBtCoexist, u8 type
>  		ALGO_TRACE_FW_EXEC,
>  		(
>  			"[BTCoex], FW write 0x66 = 0x%x\n",
> -			H2C_Parameter[0]<<16|H2C_Parameter[1]<<8|H2C_Parameter[2]
> +			H2C_Parameter[0] << 16 | H2C_Parameter[1] << 8 | H2C_Parameter[2]
>  		)
>  	);
>
> @@ -3369,7 +3369,7 @@ void EXhalbtc8723b2ant_BtInfoNotify(
>
>  	pCoexSta->bC2hBtInfoReqSent = false;
>
> -	rspSource = tmpBuf[0]&0xf;
> +	rspSource = tmpBuf[0] & 0xf;
>  	if (rspSource >= BT_INFO_SRC_8723B_2ANT_MAX)
>  		rspSource = BT_INFO_SRC_8723B_2ANT_WIFI_FW;
>
> @@ -3381,7 +3381,7 @@ void EXhalbtc8723b2ant_BtInfoNotify(
>  		if (i == 1)
>  			btInfo = tmpBuf[i];
>
> -		if (i == length-1) {
> +		if (i == length - 1) {
>  			BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("0x%02x]\n", tmpBuf[i]));
>  		} else {
>  			BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("0x%02x, ", tmpBuf[i]));
> @@ -3394,13 +3394,13 @@ void EXhalbtc8723b2ant_BtInfoNotify(
>  	}
>
>  	if (BT_INFO_SRC_8723B_2ANT_WIFI_FW != rspSource) {
> -		pCoexSta->btRetryCnt = pCoexSta->btInfoC2h[rspSource][2]&0xf; /* [3:0] */
> +		pCoexSta->btRetryCnt = pCoexSta->btInfoC2h[rspSource][2] & 0xf; /* [3:0] */
>
> -		pCoexSta->btRssi = pCoexSta->btInfoC2h[rspSource][3]*2+10;
> +		pCoexSta->btRssi = pCoexSta->btInfoC2h[rspSource][3] * 2 + 10;
>
>  		pCoexSta->btInfoExt = pCoexSta->btInfoC2h[rspSource][4];
>
> -		pCoexSta->bBtTxRxMask = (pCoexSta->btInfoC2h[rspSource][2]&0x40);
> +		pCoexSta->bBtTxRxMask = (pCoexSta->btInfoC2h[rspSource][2] & 0x40);
>  		pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_BL_BT_TX_RX_MASK, &pCoexSta->bBtTxRxMask);
>  		if (pCoexSta->bBtTxRxMask) {
>  			/* BT into is responded by BT FW and BT RF REG 0x3C != 0x01 => Need to switch BT TRx Mask */
> @@ -3435,7 +3435,7 @@ void EXhalbtc8723b2ant_BtInfoNotify(
>  		pCoexSta->bC2hBtInquiryPage = false;
>
>  	/*  set link exist status */
> -	if (!(btInfo&BT_INFO_8723B_2ANT_B_CONNECTION)) {
> +	if (!(btInfo & BT_INFO_8723B_2ANT_B_CONNECTION)) {
>  		pCoexSta->bBtLinkExist = false;
>  		pCoexSta->bPanExist = false;
>  		pCoexSta->bA2dpExist = false;
> @@ -3463,19 +3463,19 @@ void EXhalbtc8723b2ant_BtInfoNotify(
>
>  	halbtc8723b2ant_UpdateBtLinkInfo(pBtCoexist);
>
> -	if (!(btInfo&BT_INFO_8723B_2ANT_B_CONNECTION)) {
> +	if (!(btInfo & BT_INFO_8723B_2ANT_B_CONNECTION)) {
>  		pCoexDm->btStatus = BT_8723B_2ANT_BT_STATUS_NON_CONNECTED_IDLE;
>  		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT Non-Connected idle!!!\n"));
>  	} else if (btInfo == BT_INFO_8723B_2ANT_B_CONNECTION)	{ /*  connection exists but no busy */
>  		pCoexDm->btStatus = BT_8723B_2ANT_BT_STATUS_CONNECTED_IDLE;
>  		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT Connected-idle!!!\n"));
>  	} else if (
> -		(btInfo&BT_INFO_8723B_2ANT_B_SCO_ESCO) ||
> -		(btInfo&BT_INFO_8723B_2ANT_B_SCO_BUSY)
> +		(btInfo & BT_INFO_8723B_2ANT_B_SCO_ESCO) ||
> +		(btInfo & BT_INFO_8723B_2ANT_B_SCO_BUSY)
>  	) {
>  		pCoexDm->btStatus = BT_8723B_2ANT_BT_STATUS_SCO_BUSY;
>  		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT SCO busy!!!\n"));
> -	} else if (btInfo&BT_INFO_8723B_2ANT_B_ACL_BUSY) {
> +	} else if (btInfo & BT_INFO_8723B_2ANT_B_ACL_BUSY) {
>  		pCoexDm->btStatus = BT_8723B_2ANT_BT_STATUS_ACL_BUSY;
>  		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT ACL busy!!!\n"));
>  	} else {
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20210406170011.20753-1-fmdefrancesco%40gmail.com.
>
--8323329-138773298-1617728703=:16498--
