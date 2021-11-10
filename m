Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA2744BE11
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 10:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhKJJxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 04:53:31 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:44809 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhKJJx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:53:29 -0500
Received: by mail-ed1-f48.google.com with SMTP id j21so8064116edt.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 01:50:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KeIlVKt/9xSQQTs2L6NDOm0eWEpONTN7EdsmQwnJyHM=;
        b=PGP2Na4ZS+lL0pA47xBtjo4cWDLsx5yD2ayc494kfGsFlxTFZymCiDEV6zStH2vw/y
         MSYcPc+ZPivYqW2nO7mkA4V5nW/RfFNX5j46k33yC0YLzGMEENO84Zc8p9jBDXQzAnhu
         07M1IeAfrJzKmYoFiaOrp3U8+SxUax6vE6WVvnCwyVwT/2Vxaeqa7QGqGl74gumyAF3M
         eHUnCK0pOKgs5q28/mjrS9pWV0RH7UZN8cKXs71Bg7vMD0pH8Pe0AdWyYJA1g2UnsbLr
         RAzJhEvE7yibhnPFT/hdIpWTiTXtYKyf0MaxKY2p3DQ5OklX6r9F08xuqNlM/sE1D3Os
         WkBw==
X-Gm-Message-State: AOAM532jwbY16ugUgjYBuHa0q0lSzb0MWK18SOgwJAILfCB52CFv4HB2
        GpGKtpTnHnoB5PfoCh5+nsI=
X-Google-Smtp-Source: ABdhPJxKfaZW904QDKTo7q9yWc1H43QHgLcLPxIAtd3mUHIdQihHXv+xeNKdZIGKy5224MSbtl4xFw==
X-Received: by 2002:a17:907:7f8b:: with SMTP id qk11mr18953761ejc.313.1636537841497;
        Wed, 10 Nov 2021 01:50:41 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id g10sm12304528edr.56.2021.11.10.01.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 01:50:41 -0800 (PST)
Message-ID: <e2ff335d-5d21-345f-d899-8985477ffa53@kernel.org>
Date:   Wed, 10 Nov 2021 10:50:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v12 1/2] tty: hvc: pass DMA capable memory to put_chars()
Content-Language: en-US
To:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        gregkh@linuxfoundation.org, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com
Cc:     shile.zhang@linux.alibaba.com, sfr@canb.auug.org.au,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20211028150954.1356334-1-xianting.tian@linux.alibaba.com>
 <20211028150954.1356334-2-xianting.tian@linux.alibaba.com>
 <55b28b16-33f4-2a69-b2f1-6781d0241b99@kernel.org>
 <7dde342a-c2b7-32fe-7410-e372c82a4a68@linux.alibaba.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <7dde342a-c2b7-32fe-7410-e372c82a4a68@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 11. 21, 14:06, Xianting Tian wrote:
>> OTOH, you need c[N_OUTBUF] in the console case (hvc_console_print), but
>> not whole hvc_struct. So cons_hvcs should be an array of structs
>> composed of only the lock and the buffer.
> It is ok for me.
>> =============
>>
>> And I would do it even simpler now. One c[N_OUTBUF] buffer for all 
>> consoles and a single lock.
>>
>> And "char c" in struct hvc_struct.
>>
>> No need for the complex logic in hvc_console_print.
> 
> So you will implement this?

No, there is a slight difference between "I would" and "I will" :). I 
don't have anything to test this hvc change on…

thanks,
-- 
js
suse labs
