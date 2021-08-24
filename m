Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78263F5994
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhHXIBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbhHXIBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:01:31 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7371C061575
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:00:47 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c12so36099794ljr.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8FImCoo5pTAQJj0KEDdtKxhCXfoD+DFQjGxp2SXkatY=;
        b=vOs7yzPi4GDGVqi1TE9XSGGYi+4JMzhwe4u+WmsQTA/m8R2zb/arpQ/9y4aicRgWN+
         i3rchTUc1TJ7db4PiocnmRZkLRT0qBxImbKp2JXOOn5jkUZKvy+9XkLBK2LsUvn0ZRjg
         QuJOGwYR6ifl4qx9Nnw8WgfXOlbvISgaTWnXQq55wGd7AKAlEmq6ipmsLbrH1yXrmqzb
         9FZjlTWSfTVe03qTSQp6vcBM41LHCVgqlXMlOfqv+QZ9IoH4qYimg6CUt62xEDhTXNBy
         o8R104FLvStnu/Y/M+R1JshychQg+YaysOR2Ot961CDXPrMBsmmWH+wVExn5yQhnUmS8
         z4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8FImCoo5pTAQJj0KEDdtKxhCXfoD+DFQjGxp2SXkatY=;
        b=gc6g+mzuQn14k9H+4BXqc6tN4AtNkvGp95aEHQa9M1GM3cjjmgFDpD62bHXfZhTpNg
         hyHtW49cqrP2d2mWjjK5EUgO7XusQDQ+LbrfmqygEeCGDrJ4AC2cSyz1r4+wKb988TAJ
         arFNJqvaEpQZOwNoHrv8u18VfasTFV+1m3Z0EO1VTmSvJHbDSzynSenScr98wOiL+zfv
         EisMgnO1pFanb+SW/mK99niSGvB8HemRzYFLQ+sOjBUUwkaVnfJ2nQtSsXBF2r8A1WAX
         xuOqLYuxRL6blBdTOAP1MEilJZhGzfQDK8L1W/1vzVD63nuDCVpodf3txX4WczPg7FIy
         VfPw==
X-Gm-Message-State: AOAM532CdWWyWIilIYvO6ozpKZUv80qCxyFT9pse9xELEatG2h8M6x6h
        bhAkhga42ZF3DVp26oKX1DU=
X-Google-Smtp-Source: ABdhPJxRZ4Qfikupak4ek2kqdmjHxPDTupO7aC0eYmRgcSXzYv9iKoQL4n6wNhOs9vsFWedb7mj9kg==
X-Received: by 2002:a05:651c:118f:: with SMTP id w15mr30986601ljo.47.1629792046064;
        Tue, 24 Aug 2021 01:00:46 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id w3sm387870ljm.13.2021.08.24.01.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 01:00:45 -0700 (PDT)
Subject: Re: [PATCH linux-next] r8188eu: remove unneeded conversions to bool
To:     CGEL <cgel.zte@gmail.com>, Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210824063443.59724-1-deng.changcheng@zte.com.cn>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <9558f8e0-2ba0-e0af-4e81-6223b1d3bef0@gmail.com>
Date:   Tue, 24 Aug 2021 11:00:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210824063443.59724-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 9:34 AM, CGEL wrote:
> From: Jing Yangyang <jing.yangyang@zte.com.cn>
> 
> Found with scripts/coccinelle/misc/boolconv.cocci.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>


Reviewed-by: Pavel Skripkin <paskripkin@gmail.com>


> ---
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index 5325fe4..20dc4d4 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -3758,7 +3758,7 @@ int issue_probereq_p2p_ex(struct adapter *adapter, u8 *da, int try_cnt, int wait
>   	u32 start = jiffies;
>   
>   	do {
> -		ret = _issue_probereq_p2p(adapter, da, wait_ms > 0 ? true : false);
> +		ret = _issue_probereq_p2p(adapter, da, wait_ms > 0);
>   
>   		i++;
>   
> @@ -4890,7 +4890,7 @@ int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
>   	u32 start = jiffies;
>   
>   	do {
> -		ret = _issue_probereq(padapter, pssid, da, wait_ms > 0 ? true : false);
> +		ret = _issue_probereq(padapter, pssid, da, wait_ms > 0);
>   
>   		i++;
>   
> @@ -5605,7 +5605,7 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
>   		da = get_my_bssid(&pmlmeinfo->network);
>   
>   	do {
> -		ret = _issue_nulldata(padapter, da, power_mode, wait_ms > 0 ? true : false);
> +		ret = _issue_nulldata(padapter, da, power_mode, wait_ms > 0);
>   
>   		i++;
>   
> @@ -5728,7 +5728,7 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int
>   		da = get_my_bssid(&pmlmeinfo->network);
>   
>   	do {
> -		ret = _issue_qos_nulldata(padapter, da, tid, wait_ms > 0 ? true : false);
> +		ret = _issue_qos_nulldata(padapter, da, tid, wait_ms > 0);
>   
>   		i++;
>   
> @@ -5839,7 +5839,7 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
>   	u32 start = jiffies;
>   
>   	do {
> -		ret = _issue_deauth(padapter, da, reason, wait_ms > 0 ? true : false);
> +		ret = _issue_deauth(padapter, da, reason, wait_ms > 0);
>   
>   		i++;
>   
> 


