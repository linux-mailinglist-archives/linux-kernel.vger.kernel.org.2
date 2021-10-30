Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493C744062E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 02:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhJ3AJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 20:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhJ3AJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 20:09:17 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603ACC061570;
        Fri, 29 Oct 2021 17:06:48 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Hh02s1kQXzQk34;
        Sat, 30 Oct 2021 02:06:45 +0200 (CEST)
Authentication-Results: spamfilter04.heinlein-hosting.de (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mailbox.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1635552403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=dY0qrvj76zWCSKOL4itCCWMl5wR6AHMfGCEQfwklEAE=;
        b=aGAAp+GS4vAfKWP0yH+xNU8EqfIKil2lW+/KxJwiJZIYoYDwBg4xlCxBW0/kSyzSugERgy
        SCaiLzVl7zs6et4nqD8x0bBWxAdKWB6TIwRDVjF8RFMxrrSZH6e7viAopbb1tQqJoRmk1B
        CeqiQKobIzK6XbbleiLKRcxi41RH+gKPYkd5+75bwu1uQmCp/cQopblIkM6CZxtOVnn0i7
        BeuTFTuU3PoumGr2sA1YRLfteVfEIn5Pc2vZffyWZS5jN5sMGSjZl31OmTH8m5TLztmXJl
        96m2/j3C/RmN3Ldj5rGLU9pVxDSvPDWPNUkaKgty8A7i/a7c0luAHdoQZyXghw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :in-reply-to:message-id:subject:subject:from:from:date:date
        :received; s=mail20150812; t=1635552402; bh=sE3ydF4zle5ia1vV+TD9
        hm4uPa48BuAInimrUVD8Ck0=; b=dWbtRF0NPIPyNyKjjL7SBbsA+7XstmRTkHP3
        ln5QLhx5QB8p9qtC2Zt8C9X3pErnFBDP+VIjnR9b4YH4Dgj7dKHkKq0I+Gr9Gpc+
        V8FuX8n+/rifb1PPvh0CI1Jowz64VSEhrgi9NSeITEBPz94VjzEI93tzH+KAG7Ft
        G394TmH+uazmaNgHzP7cIKZKRlsdWvKJjG3n1JA6lFarqxrw47tZd3I67bWcomPJ
        C4h9zS0pClFL3feODprqjbfb656NoEoA3owjGO3/W2QjIo+OUMTEAhJGrBFgDf9/
        Q/00HBuDA+v7Sm6Vdt3byq2k8E2MYNQGj37E1j0RObsvM+GvmA==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Date:   Sat, 30 Oct 2021 02:06:40 +0200
From:   "Erhard F." <erhard_f@mailbox.org>
To:     frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, erhard_f@mailbox.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: Fwd: [Bug 214867] New: UBSAN: shift-out-of-bounds in
 drivers/of/unittest.c:1933:36
Message-ID: <20211030020640.30a0964c@yea>
In-Reply-To: <c474a371-b524-1da8-4a67-e72cf8f2b0f7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 83537569
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(In reply to Arnd Bergmann from comment #2)
> My guess is that 'id' is negative here, which means it fails to tigger the
> WARN_ON() but ends up still being out of range.
> 
> Can you try changing it to 'unsigned int id'?
When I change it to static void of_unittest_untrack_overlay(unsigned int id) I get no UBSAN message but this warning:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/of/unittest.c:1931 .of_unittest_untrack_overlay+0x20/0xac
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc7-TalosII+ #2
NIP:  c000000000ad9368 LR: c000000002099000 CTR: 0000000000000000
REGS: c000000004163700 TRAP: 0700   Not tainted  (5.15.0-rc7-TalosII+)
MSR:  9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 44004242  XER: 20040000
CFAR: c000000002098ffc IRQMASK: 0 
GPR00: c000000002098f74 c0000000041639a0 c0000000023b2f00 ffffffffffffffff 
GPR04: c000000002270b90 0000000000000000 c000000004163794 c0000000027744d8 
GPR08: 00000007fdaf2000 0000000000000001 0000000000000000 00000000ffffffff 
GPR12: 0000000024004242 c0000000031d5000 b086ed6156fceb64 c0000000022718d8 
GPR16: d5cb61e74edefbbf 0000000000000000 c0000000010840b0 c000000001084078 
GPR20: c000000000e0df58 c0000000021d6120 0000000000000000 c000200004d579f0 
GPR24: c0000000020ad0a0 c0000000022713c8 c0000000031c9110 0000000000000000 
GPR28: c000000000e0d110 c0000000031c9158 7bba9c880526c811 c0000000041639a0 
NIP [c000000000ad9368] .of_unittest_untrack_overlay+0x20/0xac
LR [c000000002099000] .of_unittest+0x4c5c/0x5a04
Call Trace:
[c0000000041639a0] [c000000002098f74] .of_unittest+0x4bd0/0x5a04 (unreliable)
[c000000004163b60] [c000000000011b5c] .do_one_initcall+0x7c/0x4f0
[c000000004163c50] [c00000000200300c] .kernel_init_freeable+0x704/0x858
[c000000004163d90] [c000000000012730] .kernel_init+0x20/0x190
[c000000004163e10] [c00000000000ce78] .ret_from_kernel_thread+0x58/0x60
Instruction dump:
60000000 60000000 38600000 4e800020 3d22ffec e929e4ca 2c090000 4d800020 
7c691850 39200001 28030100 7d20481e <0b090000> 7c0802a6 fb81ffe0 fba1ffe8 
irq event stamp: 514764
hardirqs last  enabled at (514763): [<c0000000004398e4>] .__slab_free+0x394/0x590
hardirqs last disabled at (514764): [<c0000000000312bc>] .interrupt_enter_prepare.constprop.0+0xec/0x150
softirqs last  enabled at (509346): [<c000000000d845cc>] .__do_softirq+0x4cc/0x714
softirqs last disabled at (509339): [<c0000000000f6eb8>] .__irq_exit_rcu+0x148/0x1b0
---[ end trace 0c8618d488a1a13d ]---


In unittest.c id generally seems to be derived from a constant and counted downwards in loops.

[...]
#define MAX_UNITTEST_OVERLAYS   256
[...]
static void of_unittest_destroy_tracked_overlays(void)
{
        int id, ret, defers, ovcs_id;

        if (overlay_first_id < 0)
                return;

        /* try until no defers */
        do {
                defers = 0;
                /* remove in reverse order */
                for (id = MAX_UNITTEST_OVERLAYS - 1; id >= 0; id--) {
                        if (!of_unittest_overlay_tracked(id))
                                continue;

                        ovcs_id = id + overlay_first_id;
                        ret = of_overlay_remove(&ovcs_id);
                        if (ret == -ENODEV) {
                                pr_warn("%s: no overlay to destroy for #%d\n",
                                        __func__, id + overlay_first_id);
                                continue;
                        }
                        if (ret != 0) {
                                defers++;
                                pr_warn("%s: overlay destroy failed for #%d\n",
                                        __func__, id + overlay_first_id);
                                continue;
                        }

                        of_unittest_untrack_overlay(id);
                }
        } while (defers > 0);
}

It should not get negative with the "id >= 0" above in the for-loop. But from it's purpose it should be an unsigned int probably. It would need to be changed in the whole unittest.c though as it is used as int in several other places, e.g. 
static long of_unittest_overlay_tracked(int id)
static void of_unittest_track_overlay(int id)
