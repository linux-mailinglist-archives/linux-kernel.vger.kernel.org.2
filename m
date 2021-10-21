Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316CB435ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 12:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhJUKOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhJUKOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:14:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA6CC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:12:30 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r7so160146wrc.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cxW8Qi2mKQUYAF0K1wxKT6X8BPUa9h+hQltko1tGH/g=;
        b=bwgWzj8KQokqxmJSmg0ttTFcvaX4cPw7InVp3zgB6WYRMaWQwjUg5EDvOgXbX6gn4z
         +tEiJXlP56YB6SzTZ9IuP1DgZBlghPT28PhPtknW+zYTJnSCmxC5W1Mm7ymljChDOwWH
         JEmfH5ad2iYFbyB1JZ8QW6cbbhzvzcMI3MB83WaWFFC1MJU7QflcyggsjQO6HJjLlfYN
         +j5ZcAkg6X2UGxwXL4BIMHUjxCn/347j5VDTbjccqXsisCtsxXqhZJJ1QikyqHWKXucO
         7cLmSzrJXXEC8WouG+m+ypNfpLj4l8Bh99NSYBZYLrIY14IWoBjjt0N6Xc2mQ2My3/vF
         67jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cxW8Qi2mKQUYAF0K1wxKT6X8BPUa9h+hQltko1tGH/g=;
        b=A8PQHwdB0QsodrCDFWn780sh1fNm0QiFwbEZf+BcftNfHBd0ZD+HoAVHb8O5ZDy3jw
         g/4xrPMAi0pOovskuqwjGy3tQhPP/wxOCcAN7Et6xskZF5vOlTgXnziS7KDFmSRu6NMS
         pAvjDXRNPP92bo/TA/ArYHznpXlrASFeAD4rL1o3YdsDnUwFgUVPEXzp1ui6nv6S0qLp
         4SLO0s/CYWssHjHbGh4rjdndGNuS8gHREaMlXy/TtgzkeeNK4SUQSxebF30F+jtUKX9y
         /keoZmorLDYajbj92fNknLnPGnzoizUfcvqgcIRJzzn7K7zOIwfysJJiH2JPpjoZMfmX
         Fz7w==
X-Gm-Message-State: AOAM533I004RZVuiXRh8QZn5RzNUxmdgIzoiCRU0I9zuAYPuIgLD5Pmq
        ybBCUYrIVS1D7ZXBs4Z8T4I=
X-Google-Smtp-Source: ABdhPJyiNmA280qR7HaQ2miTiw/MNm2D/wRSbEWbyAIFH1MN6WiVfPr9MyTxqaVeLNwIJrpiuXZFvw==
X-Received: by 2002:adf:f486:: with SMTP id l6mr6005457wro.375.1634811149127;
        Thu, 21 Oct 2021 03:12:29 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::d7f0? ([2a02:8108:96c0:3b88::d7f0])
        by smtp.gmail.com with ESMTPSA id f15sm4434594wrt.38.2021.10.21.03.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 03:12:28 -0700 (PDT)
Message-ID: <f5657f12-e20e-5cd9-e872-32e294741e88@gmail.com>
Date:   Thu, 21 Oct 2021 12:12:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/5] staging: r8188eu: use helper to check for broadcast
 address
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211020195401.12931-1-martin@kaiser.cx>
 <20211020195401.12931-3-martin@kaiser.cx> <YXCFFO//n9N6MZXv@equinox>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <YXCFFO//n9N6MZXv@equinox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 23:07, Phillip Potter wrote:
> On Wed, Oct 20, 2021 at 09:53:59PM +0200, Martin Kaiser wrote:
>> Use the is_broadcast_ether_addr function to check for a
>> broadcast address.
>>
>> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
>> ---
>>   drivers/staging/r8188eu/core/rtw_mlme_ext.c | 6 ++----
>>   drivers/staging/r8188eu/hal/odm.c           | 3 +--
>>   2 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
>> index 995a0248c26f..b0dfafe526f7 100644
>> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
>> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
>> @@ -392,13 +392,12 @@ void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext)
>>   
>>   static void _mgt_dispatcher(struct adapter *padapter, struct mlme_handler *ptable, struct recv_frame *precv_frame)
>>   {
>> -	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>>   	u8 *pframe = precv_frame->rx_data;
>>   
>>   	if (ptable->func) {
>>   	/* receive the frames that ra(a1) is my address or ra(a1) is bc address. */
>>   		if (memcmp(GetAddr1Ptr(pframe), myid(&padapter->eeprompriv), ETH_ALEN) &&
>> -		    memcmp(GetAddr1Ptr(pframe), bc_addr, ETH_ALEN))
>> +		    !is_broadcast_ether_addr(GetAddr1Ptr(pframe)))

Hi Martin,

I'm not an expert regarding alignment. Is GetAddr1Ptr(pframe) always 
__aligned(2) as required by is_broadcast_ether_addr?

>>   			return;
>>   		ptable->func(padapter, precv_frame);
>>   	}
>> @@ -409,7 +408,6 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
>>   	int index;
>>   	struct mlme_handler *ptable;
>>   	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>> -	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>>   	u8 *pframe = precv_frame->rx_data;
>>   	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, GetAddr2Ptr(pframe));
>>   
>> @@ -418,7 +416,7 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
>>   
>>   	/* receive the frames that ra(a1) is my address or ra(a1) is bc address. */
>>   	if (memcmp(GetAddr1Ptr(pframe), myid(&padapter->eeprompriv), ETH_ALEN) &&
>> -	    memcmp(GetAddr1Ptr(pframe), bc_addr, ETH_ALEN))
>> +	    !is_broadcast_ether_addr(GetAddr1Ptr(pframe)))
>>   		return;

Same here.

>>   
>>   	ptable = mlme_sta_tbl;
>> diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
>> index 67cf8f7baba5..21f115194df8 100644
>> --- a/drivers/staging/r8188eu/hal/odm.c
>> +++ b/drivers/staging/r8188eu/hal/odm.c
>> @@ -829,7 +829,6 @@ void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm)
>>   	u8	sta_cnt = 0;
>>   	u32 PWDB_rssi[NUM_STA] = {0};/* 0~15]:MACID, [16~31]:PWDB_rssi */
>>   	struct sta_info *psta;
>> -	u8 bcast_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>>   
>>   	if (!(pDM_Odm->SupportAbility & ODM_BB_RSSI_MONITOR))
>>   		return;
>> @@ -841,7 +840,7 @@ void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm)
>>   		psta = pDM_Odm->pODM_StaInfo[i];
>>   		if (IS_STA_VALID(psta) &&
>>   		    (psta->state & WIFI_ASOC_STATE) &&
>> -		    memcmp(psta->hwaddr, bcast_addr, ETH_ALEN) &&
>> +		    !is_broadcast_ether_addr(psta->hwaddr) &&

Perhaps we should add __aligned(2) to the hwaddr variable in struct
sta_info to be safe?

u8	hwaddr[ETH_ALEN] __aligned(2);


>>   		    memcmp(psta->hwaddr, myid(&Adapter->eeprompriv), ETH_ALEN)) {
>>   			if (psta->rssi_stat.UndecoratedSmoothedPWDB < tmpEntryMinPWDB)
>>   				tmpEntryMinPWDB = psta->rssi_stat.UndecoratedSmoothedPWDB;
>> -- 
>> 2.20.1
>>

Other than that the patch looks good, thanks.

Michael

