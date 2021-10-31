Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FC744106F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 20:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhJaT1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 15:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhJaT1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 15:27:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C895C061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 12:24:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i3so2689418lfu.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 12:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IOFynaXj47+DlqNhfU/d4IsE5HjN1tVc9N4cO4MmET4=;
        b=kLYYLH6ym+E5ktJuXPLBZX/GA3OEUMfSiDLKmPa6/lfv2h77RM0GMhSarcOIp4dXdG
         Pww/RZDBZL0LGxHtfPPNyDWO0HOgNuv4ysrj6aqljL45CsXSS7te598+2Lk0Q9cIbI8j
         hMttMDOtCe/QCXzhTrKtnn7KeW72ujCJ0qZBHzEnppvn71ysMn9CRRXmOCsudy6sAjEX
         Lbk1GajoXG+2kpo+tBJVi6fY0x7G2mxRN/tSv9joTeKfXJhCwLwfzGpGu6zE/aT990Uk
         yIzvXYZ4QM+RMllNWuW1xWda4niImeBYbEGmQy5ApWZdHxVv4OpW/kPEMxHMHEVLAExr
         NFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IOFynaXj47+DlqNhfU/d4IsE5HjN1tVc9N4cO4MmET4=;
        b=bJU4sp1jsDuNqm5M8vDdeuUgPzg2xP0ZYQfGM+wCezYON75JvS12HzmaNSKcgpXYjv
         74L3OyAEOsrLXxvPHhwalJzrAJrByl8HvYMnEmwSxGZ/qnyotT/J670RJ/NVTbm6Taur
         k7SxTh+ikThURG7LX2aSK24CSlp+kHUhrhSbUHqkgWz9DV0ZpvMmg5n4t59f82y45oZZ
         eMIsukaQf+zE8y/dLTn450Foxwkv+r0IihgV6fCXQsJq6AVmncuk9+AIAbkuQwIEYL7f
         Wqy3qq5+ZmH9pE7vUN1gas/6rdhKlTZbMdXeGffZU12sNTQx0QeGfjPSkVCacnjeokCw
         9jfQ==
X-Gm-Message-State: AOAM533dqWpSU66+eI/Dba+WBXc4jz8kN8QrecNfi9MoGghG4Cum/PNH
        JkQ8skd5w62Qz71qoIFuJ44=
X-Google-Smtp-Source: ABdhPJwhUZwQ0GJzjtU0NSS/3I7Zy/M+1iHcobVO6SbTJt0eMDNn00oT7qLB3FxdrBiwhATxabDuhQ==
X-Received: by 2002:ac2:5298:: with SMTP id q24mr22998841lfm.529.1635708282338;
        Sun, 31 Oct 2021 12:24:42 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.235.8])
        by smtp.gmail.com with ESMTPSA id m8sm289856lfr.28.2021.10.31.12.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 12:24:41 -0700 (PDT)
Message-ID: <4c566e71-2426-b776-17a2-38f5f0b6f2b6@gmail.com>
Date:   Sun, 31 Oct 2021 22:24:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] staging: r8188eu: os_dep: remove the goto statement
Content-Language: en-US
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YX7cCtVss2RWOJ/a@Sauravs-MacBook-Air.local>
 <f26b4aec-c0a1-8c93-b34e-8b1a36ac81b3@gmail.com>
 <a74bd1d9-746c-650f-74e7-4a4b597348b7@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <a74bd1d9-746c-650f-74e7-4a4b597348b7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/21 22:17, Saurav Girepunje wrote:
> 
> 
> On 01/11/21 12:13 am, Pavel Skripkin wrote:
>> On 10/31/21 21:10, Saurav Girepunje wrote:
>>> Remove the goto statement from rtw_init_drv_sw(). In this function goto
>>> can be replace by return statement. As on goto label exit, function
>>> only return it is not performing any cleanup. Avoiding goto will
>>> improve the function readability.
>>>
>>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>>> ---
>>>   drivers/staging/r8188eu/os_dep/os_intfs.c | 39 +++++++----------------
>>>   1 file changed, 12 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
>>> index 1418c9c4916c..4b409479108e 100644
>>> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
>>> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
>>> @@ -480,48 +480,34 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
>>>   {
>>>       u8    ret8 = _SUCCESS;
>>>
>> 
>> 
>> Btw, this variable can be removed completely then. It's used only for:
>> 
>> ret8 = rtw_init_default_value(padapter);
>> 
>> with your patch applied, but rtw_init_default_value() always returns _SUCCESS.
>> 
> I think rtw_init_default_value should return void. It's return value is not useful.


Sure, but you need to firstly remove
`ret8 = rtw_init_default_value(padapter);` and then make it return bool 
to not break the build.


With regards,
Pavel Skripkin
