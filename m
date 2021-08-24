Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013443F6193
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbhHXP1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbhHXP1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:27:10 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C521C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:26:26 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id c12so38394252ljr.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=IfNLo6XWntq1Wmj3xOxBjBPVMVX60+WnVKGv8fh5Bx4=;
        b=smQr5KCKJKPrkfE5e+w6mTJQoEgmR6NhXHZMAyO8q4bZMoaD5pVjEyp0/vCdLakoyB
         gZJhaP22T6RClou4z1NpiwzWOKRQTRlZl3CRW61y08+UdJ9xzoU+AoYRo/AAfIoebc1m
         bYHfBaKQ/YcvEy2I1BbV/hjzoXC+JSt3wpAHLGfjxkujuUoojh36UgDxQOX5RmK1DP8p
         LElEQN2MbKlNB64mXAevtbcWVOJpYit3rfsmp87bcBClyzQiAAueV2SDweK13xCZaaEX
         FeF5t0SiBKUTUDDI7Yg1WN4ccC3Fh/u6X6eJVvv2DBiWgKiYI/L7GS8636SAEKDueopx
         zyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IfNLo6XWntq1Wmj3xOxBjBPVMVX60+WnVKGv8fh5Bx4=;
        b=HbANTUK4EmsqqD7meowzlfIgUiw8NPICUxly8bgV/PfSwYv2fNSbfex6ShDWwOjs0V
         cpHlflzTStMVDOZXfPnryUucco1xD/Ud3F0CHfEeUjtkf3FejJAPE9Jq58gw0R3fU8EH
         POjZLyp6Q3zqpm5dVMrB8Ygh1ZMSruxbG+TqAQNhm5ll4VYTspXkT0f+PBsD6HMyrKAp
         TghbnVavk3t+mXhsQ7k95iTfXx7Q57hcxQOHEZB52d4A/WGI2NNtnHWC9siVe4UtwyRH
         SDdmMt1CjuwyTWS7lPBvwV5H1v4Wx4dspGwsX28m9AhLhsG4oy+TpAvPGAL22zHSjGO1
         09TA==
X-Gm-Message-State: AOAM531wzoqusEDtNn37Z19ezeuWZtUlh8qDj2N8My+f3x5DZyLPV9FW
        vzYG5HV2XU/vVTvZ+Fn8dgc=
X-Google-Smtp-Source: ABdhPJwlw6JyfStHHTsxrwcvaFP9yFsWOSgdMqA5ceUsYmvTA9sUl4m6hqfHat5kzuH78zodzxx9OQ==
X-Received: by 2002:a05:651c:993:: with SMTP id b19mr4233933ljq.139.1629818784905;
        Tue, 24 Aug 2021 08:26:24 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id bq10sm1779701lfb.25.2021.08.24.08.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 08:26:24 -0700 (PDT)
Subject: Re: [PATCH 2/2] staging: r8188eu: Make some clean-ups in
 usbctrl_vendorreq()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20210824142823.16845-1-fmdefrancesco@gmail.com>
 <20210824142823.16845-3-fmdefrancesco@gmail.com>
 <27c7e4ef-06a8-2f0c-d388-1a64e7d4a735@gmail.com>
 <3740714.KPokl01s95@localhost.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <17234f07-debc-5b6c-244d-472a3f33bc3f@gmail.com>
Date:   Tue, 24 Aug 2021 18:26:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3740714.KPokl01s95@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 6:15 PM, Fabio M. De Francesco wrote:
> On Tuesday, August 24, 2021 4:39:51 PM CEST Pavel Skripkin wrote:
>> On 8/24/21 5:28 PM, Fabio M. De Francesco wrote:
>> > After replacing usb_control_msg() with the new usb_control_msg_recv() and
>> > usb_control_msg_send() API of USB Core, remove camelcase from the pIo_buf
>> > variable that is passed as argument to the new API and remove the initial
>> > 'p' (that probably stands for "pointer") from the same pIo_buf and from
>> > the pintfhdl and pdata arguments of usbctrl_vendorreq().
>> > 
>> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>> > ---
>> >   drivers/staging/r8188eu/hal/usb_ops_linux.c | 22 ++++++++++-----------
>> >   1 file changed, 11 insertions(+), 11 deletions(-)
>> > 
>> 
>> I cannot apply this one on top of the first one:
>> 
>> error: patch failed: drivers/staging/r8188eu/hal/usb_ops_linux.c:33
>> error: drivers/staging/r8188eu/hal/usb_ops_linux.c: patch does not apply
>> 
>> With regards,
>> Pavel Skripkin
> 

I found the problem:

>  	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
>  
>  	/*  Acquire IO memory for vendorreq */
> -	pIo_buf = dvobjpriv->usb_vendor_req_buf;
> +	io_buf = dvobjpriv->usb_vendor_req_buf;


I don't know from where mutex_lock() comes from. In staging-next I have

_enter_critical_mutex(&dvobjpriv->usb_vendor_req_mutex, NULL);

instead of

mutex_lock(&dvobjpriv->usb_vendor_req_mutex);




With regards,
Pavel Skripkin
