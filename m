Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1AE3EE743
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 09:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhHQHdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 03:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbhHQHda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 03:33:30 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA73C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 00:32:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id a20so23971656plm.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 00:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OmGjoPwRoQioipcSA3lcuU3i2adzPOju2P2is/uAIkQ=;
        b=pVnJAOXGmg6N9WpcoLwoGv6FSI2VUrPlhODr+6OGg9ggyE5FSefT4kC/j9ZXaWu+AP
         gy8mN4iyl9Q84JBHoE/htWADyU1/MTG7j8wVzT346I/P20PNNEjOHeJ7gsgpE+2wV61Z
         M9YzaX+ZQRnqoPzPI1385x5Ze66bAcLR6+G91yVcwyr+C5426940BPBLDtLgK0U1Nuq+
         GsvqR1zn1W0T9TGHsiTveF+MRIGgdoioNBywTZnSA2ItEy0ttewOZQd4Y8/7L7Aw6rWd
         Wr9L6HemLcKuIzrKCgDyoAYRREnXXfn9WBLoXjwtmkZyLNPxDwS8fX3m3snqEIb8SEwI
         y9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OmGjoPwRoQioipcSA3lcuU3i2adzPOju2P2is/uAIkQ=;
        b=enxvV8FId1dp0+sqsBM4w12MB4u9ZetBIMwLK6ddcvpXYWFQas+ypDAwuaU5dEKU9N
         vrylC2yyKtmBUE4VLxahi9dyUsCt3iknuwaQDbe1/VZArPo5sYLrQ0WCV+X2O3iKwYiq
         n+k6zbtEsu7DqJXwC6YLAe0I3ADzxefKaFxgdxXS3MfYQPrFSxpSHIXgFh8OjKYKZveR
         Y2FBACUvYY256/65yCGWfhw9CycxBEziTg1+wEp2Dd0VeP7HTfiJRXjAHw2CytsOAYci
         Pt5O05OYhB9ke8BdIn1vOS1u3BKe2Q3PVuELwIy1F1Ok3csiWtQYw4OnrYQzETjo0sGd
         IBKw==
X-Gm-Message-State: AOAM533DB1+DD/SNOYd2KORbSzPTTo4BENGP6lkFRhrR84+9LQYbTp76
        nCq2lwvkBYvTK/sO4UgEOCk=
X-Google-Smtp-Source: ABdhPJyiSPzAA1MHRo1eVK5qvZ4f9+4RBMZHH/IJ9YL7+giF9oSEkcUjduIHaXRAkmaQjwkBIXZ3Bg==
X-Received: by 2002:a17:90a:c705:: with SMTP id o5mr2235956pjt.55.1629185577147;
        Tue, 17 Aug 2021 00:32:57 -0700 (PDT)
Received: from [10.252.0.198] (ec2-54-250-108-108.ap-northeast-1.compute.amazonaws.com. [54.250.108.108])
        by smtp.gmail.com with ESMTPSA id z16sm1734052pgu.21.2021.08.17.00.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 00:32:56 -0700 (PDT)
Cc:     akira.tsukamoto@gmail.com
Subject: Re: [PATCH 0/1] __asm_copy_to-from_user: Reduce more byte_copy
To:     Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <65f08f01-d4ce-75c2-030b-f8759003e061@gmail.com>
 <a70451d1-57ad-6b49-24c1-6408ef94a959@gmail.com>
 <61187c37.1c69fb81.ed9bd.cc45SMTPIN_ADDED_BROKEN@mx.google.com>
 <a85be25a-3a67-2baa-531d-98fa4f292f30@gmail.com>
 <611a33ac.1c69fb81.12aae.89a5SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <62b045c0-28ae-5d59-a91b-a2edaf060a62@gmail.com>
Date:   Tue, 17 Aug 2021 16:32:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <611a33ac.1c69fb81.12aae.89a5SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qiu,


On 8/16/2021 6:45 PM, Qiu Wenbo wrote:
> Hi Akira,
> 
> 
> I can reproduce it on my HiFive Unmatched with a custom Gentoo rootfs. As pointed out by Andreas, there might be a missing fixup.  I'm going to debug this issue myself since I can reproduce it fairly stable.

Ah! Now I understand the bug.

> +    REG_L    a5, 0(a1)

should be 

+    fixup REG_L    a5, 0(a1)

If you do not mind, could you make the patch to add 'fixup' to all REG_S and REG_L?
Then I will resubmit them to Palmer with your patch.

Thanks,

Akira

> 
> 
> Qiu
> 
> 
> On 8/16/21 14:24, Akira Tsukamoto wrote:
>> Hi Qiu,
>>
>> On 8/15/2021 11:30 AM, Qiu Wenbo wrote:
>>> Hi Akira,
>>>
>>>
>>> This patch breaks my userspace  and I can't boot my system after applying this. Here is the stack trace:
>>>
>>>
>>> [   10.349080] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>>> [   10.357116] Oops [#15]
>>> [   10.359433] CPU: 2 PID: 169 Comm: (networkd) Tainted: G D           5.14.0-rc5 #53
>>> [   10.367422] Hardware name: SiFive HiFive Unmatched A00 (DT)
>>> [   10.372981] epc : __asm_copy_from_user+0x48/0xf0
>>> [   10.377584]  ra : _copy_from_user+0x28/0x68
>>> [   10.381754] epc : ffffffff8099a280 ra : ffffffff803614a8 sp : ffffffd00416bd90
>>> [   10.388963]  gp : ffffffff811ee540 tp : ffffffe0841b3680 t0 : ffffffd00416bde0
>>> [   10.396172]  t1 : ffffffd00416bdd8 t2 : 0000003ff09ca3a0 s0 : ffffffd00416bdc0
>>> [   10.403381]  s1 : 0000000000000000 a0 : ffffffd00416bdd8 a1 : 0000000000000000
>>> [   10.410590]  a2 : 0000000000000010 a3 : 0000000000000040 a4 : ffffffd00416be18
>>> [   10.417800]  a5 : 0000003ffffffff0 a6 : 000000000000000f a7 : ffffffe085d58540
>>> [   10.425009]  s2 : 0000000000000010 s3 : ffffffd00416bdd8 s4 : 0000000000000002
>>> [   10.432218]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : ffffffe0841b3680
>>> [   10.439427]  s8 : 0000002aad788040 s9 : 0000000000000000 s10: 0000000000000001
>>> [   10.446636]  s11: 0000000000000000 t3 : 0000000000000000 t4 : 0000000000000001
>>> [   10.453845]  t5 : 0000000000000010 t6 : 0000000000040000
>>> [   10.459144] status: 0000000200040120 badaddr: 0000000000000000 cause: 000000000000000d
>>> [   10.467049] [<ffffffff8099a280>] __asm_copy_from_user+0x48/0xf0
>>> [   10.472955] [<ffffffff8009a562>] do_seccomp+0x62/0x8be
>>> [   10.478079] [<ffffffff8009af58>] prctl_set_seccomp+0x24/0x32
>>> [   10.483725] [<ffffffff80020756>] sys_prctl+0xf6/0x450
>>> [   10.488763] [<ffffffff800034f2>] ret_from_syscall+0x0/0x2
>>>
>>>
>>> The PC register points to this line:
>>>
>>> +1:
>>> +    REG_L    a5, 0(a1)
>> Thanks for testing! Do you mind teaching me how to reproduce the error?
>>
>> Akira
>>
> 
> 
> 
