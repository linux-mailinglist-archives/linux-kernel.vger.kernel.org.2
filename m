Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC4A4301AD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 11:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbhJPJsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 05:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240175AbhJPJsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 05:48:11 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EACC061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 02:46:03 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mbgGN-0003BM-0X; Sat, 16 Oct 2021 11:45:59 +0200
Date:   Sat, 16 Oct 2021 11:45:58 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] staging: r8188eu: pMacPhyMode is not used
Message-ID: <20211016094558.wxgjy4t7k6lslwqb@viti.kaiser.cx>
References: <20211015163507.9091-1-straube.linux@gmail.com>
 <20211015163507.9091-7-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015163507.9091-7-straube.linux@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> pMacPhyMode is not used. Remove it from odm_dm_struct and remove
> related dead code.

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/odm.c     | 3 ---
>  drivers/staging/r8188eu/include/odm.h | 3 ---
>  2 files changed, 6 deletions(-)

> diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
> index 85bc5050cda5..a2cbe727f6e0 100644
> --- a/drivers/staging/r8188eu/hal/odm.c
> +++ b/drivers/staging/r8188eu/hal/odm.c
> @@ -231,9 +231,6 @@ void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
>  	/*  */
>  	switch	(CmnInfo) {
>  	/*  Dynamic call by reference pointer. */
> -	case	ODM_CMNINFO_MAC_PHY_MODE:
> -		pDM_Odm->pMacPhyMode = (u8 *)pValue;
> -		break;
>  	case	ODM_CMNINFO_TX_UNI:
>  		pDM_Odm->pNumTxBytesUnicast = (u64 *)pValue;
>  		break;
> diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
> index 9745069060d7..6cbf64df9be7 100644
> --- a/drivers/staging/r8188eu/include/odm.h
> +++ b/drivers/staging/r8188eu/include/odm.h
> @@ -269,7 +269,6 @@ enum odm_common_info_def {

>  	/*  Dynamic value: */
>  /*  POINTER REFERENCE-----------  */
> -	ODM_CMNINFO_MAC_PHY_MODE,	/*  ODM_MAC_PHY_MODE_E */
>  	ODM_CMNINFO_TX_UNI,
>  	ODM_CMNINFO_RX_UNI,
>  	ODM_CMNINFO_WM_MODE,		/*  ODM_WIRELESS_MODE_E */
> @@ -621,8 +620,6 @@ struct odm_dm_struct {
>  	bool	bool_temp;
>  	struct adapter *adapter_temp;

> -	/*  MAC PHY Mode SMSP/DMSP/DMDP = 0/1/2 */
> -	u8	*pMacPhyMode;
>  	/* TX Unicast byte count */
>  	u64	*pNumTxBytesUnicast;
>  	/* RX Unicast byte count */
> -- 
> 2.33.0

Acked-by: Martin Kaiser <martin@kaiser.cx>
