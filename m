Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0B5330FA9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhCHNjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhCHNjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:39:32 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7D7C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 05:39:32 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id w60so2559135qte.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 05:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IApx5JgU+J7ox+9BpAQuSUb1g+9FXJvkJqbP370G5e4=;
        b=HQHjHFVQU2pFE61BANBjHUQ5VsO8RvhzYXO/k70p2Ny/O/sVF+2IG2uec4cq0jVlKQ
         Duzf0P6G6Gx51A7it9PDCyq31S/HPtmrC5/tdO+UxOr2aU255bcZkhDbOqv6giS8IjTc
         6VmIo8idKCHbrGSxzrjA8ry3PlUvuhDAFOaQ/Y+cgdb7oBaszxhDSPTr6wD+xqlEkNAp
         LMgTtsK33Oivmysa/37KPAk+uWw3diQSnEBEaU20M3gwpPoncTEYG1JZ9IkO7IKGiOOk
         ayP+RZefGH+wb13FIj7/9kXmn6MDSnf3cI8xNn6YVYoR8pIjFmUe3ZDzses0CGlwzbtN
         gABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IApx5JgU+J7ox+9BpAQuSUb1g+9FXJvkJqbP370G5e4=;
        b=cECNfMU2VxOvQiMUUtf97ecixFgUNpzf1HvyRHGE1mySy922CtdeRcBqyfYUy+Aigk
         727RurJFWbNXsrJS0xF/euKbC8O919hh0JDum9HXSbTIx+kqAQauIFV4grAdApekhNan
         1kcIFXDfLkMltR7DZQOX1kT4LX2eQLh/N2yml/YgPr5uFqthCNJLC95MeWPpTOmJRmGb
         311WdE0yw6/Wbfi+U3bNjY8l89/SoXqXbmV4WyjOdO8Pvrpn7bUcfdL5amlq78wpMRO1
         dFOO/yHabzzGDnBplo9bAerKiTUH1u18FWgm5gliALyK5fm8zHk3inTkJz4E1cb2iu9b
         nRDw==
X-Gm-Message-State: AOAM5314FKYFlhPmKanKJFlJg9yfZIuAOTar7gFfS5cKya6A22rT309G
        A3vbYYOLt2raEY5D/EE69dTe7jcDzQjxLA==
X-Google-Smtp-Source: ABdhPJwKA/AUL9UFFq5/0Y0FR+UjBsO6jNZ3Ug4aJN6wUdzGr74vKkXVw5DdJU0AXpNz7aVtON9q3g==
X-Received: by 2002:a05:622a:109:: with SMTP id u9mr20611418qtw.116.1615210771371;
        Mon, 08 Mar 2021 05:39:31 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id 19sm7548134qkv.95.2021.03.08.05.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 05:39:30 -0800 (PST)
Subject: Re: [PATCH net-next v2 5/6] net: qualcomm: rmnet: don't use C
 bit-fields in rmnet checksum trailer
To:     David Laight <David.Laight@ACULAB.COM>,
        "subashab@codeaurora.org" <subashab@codeaurora.org>,
        "stranche@codeaurora.org" <stranche@codeaurora.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>
Cc:     "sharathv@codeaurora.org" <sharathv@codeaurora.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "cpratapa@codeaurora.org" <cpratapa@codeaurora.org>,
        "elder@kernel.org" <elder@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210306031550.26530-1-elder@linaro.org>
 <20210306031550.26530-6-elder@linaro.org>
 <ebe1bf51902e49458cfdd685790c4350@AcuMS.aculab.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <956ca2dd-d15e-ce40-e3b4-56b0f5bf2154@linaro.org>
Date:   Mon, 8 Mar 2021 07:39:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <ebe1bf51902e49458cfdd685790c4350@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/21 4:13 AM, David Laight wrote:
> From: Alex Elder
>> Sent: 06 March 2021 03:16
>>
>> Replace the use of C bit-fields in the rmnet_map_dl_csum_trailer
>> structure with a single one-byte field, using constant field masks
>> to encode or get at embedded values.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> ---
>>   .../ethernet/qualcomm/rmnet/rmnet_map_data.c    |  2 +-
>>   include/linux/if_rmnet.h                        | 17 +++++++----------
>>   2 files changed, 8 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
>> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
>> index 3291f252d81b0..29d485b868a65 100644
>> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
>> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
>> @@ -365,7 +365,7 @@ int rmnet_map_checksum_downlink_packet(struct sk_buff *skb, u16 len)
>>
>>   	csum_trailer = (struct rmnet_map_dl_csum_trailer *)(skb->data + len);
>>
>> -	if (!csum_trailer->valid) {
>> +	if (!u8_get_bits(csum_trailer->flags, MAP_CSUM_DL_VALID_FMASK)) {
> 
> Is that just an overcomplicated way of saying:
> 	if (!(csum_trailer->flags & MAP_CSUM_DL_VALID_FMASK)) {

Yes it is.  I defined and used all the field masks in a
consistent way, but I do think it will read better the
way you suggest.  Bjorn also asked me privately whether
GENMASK(15, 15) was just the same as BIT(15) (it is).

I will post version 3 of the series, identifying which
fields are single bit/Boolean.  For those I will define
the value using BIT() and will set/extract using simple
AND/OR operators.  I won't use the _FMASK suffix on such
fields.

Thanks a lot for your comment/question/suggestion.  I
like it.

					-Alex

>      David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

