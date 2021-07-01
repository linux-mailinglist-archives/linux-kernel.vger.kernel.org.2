Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FC13B8DAA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 08:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhGAGSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 02:18:04 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:44812 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbhGAGSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 02:18:02 -0400
Received: by mail-wm1-f45.google.com with SMTP id m9-20020a05600c3b09b02901f246b43bbeso3217386wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 23:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6CT8LZeGU4LfOF5lMwqGqN5rOpjlcG9LDR290/wD/k0=;
        b=QaGWAoD2PBCUny6UWBEyBStHPhJ8Px4K9DU56hdFSjGAQ3GdcDKgSxLGaNXIy+rZpw
         45OCHGxY0UluT6uVkM+mlbhukFzUz6/7huInJnBNTUerkGftbq9xD+bupQ9yGgDhLbo4
         AMxekA4hQKJXNHMe6b3oBRe/7qYzlGLfi5lU249LFnJ7ZHOFGYIAvcTVN/+gNaROXsJ0
         IgORiZuz3nB8yI+c5YOE7GmRzKR3RybLeuwFZ+okVTMJ/reNpCfwJHQ7Hp402KuFlzoG
         f45U31q/d4RfMwwK5XyjmRdO/ZEzLPNnM4E7XnonIlBWcvjQ7dO/uDKhGIi3G+Lx1/Q5
         bmMg==
X-Gm-Message-State: AOAM531elDCDWWCdwS1uyNjC4oBbJvuHPMZzINLmlOxAUHWjBztUjF0Q
        1Jq3Iq7tiqotNQ3zglUwzvR43yNQ6kjBgw==
X-Google-Smtp-Source: ABdhPJwJiHi+iL/g8LEYOyOFBty1cmf//RzSKrI8jFwzT/NzPH1+M1nMG9dNsqJD8sE0ZeEkfzbyvg==
X-Received: by 2002:a7b:c20d:: with SMTP id x13mr43211692wmi.134.1625120130047;
        Wed, 30 Jun 2021 23:15:30 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id p15sm21829866wmq.43.2021.06.30.23.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 23:15:29 -0700 (PDT)
Subject: Re: [PATCH] tty: n_gsm: delete SABM command frame as requester
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Zhenguo Zhao <zhenguo6858@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <1625108078-16491-1-git-send-email-zhenguo6858@gmail.com>
 <695b2537-28e0-90c4-d516-727dfeead12d@kernel.org>
Message-ID: <5cb496dc-eac1-124e-397d-0c58f5d4a7a1@kernel.org>
Date:   Thu, 1 Jul 2021 08:15:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <695b2537-28e0-90c4-d516-727dfeead12d@kernel.org>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01. 07. 21, 8:13, Jiri Slaby wrote:
> On 01. 07. 21, 4:54, Zhenguo Zhao wrote:
>> From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
>>
>> as initiator,it need to send SABM conmmand ,as requester,there is
>> no need to send the SABM control frame,it will cause redundant data.
> 
> Hi,
> 
> is there any document you can refer to? I am still confused so I don't 
> understand why this didn't matter until now. Maybe you only need to 
> explain better the whole point behind the introduced initiator/requester 
> functionality.

Having written that, I am missing the WHY part. E.g. why it causes 
redundant data.

> In any way, could you use spell checker on the commit log (like 
> "conmmand")?
> 
>> Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
>> ---
>>   drivers/tty/n_gsm.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
>> index 5fea02c..e66418b 100644
>> --- a/drivers/tty/n_gsm.c
>> +++ b/drivers/tty/n_gsm.c
>> @@ -3005,8 +3005,9 @@ static int gsmtty_open(struct tty_struct *tty, 
>> struct file *filp)
>>       /* We could in theory open and close before we wait - eg if we get
>>          a DM straight back. This is ok as that will have caused a 
>> hangup */
>>       tty_port_set_initialized(port, 1);
>> -    /* Start sending off SABM messages */
>> -    gsm_dlci_begin_open(dlci);
>> +    /* Start sending off SABM messages for initiator */
>> +    if (gsm->initiator)
>> +        gsm_dlci_begin_open(dlci);
>>       /* And wait for virtual carrier */
>>       return tty_port_block_til_ready(port, tty, filp);
>>   }
>>
> 
> thanks,


-- 
js
suse labs
