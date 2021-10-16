Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E684301B3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 11:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240202AbhJPJ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 05:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbhJPJ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 05:58:19 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C58C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 02:56:11 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mbgQA-0003HW-Jj; Sat, 16 Oct 2021 11:56:06 +0200
Date:   Sat, 16 Oct 2021 11:56:06 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] staging: r8188eu: remove ODM_CmnInfoPtrArrayHook()
Message-ID: <20211016095606.3bnntfllbbdomgfu@viti.kaiser.cx>
References: <20211015163507.9091-1-straube.linux@gmail.com>
 <20211015163507.9091-8-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015163507.9091-8-straube.linux@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> In ODM_CmnInfoPtrArrayHook() there is only the case
> ODM_CMNINFO_STA_STATUS and the function is called only with this value.
> Remove ODM_CmnInfoPtrArrayHook() and fix the three places where it is
> called.

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/odm.c               | 15 ---------------
>  drivers/staging/r8188eu/hal/rtl8188e_dm.c       |  2 +-
>  drivers/staging/r8188eu/hal/rtl8188e_hal_init.c |  5 +++--
>  drivers/staging/r8188eu/include/odm.h           | 10 ----------
>  4 files changed, 4 insertions(+), 28 deletions(-)

> diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
> index a2cbe727f6e0..0987ff3e382a 100644
> --- a/drivers/staging/r8188eu/hal/odm.c
> +++ b/drivers/staging/r8188eu/hal/odm.c
> @@ -292,21 +292,6 @@ void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
>  	}
>  }

> -void ODM_CmnInfoPtrArrayHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def CmnInfo, u16 Index, void *pValue)
> -{
> -	/*  Hook call by reference pointer. */
> -	switch	(CmnInfo) {
> -	/*  Dynamic call by reference pointer. */
> -	case	ODM_CMNINFO_STA_STATUS:
> -		pDM_Odm->pODM_StaInfo[Index] = (struct sta_info *)pValue;
> -		break;
> -	/* To remove the compiler warning, must add an empty default statement to handle the other values. */
> -	default:
> -		/* do nothing */
> -		break;
> -	}
> -}
> -
>  /*  Update Band/CHannel/.. The values are dynamic but non-per-packet. */
>  void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value)
>  {
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
> index 1ca24a507d6d..f1a1015eedfb 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
> @@ -90,7 +90,7 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
>  	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_RF_ANTENNA_TYPE, hal_data->TRxAntDivType);

>  	for (i = 0; i < NUM_STA; i++)
> -		ODM_CmnInfoPtrArrayHook(dm_odm, ODM_CMNINFO_STA_STATUS, i, NULL);
> +		dm_odm->pODM_StaInfo[i] = NULL;
>  }

>  void rtl8188e_InitHalDm(struct adapter *Adapter)
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> index dd8d6b4a9d48..8c00f2dd67da 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> @@ -1671,13 +1671,14 @@ void rtl8188e_SetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVaria
>  	case HAL_ODM_STA_INFO:
>  		{
>  			struct sta_info *psta = (struct sta_info *)pValue1;
> +
>  			if (bSet) {
>  				DBG_88E("### Set STA_(%d) info\n", psta->mac_id);
> -				ODM_CmnInfoPtrArrayHook(podmpriv, ODM_CMNINFO_STA_STATUS, psta->mac_id, psta);
> +				podmpriv->pODM_StaInfo[psta->mac_id] = psta;
>  				ODM_RAInfo_Init(podmpriv, psta->mac_id);
>  			} else {
>  				DBG_88E("### Clean STA_(%d) info\n", psta->mac_id);
> -				ODM_CmnInfoPtrArrayHook(podmpriv, ODM_CMNINFO_STA_STATUS, psta->mac_id, NULL);
> +				podmpriv->pODM_StaInfo[psta->mac_id] = NULL;
>  		       }
>  		}
>  		break;
> diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
> index 6cbf64df9be7..841603b341bd 100644
> --- a/drivers/staging/r8188eu/include/odm.h
> +++ b/drivers/staging/r8188eu/include/odm.h
> @@ -305,12 +305,6 @@ enum odm_common_info_def {
>  	ODM_CMNINFO_BT_BUSY,			/* Check Bt is using or not */
>  	ODM_CMNINFO_BT_DISABLE_EDCA,
>  /* CALL BY VALUE-------------*/
> -
> -	/*  Dynamic ptr array hook itms. */
> -	ODM_CMNINFO_STA_STATUS,
> -	ODM_CMNINFO_PHY_STATUS,
> -	ODM_CMNINFO_MAC_STATUS,
> -	ODM_CMNINFO_MAX,
>  };

>  /*  2011/10/20 MH Define ODM support ability.  ODM_CMNINFO_ABILITY */
> @@ -882,10 +876,6 @@ void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm,
>  void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm,
>  		     enum odm_common_info_def CmnInfo, void *pValue);

> -void ODM_CmnInfoPtrArrayHook(struct odm_dm_struct *pDM_Odm,
> -			     enum odm_common_info_def CmnInfo,
> -			     u16 Index, void *pValue);
> -
>  void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value);

>  #endif
> -- 
> 2.33.0

Acked-by: Martin Kaiser <martin@kaiser.cx>
