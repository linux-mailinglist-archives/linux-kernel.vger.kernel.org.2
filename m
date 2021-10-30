Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9AF440658
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 02:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhJ3AQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 20:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJ3AQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 20:16:53 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA9CC061570;
        Fri, 29 Oct 2021 17:14:23 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id bp7so5805168qkb.10;
        Fri, 29 Oct 2021 17:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BnlTb+ptZ4xG5Lrdna/PjuxLxMQcyXaiH4BWbtaQhsw=;
        b=RfHVLGH2VBTDcTzxQ/90tzCgM4ZYqHV3xiWmcJDSn9Wbu6CCWxXwAvcp9AjOqpLfg6
         mMDqL7fcVcsh2Y65SM2NVX/8LLAkUlPNbCxOlGGjkSrNxoHg79bL+xbPi+jMwBH39tmk
         HSzUc63Z3kWcJ5RzxtSUC28jEqPdLuI3cbenFDI74dBprHHliDZuBaiK8MDCxNQiyXux
         7kHmLCLS+W55C8rsgkq9UC7aU8gBgaiQADUS3C4ArcmL6ETGv3lNcb/JaYeFiUiW53+X
         rjGNG/sy6TQNyTojzhhj1feOmthDx/mr6Z9Vlxe6dpZfTqPbZwPV65jnmNDpTU6F3wuP
         5HAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BnlTb+ptZ4xG5Lrdna/PjuxLxMQcyXaiH4BWbtaQhsw=;
        b=Mx+u43Wi1EhhKmn5t/zAjHby0FTwflv/fT8AMyos/5ei9+YO5VX+sxH82r7A06lax6
         rC52J9izXT2A6LSDfT3kNdROXyiiW8uQlVA3Vx2EyCWihi959b9w2X+tRPrmjkwM0lzD
         +4P175JRb9Pmq7lzmA0znQzLyFrnMe8XmlwbolUHZkpYYbwExAbGOaK7+WfAQtjb5leg
         ZkMZNoDKJsIRzBQd1cdeBE0s0xI+vnDFnsJZgOJu/TgufgBjf10bppfZBNU/b+Y0RpOY
         GqESTqs110rSjB2fgWQ8Y+Zb37l8ykzEUylVOhdiV4JvwRkaPoZYpfknh9EIVZnis1Ia
         5q/Q==
X-Gm-Message-State: AOAM530NLYTXnEmwCyEGIOtt1c0dHRm2ThIwEF2ZO4HKW9r1oOQEzkqR
        h1xATK+/N7b0Sq58APhg8tM=
X-Google-Smtp-Source: ABdhPJzvshfXl/5vd3nmW0FOPkRpTMzRObznPbuiYJyIInkkp6K2s7yBAjhmSZ+gtXktpXmMaiwouQ==
X-Received: by 2002:a37:bc1:: with SMTP id 184mr11519134qkl.96.1635552862287;
        Fri, 29 Oct 2021 17:14:22 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id l15sm5576127qtk.41.2021.10.29.17.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 17:14:22 -0700 (PDT)
Subject: Re: Fwd: [Bug 214867] New: UBSAN: shift-out-of-bounds in
 drivers/of/unittest.c:1933:36
To:     "Erhard F." <erhard_f@mailbox.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, Frank Rowand <frowand.list@gmail.com>
References: <20211030020640.30a0964c@yea>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <7a27e30e-bd33-876e-121b-a4b97351d0f7@gmail.com>
Date:   Fri, 29 Oct 2021 19:14:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211030020640.30a0964c@yea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/21 7:06 PM, Erhard F. wrote:
> (In reply to Arnd Bergmann from comment #2)
>> My guess is that 'id' is negative here, which means it fails to tigger the
>> WARN_ON() but ends up still being out of range.
>>
>> Can you try changing it to 'unsigned int id'?
> When I change it to static void of_unittest_untrack_overlay(unsigned int id) I get no UBSAN message but this warning:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at drivers/of/unittest.c:1931 .of_unittest_untrack_overlay+0x20/0xac
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc7-TalosII+ #2
> NIP:  c000000000ad9368 LR: c000000002099000 CTR: 0000000000000000
> REGS: c000000004163700 TRAP: 0700   Not tainted  (5.15.0-rc7-TalosII+)
> MSR:  9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 44004242  XER: 20040000
> CFAR: c000000002098ffc IRQMASK: 0 
> GPR00: c000000002098f74 c0000000041639a0 c0000000023b2f00 ffffffffffffffff 
> GPR04: c000000002270b90 0000000000000000 c000000004163794 c0000000027744d8 
> GPR08: 00000007fdaf2000 0000000000000001 0000000000000000 00000000ffffffff 
> GPR12: 0000000024004242 c0000000031d5000 b086ed6156fceb64 c0000000022718d8 
> GPR16: d5cb61e74edefbbf 0000000000000000 c0000000010840b0 c000000001084078 
> GPR20: c000000000e0df58 c0000000021d6120 0000000000000000 c000200004d579f0 
> GPR24: c0000000020ad0a0 c0000000022713c8 c0000000031c9110 0000000000000000 
> GPR28: c000000000e0d110 c0000000031c9158 7bba9c880526c811 c0000000041639a0 
> NIP [c000000000ad9368] .of_unittest_untrack_overlay+0x20/0xac
> LR [c000000002099000] .of_unittest+0x4c5c/0x5a04
> Call Trace:
> [c0000000041639a0] [c000000002098f74] .of_unittest+0x4bd0/0x5a04 (unreliable)
> [c000000004163b60] [c000000000011b5c] .do_one_initcall+0x7c/0x4f0
> [c000000004163c50] [c00000000200300c] .kernel_init_freeable+0x704/0x858
> [c000000004163d90] [c000000000012730] .kernel_init+0x20/0x190
> [c000000004163e10] [c00000000000ce78] .ret_from_kernel_thread+0x58/0x60
> Instruction dump:
> 60000000 60000000 38600000 4e800020 3d22ffec e929e4ca 2c090000 4d800020 
> 7c691850 39200001 28030100 7d20481e <0b090000> 7c0802a6 fb81ffe0 fba1ffe8 
> irq event stamp: 514764
> hardirqs last  enabled at (514763): [<c0000000004398e4>] .__slab_free+0x394/0x590
> hardirqs last disabled at (514764): [<c0000000000312bc>] .interrupt_enter_prepare.constprop.0+0xec/0x150
> softirqs last  enabled at (509346): [<c000000000d845cc>] .__do_softirq+0x4cc/0x714
> softirqs last disabled at (509339): [<c0000000000f6eb8>] .__irq_exit_rcu+0x148/0x1b0
> ---[ end trace 0c8618d488a1a13d ]---
> 
> 
> In unittest.c id generally seems to be derived from a constant and counted downwards in loops.
> 
> [...]
> #define MAX_UNITTEST_OVERLAYS   256
> [...]
> static void of_unittest_destroy_tracked_overlays(void)
> {
>         int id, ret, defers, ovcs_id;
> 
>         if (overlay_first_id < 0)
>                 return;
> 
>         /* try until no defers */
>         do {
>                 defers = 0;
>                 /* remove in reverse order */
>                 for (id = MAX_UNITTEST_OVERLAYS - 1; id >= 0; id--) {
>                         if (!of_unittest_overlay_tracked(id))
>                                 continue;
> 
>                         ovcs_id = id + overlay_first_id;
>                         ret = of_overlay_remove(&ovcs_id);
>                         if (ret == -ENODEV) {
>                                 pr_warn("%s: no overlay to destroy for #%d\n",
>                                         __func__, id + overlay_first_id);
>                                 continue;
>                         }
>                         if (ret != 0) {
>                                 defers++;
>                                 pr_warn("%s: overlay destroy failed for #%d\n",
>                                         __func__, id + overlay_first_id);
>                                 continue;
>                         }
> 
>                         of_unittest_untrack_overlay(id);
>                 }
>         } while (defers > 0);
> }
> 
> It should not get negative with the "id >= 0" above in the for-loop. But from it's purpose it should be an unsigned int probably. It would need to be changed in the whole unittest.c though as it is used as int in several other places, e.g. 
> static long of_unittest_overlay_tracked(int id)
> static void of_unittest_track_overlay(int id)
> 

Thanks for digging deeper into this.

The overlay tracking implementation has annoyed me for a long time, because
it makes assumptions of the possible range of overlay id values (max is
hardcoded as 256) to allow a space efficient bitmap.  I would prefer to
rewrite the overlay tracking functions to us a less space efficient data
structure that allows arbitrary overlay values, instead of 0..MAX_UNITTEST_OVERLAYS.

-Frank
