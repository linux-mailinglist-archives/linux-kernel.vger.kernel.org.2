Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6CF3E926D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhHKNTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhHKNTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:19:14 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2119C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:18:50 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so4792813pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cK1OcsU/Xxbl5ieYWkgmE/ytFhLsP50rySoQpfc3oAg=;
        b=BVTNKJvYkHzNgRaoeCNeZgJIAgdNL59o/KvP8U9cFgIi56EQT6T5uuJ+AGP1IRszAQ
         4mpWSVKbgPf2/3ueYDD976pR0SxbMT3LkReRIIc7VHH09AiRlPrhZ/sqVYANlBMb3XTK
         rrWK534CjIvSUIDC+ggIkceNQgY6dYnosRUhPEgaUkcSEQ7r7jWt3QIxpF35ShLa4w38
         fctHNS9dJwCZZHvI3SGK1c75gS8AELJAblsRjeaPA8XxYeVWrLYwZaiP7SZWVNiUymdc
         KzwU+yQzvlcUZJomdNNRdLlkIHgmo6X/KEiUjvh+S5n7E3olyaOHYzU/LTBdGKqcStaM
         xZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cK1OcsU/Xxbl5ieYWkgmE/ytFhLsP50rySoQpfc3oAg=;
        b=cWvzjQ74UTTRDMDV8l9mgypfS4DtPH6DzVe/FXkMKHrti6aO8keChQu0InwdBhy1R3
         A6P8eKmdkbymBIcoTyBVr7+EprHtQAqT5uosMt4hMa+KtI5/7usb2RI+McRXEftCxtyp
         ua/Zlnv4okEr9Lk4zN/sIHYENE7Wbqz342jOM/VX69zMknf5R/Sbindne+ZY0x0kXNfg
         ZeOJPi4w7K86731c82rljaokjc5bYRsWx06IpMn44XmQrc/s3ZWKf3fGSuiFtT8ztZsU
         QNgYUnYhuXQwYxOZ8oXuWCvS1hHN9HCDZb3yqkAPajzRfHdi0LVUI2AM0VyRrVWz7agP
         +/tg==
X-Gm-Message-State: AOAM531qlOxrRtNAwdFPO4s1EI3BYfXRoFVoX1i2i7LSVHKZ1vvt7ZV6
        MKLvo5b1a8GggJzzSsqqlZ8k//Z4bxxbZGsf
X-Google-Smtp-Source: ABdhPJw9DZ7UC0ry00MCPtzn3gBnJGyWy28WwaKKyDzXb3HeBUfsgvDcMToIosou/6w+5ZURmLnCLw==
X-Received: by 2002:a17:902:7c01:b029:12c:25f:be9e with SMTP id x1-20020a1709027c01b029012c025fbe9emr23333319pll.75.1628687930291;
        Wed, 11 Aug 2021 06:18:50 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.115])
        by smtp.gmail.com with ESMTPSA id v63sm31249872pgv.59.2021.08.11.06.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 06:18:50 -0700 (PDT)
Subject: Re: [RFC PATCH] clocksource: skip check while watchdog hung up or
 unstable
To:     Thomas Gleixner <tglx@linutronix.de>, john.stultz@linaro.org,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <63064a758eb087febce3eff5b2c736a5449b3dd2.1628675461.git.brookxu@tencent.com>
 <877dgsp2vp.ffs@tglx>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <2614d5ac-3392-20d1-d772-7a18bec40fa2@gmail.com>
Date:   Wed, 11 Aug 2021 21:18:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <877dgsp2vp.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for your time.

Thomas Gleixner wrote on 2021/8/11 8:44 下午:
> On Wed, Aug 11 2021 at 17:55, brookxu wrote:
>> From: Chunguang Xu <brookxu@tencent.com>
>>
>> After patch 1f45f1f3 (clocksource: Make clocksource validation work
>> for all clocksources), md_nsec may be 0 in some scenarios, such as
>> the watchdog is delayed for a long time or the watchdog has a
>> time-warp.
> 
> Maybe 0? There is exactly one single possibility for it to be zero:
> 
>   cs->wd_last == wdnow, i.e. delta = 0 -> wd_nsec = 0
> 
> So how does that condition solve any long delay or wrap around of the
> watchdog? It's more than unlikely to hit exactly this case where the
> readout is identical to the previous readout unless the watchdog stopped
> counting.

Maybe I missed something. Like this example, when watchdog run ,hpet have
wrap around:

'hpet' wd_now: d76e5a69 wd_last: f929eb3c mask: ffffffff

We can calculate the number of elapsed cycles:
cycles = wd_now - wd_last = 0xde446f2d

clocksource_delta() uses the MSB to determine an invalid inteval and returns
0, but for 0xde446f2d, this judgment should be wrong.


>> We found a problem when testing nvme disks with fio, when multiple
>> queue interrupts of a disk were mapped to a single CPU. IO interrupt
>> processing will cause the watchdog to be delayed for a long time
>> (155 seconds), the system reports TSC unstable and switches the clock
> 
> If you hold off the softirq from running for 155 seconds then the TSC
> watchdog is the least of your problems.

To be precise, we are processing interrupts in handle_edge_irq() for a long
time. Since the interrupts of multiple hardware queues are mapped to a single
CPU, multiple cores are continuously issuing IO, and then a single core is
processing IO. Perhaps the test case can be optimized, but shouldn't this lead
to switching clocks in principle?

> Thanks,
> 
>         tglx
> 
