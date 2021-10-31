Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318FC441071
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 20:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhJaTaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 15:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhJaTaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 15:30:15 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BD9C061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 12:27:42 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id t11so7626850ljh.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 12:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=V5/S9C66G0DHMWVujgT6AW2yL+Z8DSmr42TXOBZj6ZQ=;
        b=MyFkvskn4vvk4JibQW6Cjx0hLJfgjh/VZQkhxbXCj15B6SbCVM7Py0eDRG88HIYGRW
         I0AzWBqabAOFKmPgApTWYQYm7gP5fKowkZ1DGxRyw6Mib0MAB04oi77HDVMW79dtRPTq
         /Ai05P1rXjrLfjMPETFG8+D+sdowFZY8akZx/43xX6/gpxPILBZvjDVQuWTQSjAHLOEp
         xk0TaZrFEHKbMMEzq7yJ75h5e8OkxrRDVKgJiEsQU+Mj8DULLPVOX8cglRyp6IQJ6KiL
         zeDbOxo0Aya4ULrdU9LMdGq1tYtGY4kxDfCmryznZrEO2pL8FzEqrIGswms3UmlJ9Fjd
         Tmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=V5/S9C66G0DHMWVujgT6AW2yL+Z8DSmr42TXOBZj6ZQ=;
        b=8JeIRVtuzAyT+aFqh3xZFRJVKBWgFFGXw5oqu0F7/YUPUDDIoVvngqyaF0/d2dpKAg
         CwEXPmeblczAyNyEMlGFyowt5/Bqi7wAKnZHlZ6R+ezVthQA381HSn4pDfTQLlhdAvNu
         C6nxrYC24oOVFg2ST+Oqimi7/hscvUczTsPipPonJmL3ZsOa5mDoj51Lc3AMz2rjgWXH
         QMb10VYnWzyhaVj6gnyDZy1+NkL3xbjg7xtOe7ftZ9IzmTuwoFhrYWHa3RI7KkFjq2xN
         4iOSRtCUVatalLlorwyPFaXRcldZNh0zUEFAStNm6X1K6ytm0+q7dw7NBg28aor3wz8d
         irIw==
X-Gm-Message-State: AOAM533q8hgtOBTWnfBbnIxVs4GK92UpnnwbppgQ6SaUSQnkEBMGDejb
        D1wMeg8RAFvigHXGhmLxASs=
X-Google-Smtp-Source: ABdhPJx8kLiOA1sPzX39skSfEGqMOIuSjglYfy7pcXL6yG7oPDCR9bhTxt1FbxFUVwJ+KFzLzBQikg==
X-Received: by 2002:a05:651c:1549:: with SMTP id y9mr27220821ljp.327.1635708461105;
        Sun, 31 Oct 2021 12:27:41 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.235.8])
        by smtp.gmail.com with ESMTPSA id x14sm552614lfr.110.2021.10.31.12.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 12:27:40 -0700 (PDT)
Message-ID: <da61a07e-8ee8-8737-d110-c8b107cf7303@gmail.com>
Date:   Sun, 31 Oct 2021 22:27:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] staging: r8188eu: os_dep: remove the goto statement
Content-Language: en-US
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YX7cCtVss2RWOJ/a@Sauravs-MacBook-Air.local>
 <f26b4aec-c0a1-8c93-b34e-8b1a36ac81b3@gmail.com>
 <a74bd1d9-746c-650f-74e7-4a4b597348b7@gmail.com>
 <4c566e71-2426-b776-17a2-38f5f0b6f2b6@gmail.com>
In-Reply-To: <4c566e71-2426-b776-17a2-38f5f0b6f2b6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/21 22:24, Pavel Skripkin wrote:
>> I think rtw_init_default_value should return void. It's return value is not useful.
> 
> 
> Sure, but you need to firstly remove
> `ret8 = rtw_init_default_value(padapter);` and then make it return bool
								     ^^^^

I mean void, of course :)


With regards,
Pavel Skripkin
