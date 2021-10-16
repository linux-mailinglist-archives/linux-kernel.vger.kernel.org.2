Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0F8430184
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 11:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243945AbhJPJic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 05:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243936AbhJPJib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 05:38:31 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22F2C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 02:36:22 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mbg6z-00034s-60; Sat, 16 Oct 2021 11:36:17 +0200
Date:   Sat, 16 Oct 2021 11:36:17 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] staging: r8188eu: remove GetPSDData()
Message-ID: <20211016093617.24zs2vg64u62y2w2@viti.kaiser.cx>
References: <20211015163507.9091-1-straube.linux@gmail.com>
 <20211015163507.9091-4-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015163507.9091-4-straube.linux@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> Function GetPSDData() is not used, remove it. It is the only user of
> ConvertTo_dB() and ODM_StallExecution(), remove these two functions
> and the now unused dB_Invert_Table as well.

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/odm.c             | 59 -------------------
>  drivers/staging/r8188eu/hal/odm_interface.c   |  5 --
>  drivers/staging/r8188eu/include/odm.h         |  5 --
>  .../staging/r8188eu/include/odm_interface.h   |  2 -
>  4 files changed, 71 deletions(-)

> diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
> index 030bc7bd9905..28bd6f36cddd 100644
> --- a/drivers/staging/r8188eu/hal/odm.c
> +++ b/drivers/staging/r8188eu/hal/odm.c
> @@ -5,17 +5,6 @@

>  #include "../include/odm_precomp.h"

> -static const u16 dB_Invert_Table[8][12] = {
> -	{1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4},
> -	{4, 5, 6, 6, 7, 8, 9, 10, 11, 13, 14, 16},
> -	{18, 20, 22, 25, 28, 32, 35, 40, 45, 50, 56, 63},
> -	{71, 79, 89, 100, 112, 126, 141, 158, 178, 200, 224, 251},
> -	{282, 316, 355, 398, 447, 501, 562, 631, 708, 794, 891, 1000},
> -	{1122, 1259, 1413, 1585, 1778, 1995, 2239, 2512, 2818, 3162, 3548, 3981},
> -	{4467, 5012, 5623, 6310, 7079, 7943, 8913, 10000, 11220, 12589, 14125, 15849},
> -	{17783, 19953, 22387, 25119, 28184, 31623, 35481, 39811, 44668, 50119, 56234, 65535}
> -};
> -
>  /* avoid to warn in FreeBSD ==> To DO modify */
>  static u32 EDCAParam[HT_IOT_PEER_MAX][3] = {
>  	/*  UL			DL */
> @@ -1142,51 +1131,3 @@ void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm)
>  	pxmitpriv->last_tx_bytes = pxmitpriv->tx_bytes;
>  	precvpriv->last_rx_bytes = precvpriv->rx_bytes;
>  }
> -
> -/*  need to ODM CE Platform */
> -/* move to here for ANT detection mechanism using */
> -
> -u32 GetPSDData(struct odm_dm_struct *pDM_Odm, unsigned int point, u8 initial_gain_psd)
> -{
> -	u32 psd_report;
> -
> -	/* Set DCO frequency index, offset=(40MHz/SamplePts)*point */
> -	ODM_SetBBReg(pDM_Odm, 0x808, 0x3FF, point);
> -
> -	/* Start PSD calculation, Reg808[22]=0->1 */
> -	ODM_SetBBReg(pDM_Odm, 0x808, BIT(22), 1);
> -	/* Need to wait for HW PSD report */
> -	ODM_StallExecution(30);
> -	ODM_SetBBReg(pDM_Odm, 0x808, BIT(22), 0);
> -	/* Read PSD report, Reg8B4[15:0] */
> -	psd_report = ODM_GetBBReg(pDM_Odm, 0x8B4, bMaskDWord) & 0x0000FFFF;
> -
> -	psd_report = (u32)(ConvertTo_dB(psd_report)) + (u32)(initial_gain_psd - 0x1c);
> -
> -	return psd_report;
> -}
> -
> -u32 ConvertTo_dB(u32 Value)
> -{
> -	u8 i;
> -	u8 j;
> -	u32 dB;
> -
> -	Value = Value & 0xFFFF;
> -	for (i = 0; i < 8; i++) {
> -		if (Value <= dB_Invert_Table[i][11])
> -			break;
> -	}
> -
> -	if (i >= 8)
> -		return 96;	/*  maximum 96 dB */
> -
> -	for (j = 0; j < 12; j++) {
> -		if (Value <= dB_Invert_Table[i][j])
> -			break;
> -	}
> -
> -	dB = i * 12 + j + 1;
> -
> -	return dB;
> -}
> diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
> index c97104c3682f..7ddba39a0f4b 100644
> --- a/drivers/staging/r8188eu/hal/odm_interface.c
> +++ b/drivers/staging/r8188eu/hal/odm_interface.c
> @@ -77,11 +77,6 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u
>  }

>  /*  ODM Timer relative API. */
> -void ODM_StallExecution(u32 usDelay)
> -{
> -	udelay(usDelay);
> -}
> -
>  void ODM_delay_ms(u32 ms)
>  {
>  	mdelay(ms);
> diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
> index 21e08a9f8bf8..db24678eb0bc 100644
> --- a/drivers/staging/r8188eu/include/odm.h
> +++ b/drivers/staging/r8188eu/include/odm.h
> @@ -880,11 +880,6 @@ void ODM_TXPowerTrackingCheck(struct odm_dm_struct *pDM_Odm);
>  bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI,
>  		      bool bForceUpdate, u8 *pRATRState);

> -u32 ConvertTo_dB(u32 Value);
> -
> -u32 GetPSDData(struct odm_dm_struct *pDM_Odm, unsigned int point,
> -	       u8 initial_gain_psd);
> -
>  u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid,
>  			u32 ra_mask, u8 rssi_level);

> diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
> index 3af58e853828..17a315d19a50 100644
> --- a/drivers/staging/r8188eu/include/odm_interface.h
> +++ b/drivers/staging/r8188eu/include/odm_interface.h
> @@ -50,8 +50,6 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
>  		      u32 length);

>  /*  ODM Timer relative API. */
> -void ODM_StallExecution(u32 usDelay);
> -
>  void ODM_delay_ms(u32 ms);

>  void ODM_delay_us(u32 us);
> -- 
> 2.33.0

Acked-by: Martin Kaiser <martin@kaiser.cx>
