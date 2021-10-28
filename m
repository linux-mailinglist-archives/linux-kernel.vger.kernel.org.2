Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB52A43E706
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhJ1RTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhJ1RTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:19:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB530C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:16:48 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so5336445pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Otd8wqbvX1Uw8nMu3+24uiRjK4m32qtFfunufxK5O1w=;
        b=yzm/DL9B4BfHqch51I3/f+IhIRl5OUPUa/iPXmZb9JNGqlmcnXvHT9wzcY80WC80X4
         JJXcXOjAT1LXvAy5pvy4cUsR2cFTnyRhPvHkbiSzpAJv2q211biot9xMRHO85OcsINFK
         uV6qfURruqRqTAMR/XI9X/+ymXniDK2ZEMtr6i7xJqNfdjcqs2j7AJB+DeRkd3PiV1Jw
         e5dr3yNkwlJVtlp8SZDkctdW6BWzfNo3oTwoBez7ehKJXETi7y+jyCiw1LDstFtTbIOQ
         zLmAXzrx5QFe9mCswZLNlYmurTyPKYJuFJshw+LvDlVlf1LZDtPTjJ4+UF7ySvuKsjcW
         HWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Otd8wqbvX1Uw8nMu3+24uiRjK4m32qtFfunufxK5O1w=;
        b=sWiuc4CTbSJfYEJ8NhRmgLxiITf3ScBeMYJctB+JvfI8QzFYhO5RYslt533IoNMko3
         E9gXd6B/WdFIqIfC8xqZi1pM1UJrf+HGMQZhIvsRYm9QuEsRYxSLreL/q4xcbUp+/25+
         lYduQyR5XCcS+UYWZFN5wPHVQ1ici6kLsGwPyHABbtueHEV+0fJut62nS4OIvfOMs7X8
         h92D0TO96Wdg4wF9XWo46ppoWwzr/ZRmin/hwZD+JvdHk2S7l0N/646iqRSm6RRlnygN
         mSJjmd/61iNusgYUb/83MamLGbeQx6/kAtY406Rw1FcTJcHCPMM8ivsHPvRGP6wIeozo
         b6ww==
X-Gm-Message-State: AOAM533Z4SOuXzvOmkzYrXc/vaBGjCGWpmSJ3otw3X2oBHrfXY+OfSWj
        bNBUdYqzFE4As1TZQrzgM2hnbQ==
X-Google-Smtp-Source: ABdhPJytfam8w3644kpAMsGPzZI1mS9HokpMKgKf1d/Qspc0dhNn6t1sdTh7eGTZ1cAZr7GuiiOu3g==
X-Received: by 2002:a17:90a:65c7:: with SMTP id i7mr14075110pjs.192.1635441408161;
        Thu, 28 Oct 2021 10:16:48 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z15sm3260685pga.16.2021.10.28.10.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 10:16:47 -0700 (PDT)
Date:   Thu, 28 Oct 2021 10:16:47 -0700 (PDT)
X-Google-Original-Date: Thu, 28 Oct 2021 10:16:45 PDT (-0700)
Subject:     Re: Out-of-bounds access when hartid >= NR_CPUS
In-Reply-To: <CAAhSdy2oV9fNtsY258h6zQS6Us7GyW6B_ox6U1Um2Why354-gA@mail.gmail.com>
CC:     atishp@atishpatra.org, heiko@sntech.de, geert@linux-m68k.org,
        re@w6rz.net, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     anup@brainfault.org
Message-ID: <mhng-730fea8d-0455-4333-a731-1e7b0e062587@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 09:21:31 PDT (-0700), anup@brainfault.org wrote:
> On Thu, Oct 28, 2021 at 8:39 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Wed, 27 Oct 2021 16:34:15 PDT (-0700), atishp@atishpatra.org wrote:
>> > On Tue, Oct 26, 2021 at 2:34 AM Heiko Stübner <heiko@sntech.de> wrote:
>> >>
>> >> Am Dienstag, 26. Oktober 2021, 10:57:26 CEST schrieb Geert Uytterhoeven:
>> >> > Hi Heiko,
>> >> >
>> >> > On Tue, Oct 26, 2021 at 10:53 AM Heiko Stübner <heiko@sntech.de> wrote:
>> >> > > Am Dienstag, 26. Oktober 2021, 08:44:31 CEST schrieb Geert Uytterhoeven:
>> >> > > > On Tue, Oct 26, 2021 at 2:37 AM Ron Economos <re@w6rz.net> wrote:
>> >> > > > > On 10/25/21 8:54 AM, Geert Uytterhoeven wrote:
>> >> > > > > > When booting a kernel with CONFIG_NR_CPUS=4 on Microchip PolarFire,
>> >> > > > > > the 4th CPU either fails to come online, or the system crashes.
>> >> > > > > >
>> >> > > > > > This happens because PolarFire has 5 CPU cores: hart 0 is an e51,
>> >> > > > > > and harts 1-4 are u54s, with the latter becoming CPUs 0-3 in Linux:
>> >> > > > > >    - unused core has hartid 0 (sifive,e51),
>> >> > > > > >    - processor 0 has hartid 1 (sifive,u74-mc),
>> >> > > > > >    - processor 1 has hartid 2 (sifive,u74-mc),
>> >> > > > > >    - processor 2 has hartid 3 (sifive,u74-mc),
>> >> > > > > >    - processor 3 has hartid 4 (sifive,u74-mc).
>> >> > > > > >
>> >> > > > > > I assume the same issue is present on the SiFive fu540 and fu740
>> >> > > > > > SoCs, but I don't have access to these.  The issue is not present
>> >> > > > > > on StarFive JH7100, as processor 0 has hartid 1, and processor 1 has
>> >> > > > > > hartid 0.
>> >> > > > > >
>> >> > > > > > arch/riscv/kernel/cpu_ops.c has:
>> >> > > > > >
>> >> > > > > >      void *__cpu_up_stack_pointer[NR_CPUS] __section(".data");
>> >> > > > > >      void *__cpu_up_task_pointer[NR_CPUS] __section(".data");
>> >> > > > > >
>> >> > > > > >      void cpu_update_secondary_bootdata(unsigned int cpuid,
>> >> > > > > >                                         struct task_struct *tidle)
>> >> > > > > >      {
>> >> > > > > >              int hartid = cpuid_to_hartid_map(cpuid);
>> >> > > > > >
>> >> > > > > >              /* Make sure tidle is updated */
>> >> > > > > >              smp_mb();
>> >> > > > > >              WRITE_ONCE(__cpu_up_stack_pointer[hartid],
>> >> > > > > >                         task_stack_page(tidle) + THREAD_SIZE);
>> >> > > > > >              WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
>> >> > > > > >
>> >> > > > > > The above two writes cause out-of-bound accesses beyond
>> >> > > > > > __cpu_up_{stack,pointer}_pointer[] if hartid >= CONFIG_NR_CPUS.
>> >> > > > > >
>> >> > > > > >      }
>> >> >
>> >> > > > https://riscv.org/wp-content/uploads/2017/05/riscv-privileged-v1.10.pdf
>> >> > > > says:
>> >> > > >
>> >> > > >     Hart IDs might not necessarily be numbered contiguously in a
>> >> > > >     multiprocessor system, but at least one hart must have a hart
>> >> > > >     ID of zero.
>> >> > > >
>> >> > > > Which means indexing arrays by hart ID is a no-go?
>> >> > >
>> >> > > Isn't that also similar on aarch64?
>> >> > >
>> >> > > On a rk3399 you get 0-3 and 100-101 and with the paragraph above
>> >> > > something like this could very well exist on some riscv cpu too I guess.
>> >> >
>> >> > Yes, it looks like hart IDs are similar to MPIDRs on ARM.
>> >>
>> >> and they have the set_cpu_logical_map construct to map hwids
>> >> to a continuous list of cpu-ids.
>> >>
>> >> So with hartids not being necessarily continuous this looks like
>> >> riscv would need a similar mechanism.
>> >>
>> >
>> > RISC-V already has a similar mechanism cpuid_to_hartid_map. Logical
>> > cpu ids are continuous
>> > while hartid can be sparse.
>> >
>> > The issue here is that __cpu_up_stack/task_pointer are per hart but
>> > array size depends on the NR_CPUs
>> > which represents the logical CPU.
>> >
>> > That's why, having a maximum number of hartids defined in config will
>> > be helpful.
>>
>> I don't understand why we'd have both: if we can't find a CPU number for
>> a hart, then all we can do is just leave it offline.  Wouldn't it be
>> simpler to just rely on NR_CPUS?  We'll need to fix the crashes on
>> overflows either way.,
>
> For HSM ops, we can easily fix this limitation because the HART
> start call has an opaque parameter which can be used to specify TP
> and SP for the HART being brought up.
>
> For spinwait ops, I don't see much value in fixing sparse hartid
> problems so let's document this problem and have appropriate
> checks in spinwait ops for out-of-bound array checks.

Seems reasonable.  That's the legacy method anyway, so hopefully vendors 
will have moved to the new stuff by the time we get sufficiently sparse 
hart IDs that this matters.

We should fix the crashes, though.  Happy to take a patch, otherwise 
I'll throw something together.

>
> Regards,
> Anup
