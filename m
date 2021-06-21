Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD543AE67D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhFUJxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUJxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:53:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC4DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 02:51:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x24so29132821lfr.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 02:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XXYvdNEWj/MGYTvITgwucVOE3a8z0n3hUXB9ArNi2L4=;
        b=sHVP3zPmgKC74+TAXz0sjDq/I+KEsZzxe4ir2EdYX+2ZFPYhljExDY9dSIqlCO2Ijm
         joMeBW+Q0vKPNayV6ZNHAQu8ZSBdc3PFQG+9gPhsyEVkjGTiWk51TkzMIo7iCB8H0OHH
         /LefYTxoYup225X73P95BkM3ma6FDfK/60l7M+3zS6xjZ+Rdk31HvvJlRfPMPsMfUMQY
         3qppAaGKtsLuyulZTwCaR73fIZjz3RaAjY222O2opoRi30uHroTv6b5Svk1sc66VOrKo
         B+e1iylEVChof49Pfef5Y0O6iMJcggLmMPIoJINKjvEpWpxTfA5/aA87vcU2txnGKPd1
         TR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XXYvdNEWj/MGYTvITgwucVOE3a8z0n3hUXB9ArNi2L4=;
        b=UszaB5rKC6V2vl61/a7RWIZQOpydKtSpdbB4p3XAJiOqdMMsJ0xm3W4p1bKZyu3p0U
         6dkHl8SPOOD5O6XKn9JIOfVhI1Hu1JTMIWc9va8IwyWpWJhoMuSXoqmDD7W5/Fn04zjc
         eHDwU8hfLyeGF9hnnaN/cz2Rs+C/vVAnZ+cyE0Z4Kgqo6mmwKI1XMXtjv9iMY36UPa8k
         TVcnLTYe090FZzhLsNIr3vo9co1wMCYrZCLfH+oZy8atgdZ6UJBnj7/pg8MlY5FKiW/b
         85ny3xImjCt/VZ/AySNXxEpitDLZaoR0q+1dOaJ/1l/1lCg5MpyZjV2quSmLoY9hLS08
         /cSg==
X-Gm-Message-State: AOAM530b7A7UyjiPttp7kQlCEW65jpMxwrcW1s47Eh/dQPSdl87XsMib
        sz1PhD9KRjM1s5mnr1N9S/LCFVa+GVBOD8XY49LJUQ==
X-Google-Smtp-Source: ABdhPJyZ4ojzs4lKFe02BGMii8d3Kipd14Dac5QKr1UyEd+fYviMLZSMHEAtRc42sK1dMmN2gxpL3tp2K9Mi32GG4nk=
X-Received: by 2002:a05:6512:3483:: with SMTP id v3mr13765211lfr.154.1624269058666;
 Mon, 21 Jun 2021 02:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <9D4A658A-5F77-4C33-904A-126E6052B205@linux.vnet.ibm.com> <CAFpoUr3g5t3Z0BtW4-jnYomc3cdY=V5=Zt94-C+fHOjGWa107w@mail.gmail.com>
In-Reply-To: <CAFpoUr3g5t3Z0BtW4-jnYomc3cdY=V5=Zt94-C+fHOjGWa107w@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 21 Jun 2021 11:50:47 +0200
Message-ID: <CAKfTPtC=aXasuSNvn+A3152-4xoOTWROhJpZAVq6RLh1Hacpng@mail.gmail.com>
Subject: Re: [powerpc][5.13.0-rc7] Kernel warning (kernel/sched/fair.c:401)
 while running LTP tests
To:     Odin Ugedal <odin@uged.al>
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        open list <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2021 at 11:39, Odin Ugedal <odin@uged.al> wrote:
>
> man. 21. jun. 2021 kl. 08:33 skrev Sachin Sant <sachinp@linux.vnet.ibm.co=
m>:
> >
> > While running LTP tests (cfs_bandwidth01) against 5.13.0-rc7 kernel on =
a powerpc box
> > following warning is seen
> >
> > [ 6611.331827] ------------[ cut here ]------------
> > [ 6611.331855] rq->tmp_alone_branch !=3D &rq->leaf_cfs_rq_list
> > [ 6611.331862] WARNING: CPU: 8 PID: 0 at kernel/sched/fair.c:401 unthro=
ttle_cfs_rq+0x4cc/0x590
> > [ 6611.331883] Modules linked in: nfsv3 nfs_acl nfs lockd grace fscache=
 netfs tun brd overlay vfat fat btrfs blake2b_generic xor zstd_compress rai=
d6_pq xfs loop sctp ip6_udp_tunnel udp_tunnel libcrc32c dm_mod bonding rfki=
ll sunrpc pseries_rng xts vmx_crypto sch_fq_codel ip_tables ext4 mbcache jb=
d2 sd_mod t10_pi sg ibmvscsi ibmveth scsi_transport_srp fuse [last unloaded=
: init_module]
> > [ 6611.331957] CPU: 8 PID: 0 Comm: swapper/8 Tainted: G           OE   =
  5.13.0-rc6-gcba5e97280f5 #1
> > [ 6611.331968] NIP:  c0000000001b7aac LR: c0000000001b7aa8 CTR: c000000=
000722d30
> > [ 6611.331976] REGS: c00000000274f3a0 TRAP: 0700   Tainted: G          =
 OE      (5.13.0-rc6-gcba5e97280f5)
> > [ 6611.331985] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 48000=
224  XER: 00000005
> > [ 6611.332002] CFAR: c00000000014ca20 IRQMASK: 1
> > [ 6611.332002] GPR00: c0000000001b7aa8 c00000000274f640 c000000001abaf0=
0 000000000000002d
> > [ 6611.332002] GPR04: 00000000ffff7fff c00000000274f300 000000000000002=
7 c000000efdb07e08
> > [ 6611.332002] GPR08: 0000000000000023 0000000000000001 000000000000002=
7 c000000001976680
> > [ 6611.332002] GPR12: 0000000000000000 c000000effc0be80 c000000ef07b3f9=
0 000000001eefe200
> > [ 6611.332002] GPR16: 0000000000000000 0000000000000000 000000000000000=
0 0000000000000000
> > [ 6611.332002] GPR20: 0000000000000001 c000000000fa6c08 c000000000fa603=
0 0000000000000001
> > [ 6611.332002] GPR24: 0000000000000000 0000000000000000 c000000efde1238=
0 0000000000000001
> > [ 6611.332002] GPR28: 0000000000000001 0000000000000000 c000000efde1240=
0 0000000000000000
> > [ 6611.332094] NIP [c0000000001b7aac] unthrottle_cfs_rq+0x4cc/0x590
> > [ 6611.332104] LR [c0000000001b7aa8] unthrottle_cfs_rq+0x4c8/0x590
> > [ 6611.332113] Call Trace:
> > [ 6611.332116] [c00000000274f640] [c0000000001b7aa8] unthrottle_cfs_rq+=
0x4c8/0x590 (unreliable)
> > [ 6611.332128] [c00000000274f6e0] [c0000000001b7e38] distribute_cfs_run=
time+0x1d8/0x280
> > [ 6611.332139] [c00000000274f7b0] [c0000000001b81d0] sched_cfs_period_t=
imer+0x140/0x330
> > [ 6611.332149] [c00000000274f870] [c00000000022a03c] __hrtimer_run_queu=
es+0x17c/0x380
> > [ 6611.332158] [c00000000274f8f0] [c00000000022ac68] hrtimer_interrupt+=
0x128/0x2f0
> > [ 6611.332168] [c00000000274f9a0] [c00000000002940c] timer_interrupt+0x=
13c/0x370
> > [ 6611.332179] [c00000000274fa00] [c000000000009c04] decrementer_common=
_virt+0x1a4/0x1b0
> > [ 6611.332189] --- interrupt: 900 at plpar_hcall_norets_notrace+0x18/0x=
24
> > [ 6611.332199] NIP:  c0000000000f6af8 LR: c000000000a05f68 CTR: 0000000=
000000000
> > [ 6611.332206] REGS: c00000000274fa70 TRAP: 0900   Tainted: G          =
 OE      (5.13.0-rc6-gcba5e97280f5)
> > [ 6611.332214] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>=
  CR: 28000224  XER: 00000000
> > [ 6611.332234] CFAR: 0000000000000c00 IRQMASK: 0
> > [ 6611.332234] GPR00: 0000000000000000 c00000000274fd10 c000000001abaf0=
0 0000000000000000
> > [ 6611.332234] GPR04: 00000000000000c0 0000000000000080 0001a91c68b80fa=
1 00000000000003dc
> > [ 6611.332234] GPR08: 000000000001f400 0000000000000001 000000000000000=
0 0000000000000000
> > [ 6611.332234] GPR12: 0000000000000000 c000000effc0be80 c000000ef07b3f9=
0 000000001eefe200
> > [ 6611.332234] GPR16: 0000000000000000 0000000000000000 000000000000000=
0 0000000000000000
> > [ 6611.332234] GPR20: 0000000000000001 0000000000000002 000000000000001=
0 c0000000019fe2f8
> > [ 6611.332234] GPR24: 0000000000000001 00000603517d757e 000000000000000=
0 0000000000000000
> > [ 6611.332234] GPR28: 0000000000000001 0000000000000000 c000000001231f9=
0 c000000001231f98
> > [ 6611.332323] NIP [c0000000000f6af8] plpar_hcall_norets_notrace+0x18/0=
x24
> > [ 6611.332332] LR [c000000000a05f68] check_and_cede_processor+0x48/0x60
> > [ 6611.332340] --- interrupt: 900
> > [ 6611.332345] [c00000000274fd10] [c000000efdb92380] 0xc000000efdb92380=
 (unreliable)
> > [ 6611.332355] [c00000000274fd70] [c000000000a063bc] dedicated_cede_loo=
p+0x9c/0x1b0
> > [ 6611.332364] [c00000000274fdc0] [c000000000a02b04] cpuidle_enter_stat=
e+0x2e4/0x4e0
> > [ 6611.332375] [c00000000274fe20] [c000000000a02da0] cpuidle_enter+0x50=
/0x70
> > [ 6611.332385] [c00000000274fe60] [c0000000001a883c] call_cpuidle+0x4c/=
0x80
> > [ 6611.332393] [c00000000274fe80] [c0000000001a8ee0] do_idle+0x380/0x3e=
0
> > [ 6611.332402] [c00000000274ff00] [c0000000001a91bc] cpu_startup_entry+=
0x3c/0x40
> > [ 6611.332411] [c00000000274ff30] [c000000000063ff8] start_secondary+0x=
298/0x2b0
> > [ 6611.332421] [c00000000274ff90] [c00000000000c754] start_secondary_pr=
olog+0x10/0x14
> > [ 6611.332430] Instruction dump:
> > [ 6611.332435] 4bfffc44 3d22fff6 8929f328 2f890000 409efea4 39200001 3d=
42fff6 3c62ff4f
> > [ 6611.332451] 3863bcd8 992af328 4bf94f15 60000000 <0fe00000> 4bfffe80 =
7f6407b4 7f43d378
> > [ 6611.332466] ---[ end trace 1346f865cd1cae91 ]=E2=80=94
> >
> > 5.13.0-rc6 was good. Bisect points to following patch
> >
> > commit a7b359fc6a37
> > sched/fair: Correctly insert cfs_rq's to list on unthrottle
> >
> > The test runs to completion(without this warning) if the patch is rever=
ted.
> >
> > Thanks
> > -Sachin
> >
>
> Hi,
>
> Thanks for the report! I have a theory about what is possibly causing
> this, so I will try to reproduce it and see if my assumptions are
> correct.

This means that a child's load was not null and it was inserted
whereas parent's load was null. This should not happen unless the
propagation failed somewhere

>
>
> Odin
