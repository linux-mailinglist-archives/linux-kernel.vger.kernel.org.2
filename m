Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD0636EDB2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbhD2PzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbhD2Py7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:54:59 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D585C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:54:12 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id b17so54477648ilh.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=70fNwGQ2+wnm+RsZQ37LOGldOw8Lk2bCC2vptNmZyrQ=;
        b=oEVICcUeVEnXPNMN2DH0TbLTP5Ex38Q4NWBnvIO0sV+5D2i8TWzp6V+edgIvpk1Ah6
         SW6GKSl++6hSuIVKF4tSltHbb73hf3XbSOAGOl+fH/SPDOoMpurQm3lTgPZEYQ2EANnU
         9JISVKdlR8/YytrKr8z03+bUEm6Y3T7qCwmKFFPF7ykbaX/U0IkCoNgokxHoNbzWhJ+R
         ivMHm/gA0esFjjwV/LGgIgKuzghmWf/K5Ek6ALZn11oBC8RD/99vAixDacRh5ICtZS8l
         h8wtYCUV4CufDCjPq0VqB1f3p8qTYP2NfAhktxHNGvp13yh+EE3I/0P3b3BI17G8okYY
         ECRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=70fNwGQ2+wnm+RsZQ37LOGldOw8Lk2bCC2vptNmZyrQ=;
        b=L8+UQIxwkvf62SRHO5xvy1GFNtAdnOLpNnA6Xq733n0x23JtTbYTiQ4MDNcFYmzfyF
         a5y90dK47S05bl6BaxPC45yAnuPDi0eGZGxQNlHYrq9Hw+IyPYWUepFnfWVZDL3WO6vs
         39MZo+hlTT6GF9r60mjYLyO4awvKLLyKrb6qEzJtevYhD2gRnspYg/d/P7DEEUedpfp5
         PxQ+1I7e/p9wy7VLk82lTxeUPv0tDJ+7tXYmG0AcENmbcAGKCN2Xl3DzQe0eeaUOsaak
         CkpfS4c332RyK6WXVmut+G6v8saVinpKUhime7f/LMbg3ST6Q97yEUZO1zSLiMJDlcuS
         a2ZA==
X-Gm-Message-State: AOAM530d4WDUAjsttA3rl4yi/i8GzKQJGSOYYnr64ApPrV+GJ9kgFubr
        D9J2WGsD3FJv5VNOI4hyf5blOg==
X-Google-Smtp-Source: ABdhPJyoEgLRtMbV6qtNsLK18iz5OQwyuRm137+ckSle536tgpbGbK7/aLQWWWwlSp6UquiUV9Mo+A==
X-Received: by 2002:a92:6012:: with SMTP id u18mr320869ilb.92.1619711651814;
        Thu, 29 Apr 2021 08:54:11 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r11sm134797iob.1.2021.04.29.08.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 08:54:11 -0700 (PDT)
Subject: Re: [PATCH] smp: fix smp_call_function_single_async prototype
To:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jian Cai <jiancai@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210429150940.3256656-1-arnd@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <90e5aaa8-20d4-fbb7-1924-2dc1b6257824@kernel.dk>
Date:   Thu, 29 Apr 2021 09:54:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210429150940.3256656-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/21 9:09 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> As of commit 966a967116e6 ("smp: Avoid using two cache lines for struct
> call_single_data"), the smp code prefers 32-byte aligned call_single_data
> objects for performance reasons, but the block layer includes an instance
> of this structure in the main 'struct request' that is more senstive
> to size than to performance here, see 4ccafe032005 ("block: unalign
> call_single_data in struct request").
> 
> The result is a violation of the calling conventions that clang correctly
> points out:
> 
> block/blk-mq.c:630:39: warning: passing 8-byte aligned argument to 32-byte aligned parameter 2 of 'smp_call_function_single_async' may result in an unaligned pointer access [-Walign-mismatch]
>                 smp_call_function_single_async(cpu, &rq->csd);
> 
> It does seem that the usage of the call_single_data without cache line
> alignment should still be allowed by the smp code, so just change the
> function prototype so it accepts both, but leave the default alignment
> unchanged for the other users. This seems better to me than adding
> a local hack to shut up an otherwise correct warning in the caller.

I think that's the right approach, rather than work-around it in eg
blk-mq.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

