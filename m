Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9A144065B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 02:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhJ3ASl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 20:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJ3ASk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 20:18:40 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9756C061570;
        Fri, 29 Oct 2021 17:16:10 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id d6so7431469qvb.3;
        Fri, 29 Oct 2021 17:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5m8CeNv9l4hoxXTwy4qJhYDQcxOUyqthLpmFszXujEs=;
        b=Lm4zQLKVlERYqROqiCV9p/BVzA1m658uVYZkCei+p2okYN9bFt/XaNlt3sF8vI1uJR
         W+atY1Ue+K/dRRdjEqwll3B4QjhDQHs1YhSb4IbAhh4oYZm79J9WLAoWBPw5noPzDO2q
         JKCqOc1UYECtcFdxyZrUrTk6PvIJQTawhwXF93Tai8og+sMhI8/crQc4bk+GbVi3lxXi
         q6ec94jAkEIVc/iICuKccQlcetRqgITmABfL9K+fF+xhBLVgzV/FvO3EY0Vds9uZ+k4J
         K133QMnve5xYW6VvKoo56UdUm/QwOilE794o9KRkyY8jXI0JBc1suxtd2VnLvoiM3OEN
         ptCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5m8CeNv9l4hoxXTwy4qJhYDQcxOUyqthLpmFszXujEs=;
        b=xktFLyTPFplZYo1+NDHH7c1oJ6XHBdm+kMUqnnT4Fx65I8pRE7KHMUe8fzXQzDwEde
         8y4unbnpvOfQBtPQ6aOL4/WZYyLCh6tmThn8ATq7FJCi3gwXRG24vXaonWMrorFQ8Jrl
         RDjt7M9HLFBRIcMbvvDMiy8scgBCsGaTci/xodGQBW4fiM8QqpXW8Yv8qTtMUAGpMWc4
         QoTwvC+Iu7fpoRu7ZP71wDKUXl0wLyTLw+RWt8CTiK+MQ0Q0a2NNuh5HQt7suNZ3poya
         6rnPzxucXATPHF/mBGFFXyGbSDtQuLskM0KPfJonfw24EPC9UCLgvaMpArBM+gzrUdcg
         Ahog==
X-Gm-Message-State: AOAM531nmdqQBenYgbKhQ1M/Or2Olw7sW4tRlOGy087fP5iGzjkzdX6f
        Yu6l04xb6AY/OjDTd5Td17I=
X-Google-Smtp-Source: ABdhPJwBMFK9NJdk/0x9SIodOqCl2enbk7u8UDukdgCtL+OIhOIR6cgL79frvC0k67dNdb3RP19Zjw==
X-Received: by 2002:ad4:5966:: with SMTP id eq6mr14250683qvb.64.1635552970135;
        Fri, 29 Oct 2021 17:16:10 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id v3sm4880682qkd.20.2021.10.29.17.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 17:16:09 -0700 (PDT)
Subject: Re: Fwd: [Bug 214867] New: UBSAN: shift-out-of-bounds in
 drivers/of/unittest.c:1933:36
To:     "Erhard F." <erhard_f@mailbox.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
References: <20211030020640.30a0964c@yea>
 <7a27e30e-bd33-876e-121b-a4b97351d0f7@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <62db60a8-c259-46e3-2a76-7d0efa675d19@gmail.com>
Date:   Fri, 29 Oct 2021 19:16:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7a27e30e-bd33-876e-121b-a4b97351d0f7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/21 7:14 PM, Frank Rowand wrote:
> On 10/29/21 7:06 PM, Erhard F. wrote:
>> (In reply to Arnd Bergmann from comment #2)
>>> My guess is that 'id' is negative here, which means it fails to tigger the
>>> WARN_ON() but ends up still being out of range.
>>>
>>> Can you try changing it to 'unsigned int id'?
>> When I change it to static void of_unittest_untrack_overlay(unsigned int id) I get no UBSAN message but this warning:
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1 at drivers/of/unittest.c:1931 .of_unittest_untrack_overlay+0x20/0xac
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc7-TalosII+ #2
>> NIP:  c000000000ad9368 LR: c000000002099000 CTR: 0000000000000000
>> REGS: c000000004163700 TRAP: 0700   Not tainted  (5.15.0-rc7-TalosII+)
>> MSR:  9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 44004242  XER: 20040000
>> CFAR: c000000002098ffc IRQMASK: 0 
>> GPR00: c000000002098f74 c0000000041639a0 c0000000023b2f00 ffffffffffffffff 
>> GPR04: c000000002270b90 0000000000000000 c000000004163794 c0000000027744d8 
>> GPR08: 00000007fdaf2000 0000000000000001 0000000000000000 00000000ffffffff 
>> GPR12: 0000000024004242 c0000000031d5000 b086ed6156fceb64 c0000000022718d8 
>> GPR16: d5cb61e74edefbbf 0000000000000000 c0000000010840b0 c000000001084078 
>> GPR20: c000000000e0df58 c0000000021d6120 0000000000000000 c000200004d579f0 
>> GPR24: c0000000020ad0a0 c0000000022713c8 c0000000031c9110 0000000000000000 
>> GPR28: c000000000e0d110 c0000000031c9158 7bba9c880526c811 c0000000041639a0 
>> NIP [c000000000ad9368] .of_unittest_untrack_overlay+0x20/0xac
>> LR [c000000002099000] .of_unittest+0x4c5c/0x5a04
>> Call Trace:
>> [c0000000041639a0] [c000000002098f74] .of_unittest+0x4bd0/0x5a04 (unreliable)
>> [c000000004163b60] [c000000000011b5c] .do_one_initcall+0x7c/0x4f0
>> [c000000004163c50] [c00000000200300c] .kernel_init_freeable+0x704/0x858
>> [c000000004163d90] [c000000000012730] .kernel_init+0x20/0x190
>> [c000000004163e10] [c00000000000ce78] .ret_from_kernel_thread+0x58/0x60
>> Instruction dump:
>> 60000000 60000000 38600000 4e800020 3d22ffec e929e4ca 2c090000 4d800020 
>> 7c691850 39200001 28030100 7d20481e <0b090000> 7c0802a6 fb81ffe0 fba1ffe8 
>> irq event stamp: 514764
>> hardirqs last  enabled at (514763): [<c0000000004398e4>] .__slab_free+0x394/0x590
>> hardirqs last disabled at (514764): [<c0000000000312bc>] .interrupt_enter_prepare.constprop.0+0xec/0x150
>> softirqs last  enabled at (509346): [<c000000000d845cc>] .__do_softirq+0x4cc/0x714
>> softirqs last disabled at (509339): [<c0000000000f6eb8>] .__irq_exit_rcu+0x148/0x1b0
>> ---[ end trace 0c8618d488a1a13d ]---
>>
>>
>> In unittest.c id generally seems to be derived from a constant and counted downwards in loops.
>>
>> [...]
>> #define MAX_UNITTEST_OVERLAYS   256
>> [...]
>> static void of_unittest_destroy_tracked_overlays(void)
>> {
>>         int id, ret, defers, ovcs_id;
>>
>>         if (overlay_first_id < 0)
>>                 return;
>>
>>         /* try until no defers */
>>         do {
>>                 defers = 0;
>>                 /* remove in reverse order */
>>                 for (id = MAX_UNITTEST_OVERLAYS - 1; id >= 0; id--) {
>>                         if (!of_unittest_overlay_tracked(id))
>>                                 continue;
>>
>>                         ovcs_id = id + overlay_first_id;
>>                         ret = of_overlay_remove(&ovcs_id);
>>                         if (ret == -ENODEV) {
>>                                 pr_warn("%s: no overlay to destroy for #%d\n",
>>                                         __func__, id + overlay_first_id);
>>                                 continue;
>>                         }
>>                         if (ret != 0) {
>>                                 defers++;
>>                                 pr_warn("%s: overlay destroy failed for #%d\n",
>>                                         __func__, id + overlay_first_id);
>>                                 continue;
>>                         }
>>
>>                         of_unittest_untrack_overlay(id);
>>                 }
>>         } while (defers > 0);
>> }
>>
>> It should not get negative with the "id >= 0" above in the for-loop. But from it's purpose it should be an unsigned int probably. It would need to be changed in the whole unittest.c though as it is used as int in several other places, e.g. 
>> static long of_unittest_overlay_tracked(int id)
>> static void of_unittest_track_overlay(int id)
>>
> 
> Thanks for digging deeper into this.
> 
> The overlay tracking implementation has annoyed me for a long time, because
> it makes assumptions of the possible range of overlay id values (max is
> hardcoded as 256) to allow a space efficient bitmap.  I would prefer to
> rewrite the overlay tracking functions to us a less space efficient data
> structure that allows arbitrary overlay values, instead of 0..MAX_UNITTEST_OVERLAYS.

Please be gentle and ignore any off by 1 issues with my characterization of
MAX_UNITTEST_OVERLAYS and maximum overlay id value.

> 
> -Frank
> 

