Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D5731EA0A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 13:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhBRMuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 07:50:52 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:38447 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhBRLEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 06:04:37 -0500
Received: by mail-lj1-f170.google.com with SMTP id j6so3677287ljo.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 03:04:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uSgPXcrr0bv/k9+aoMiPbU1h1HohLPWEr1ZB1KM7VSU=;
        b=BpO/xcDNySNLMpUUDkaKiuVLdUl0Wa+zIYx9md3Begpulpg+53eB5p2KLsCWJwT88D
         MXMNwcs85ksgtQvhpMLru7/LbPlB5fZQySWIMLCGcr2IQCb/VZNVFA8s7coG3BW4BS6s
         d56678RFxTQVE5TKsdgXAKeRcUjN6zNVWr7lLx2eKxTUNCrYf8gCTMHOY7Y+YpuPRhce
         adO6Qa0QNw9cA6WAojJSIhrKgeGdk5Y7B9jQakfvHpuMRB83Bh64I/RTaLvBy0IalYU8
         w3ZG/cQK/lH6pMg9/NAAKcnpZuxtMG+3oIlo8PQSpPv0ydIo+aHp4btXqrXSk/qBFW0i
         /DLQ==
X-Gm-Message-State: AOAM533apLJm/2s5E82hmI2vRwOAZhrBp5DWrzekkSP6EtDusAW7Gk5Z
        CBNCuYzqRqEw1WvAOFfWILn6y5ILyZkFlw==
X-Google-Smtp-Source: ABdhPJxPhsDjtWVUj4ksRrkssUUyVY+3QXund3Ixsh1OozHxG9dNcMFEhmo0IHDUDkxTNtoR9DPcZQ==
X-Received: by 2002:a2e:5753:: with SMTP id r19mr2248004ljd.374.1613646229702;
        Thu, 18 Feb 2021 03:03:49 -0800 (PST)
Received: from [10.68.32.147] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id a30sm563533ljq.96.2021.02.18.03.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 03:03:49 -0800 (PST)
Subject: Re: [PATCH] coccinelle: misc: add swap script
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
References: <20210216080133.455456-1-efremov@linux.com>
 <alpine.DEB.2.22.394.2102172224570.3081@hadrien>
 <c2b60288-3e46-14e3-9be2-3f75366a4b47@linux.com>
 <alpine.DEB.2.22.394.2102181114380.2748@hadrien>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <4e913cc4-cb86-4552-bced-a89cbecca3b2@linux.com>
Date:   Thu, 18 Feb 2021 14:03:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2102181114380.2748@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/21 1:17 PM, Julia Lawall wrote:
> 
> 
> On Thu, 18 Feb 2021, Denis Efremov wrote:
> 
>>
>>
>> On 2/18/21 12:31 AM, Julia Lawall wrote:
>>>> +@depends on patch@
>>>> +identifier tmp;
>>>> +expression a, b;
>>>> +type T;
>>>> +@@
>>>> +
>>>> +(
>>>> +- T tmp;
>>>> +|
>>>> +- T tmp = 0;
>>>> +|
>>>> +- T *tmp = NULL;
>>>> +)
>>>> +... when != tmp
>>>> +- tmp = a;
>>>> +- a = b;
>>>> +- b = tmp;
>>>> ++ swap(a, b);
>>>> +... when != tmp
>>>
>>> In this rule and the next one, if you remove the final ; from the b = tmp
>>> line and from the swap line, and put it into context code afterwards, them
>>> the generated code looks better on cases like fs/xfs/xfs_inode.c in the
>>> function xfs_lock_two_inodes where two successive swap calls are
>>> generated.
>>>
>>> There are also some cases such as drivers/net/wireless/ath/ath5k/phy.c in
>>> the function ath5k_hw_get_median_noise_floor where the swap code makes up
>>> a whole if branch.
>>
>>> In this cases it would be good to remove the {}.
>>
>> How this can be handled?
>>
>> If I use this pattern:
>> @depends on patch@
>> identifier tmp;
>> expression a, b;
>> @@
>>
>> (
>>   if (...)
>> - {
>> -       tmp = a;
>> -       a = b;
>> -       b = tmp
>> +       swap(a, b)
>>         ;
>> - }
>> |
>> -       tmp = a;
>> -       a = b;
>> -       b = tmp
>> +       swap(a, b)
>>         ;
>> )
>>
>> The tool fails with error:
>>
>> EXN: Failure("rule starting on line 58: already tagged token:\nC code
>> context\nFile \"drivers/net/wireless/ath/ath5k/phy.c\", line 1574,
>> column 4, charpos = 41650\n around = 'sort',\n whole content =
>> \t\t\t\tsort[j - 1] = tmp;") in drivers/net/wireless/ath/ath5k/phy.c
> 
> A disjunction basically says "at this node in the cfg, can I match the
> first patter, or can I match the second pattern, etc."  Unfortunately in
> this case the two branches start matching at different nodes, so the short
> circuit aspect of a disjunction isn't used, and it matches both patterns.
> 
> The solution is to just make two rules.  The first for the if case and the
> second for everything else.
> 

  if (...)
- {
-       tmp = a;
-       a = b;
-       b = tmp
+       swap(a, b)
        ;
- }


This produces "single-line ifs".
Maybe generated patches can be improved somehow?
Moving -+; doesn't help in this case.

diff -u -p a/drivers/net/wireless/ath/ath9k/calib.c b/drivers/net/wireless/ath/ath9k/calib.c
--- a/drivers/net/wireless/ath/ath9k/calib.c
+++ b/drivers/net/wireless/ath/ath9k/calib.c
@@ -32,11 +32,7 @@ static int16_t ath9k_hw_get_nf_hist_mid(
 
        for (i = 0; i < ATH9K_NF_CAL_HIST_MAX - 1; i++) {
                for (j = 1; j < ATH9K_NF_CAL_HIST_MAX - i; j++) {
-                       if (sort[j] > sort[j - 1]) {
-                               nfval = sort[j];
-                               sort[j] = sort[j - 1];
-                               sort[j - 1] = nfval;
-                       }
+                       if (sort[j] > sort[j - 1]) swap(sort[j], sort[j - 1]);
                }
        }
        nfval = sort[(ATH9K_NF_CAL_HIST_MAX - 1) >> 1];
diff -u -p a/drivers/net/wireless/ath/ath9k/ar9003_calib.c b/drivers/net/wireless/ath/ath9k/ar9003_calib.c
--- a/drivers/net/wireless/ath/ath9k/ar9003_calib.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_calib.c
@@ -1011,19 +1011,11 @@ static void __ar955x_tx_iq_cal_sort(stru
                for (ix = 0; ix < MAXIQCAL - 1; ix++) {
                        for (iy = ix + 1; iy <= MAXIQCAL - 1; iy++) {
                                if (coeff->mag_coeff[i][im][iy] <
-                                   coeff->mag_coeff[i][im][ix]) {
-                                       temp = coeff->mag_coeff[i][im][ix];
-                                       coeff->mag_coeff[i][im][ix] =
-                                               coeff->mag_coeff[i][im][iy];
-                                       coeff->mag_coeff[i][im][iy] = temp;
-                               }
+                                   coeff->mag_coeff[i][im][ix]) swap(coeff->mag_coeff[i][im][ix],
+                                                                     coeff->mag_coeff[i][im][iy]);
                                if (coeff->phs_coeff[i][im][iy] <
-                                   coeff->phs_coeff[i][im][ix]) {
-                                       temp = coeff->phs_coeff[i][im][ix];
-                                       coeff->phs_coeff[i][im][ix] =
-                                               coeff->phs_coeff[i][im][iy];
-                                       coeff->phs_coeff[i][im][iy] = temp;
-                               }
+                                   coeff->phs_coeff[i][im][ix]) swap(coeff->phs_coeff[i][im][ix],
+                                                                     coeff->phs_coeff[i][im][iy]);

Thanks,
Denis
