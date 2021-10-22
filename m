Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED1A437033
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhJVCvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbhJVCvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:51:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F117C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:48:52 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c29so2385548pfp.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oh7BegofVIUn5uB2hKbuYfRyYWicxbDsuoabRMJIstA=;
        b=CL+cAVkpVDXC2pkIpAb7W6WCAzaAtqc02ZKsFFqoAHVj/pBU7pzaKPFo+NgW9zO/78
         QKWfTl4n+wt1VZDBwgvO70q5PwZyGagAjnS/JhGg6BH/tVIgTiNoYfVMGBvXYzKBs6y7
         AC5rjRlJjuzjM6deHBARUs5yMaM6gEXmyEpXHlDXnoidg+hlN1HQV7DdofBzlzr1oJwQ
         l+TiYBYNJF7kg2D4WPv7v0gr0vvWNTFRtKWGMs2ViKutkMcw9acg7Z1VPcQM3kpz70q3
         5AVNxd88srfNwINJe4JgZHMrgxz3vG7N0WsiWwE9HDGWVxEUkrgJjk7p0NnZUKNs8XDB
         rKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oh7BegofVIUn5uB2hKbuYfRyYWicxbDsuoabRMJIstA=;
        b=wiKzOGM+ozg5HhP16eH/U4ZpaRYGDtTNd4GRY7yphXkIczU+7YjYsGHJRQiMxhFqfM
         NUw1G/9gyLhS58CWNDki93jhQdRoQQSzf3PMBbmwJnyz53Syh7PMvptFFJ1i3mcvRITA
         ZnxSPdspJ26zoVhWejCVaD92SLRCt6kYDZQpJDBz2UgphXAeriA3rKiNELJRIhZQWHed
         iCquzvDcZfpvZZ0sPv7nm+nJFG9LHUk+nm7ZjNrwZyqvprHERpIUqtBqiVQ+yD4gfxQw
         nW4Qv0hCh+O4akX9d3DXxhtI88ItCpKSjktcu/TI8n7MqEwSY8g9sPiW2TTv9+FIesZw
         9bLw==
X-Gm-Message-State: AOAM530h9wbqqxavEg57hCOtztq+9phkVhDNb1N6aTikzfnAtku2FIhk
        N5QgrnV6MgDezUcfMTcIdiA=
X-Google-Smtp-Source: ABdhPJzAGcu0FU7tOKWY7i/7VAwzZhhpWSqUYsNKG9qb3qnudsixR/km8pwdnzRGYAYqqHt0g1xP9A==
X-Received: by 2002:aa7:9212:0:b0:47b:aefd:2cc4 with SMTP id 18-20020aa79212000000b0047baefd2cc4mr41640pfo.47.1634870931730;
        Thu, 21 Oct 2021 19:48:51 -0700 (PDT)
Received: from ?IPV6:2405:201:d007:e827:d9ab:a6dc:54b8:e75d? ([2405:201:d007:e827:d9ab:a6dc:54b8:e75d])
        by smtp.gmail.com with ESMTPSA id t3sm6494286pgo.51.2021.10.21.19.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 19:48:51 -0700 (PDT)
Message-ID: <4cfb2624-4e64-2d7f-a1e7-5032a3078ec9@gmail.com>
Date:   Fri, 22 Oct 2021 08:18:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [Outreachy kernel] [PATCH 3/4] staging: rtl8723bs: core: Remove
 unnecessary space after a cast
Content-Language: en-US
To:     Kushal Kothari <kushalkothari285@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        fmdefrancesco@gmail.com, marcocesati@gmail.com,
        straube.linux@gmail.com, philippesdixon@gmail.com,
        manuelpalenzuelamerino@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, mike.rapoport@gmail.com,
        kushalkotharitest@googlegroups.com,
        outreachy-kernel@googlegroups.com
References: <cover.1634845504.git.kushalkothari285@gmail.com>
 <f350e30b1e09332dff896b6588d962aab9800a52.1634845504.git.kushalkothari285@gmail.com>
From:   Praveen Kumar <kpraveen.lkml@gmail.com>
In-Reply-To: <f350e30b1e09332dff896b6588d962aab9800a52.1634845504.git.kushalkothari285@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-2021 01:27, Kushal Kothari wrote:
> Issue found with checkpatch.pl.
> Space after cast is not needes

*needed

> 
> Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_cmd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> index 88f6b7405106..fce3256cc275 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> @@ -922,7 +922,7 @@ u8 rtw_setstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 unicast_
>  	memcpy(psetstakey_para->addr, sta->hwaddr, ETH_ALEN);
>  
>  	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
> -		psetstakey_para->algorithm = (unsigned char) psecuritypriv->dot11PrivacyAlgrthm;
> +		psetstakey_para->algorithm = (unsigned char)psecuritypriv->dot11PrivacyAlgrthm;
>  	else
>  		GET_ENCRY_ALGO(psecuritypriv, sta, psetstakey_para->algorithm, false);
>  
> @@ -951,7 +951,7 @@ u8 rtw_setstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 unicast_
>  		}
>  
>  		init_h2fwcmd_w_parm_no_rsp(ph2c, psetstakey_para, _SetStaKey_CMD_);
> -		ph2c->rsp = (u8 *) psetstakey_rsp;
> +		ph2c->rsp = (u8 *)psetstakey_rsp;
>  		ph2c->rspsz = sizeof(struct set_stakey_rsp);
>  		res = rtw_enqueue_cmd(pcmdpriv, ph2c);
>  	} else {
> @@ -1002,7 +1002,7 @@ u8 rtw_clearstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 enqueu
>  		}
>  
>  		init_h2fwcmd_w_parm_no_rsp(ph2c, psetstakey_para, _SetStaKey_CMD_);
> -		ph2c->rsp = (u8 *) psetstakey_rsp;
> +		ph2c->rsp = (u8 *)psetstakey_rsp;
>  		ph2c->rspsz = sizeof(struct set_stakey_rsp);
>  
>  		memcpy(psetstakey_para->addr, sta->hwaddr, ETH_ALEN);
> @@ -2027,7 +2027,7 @@ void rtw_setstaKey_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pc
>  {
>  
>  	struct sta_priv *pstapriv = &padapter->stapriv;
> -	struct set_stakey_rsp *psetstakey_rsp = (struct set_stakey_rsp *) (pcmd->rsp);
> +	struct set_stakey_rsp *psetstakey_rsp = (struct set_stakey_rsp *)(pcmd->rsp);
>  	struct sta_info *psta = rtw_get_stainfo(pstapriv, psetstakey_rsp->addr);
>  
>  	if (!psta)
> @@ -2042,7 +2042,7 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  	struct set_assocsta_parm *passocsta_parm = (struct set_assocsta_parm *)(pcmd->parmbuf);
> -	struct set_assocsta_rsp *passocsta_rsp = (struct set_assocsta_rsp *) (pcmd->rsp);
> +	struct set_assocsta_rsp *passocsta_rsp = (struct set_assocsta_rsp *)(pcmd->rsp);
>  	struct sta_info *psta = rtw_get_stainfo(pstapriv, passocsta_parm->addr);
>  
>  	if (!psta)
> 

Regards,

~Praveen.
