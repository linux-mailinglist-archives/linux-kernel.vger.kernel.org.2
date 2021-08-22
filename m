Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419E03F4035
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 17:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbhHVPDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 11:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbhHVPC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 11:02:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2CFC061756
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 08:02:17 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y190so13135609pfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YxWyF7jZFZgYvbtPOP7ffVUtKMjIGXRzIUPnkjQuy3E=;
        b=S7VtchWGEStyINkhiOrzS6UhIgvIgOUSNQRHeLmOIcS88NQ1YDRJ51QgnKGIBsXH2D
         t9Gwxwkq5wXMrulV3tyb2WTyGvytKjUl6XQDQYJmjcULSdG/mnI+yFWKe4wDvDCrC0S8
         uPVeNm6T7hDo07kWY0W3bW9MEsMv3zl69aH3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YxWyF7jZFZgYvbtPOP7ffVUtKMjIGXRzIUPnkjQuy3E=;
        b=NZXSzklg+49Tts8uneRet1GefZuvv/2Hy88taxbEsEaV9D7iOTYtA/NAi+aCi/9uIt
         Gma60XmaoH65BN77kIIyKtLlUaok8sV2OASvWZxge9Pt3JZye1b6whjxqaiOLMfldBXZ
         v0siIcZ6NBG0KMz4YTMR+s+MDjYO01ch5Z4F8uN+42Pm1jcBKJFifFgd+gsrivnYaGph
         2c9/GoZNa4zKOucGRzJbdEMKro0GdeZEhO5z/TxWCx4sX+IuwzSEAavye/0NPgOAkIKP
         Swl1XoZUxkbojzbpL+1LBQC9oY5yZnidT/fJszPVTj4pk3XpjzfD5ONyjAuqObiDxZfA
         KjWA==
X-Gm-Message-State: AOAM5330Y9QpeG4Kuy0RDOm9d73rj3fZCx/rvSedgkJzr/RDaQxmSxwx
        MO6oEqL65ThA0sgambN9S+DyFw==
X-Google-Smtp-Source: ABdhPJzEGx8weZ0MvdBWdZyjoc6e83CMLziaCAox9+2idy1pzaFnvFQ65GYZwwU7pR306fARrmLtUg==
X-Received: by 2002:a05:6a00:1c5d:b029:3e0:6fb9:1de4 with SMTP id s29-20020a056a001c5db02903e06fb91de4mr30064638pfw.21.1629644536333;
        Sun, 22 Aug 2021 08:02:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c24sm15549164pgj.11.2021.08.22.08.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 08:02:15 -0700 (PDT)
Date:   Sun, 22 Aug 2021 08:02:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] staging/rtl8192u: Avoid CamelCase in names of
 variables
Message-ID: <202108220759.E6D94F75D@keescook>
References: <20210822142820.5109-1-len.baker@gmx.com>
 <20210822142820.5109-2-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210822142820.5109-2-len.baker@gmx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 04:28:19PM +0200, Len Baker wrote:
> Avoid CameCase in the names of all local variables inside the function
> rtl8192_phy_SwChnlStepByStep().

This mixes decamelization with some (minor) logic changes (moving
initializations earlier). I'd normally do this kind of thing with a sed
script and not touch anything else, so that the results can be compared
against the sed command. And I'd include the sed command in the commit
log.

I'm actually not sure what the norm is in the kernel for doing
decamelization -- should the entire driver get decamelized at once,
instead of just one function at a time? Greg, do you have an opinion
here?

-Kees

> 
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
>  drivers/staging/rtl8192u/r819xU_phy.c | 92 +++++++++++++--------------
>  1 file changed, 44 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
> index 37b82553412e..ff6fe2ee3349 100644
> --- a/drivers/staging/rtl8192u/r819xU_phy.c
> +++ b/drivers/staging/rtl8192u/r819xU_phy.c
> @@ -1185,30 +1185,30 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
>  				       u8 *stage, u8 *step, u32 *delay)
>  {
>  	struct r8192_priv *priv = ieee80211_priv(dev);
> -	struct sw_chnl_cmd   *PreCommonCmd;
> -	u32		   PreCommonCmdCnt;
> -	struct sw_chnl_cmd   *PostCommonCmd;
> -	u32		   PostCommonCmdCnt;
> -	struct sw_chnl_cmd   *RfDependCmd;
> -	u32		   RfDependCmdCnt;
> -	struct sw_chnl_cmd  *CurrentCmd = NULL;
> -	u8		   e_rfpath;
> -	bool		   ret;
> -
> -	PreCommonCmd = kzalloc(sizeof(*PreCommonCmd) * MAX_PRECMD_CNT, GFP_KERNEL);
> -	if (!PreCommonCmd)
> +	struct sw_chnl_cmd *pre_cmd;
> +	u32 pre_cmd_cnt = 0;
> +	struct sw_chnl_cmd *post_cmd;
> +	u32 post_cmd_cnt = 0;
> +	struct sw_chnl_cmd *rf_cmd;
> +	u32 rf_cmd_cnt = 0;
> +	struct sw_chnl_cmd *current_cmd = NULL;
> +	u8 e_rfpath;
> +	bool ret;
> +
> +	pre_cmd = kzalloc(sizeof(*pre_cmd) * MAX_PRECMD_CNT, GFP_KERNEL);
> +	if (!pre_cmd)
>  		return false;
> 
> -	PostCommonCmd = kzalloc(sizeof(*PostCommonCmd) * MAX_POSTCMD_CNT, GFP_KERNEL);
> -	if (!PostCommonCmd) {
> -		kfree(PreCommonCmd);
> +	post_cmd = kzalloc(sizeof(*post_cmd) * MAX_POSTCMD_CNT, GFP_KERNEL);
> +	if (!post_cmd) {
> +		kfree(pre_cmd);
>  		return false;
>  	}
> 
> -	RfDependCmd = kzalloc(sizeof(*RfDependCmd) * MAX_RFDEPENDCMD_CNT, GFP_KERNEL);
> -	if (!RfDependCmd) {
> -		kfree(PreCommonCmd);
> -		kfree(PostCommonCmd);
> +	rf_cmd = kzalloc(sizeof(*rf_cmd) * MAX_RFDEPENDCMD_CNT, GFP_KERNEL);
> +	if (!rf_cmd) {
> +		kfree(pre_cmd);
> +		kfree(post_cmd);
>  		return false;
>  	}
> 
> @@ -1225,21 +1225,17 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
>  	/* FIXME: need to check whether channel is legal or not here */
> 
>  	/* <1> Fill up pre common command. */
> -	PreCommonCmdCnt = 0;
> -	rtl8192_phy_SetSwChnlCmdArray(PreCommonCmd, PreCommonCmdCnt++,
> +	rtl8192_phy_SetSwChnlCmdArray(pre_cmd, pre_cmd_cnt++,
>  				      MAX_PRECMD_CNT, CMD_ID_SET_TX_PWR_LEVEL,
>  				      0, 0, 0);
> -	rtl8192_phy_SetSwChnlCmdArray(PreCommonCmd, PreCommonCmdCnt++,
> +	rtl8192_phy_SetSwChnlCmdArray(pre_cmd, pre_cmd_cnt++,
>  				      MAX_PRECMD_CNT, CMD_ID_END, 0, 0, 0);
> 
>  	/* <2> Fill up post common command. */
> -	PostCommonCmdCnt = 0;
> -
> -	rtl8192_phy_SetSwChnlCmdArray(PostCommonCmd, PostCommonCmdCnt++,
> +	rtl8192_phy_SetSwChnlCmdArray(post_cmd, post_cmd_cnt++,
>  				      MAX_POSTCMD_CNT, CMD_ID_END, 0, 0, 0);
> 
>  	/* <3> Fill up RF dependent command. */
> -	RfDependCmdCnt = 0;
>  	switch (priv->rf_chip) {
>  	case RF_8225:
>  		if (!(channel >= 1 && channel <= 14)) {
> @@ -1249,13 +1245,13 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
>  			ret = true;
>  			goto out;
>  		}
> -		rtl8192_phy_SetSwChnlCmdArray(RfDependCmd, RfDependCmdCnt++,
> +		rtl8192_phy_SetSwChnlCmdArray(rf_cmd, rf_cmd_cnt++,
>  					      MAX_RFDEPENDCMD_CNT,
>  					      CMD_ID_RF_WRITE_REG,
>  					      rZebra1_Channel,
>  					      RF_CHANNEL_TABLE_ZEBRA[channel],
>  					      10);
> -		rtl8192_phy_SetSwChnlCmdArray(RfDependCmd, RfDependCmdCnt++,
> +		rtl8192_phy_SetSwChnlCmdArray(rf_cmd, rf_cmd_cnt++,
>  					      MAX_RFDEPENDCMD_CNT,
>  					      CMD_ID_END, 0, 0, 0);
>  		break;
> @@ -1269,11 +1265,11 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
>  			ret = true;
>  			goto out;
>  		}
> -		rtl8192_phy_SetSwChnlCmdArray(RfDependCmd, RfDependCmdCnt++,
> +		rtl8192_phy_SetSwChnlCmdArray(rf_cmd, rf_cmd_cnt++,
>  					      MAX_RFDEPENDCMD_CNT,
>  					      CMD_ID_RF_WRITE_REG,
>  					      rZebra1_Channel, channel, 10);
> -		rtl8192_phy_SetSwChnlCmdArray(RfDependCmd, RfDependCmdCnt++,
> +		rtl8192_phy_SetSwChnlCmdArray(rf_cmd, rf_cmd_cnt++,
>  					      MAX_RFDEPENDCMD_CNT,
>  					      CMD_ID_END, 0, 0, 0);
>  		break;
> @@ -1290,19 +1286,19 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
>  	do {
>  		switch (*stage) {
>  		case 0:
> -			CurrentCmd = &PreCommonCmd[*step];
> +			current_cmd = &pre_cmd[*step];
>  			break;
>  		case 1:
> -			CurrentCmd = &RfDependCmd[*step];
> +			current_cmd = &rf_cmd[*step];
>  			break;
>  		case 2:
> -			CurrentCmd = &PostCommonCmd[*step];
> +			current_cmd = &post_cmd[*step];
>  			break;
>  		}
> 
> -		if (CurrentCmd->cmd_id == CMD_ID_END) {
> +		if (current_cmd->cmd_id == CMD_ID_END) {
>  			if ((*stage) == 2) {
> -				(*delay) = CurrentCmd->ms_delay;
> +				*delay = current_cmd->ms_delay;
>  				ret = true;
>  				goto out;
>  			}
> @@ -1311,31 +1307,31 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
>  			continue;
>  		}
> 
> -		switch (CurrentCmd->cmd_id) {
> +		switch (current_cmd->cmd_id) {
>  		case CMD_ID_SET_TX_PWR_LEVEL:
>  			if (priv->card_8192_version == VERSION_819XU_A)
>  				/* consider it later! */
>  				rtl8192_SetTxPowerLevel(dev, channel);
>  			break;
>  		case CMD_ID_WRITE_PORT_ULONG:
> -			write_nic_dword(dev, CurrentCmd->para_1,
> -					CurrentCmd->para_2);
> +			write_nic_dword(dev, current_cmd->para_1,
> +					current_cmd->para_2);
>  			break;
>  		case CMD_ID_WRITE_PORT_USHORT:
> -			write_nic_word(dev, CurrentCmd->para_1,
> -				       (u16)CurrentCmd->para_2);
> +			write_nic_word(dev, current_cmd->para_1,
> +				       (u16)current_cmd->para_2);
>  			break;
>  		case CMD_ID_WRITE_PORT_UCHAR:
> -			write_nic_byte(dev, CurrentCmd->para_1,
> -				       (u8)CurrentCmd->para_2);
> +			write_nic_byte(dev, current_cmd->para_1,
> +				       (u8)current_cmd->para_2);
>  			break;
>  		case CMD_ID_RF_WRITE_REG:
>  			for (e_rfpath = 0; e_rfpath < RF90_PATH_MAX; e_rfpath++) {
>  				rtl8192_phy_SetRFReg(dev,
>  						     (enum rf90_radio_path_e)e_rfpath,
> -						     CurrentCmd->para_1,
> +						     current_cmd->para_1,
>  						     bZebra1_ChannelNum,
> -						     CurrentCmd->para_2);
> +						     current_cmd->para_2);
>  			}
>  			break;
>  		default:
> @@ -1345,14 +1341,14 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
>  		break;
>  	} while (true);
> 
> -	(*delay) = CurrentCmd->ms_delay;
> +	*delay = current_cmd->ms_delay;
>  	(*step)++;
>  	ret = false;
> 
>  out:
> -	kfree(PreCommonCmd);
> -	kfree(PostCommonCmd);
> -	kfree(RfDependCmd);
> +	kfree(pre_cmd);
> +	kfree(post_cmd);
> +	kfree(rf_cmd);
> 
>  	return ret;
>  }
> --
> 2.25.1
> 

-- 
Kees Cook
