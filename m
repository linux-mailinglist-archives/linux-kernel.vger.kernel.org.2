Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A759F427C8C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 20:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhJISQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 14:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhJISQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 14:16:14 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DDEC061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 11:14:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q10-20020a17090a1b0a00b001a076a59640so599893pjq.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 11:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:cc:subject:content-language
         :to:references:from:in-reply-to:content-transfer-encoding;
        bh=CWTfgGVMFavm0exUxVdTkCtIcKrvf9YPDx3Ir4BnYtw=;
        b=c1eo5pMoZ8D3d5OHrwfUmncEOTMBHFRzaKZ0bSlOKbTxdp8alBrJKYkUW+bvweZC5H
         AgDGZi7KpbzygMqVoloF4WMpJ6crGC6SouYMPf6sIwynandTcsPUIpn7731SoK8xRskd
         ibavPN/k5OvtkDTDUChlxoWGRnIxH5/WaMfGN9m71tjNxZ5mtNSK+AlN6GSVK8kjIH+H
         hrL1pGpn65Zwex6ZixlJgcZcaXvptbIwJE5ErPNkCiv4aXMmIuJ+3bYxV8MiGstIHB2O
         IgY9ox2OTzL7U8cAVPLEls9a6fZ9X2r5IRW53i8KBmDBHZKdEUlvuhkpdPuwoOKgrVza
         xWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CWTfgGVMFavm0exUxVdTkCtIcKrvf9YPDx3Ir4BnYtw=;
        b=Qd0eINxU2WooCEOg/Fgh0eJn7DmVWgZLall2m8L3DuJratxHbhJYgG6AhteqVJg7bJ
         Ti0Otvfbq7OS8WC50CDFxb+mxlHhsYs1Atl5GHmGThxzjQZmBFbipehgj3p0uJUORBAb
         OoIfyF6Fsd9+DsTUjXa3Is2ss89nz6IWzqXxDtqeQo58XpMtMaMvfJfywl4150CM1Opu
         vDth9FdJ84658mOKTzwj/8Lw99VXMgL5/Cib967UjCr1nlO822BEIE1O0XFnr8h12x4P
         UG0j3bLoCPpX6PaHvBF01nJPfQV24U78y3WXB/5p/1oQMK954kOBeSopupg779GHkJOF
         aGCw==
X-Gm-Message-State: AOAM530BjqYqVwVhi0bxiwQcqpbI+/2jmkKjTaFnQ0MhKDufjDTEixQw
        TeZO+ovo58O3XxbUxPxBLK3tEKFxleQO9A==
X-Google-Smtp-Source: ABdhPJx2PaxFMJ+bGQ+4Yd1uSd6YhKMjs/22VwAMQrP9jIODuUeH+oor6WlHrnHzc9gsGb3QXDaC7w==
X-Received: by 2002:a17:90a:ad46:: with SMTP id w6mr3569886pjv.68.1633803256542;
        Sat, 09 Oct 2021 11:14:16 -0700 (PDT)
Received: from [192.168.1.6] ([223.230.43.197])
        by smtp.gmail.com with ESMTPSA id k3sm14416293pjg.43.2021.10.09.11.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 11:14:16 -0700 (PDT)
Message-ID: <b9dcf405-3436-983f-143c-a429ce9598cf@gmail.com>
Date:   Sat, 9 Oct 2021 23:44:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Cc:     saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: rtl8723bs: core: simplify the if condition
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, gregkh@linuxfoundation.org,
        fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        deborahbrouwer3563@gmail.com, marcocesati@gmail.com,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <YWEwFf0YMi4W1xKN@user>
 <94cb79ea-1952-c92c-f5c9-f03f7b1a892c@redhat.com>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <94cb79ea-1952-c92c-f5c9-f03f7b1a892c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/21 10:21 pm, Hans de Goede wrote:
> Hi,
> 
> On 10/9/21 8:00 AM, Saurav Girepunje wrote:
>> if psta is NULL, function is returning with fail. On next if condition
>> again checking if psta is not a NULL. Remove multiple if condition check.
>>
>> Function is already using goto exit statement to exit.Replace multiple
>> return with goto exit statement.
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>   drivers/staging/rtl8723bs/core/rtw_xmit.c | 61 ++++++++++-------------
>>   1 file changed, 26 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
>> index 34505b35a7f3..4e4a1bed882b 100644
>> --- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
>> +++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
>> @@ -932,49 +932,40 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
>>   		/* TODO: fill HT Control Field */
>>
>>   		/* Update Seq Num will be handled by f/w */
>> -		{
>> -			struct sta_info *psta;
>> -
>> -			psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
>> -			if (pattrib->psta != psta)
>> -				return _FAIL;
>> -
>> -			if (!psta)
>> -				return _FAIL;
>> +		struct sta_info *psta;
> 
> You are now declaring a variable after some statements, this will
> cause a compiler warning in some cases. Please move this variable
> declaration up, grouping it together with the other variable
> declarations.
> 
Yes, I will move variable declaration to up.
>>
>> -			if (!(psta->state & _FW_LINKED))
>> -				return _FAIL;
>> +		psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
>> +		if (!psta || pattrib->psta != psta || !(psta->state & _FW_LINKED))
>> +			res = _FAIL;
>> +			goto exit;
> 
> You are both removing an identation level here because you are removing
> the compound statement which contained the psta declaration as well
> as refactoring the code.
> 
> Please split this into 2 separate commits, 1 where you only drop the
> extra indentation level (and move the psta declaration up).
> 
> And then a separate commit which just the actual code changes.
> 
> Your current patch is very hard to review because you are doing
> 2 things at once.
> 
> Also it looks like this patch depends on your previous patch:
> "[PATCH] staging: rtl8723bs: core: remove empty else section"
> 
> When patches depend on each other please send them together
> as a single patch series. E.g. for version 2 (v2) of a 3 patch
> series consisting of the last 3 commits in your local tree use
> (so the next version of these patches) use:
> 
> git format-patch -v2 --cover-letter HEAD~3
> $editor v2-0000-cover-letter.patch
>   <describe series contents + what was changed in the cover-letter>
> git send-email v2-00*.patch
> 
> Regards,
> 
> Hans
>
Sure, I will split this patch and resend all of them as a single patch 
series including my previous patch.

> 
>>
>> -			if (psta) {
>> -				psta->sta_xmitpriv.txseq_tid[pattrib->priority]++;
>> -				psta->sta_xmitpriv.txseq_tid[pattrib->priority] &= 0xFFF;
>> -				pattrib->seqnum = psta->sta_xmitpriv.txseq_tid[pattrib->priority];
>> +		psta->sta_xmitpriv.txseq_tid[pattrib->priority]++;
>> +		psta->sta_xmitpriv.txseq_tid[pattrib->priority] &= 0xFFF;
>> +		pattrib->seqnum = psta->sta_xmitpriv.txseq_tid[pattrib->priority];
>>
>> -				SetSeqNum(hdr, pattrib->seqnum);
>> +		SetSeqNum(hdr, pattrib->seqnum);
>>
>> -				/* check if enable ampdu */
>> -				if (pattrib->ht_en && psta->htpriv.ampdu_enable)
>> -					if (psta->htpriv.agg_enable_bitmap & BIT(pattrib->priority))
>> -						pattrib->ampdu_en = true;
>> +		/* check if enable ampdu */
>> +		if (pattrib->ht_en && psta->htpriv.ampdu_enable)
>> +			if (psta->htpriv.agg_enable_bitmap & BIT(pattrib->priority))
>> +				pattrib->ampdu_en = true;
>>
>> -				/* re-check if enable ampdu by BA_starting_seqctrl */
>> -				if (pattrib->ampdu_en == true) {
>> -					u16 tx_seq;
>> +		/* re-check if enable ampdu by BA_starting_seqctrl */
>> +		if (pattrib->ampdu_en == true) {
>> +			u16 tx_seq;
>>
>> -					tx_seq = psta->BA_starting_seqctrl[pattrib->priority & 0x0f];
>> +			tx_seq = psta->BA_starting_seqctrl[pattrib->priority & 0x0f];
>>
>> -					/* check BA_starting_seqctrl */
>> -					if (SN_LESS(pattrib->seqnum, tx_seq)) {
>> -						pattrib->ampdu_en = false;/* AGG BK */
>> -					} else if (SN_EQUAL(pattrib->seqnum, tx_seq)) {
>> -						psta->BA_starting_seqctrl[pattrib->priority & 0x0f] = (tx_seq+1)&0xfff;
>> +			/* check BA_starting_seqctrl */
>> +			if (SN_LESS(pattrib->seqnum, tx_seq)) {
>> +				pattrib->ampdu_en = false;/* AGG BK */
>> +			} else if (SN_EQUAL(pattrib->seqnum, tx_seq)) {
>> +				psta->BA_starting_seqctrl[pattrib->priority & 0x0f] = (tx_seq+1)&0xfff;
>>
>> -						pattrib->ampdu_en = true;/* AGG EN */
>> -					} else {
>> -						psta->BA_starting_seqctrl[pattrib->priority & 0x0f] = (pattrib->seqnum+1)&0xfff;
>> -						pattrib->ampdu_en = true;/* AGG EN */
>> -					}
>> -				}
>> +				pattrib->ampdu_en = true;/* AGG EN */
>> +			} else {
>> +				psta->BA_starting_seqctrl[pattrib->priority & 0x0f] = (pattrib->seqnum+1)&0xfff;
>> +				pattrib->ampdu_en = true;/* AGG EN */
>>   			}
>>   		}
>>   	}
>> --
>> 2.32.0
>>
> 

Thanks Hans for review.

Regards,
Saurav
