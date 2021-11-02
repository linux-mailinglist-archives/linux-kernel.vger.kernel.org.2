Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BE2442725
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 07:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhKBGgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 02:36:09 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:50875 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhKBGgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 02:36:09 -0400
Received: by mail-wm1-f42.google.com with SMTP id 133so5527556wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 23:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/iqE7dO8WNGbpVJBxdR3E5i6Fo6FPuhTcPAq49hulYI=;
        b=fPeA3khC2uOCMFkTjo6tmuHUV0VPbRTN2hbmSELulALJCDdf9j03mFfjchvh/K3KX4
         e9Z/5Qw09juwJYxmVGE8N3f1jxcqgYaGjGW2xUhcuk7V3Go7l4U7BrJoru1uNj67WX+x
         kGijE9JvD6A5dlOKQpxrDblJA1u5Uz45vdGipcgHkB6XnBkXrwlQh63SY0MXkT3iYv9b
         90X9cOkS66BRQGUL2RBtjEIJGDsk6QBWkuMHL0J7Govvm8kI7C5EfPYCARIKRp/cc+a7
         4CiI8EtEq1OBFnUVzvzmDlEUjfh1MK07wpROR9A5RP721Nhy20+AkauE23H5EZkmmJXb
         wmzw==
X-Gm-Message-State: AOAM530rSNH2QRpbOxcP+oH1DJRwLKiTVdPnf6jpEEDPHqk7zvxDzmDa
        tlUfKVfP+ryxBjuvZepKsdE=
X-Google-Smtp-Source: ABdhPJyjbofYFZEFSkDZzkjyL5u0jq640dqJMdekotBbvTnBd2qavVtozXmUfGCQANkLkAw86c4ATQ==
X-Received: by 2002:a1c:9ad4:: with SMTP id c203mr4466452wme.23.1635834813759;
        Mon, 01 Nov 2021 23:33:33 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id b197sm1454869wmb.24.2021.11.01.23.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 23:33:33 -0700 (PDT)
Message-ID: <55b28b16-33f4-2a69-b2f1-6781d0241b99@kernel.org>
Date:   Tue, 2 Nov 2021 07:33:31 +0100
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
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20211028150954.1356334-2-xianting.tian@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28. 10. 21, 17:09, Xianting Tian wrote:
> As well known, hvc backend can register its opertions to hvc backend.
> the operations contain put_chars(), get_chars() and so on.
> 
> Some hvc backend may do dma in its operations. eg, put_chars() of
> virtio-console. But in the code of hvc framework, it may pass DMA
> incapable memory to put_chars() under a specific configuration, which
> is explained in commit c4baad5029(virtio-console: avoid DMA from stack):
> 1, c[] is on stack,
>     hvc_console_print():
>          char c[N_OUTBUF] __ALIGNED__;
>          cons_ops[index]->put_chars(vtermnos[index], c, i);
> 2, ch is on stack,
>     static void hvc_poll_put_char(,,char ch)
>     {
>          struct tty_struct *tty = driver->ttys[0];
>          struct hvc_struct *hp = tty->driver_data;
>          int n;
> 
>          do {
>                  n = hp->ops->put_chars(hp->vtermno, &ch, 1);
>          } while (n <= 0);
>     }
> 
> Commit c4baad5029 is just the fix to avoid DMA from stack memory, which
> is passed to virtio-console by hvc framework in above code. But I think
> the fix is aggressive, it directly uses kmemdup() to alloc new buffer
> from kmalloc area and do memcpy no matter the memory is in kmalloc area
> or not. But most importantly, it should better be fixed in the hvc
> framework, by changing it to never pass stack memory to the put_chars()
> function in the first place. Otherwise, we still face the same issue if
> a new hvc backend using dma added in the furture.
> 
> In this patch, add 'char cons_outbuf[]' as part of 'struct hvc_struct',
> so hp->cons_outbuf is no longer the stack memory, we can use it in above
> cases safely. We also add lock to protect cons_outbuf instead of using
> the global lock of hvc.
> 
> Introduce array cons_hvcs[] for hvc pointers next to the cons_ops[] and
> vtermnos[] arrays. With the array, we can easily find hvc's cons_outbuf
> and its lock.

Hi,

this is still overly complicated IMO. As I already noted in:
https://lore.kernel.org/all/5b728c71-a754-b3ef-4ad3-6e33db1b7647@kernel.org/

this:
=============
In fact, you need only a single char for the poll case
(hvc_poll_put_char), so hvc_struct needs to contain only c, not an array.

OTOH, you need c[N_OUTBUF] in the console case (hvc_console_print), but
not whole hvc_struct. So cons_hvcs should be an array of structs
composed of only the lock and the buffer.
=============

And I would do it even simpler now. One c[N_OUTBUF] buffer for all 
consoles and a single lock.

And "char c" in struct hvc_struct.

No need for the complex logic in hvc_console_print.

> Introduce array cons_early_outbuf[] to ensure the mechanism of early
> console still work normally.


thanks,
-- 
js
suse labs
