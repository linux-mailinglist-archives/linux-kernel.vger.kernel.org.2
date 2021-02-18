Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8DE31EE22
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhBRSTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbhBRPxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 10:53:31 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BF8C0613D6;
        Thu, 18 Feb 2021 07:52:49 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z22so4924225edb.9;
        Thu, 18 Feb 2021 07:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sWT6BJ7Jd5T7YoEU9FbkRFbxR5CaNoZoMghqmBnTf4w=;
        b=shGvC1TCxaF0N6CzgJaqWshN4MKKPOE0h3mYwDLe5HD8KpsSmVwIX3p5vF7sSdTbp/
         bVtwDianWaett4sMa39wP6MoW8y3zZi1hN2R6jQPfat5HNaBfMXYQ3pH3DMJe77uWRpK
         CwfuOjRLU9JFOvSvDBD6Zp0qNrCrEpHagcwhW+n/mZ4EERe1BV8PJNWfw0vmU6EVWJ+2
         rEfivDpRNDHj/r5fAUBgIleQux6VoDE4qTYdApeIkMWutnM3MGxjz9ARMeJg9ibvBn61
         tBckrh3We2OAdSZMzpv6aSTotnmkMvdONVZrGkhw8ZlONNhMh+a9H5P0jpoEbDTn4XOT
         CUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sWT6BJ7Jd5T7YoEU9FbkRFbxR5CaNoZoMghqmBnTf4w=;
        b=rST5JUL7eu6Eekb7GuRpl0rF7r5HoJEM7+gMMpjiQsvF+xurTPQV32c9jveeLW4YTd
         3Xp2RcHEE1TGkF/e2HMjoY3qJblaI1ln/4LXjWfXV8dqexG932pt60uv/T0svDzME86T
         xcCQH/j0lpR84wfOe2vTYj1NozUps2YAK4rowFZf2TsYPx/tcSy4rQblFYyoK6EF08Qi
         sN9aUlTxXP+Rr3rMmkVNtBueP43YQ9zIx9cc41dj9WvROKYDnZdDz+BrQUCYjIbpcYoq
         hoqOlGwib2NSVLLBxX/fLWc5RcewKE35S6Enn0x0hCD/sLdpoPmZoGDFk0OJlz/xv9El
         uDGg==
X-Gm-Message-State: AOAM5339ra96rtquqsAfuYG7eoz60Dluf1v0OvGqS7kg3S8s8XOKc7fW
        UY4R1voShBte3Bmc07ebZDzWsKC9MGEGnO8F80jIh1iNlWRTIw==
X-Google-Smtp-Source: ABdhPJwEW+2amEZBzpTRDLgL17sBhoHUF0SUa4FGJ1I+VKq3maqtLOFb/tRkVBMQqj60o6jAvPjh90g1+8AQhRhVKto=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr4703135edw.303.1613663567928;
 Thu, 18 Feb 2021 07:52:47 -0800 (PST)
MIME-Version: 1.0
References: <CAH+2xPCmZNW0ct8XoBmAnd0QK53guv2e4HLn40NvWrEA7pj3qw@mail.gmail.com>
In-Reply-To: <CAH+2xPCmZNW0ct8XoBmAnd0QK53guv2e4HLn40NvWrEA7pj3qw@mail.gmail.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Thu, 18 Feb 2021 16:52:32 +0100
Message-ID: <CAH+2xPCkKRhXJSqMx7kzsO53JwXbrmYPLLL-_ANO9waNJREDWA@mail.gmail.com>
Subject: Re: usb: cdc-acm: BUG kmalloc-128 Poison overwritten
To:     linux-usb@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Bruno Thomsen <bth@kamstrup.com>,
        Lars Alex Pedersen <laa@kamstrup.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den fre. 12. feb. 2021 kl. 16.33 skrev Bruno Thomsen <bruno.thomsen@gmail.com>:
>
> Hi,
>
> I have been experience random kernel oops in the cdc-acm driver on
> imx7 (arm arch). Normally it happens during the first 1-3min runtime
> after power-on. Below oops is from 5.8.17 mainline kernel with an
> extra patch back-ported in an attempt to fix it:
> 38203b8385 ("usb: cdc-acm: fix cooldown mechanism")

I can now boot board with 5.11 kernel without any extra patches and
it produce similar issue. Hopefully that make the oops more useful.
Issue has been seen on multiple devices, so I don't think it's a bad
hardware issue.

[ 76.458010] 8<--- cut here ---
[ 76.461178] Unable to handle kernel paging request at virtual address 6b6b6b93
[ 76.472958] pgd = f805d813
[ 76.475788] [6b6b6b93] *pgd=00000000
[ 76.488068] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[ 76.493441] Modules linked in: xt_TCPMSS xt_tcpmss xt_hl nf_log_ipv6
nf_log_ipv4 nf_log_common xt_policy xt_limit xt_conntrack xt_tcpudp
xt_pkttype ip6table_mangle iptable_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle ip6table_filter
ip6_tables iptable_filter ip_tables des_generic md5 sch_fq_codel
cdc_mbim cdc_wdm cdc_ncm cdc_ether usbnet mii cdc_acm usb_storage
ip_tunnel xfrm_user xfrm6_tunnel tunnel6 xfrm4_tunnel tunnel4 esp6
esp4 ah6 ah4 xfrm_algo xt_LOG xt_LED xt_comment x_tables ipv6
[ 76.539032] CPU: 0 PID: 5 Comm: kworker/0:0 Tainted: G T 5.11.0 #1
[ 76.546539] Hardware name: Freescale i.MX7 Dual (Device Tree)
[ 76.552295] Workqueue: events acm_softint [cdc_acm]
[ 76.557223] PC is at usb_kill_urb+0x8/0x24
[ 76.561337] LR is at acm_softint+0x4c/0x10c [cdc_acm]
[ 76.566415] pc : [<805911a8>] lr : [<7f1168c4>] psr: 200e0113
[ 76.572689] sp : 84113f08 ip : 8575de7c fp : 840e92bc
[ 76.577920] r10: 00000000 r9 : 893222a8 r8 : 89322008
[ 76.583151] r7 : 89322000 r6 : 89322438 r5 : 89322448 r4 : 0000000a
[ 76.589686] r3 : 6b6b6b6b r2 : 12d79029 r1 : 800e0113 r0 : 6b6b6b6b
[ 76.596223] Flags: nzCv IRQs on FIQs on Mode SVC_32 ISA ARM Segment none
[ 76.603369] Control: 10c5387d Table: 8933406a DAC: 00000051
[ 76.609120] Process kworker/0:0 (pid: 5, stack limit = 0x8fb8cf7e)
[ 76.615315] Stack: (0x84113f08 to 0x84114000)
[ 76.619685] 3f00: 89322448 840e9280 bf6caf40 bf6ce100 00000000 00000000
[ 76.627875] 3f20: 00000000 8013f14c 84112000 bf6caf40 bf6caf58
840e9280 bf6caf40 840e9294
[ 76.636065] 3f40: bf6caf58 80c03d00 00000008 84112000 bf6caf40
8013f3e8 00000000 80d0bbb0
[ 76.644255] 3f60: 00000000 840a7640 840a77c0 84112000 840ede7c
8013f3a4 840e9280 840a7664
[ 76.652445] 3f80: 00000000 801467d8 00000000 840a77c0 80146694
00000000 00000000 00000000
[ 76.660634] 3fa0: 00000000 00000000 00000000 80100150 00000000
00000000 00000000 00000000
[ 76.668823] 3fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[ 76.677012] 3fe0: 00000000 00000000 00000000 00000000 00000013
00000000 00000000 00000000
[ 76.685203] [<805911a8>] (usb_kill_urb) from [<7f1168c4>]
(acm_softint+0x4c/0x10c [cdc_acm])
[ 76.693690] [<7f1168c4>] (acm_softint [cdc_acm]) from [<8013f14c>]
(process_one_work+0x1bc/0x414)
[ 76.702605] [<8013f14c>] (process_one_work) from [<8013f3e8>]
(worker_thread+0x44/0x4dc)
[ 76.710719] [<8013f3e8>] (worker_thread) from [<801467d8>]
(kthread+0x144/0x180)
[ 76.718139] [<801467d8>] (kthread) from [<80100150>] (ret_from_fork+0x14/0x24)
[ 76.725380] Exception stack(0x84113fb0 to 0x84113ff8)
[ 76.730443] 3fa0: 00000000 00000000 00000000 00000000
[ 76.738632] 3fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[ 76.746819] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[ 76.753448] Code: eaffffe0 eb081505 e2503000 012fff1e (e5932028)
[ 76.761647] ---[ end trace 05b398f82b2a04b9 ]---
