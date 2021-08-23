Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C983F48C4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbhHWKg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:36:59 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:43936 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbhHWKg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:36:58 -0400
Received: by mail-wm1-f54.google.com with SMTP id o39-20020a05600c512700b002e74638b567so2770009wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kTX+zkKa0alsSXs8qwxcqmN4Mx9+u54mfcfnGWbSmsc=;
        b=F8LSQVip90LDCWup3Rs1FPjeT9dI37t0ghgE7wzBuB7/wGWegtOa4oa1HWhRQJA9C7
         l3tyyCba9RczKZNMvhckhWxxY2U6yI74sZH0y58N7YoKaw53HWNnnfmgMJ4OYw+15Chf
         Zz2JYUflvyv0b6gImgMF2rFn7ejCmYF1CcHmHK0Yb4CetvGA31qTr4WLmHfwCvTtjZMW
         UYWoCMQ5iW9uLx2pH4QbWv5sF5YMX8BfwsEd5H2XuqH/0ssaW132ciisu1g60a6B5ADC
         zTlLYCJXo6uQHHUW0gBmH15WYbz71LCyYHfDkGQvWnn/7jNy5wgYArqE2tyy3LvHnmfT
         lrMA==
X-Gm-Message-State: AOAM530ZPtgDp9pgb+N9uYvyvuYBA5yr9mQn8RyxS56W5+A6tcY2i88P
        ploV+o0eWCTfeznqUYrJvwg=
X-Google-Smtp-Source: ABdhPJx5MKsovyLBQKdDpGovJfQpG77APQ9BDa6K2jJnvFMigOY8OZfrHoZsyWvpwfc+IRp0EuU27g==
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mr15655264wmf.149.1629714974949;
        Mon, 23 Aug 2021 03:36:14 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id e3sm14997319wrv.65.2021.08.23.03.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 03:36:14 -0700 (PDT)
Subject: Re: [PATCH linux-next] serial: drop unneeded assignment
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        CGEL <cgel.zte@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210821021727.27170-1-luo.penghao@zte.com.cn>
 <dab03cf3-3fdd-8734-485b-469b57caf0e2@wanadoo.fr>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <f48ea2ed-c2a8-da6c-1ce9-20718e7c1f71@kernel.org>
Date:   Mon, 23 Aug 2021 12:36:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <dab03cf3-3fdd-8734-485b-469b57caf0e2@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 08. 21, 7:04, Christophe JAILLET wrote:
> Hi,
> 
> Le 21/08/2021 à 04:17, CGEL a écrit :
>> From: Luo penghao <luo.penghao@zte.com.cn>
>>
>> The first assignment is not used. In order to keep the code style
>> consistency of the whole file, the first 'offset' assignment should be
>> deleted.
>>
>> The clang_analyzer complains as follows:
>>
>> drivers/tty/nozomi.c:520:6: warning:
>> Although the value storedto 'offset' is used in the enclosing expression,
>> the value is never actually read from 'offset'.
>>
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: Luo penghao <luo.penghao@zte.com.cn>
>> ---
>>   drivers/tty/nozomi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
>> index 0454c78..210a48f 100644
>> --- a/drivers/tty/nozomi.c
>> +++ b/drivers/tty/nozomi.c
>> @@ -517,7 +517,7 @@ static void nozomi_setup_memory(struct nozomi *dc)
>>       /* Ctrl dl configuration */
>>       dc->port[PORT_CTRL].dl_addr[CH_A] =
>> -                (offset += dc->config_table.dl_app2_len);
>> +                (offset + dc->config_table.dl_app2_len);
> 
> I guess that it has been written that way for consistency reasons with 
> previous lines.
> 
> Should it be changed, you have the same pattern at line 554 that should 
> be updated the same way.

RIght.

Provided the code is always over two lines already, wouldn't it be more 
readable to calculate the offset before each line, not inline. Like:
         /* Modem port dl configuration */
         dc->port[PORT_MDM].dl_addr[CH_A] = offset;
	offset += dc->config_table.dl_mdm_len1;
         dc->port[PORT_MDM].dl_addr[CH_B] = offset;
... // the last one being:
         /* Ctrl dl configuration */
	offset += dc->config_table.dl_app2_len;
         dc->port[PORT_CTRL].dl_addr[CH_A] = offset;

That would 1) remove the warning too, 2) make it less error-prone / more 
readable.

thanks,
-- 
js
suse labs
