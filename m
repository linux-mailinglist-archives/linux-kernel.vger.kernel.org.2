Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6790B3E0FEF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239001AbhHEIKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:10:06 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:37876 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbhHEIKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:10:04 -0400
Received: by mail-wr1-f51.google.com with SMTP id d8so5332551wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 01:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wOvvcGOWNL43pF5gzZ1KGiUW3rYoHQr+5VBEfIZFYow=;
        b=fZ/VmSL8cdzLWoBksdPq1hw9/zlBCehIN+5XsiA8Saa17MoTaos6k7aVY1Dy2rlXVX
         CB/G74lP22eEA4DFMN340DMiW3HilpdArs/sQnHCg3fo/rT7dtsqbRLiZc9Ujupttrkj
         IgRer8FBffkXL7XfL7xMJt3oXKFP0SqWuecPN1REzugienO7G9fSW1eS6mvHwrg380RE
         /x/R7kD6RLN2TLwMTmQtEEwN3iVNZXHHelVSnurKK3Ai8LsYISPvNJd5gledAhKlpIeH
         KC4buO0hbNLQ3Qfrl0WOe8G59zZ1GyNHs0JTV8U/npngRgnq7HkZSIXUNqLhhK3ec2CG
         27fQ==
X-Gm-Message-State: AOAM533gWsmUq+sY3TB1qwkkRjcArc4B14p7QnL4wrBdIrAj+/7MHKMr
        vX9Kw1ueyWxMU0iZYHBgQ9uxrJEeg7iHigSE
X-Google-Smtp-Source: ABdhPJza9yPxZ/Yp1GJ6J7eu3qML/uunC/YdJrWn4YIzJejETB/deUbtlehxI2PyWD7B9IGNnmfT1A==
X-Received: by 2002:a5d:6691:: with SMTP id l17mr3681771wru.368.1628150988580;
        Thu, 05 Aug 2021 01:09:48 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id i5sm5215326wrs.85.2021.08.05.01.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 01:09:48 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] tty: hvc: pass DMA capable memory to put_chars()
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        gregkh@linuxfoundation.org, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210804025453.93543-1-xianting.tian@linux.alibaba.com>
 <0f26a1c3-53e8-9282-69e8-8d81a9cafc59@kernel.org>
Message-ID: <f1b92c7d-0eaf-4eac-ecd2-fbb74fb63b52@kernel.org>
Date:   Thu, 5 Aug 2021 10:09:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <0f26a1c3-53e8-9282-69e8-8d81a9cafc59@kernel.org>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 08. 21, 9:58, Jiri Slaby wrote:
> Hi,
> 
> On 04. 08. 21, 4:54, Xianting Tian wrote:
>> @@ -933,6 +949,16 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, 
>> int data,
>>       hp->outbuf_size = outbuf_size;
>>       hp->outbuf = &((char *)hp)[ALIGN(sizeof(*hp), sizeof(long))];

This deserves cleanup too. Why is "outbuf" not "char outbuf[0] 
__ALIGNED__" at the end of the structure? The allocation would be easier 
(using struct_size()) and this line would be gone completely.

>> +    /*
>> +     * hvc_con_outbuf is guaranteed to be aligned at least to the
>> +     * size(N_OUTBUF) by kmalloc().
>> +     */
>> +    hp->hvc_con_outbuf = kzalloc(N_OUTBUF, GFP_KERNEL);
>> +    if (!hp->hvc_con_outbuf)
>> +        return ERR_PTR(-ENOMEM);
> 
> This leaks hp, right?

Actually, why don't you make
char c[N_OUTBUF] __ALIGNED__;

part of struct hvc_struct directly?

> BTW your 2 patches are still not threaded, that is hard to follow.
> 
>> +
>> +    spin_lock_init(&hp->hvc_con_lock);
>> +
>>       tty_port_init(&hp->port);
>>       hp->port.ops = &hvc_port_ops;
> 
> thanks,
-- 
js
suse labs
