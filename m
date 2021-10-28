Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66D943E49F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhJ1PMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 11:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhJ1PMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:12:12 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655D8C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 08:09:45 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r28so6741939pga.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 08:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=N7Lz9MlAMZ2EGF4S5jNyBSYl14bB0H20CJuEnD/geJQ=;
        b=2uuYfs53wDiP8SOJND/mT1QmnMTq1Kvus1r7zENS40yq0e8Rq2cQndpVU5VWhK3o+m
         6JmwQXM0xnR46VZ/3ftL32FoXfce6Hi6jt7T210datbosHDW8dndLg3dBvzBb32YSyqi
         EgjgLHDrAJcCqauSzjfeAy9llX6NfTFNUwMDSWwPPQW7jr00B59kg5mfx28kAFn2nGuV
         5i0ERVPQUlmWBxEWUnU3dseyi+V70LdAYXPGFaEfNET+d7b3OyJsww9BdxwqlD7qNlne
         uPVeahnkmGPqF2Cso2ALiepQBsSLd78TXqmrBY9NIhrazNWpzz+EFSMVk3jRid1Gn7pf
         YBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=N7Lz9MlAMZ2EGF4S5jNyBSYl14bB0H20CJuEnD/geJQ=;
        b=MA10VxfRpzvaBLe1s+AyNUxWNH3OmsSwp40LS5Ep5JRK+gB8gNmu1sHWxPamMonpMw
         ta8U/WdeCOCaq1BIz21bcJ46YIsN0AJ4qDnsKXTRJ83PA07V4KePeqJlrNkYxvtdDS/T
         5Eoh3WyHhDyz826aUX3uLnQIU8X4FH9ZV24+BvXAyFHYz+Coa7VhV4kJjd2kiA5CetK8
         eGva6ke69f45ZDw2+XKRxdeDJi+p+YxRoRJGGf+1BrjkMlbo9nItaogSvKnA2jYwQRIX
         ehU2niO/evAVEIj70VYuUslIEYT+2+evp3WSJleozBIdJTGc1HWYwTjpAkG+j22IDMWL
         SJbA==
X-Gm-Message-State: AOAM531aHNhrWDJEqHD5j3i5zKuC4yvSNObWe0LWWc9cjY4plGd7SA52
        v4x0SYMB7l81htz8d64HM9Gw9w==
X-Google-Smtp-Source: ABdhPJwRRDZyKhXpNUtdLZyEV4kcEI+U8JXXFrleCFGmkM6ObKtrEsBtJfXxxHCTLi6yvm+nwByeJg==
X-Received: by 2002:a05:6a00:158d:b0:47c:2341:264f with SMTP id u13-20020a056a00158d00b0047c2341264fmr4997658pfk.80.1635433784596;
        Thu, 28 Oct 2021 08:09:44 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y9sm3212418pjj.6.2021.10.28.08.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 08:09:44 -0700 (PDT)
Date:   Thu, 28 Oct 2021 08:09:44 -0700 (PDT)
X-Google-Original-Date: Thu, 28 Oct 2021 08:09:41 PDT (-0700)
Subject:     Re: Out-of-bounds access when hartid >= NR_CPUS
In-Reply-To: <CAOnJCU+MSP1QdpRRGYUpen8xZU+kn3PcSMJnZnRQw-iATs8JgQ@mail.gmail.com>
CC:     heiko@sntech.de, geert@linux-m68k.org, re@w6rz.net,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-51188428-41ff-4962-b548-bf514a779723@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 16:34:15 PDT (-0700), atishp@atishpatra.org wrote:
> On Tue, Oct 26, 2021 at 2:34 AM Heiko Stübner <heiko@sntech.de> wrote:
>>
>> Am Dienstag, 26. Oktober 2021, 10:57:26 CEST schrieb Geert Uytterhoeven:
>> > Hi Heiko,
>> >
>> > On Tue, Oct 26, 2021 at 10:53 AM Heiko Stübner <heiko@sntech.de> wrote:
>> > > Am Dienstag, 26. Oktober 2021, 08:44:31 CEST schrieb Geert Uytterhoeven:
>> > > > On Tue, Oct 26, 2021 at 2:37 AM Ron Economos <re@w6rz.net> wrote:
>> > > > > On 10/25/21 8:54 AM, Geert Uytterhoeven wrote:
>> > > > > > When booting a kernel with CONFIG_NR_CPUS=4 on Microchip PolarFire,
>> > > > > > the 4th CPU either fails to come online, or the system crashes.
>> > > > > >
>> > > > > > This happens because PolarFire has 5 CPU cores: hart 0 is an e51,
>> > > > > > and harts 1-4 are u54s, with the latter becoming CPUs 0-3 in Linux:
>> > > > > >    - unused core has hartid 0 (sifive,e51),
>> > > > > >    - processor 0 has hartid 1 (sifive,u74-mc),
>> > > > > >    - processor 1 has hartid 2 (sifive,u74-mc),
>> > > > > >    - processor 2 has hartid 3 (sifive,u74-mc),
>> > > > > >    - processor 3 has hartid 4 (sifive,u74-mc).
>> > > > > >
>> > > > > > I assume the same issue is present on the SiFive fu540 and fu740
>> > > > > > SoCs, but I don't have access to these.  The issue is not present
>> > > > > > on StarFive JH7100, as processor 0 has hartid 1, and processor 1 has
>> > > > > > hartid 0.
>> > > > > >
>> > > > > > arch/riscv/kernel/cpu_ops.c has:
>> > > > > >
>> > > > > >      void *__cpu_up_stack_pointer[NR_CPUS] __section(".data");
>> > > > > >      void *__cpu_up_task_pointer[NR_CPUS] __section(".data");
>> > > > > >
>> > > > > >      void cpu_update_secondary_bootdata(unsigned int cpuid,
>> > > > > >                                         struct task_struct *tidle)
>> > > > > >      {
>> > > > > >              int hartid = cpuid_to_hartid_map(cpuid);
>> > > > > >
>> > > > > >              /* Make sure tidle is updated */
>> > > > > >              smp_mb();
>> > > > > >              WRITE_ONCE(__cpu_up_stack_pointer[hartid],
>> > > > > >                         task_stack_page(tidle) + THREAD_SIZE);
>> > > > > >              WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
>> > > > > >
>> > > > > > The above two writes cause out-of-bound accesses beyond
>> > > > > > __cpu_up_{stack,pointer}_pointer[] if hartid >= CONFIG_NR_CPUS.
>> > > > > >
>> > > > > >      }
>> >
>> > > > https://riscv.org/wp-content/uploads/2017/05/riscv-privileged-v1.10.pdf
>> > > > says:
>> > > >
>> > > >     Hart IDs might not necessarily be numbered contiguously in a
>> > > >     multiprocessor system, but at least one hart must have a hart
>> > > >     ID of zero.
>> > > >
>> > > > Which means indexing arrays by hart ID is a no-go?
>> > >
>> > > Isn't that also similar on aarch64?
>> > >
>> > > On a rk3399 you get 0-3 and 100-101 and with the paragraph above
>> > > something like this could very well exist on some riscv cpu too I guess.
>> >
>> > Yes, it looks like hart IDs are similar to MPIDRs on ARM.
>>
>> and they have the set_cpu_logical_map construct to map hwids
>> to a continuous list of cpu-ids.
>>
>> So with hartids not being necessarily continuous this looks like
>> riscv would need a similar mechanism.
>>
>
> RISC-V already has a similar mechanism cpuid_to_hartid_map. Logical
> cpu ids are continuous
> while hartid can be sparse.
>
> The issue here is that __cpu_up_stack/task_pointer are per hart but
> array size depends on the NR_CPUs
> which represents the logical CPU.
>
> That's why, having a maximum number of hartids defined in config will
> be helpful.

I don't understand why we'd have both: if we can't find a CPU number for 
a hart, then all we can do is just leave it offline.  Wouldn't it be 
simpler to just rely on NR_CPUS?  We'll need to fix the crashes on 
overflows either way.
