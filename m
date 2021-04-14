Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A90C35FCE5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhDNVA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:00:56 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:51982
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229463AbhDNVAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:00:54 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AnyNFxqsseIj7FAFopQY5887n7skCGYAji2hD?=
 =?us-ascii?q?6mlwRA09T+WxjMqunOsW2FvdlV8qKTEdsPqHP7SNRm6Z0JZz75UYM7vKZniZhE?=
 =?us-ascii?q?KDKoZ+4Yz+hwDxAiGWzJ8j6Y5Me7VzYeeAdmRSoMr+4Ba1CNoshOSAmZrFuc7z?=
 =?us-ascii?q?1GxqVhsvVqcI1XYMNi+1CUtzLTM2Y6YRNJ3Z3cZfoirlRHJ/VLXGOlAhX/Lf4/?=
 =?us-ascii?q?XRnpPnfhJuPW9n1CCqjSm0rJ/3FgHw5GZVbxprwa0+tUjJ+jaJrZmLlvGg11v7?=
 =?us-ascii?q?yWje9P1t6ZXc4/5CHtHJs84ON1zX+0mVTaFgQaDHhiw/uuu16F0n+eO87isIGs?=
 =?us-ascii?q?Ro9jfseXuoqgHmwAnq3F8VmjPf4Hu5pVemnsDjXjI9DKN69P9kWz/U8VApst05?=
 =?us-ascii?q?8I8j5RPgi7NvFh/LkCnw4NLFPisa4TvDnVMYneQej2NSXOIlAdc7x+NwnDI3Yf?=
 =?us-ascii?q?I9NRn354w9HO5lANu03oczTXqgY2ndri1TxrWXLwcONy2LRUUPoaWuonFrtUpk?=
 =?us-ascii?q?xEgVztF3pAZxyLsBTfB/loP5G5hzmKoLZsEbar8VPpZ6feKHTkPKWgzFK2+fLB?=
 =?us-ascii?q?DCGLscM3zA7777iY9Fnd2CSdgsyp0q8a6xIm9whCoVYELhCcqH2dl39Hn2LVmV?=
 =?us-ascii?q?bHDK0cFR559wp736Sv7KCES4OTITuvrlmfkGHsHdUfrbAuMiP9bTaVTnHIZF1x?=
 =?us-ascii?q?D/XZ4XIml2arxlhv8LH22Pud7QbrfhvuvdfPu7HtvQOAdhXWW6CmAIXTjtKKx7?=
 =?us-ascii?q?nwiWZkM=3D?=
X-IronPort-AV: E=Sophos;i="5.82,223,1613430000"; 
   d="scan'208";a="378682658"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 23:00:29 +0200
Date:   Wed, 14 Apr 2021 23:00:29 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Outreachy kernel] [PATCH v3 2/2] staging: rtl8723bs: Remove
 everything related with LedBlink
In-Reply-To: <20210414192750.4974-3-fmdefrancesco@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2104142259320.33347@hadrien>
References: <20210414192750.4974-1-fmdefrancesco@gmail.com> <20210414192750.4974-3-fmdefrancesco@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Apr 2021, Fabio M. De Francesco wrote:

> Removed struct LedBlink_param. Removed LedBlink entries in
> rtw_cmd_callback[] and in wlancmds[]. Everything related to LedBlink is
> not anymore needed. Removed extra blank lines in the two mentioned
> arrays and changend the numbers set in comments for having them in line
> with the shift.

It would be better not to remove the blank lines at the same time.  That
could be in another patch.  It is distracting here.

julia

>
> Reported-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>
> Changes from v2: Added this patch as 2/2.
> Changes from v1: No changes.
>
>  drivers/staging/rtl8723bs/core/rtw_cmd.c    | 27 ++++++---------------
>  drivers/staging/rtl8723bs/include/rtw_cmd.h | 14 +++--------
>  2 files changed, 11 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> index f82dbd4f4c3d..a74e6846f2df 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> @@ -22,7 +22,6 @@ static struct _cmd_callback rtw_cmd_callback[] = {
>  	{GEN_CMD_CODE(_Write_EEPROM), NULL},
>  	{GEN_CMD_CODE(_Read_EFUSE), NULL},
>  	{GEN_CMD_CODE(_Write_EFUSE), NULL},
> -
>  	{GEN_CMD_CODE(_Read_CAM),	NULL},	/*10*/
>  	{GEN_CMD_CODE(_Write_CAM),	 NULL},
>  	{GEN_CMD_CODE(_setBCNITV), NULL},
> @@ -33,7 +32,6 @@ static struct _cmd_callback rtw_cmd_callback[] = {
>  	{GEN_CMD_CODE(_SetOpMode), NULL},
>  	{GEN_CMD_CODE(_SiteSurvey), &rtw_survey_cmd_callback}, /*18*/
>  	{GEN_CMD_CODE(_SetAuth), NULL},
> -
>  	{GEN_CMD_CODE(_SetKey), NULL},	/*20*/
>  	{GEN_CMD_CODE(_SetStaKey), &rtw_setstaKey_cmdrsp_callback},
>  	{GEN_CMD_CODE(_SetAssocSta), &rtw_setassocsta_cmdrsp_callback},
> @@ -44,7 +42,6 @@ static struct _cmd_callback rtw_cmd_callback[] = {
>  	{GEN_CMD_CODE(_SetDataRate), NULL},
>  	{GEN_CMD_CODE(_GetDataRate), NULL},
>  	{GEN_CMD_CODE(_SetPhyInfo), NULL},
> -
>  	{GEN_CMD_CODE(_GetPhyInfo), NULL}, /*30*/
>  	{GEN_CMD_CODE(_SetPhy), NULL},
>  	{GEN_CMD_CODE(_GetPhy), NULL},
> @@ -55,7 +52,6 @@ static struct _cmd_callback rtw_cmd_callback[] = {
>  	{GEN_CMD_CODE(_JoinbssRpt), NULL},
>  	{GEN_CMD_CODE(_SetRaTable), NULL},
>  	{GEN_CMD_CODE(_GetRaTable), NULL},
> -
>  	{GEN_CMD_CODE(_GetCCXReport), NULL}, /*40*/
>  	{GEN_CMD_CODE(_GetDTMReport),	NULL},
>  	{GEN_CMD_CODE(_GetTXRateStatistics), NULL},
> @@ -67,24 +63,19 @@ static struct _cmd_callback rtw_cmd_callback[] = {
>  	{GEN_CMD_CODE(_SwitchAntenna), NULL},
>  	{GEN_CMD_CODE(_SetCrystalCap), NULL},
>  	{GEN_CMD_CODE(_SetSingleCarrierTx), NULL},	/*50*/
> -
>  	{GEN_CMD_CODE(_SetSingleToneTx), NULL}, /*51*/
>  	{GEN_CMD_CODE(_SetCarrierSuppressionTx), NULL},
>  	{GEN_CMD_CODE(_SetContinuousTx), NULL},
>  	{GEN_CMD_CODE(_SwitchBandwidth), NULL},		/*54*/
>  	{GEN_CMD_CODE(_TX_Beacon), NULL},/*55*/
> -
>  	{GEN_CMD_CODE(_Set_MLME_EVT), NULL},/*56*/
>  	{GEN_CMD_CODE(_Set_Drv_Extra), NULL},/*57*/
>  	{GEN_CMD_CODE(_Set_H2C_MSG), NULL},/*58*/
>  	{GEN_CMD_CODE(_SetChannelPlan), NULL},/*59*/
> -	{GEN_CMD_CODE(_LedBlink), NULL},/*60*/
> -
> -	{GEN_CMD_CODE(_SetChannelSwitch), NULL},/*61*/
> -	{GEN_CMD_CODE(_TDLS), NULL},/*62*/
> -	{GEN_CMD_CODE(_ChkBMCSleepq), NULL}, /*63*/
> -
> -	{GEN_CMD_CODE(_RunInThreadCMD), NULL},/*64*/
> +	{GEN_CMD_CODE(_SetChannelSwitch), NULL},/*60*/
> +	{GEN_CMD_CODE(_TDLS), NULL},/*61*/
> +	{GEN_CMD_CODE(_ChkBMCSleepq), NULL}, /*62*/
> +	{GEN_CMD_CODE(_RunInThreadCMD), NULL},/*63*/
>  };
>
>  static struct cmd_hdl wlancmds[] = {
> @@ -144,17 +135,13 @@ static struct cmd_hdl wlancmds[] = {
>  	GEN_MLME_EXT_HANDLER(0, NULL)
>  	GEN_MLME_EXT_HANDLER(0, NULL)
>  	GEN_MLME_EXT_HANDLER(sizeof(struct Tx_Beacon_param), tx_beacon_hdl) /*55*/
> -
>  	GEN_MLME_EXT_HANDLER(0, mlme_evt_hdl) /*56*/
>  	GEN_MLME_EXT_HANDLER(0, rtw_drvextra_cmd_hdl) /*57*/
> -
>  	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
>  	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelPlan_param), set_chplan_hdl) /*59*/
> -	GEN_MLME_EXT_HANDLER(0, NULL) /*60*/
> -
> -	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelSwitch_param), set_csa_hdl) /*61*/
> -	GEN_MLME_EXT_HANDLER(sizeof(struct TDLSoption_param), tdls_hdl) /*62*/
> -	GEN_MLME_EXT_HANDLER(0, chk_bmc_sleepq_hdl) /*63*/
> +	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelSwitch_param), set_csa_hdl) /*60*/
> +	GEN_MLME_EXT_HANDLER(sizeof(struct TDLSoption_param), tdls_hdl) /*61*/
> +	GEN_MLME_EXT_HANDLER(0, chk_bmc_sleepq_hdl) /*62*/
>  	GEN_MLME_EXT_HANDLER(sizeof(struct RunInThread_param), run_in_thread_hdl) /*63*/
>  };
>
> diff --git a/drivers/staging/rtl8723bs/include/rtw_cmd.h b/drivers/staging/rtl8723bs/include/rtw_cmd.h
> index 517ae3b51386..28d2d2732374 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_cmd.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_cmd.h
> @@ -537,11 +537,6 @@ struct SetChannelPlan_param {
>  	u8 channel_plan;
>  };
>
> -/*H2C Handler index: 60 */
> -struct LedBlink_param {
> -	void *pLed;
> -};
> -
>  /*H2C Handler index: 61 */
>  struct SetChannelSwitch_param {
>  	u8 new_ch_no;
> @@ -709,13 +704,12 @@ enum {
>  	GEN_CMD_CODE(_Set_H2C_MSG), /*58*/
>
>  	GEN_CMD_CODE(_SetChannelPlan), /*59*/
> -	GEN_CMD_CODE(_LedBlink), /*60*/
>
> -	GEN_CMD_CODE(_SetChannelSwitch), /*61*/
> -	GEN_CMD_CODE(_TDLS), /*62*/
> -	GEN_CMD_CODE(_ChkBMCSleepq), /*63*/
> +	GEN_CMD_CODE(_SetChannelSwitch), /*60*/
> +	GEN_CMD_CODE(_TDLS), /*61*/
> +	GEN_CMD_CODE(_ChkBMCSleepq), /*62*/
>
> -	GEN_CMD_CODE(_RunInThreadCMD), /*64*/
> +	GEN_CMD_CODE(_RunInThreadCMD), /*63*/
>
>  	MAX_H2CCMD
>  };
> --
> 2.31.1
>
>
