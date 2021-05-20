Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF6338B477
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhETQmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhETQmU (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:42:20 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECAFC061574
        for <Linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:40:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x8so18329951wrq.9
        for <Linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nGF0DjZvZtJnILHDTEWPgYYmg5RLAu5DLyU93dgxNlY=;
        b=oIu9u0Sb3DO1TvN8XAi1Ekd0OARrP8M2S5LjTI0ea7MdOVusMYmBFkNCFiMHv3ef4/
         /pvZEIg8tUK5ASaglq3uM3uSkk55kCIPfpoYk61MzB31DLh04LwUVSBQ4wWQsDlxXvwD
         9trh/JEXJIyEw5tmHfoqnbjbs4SbSJSeEhvo2bb2iCX+qUeRiNwI5dtsJ7qT3Jxp2Jdz
         Z/ewLNEVaPEOnKs8Osw1jhobKahhsFxKx65z0w666wnTC87vzUN+u1tK+vnV+j6mkpPi
         fUUMeyPBQTe0iXaPc7NcV3oOhCYIJ5Ka2A3a/4nsUn9uAylQ5inNuOqx9BpZUxwSEzZa
         QYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nGF0DjZvZtJnILHDTEWPgYYmg5RLAu5DLyU93dgxNlY=;
        b=Gs8HgMPEhO66+i+sBYeXiv4bV6nO+MdAOVJZ7xnK1fcu8zvTOa1IvBOWfu/hJ7asJ3
         kexLJknhEEAo0qZI9+uRVo6KHJbiQleRNdaxhJwUTO02g3N0XGxc3dHgVf+lj6mmG0FT
         gvw35RMssxekzZC+1CzQkoSgIg/qRhDPlO62U4zl2kKXI/210VQY4JmpKNPIrMaO3Awu
         VhmOicO7Jnl57+YZdjE+yOt7kSkMCwkfLSklDsQlMh03A2Yy9TkHFX4itNVQ/Ihb1hwA
         SeiEtvsaz9blZVhBFkndkcMwXms7Y2BpO1u5Wvih9q5r9LM5de1t6/CPvVevXkPJXwDU
         z5cA==
X-Gm-Message-State: AOAM531SIjPafL2sUj57qd+yPghwdDKn+cvZFsH6Pe4SDhtOlxRC9uBS
        JhGoV0rpLQMB8P2PM5T9ZLndoZEOSja8QOM7l5zl0A==
X-Google-Smtp-Source: ABdhPJwnYWe1AkFwcTegOwV5oZoweM5XXehmSkpVJED+uilIn8b2qb7sWZmqyIrFM+okFvHrbVhItS66XKfr3fuSKAI=
X-Received: by 2002:adf:db4e:: with SMTP id f14mr5161427wrj.48.1621528857163;
 Thu, 20 May 2021 09:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210510012438.6293-1-yao.jin@linux.intel.com> <20210510012438.6293-4-yao.jin@linux.intel.com>
In-Reply-To: <20210510012438.6293-4-yao.jin@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 May 2021 09:40:44 -0700
Message-ID: <CAP-5=fUWh4_vzd5QxvLvJD=R-_VFfzjs556VBtd1ZZHEnpmOxw@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf vendor events: Add metrics for Icelake Server
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 9, 2021 at 6:26 PM Jin Yao <yao.jin@linux.intel.com> wrote:
>
> Add JSON metrics for Icelake Server to perf.
>
> Based on TMA metrics 4.21 at 01.org.
> https://download.01.org/perfmon/

Acked-by: Ian Rogers <irogers@google.com>

Could you update ratio_column here:
https://github.com/intel/event-converter-for-linux-perf/blob/master/extract=
-tmam-metrics.py#L81
as currently this can't be generated.

Thanks,
Ian

> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
>  .../arch/x86/icelakex/icx-metrics.json        | 327 ++++++++++++++++++
>  1 file changed, 327 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.j=
son
>
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/t=
ools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> new file mode 100644
> index 000000000000..7d61c4eab428
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> @@ -0,0 +1,327 @@
> +[
> +    {
> +        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> +        "BriefDescription": "Instructions Per Cycle (per Logical Process=
or)",
> +        "MetricGroup": "Summary",
> +        "MetricName": "IPC"
> +    },
> +    {
> +        "MetricExpr": "UOPS_RETIRED.SLOTS / INST_RETIRED.ANY",
> +        "BriefDescription": "Uops Per Instruction",
> +        "MetricGroup": "Pipeline;Retire",
> +        "MetricName": "UPI"
> +    },
> +    {
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
> +        "BriefDescription": "Instruction per taken branch",
> +        "MetricGroup": "Branches;FetchBW;PGO",
> +        "MetricName": "IpTB"
> +    },
> +    {
> +        "MetricExpr": "1 / (INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD)"=
,
> +        "BriefDescription": "Cycles Per Instruction (per Logical Process=
or)",
> +        "MetricGroup": "Pipeline",
> +        "MetricName": "CPI"
> +    },
> +    {
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
> +        "BriefDescription": "Per-Logical Processor actual clocks when th=
e Logical Processor is active.",
> +        "MetricGroup": "Pipeline",
> +        "MetricName": "CLKS"
> +    },
> +    {
> +        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.DISTRIBUTED",
> +        "BriefDescription": "Instructions Per Cycle (per physical core)"=
,
> +        "MetricGroup": "SMT;TmaL1",
> +        "MetricName": "CoreIPC"
> +    },
> +    {
> +        "MetricExpr": "( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_=
ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_=
DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RET=
IRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE =
+ FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.5=
12B_PACKED_SINGLE ) / CPU_CLK_UNHALTED.DISTRIBUTED",
> +        "BriefDescription": "Floating Point Operations Per Cycle",
> +        "MetricGroup": "Flops",
> +        "MetricName": "FLOPc"
> +    },
> +    {
> +        "MetricExpr": "UOPS_EXECUTED.THREAD / ( UOPS_EXECUTED.CORE_CYCLE=
S_GE_1 / 2 )",
> +        "BriefDescription": "Instruction-Level-Parallelism (average numb=
er of uops executed when there is at least 1 uop executed)",
> +        "MetricGroup": "Pipeline;PortsUtil",
> +        "MetricName": "ILP"
> +    },
> +    {
> +        "MetricExpr": "CPU_CLK_UNHALTED.DISTRIBUTED",
> +        "BriefDescription": "Core actual clocks when any Logical Process=
or is active on the Physical Core",
> +        "MetricGroup": "SMT",
> +        "MetricName": "CORE_CLKS"
> +    },
> +    {
> +        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
> +        "BriefDescription": "Instructions per Load (lower number means h=
igher occurrence rate)",
> +        "MetricGroup": "InsType",
> +        "MetricName": "IpLoad"
> +    },
> +    {
> +        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
> +        "BriefDescription": "Instructions per Store (lower number means =
higher occurrence rate)",
> +        "MetricGroup": "InsType",
> +        "MetricName": "IpStore"
> +    },
> +    {
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
> +        "BriefDescription": "Instructions per Branch (lower number means=
 higher occurrence rate)",
> +        "MetricGroup": "Branches;InsType",
> +        "MetricName": "IpBranch"
> +    },
> +    {
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
> +        "BriefDescription": "Instructions per (near) call (lower number =
means higher occurrence rate)",
> +        "MetricGroup": "Branches",
> +        "MetricName": "IpCall"
> +    },
> +    {
> +        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NE=
AR_TAKEN",
> +        "BriefDescription": "Branch instructions per taken branch. ",
> +        "MetricGroup": "Branches;PGO",
> +        "MetricName": "BpTkBranch"
> +    },
> +    {
> +        "MetricExpr": "INST_RETIRED.ANY / ( 1 * ( FP_ARITH_INST_RETIRED.=
SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_R=
ETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE =
+ FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.=
256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_A=
RITH_INST_RETIRED.512B_PACKED_SINGLE )",
> +        "BriefDescription": "Instructions per Floating Point (FP) Operat=
ion (lower number means higher occurrence rate)",
> +        "MetricGroup": "Flops;FpArith;InsType",
> +        "MetricName": "IpFLOP"
> +    },
> +    {
> +        "MetricExpr": "INST_RETIRED.ANY",
> +        "BriefDescription": "Total number of retired Instructions",
> +        "MetricGroup": "Summary;TmaL1",
> +        "MetricName": "Instructions"
> +    },
> +    {
> +        "MetricExpr": "LSD.UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UO=
PS + IDQ.MS_UOPS)",
> +        "BriefDescription": "Fraction of Uops delivered by the LSD (Loop=
 Stream Detector; aka Loop Cache)",
> +        "MetricGroup": "LSD",
> +        "MetricName": "LSD_Coverage"
> +    },
> +    {
> +        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MIT=
E_UOPS + IDQ.MS_UOPS)",
> +        "BriefDescription": "Fraction of Uops delivered by the DSB (aka =
Decoded ICache; or Uop Cache)",
> +        "MetricGroup": "DSB;FetchBW",
> +        "MetricName": "DSB_Coverage"
> +    },
> +    {
> +        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MIS=
S + MEM_LOAD_RETIRED.FB_HIT )",
> +        "BriefDescription": "Actual Average Latency for L1 data-cache mi=
ss demand loads (in core cycles)",
> +        "MetricGroup": "MemoryBound;MemoryLat",
> +        "MetricName": "Load_Miss_Real_Latency"
> +    },
> +    {
> +        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYC=
LES",
> +        "BriefDescription": "Memory-Level-Parallelism (average number of=
 L1 miss demand load when there is at least one such miss. Per-Logical Proc=
essor)",
> +        "MetricGroup": "MemoryBound;MemoryBW",
> +        "MetricName": "MLP"
> +    },
> +    {
> +        "MetricConstraint": "NO_NMI_WATCHDOG",
> +        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WAL=
K_PENDING + DTLB_STORE_MISSES.WALK_PENDING ) / ( 2 * CPU_CLK_UNHALTED.DISTR=
IBUTED )",
> +        "BriefDescription": "Utilization of the core's Page Walker(s) se=
rving STLB misses triggered by instruction/Load/Store accesses",
> +        "MetricGroup": "MemoryTLB",
> +        "MetricName": "Page_Walks_Utilization"
> +    },
> +    {
> +        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time=
",
> +        "BriefDescription": "Average data fill bandwidth to the L1 data =
cache [GB / sec]",
> +        "MetricGroup": "MemoryBW",
> +        "MetricName": "L1D_Cache_Fill_BW"
> +    },
> +    {
> +        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time=
",
> +        "BriefDescription": "Average data fill bandwidth to the L2 cache=
 [GB / sec]",
> +        "MetricGroup": "MemoryBW",
> +        "MetricName": "L2_Cache_Fill_BW"
> +    },
> +    {
> +        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / durati=
on_time",
> +        "BriefDescription": "Average per-core data fill bandwidth to the=
 L3 cache [GB / sec]",
> +        "MetricGroup": "MemoryBW",
> +        "MetricName": "L3_Cache_Fill_BW"
> +    },
> +    {
> +        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 /=
 duration_time",
> +        "BriefDescription": "Average per-core data access bandwidth to t=
he L3 cache [GB / sec]",
> +        "MetricGroup": "MemoryBW;Offcore",
> +        "MetricName": "L3_Cache_Access_BW"
> +    },
> +    {
> +        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.AN=
Y",
> +        "BriefDescription": "L1 cache true misses per kilo instruction f=
or retired demand loads",
> +        "MetricGroup": "CacheMisses",
> +        "MetricName": "L1MPKI"
> +    },
> +    {
> +        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.AN=
Y",
> +        "BriefDescription": "L2 cache true misses per kilo instruction f=
or retired demand loads",
> +        "MetricGroup": "CacheMisses",
> +        "MetricName": "L2MPKI"
> +    },
> +    {
> +        "MetricExpr": "1000 * ( ( OFFCORE_REQUESTS.ALL_DATA_RD - OFFCORE=
_REQUESTS.DEMAND_DATA_RD ) + L2_RQSTS.ALL_DEMAND_MISS + L2_RQSTS.SWPF_MISS =
) / INST_RETIRED.ANY",
> +        "BriefDescription": "L2 cache misses per kilo instruction for al=
l request types (including speculative)",
> +        "MetricGroup": "CacheMisses;Offcore",
> +        "MetricName": "L2MPKI_All"
> +    },
> +    {
> +        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.AN=
Y",
> +        "BriefDescription": "L3 cache true misses per kilo instruction f=
or retired demand loads",
> +        "MetricGroup": "CacheMisses",
> +        "MetricName": "L3MPKI"
> +    },
> +    {
> +        "MetricExpr": "1000 * L2_LINES_OUT.SILENT / INST_RETIRED.ANY",
> +        "BriefDescription": "Rate of silent evictions from the L2 cache =
per Kilo instruction where the evicted lines are dropped (no writeback to L=
3 or memory)",
> +        "MetricGroup": "L2Evicts;Server",
> +        "MetricName": "L2_Evictions_Silent_PKI"
> +    },
> +    {
> +        "MetricExpr": "1000 * L2_LINES_OUT.NON_SILENT / INST_RETIRED.ANY=
",
> +        "BriefDescription": "Rate of non silent evictions from the L2 ca=
che per Kilo instruction",
> +        "MetricGroup": "L2Evicts;Server",
> +        "MetricName": "L2_Evictions_NonSilent_PKI"
> +    },
> +    {
> +        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
> +        "BriefDescription": "Average CPU Utilization",
> +        "MetricGroup": "HPC;Summary",
> +        "MetricName": "CPU_Utilization"
> +    },
> +    {
> +        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_T=
SC) * msr@tsc@ / 1000000000 / duration_time",
> +        "BriefDescription": "Measured Average Frequency for unhalted pro=
cessors [GHz]",
> +        "MetricGroup": "Summary;Power",
> +        "MetricName": "Average_Frequency"
> +    },
> +    {
> +        "MetricExpr": "( ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + F=
P_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKE=
D_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_R=
ETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGL=
E + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED=
.512B_PACKED_SINGLE ) / 1000000000 ) / duration_time",
> +        "BriefDescription": "Giga Floating Point Operations Per Second",
> +        "MetricGroup": "Flops;HPC",
> +        "MetricName": "GFLOPs"
> +    },
> +    {
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TS=
C",
> +        "BriefDescription": "Average Frequency Utilization relative nomi=
nal frequency",
> +        "MetricGroup": "Power",
> +        "MetricName": "Turbo_Utilization"
> +    },
> +    {
> +        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_=
UNHALTED.REF_DISTRIBUTED",
> +        "BriefDescription": "Fraction of cycles where both hardware Logi=
cal Processors were active",
> +        "MetricGroup": "SMT",
> +        "MetricName": "SMT_2T_Utilization"
> +    },
> +    {
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THRE=
AD",
> +        "BriefDescription": "Fraction of cycles spent in the Operating S=
ystem (OS) Kernel mode",
> +        "MetricGroup": "OS",
> +        "MetricName": "Kernel_Utilization"
> +    },
> +    {
> +        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@=
cas_count_write@ ) / 1000000000 ) / duration_time",
> +        "BriefDescription": "Average external Memory Bandwidth Use for r=
eads and writes [GB / sec]",
> +        "MetricGroup": "HPC;MemoryBW;SoC",
> +        "MetricName": "DRAM_BW_Use"
> +    },
> +    {
> +        "MetricExpr": "1000000000 * ( cha@event\\=3D0x36\\,umask\\=3D0x2=
1\\,config\\=3D0x40433@ / cha@event\\=3D0x35\\,umask\\=3D0x21\\,config\\=3D=
0x40433@ ) / ( cha_0@event\\=3D0x0@ / duration_time )",
> +        "BriefDescription": "Average latency of data read request to ext=
ernal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetch=
es",
> +        "MetricGroup": "MemoryLat;SoC",
> +        "MetricName": "MEM_Read_Latency"
> +    },
> +    {
> +        "MetricExpr": "cha@event\\=3D0x36\\,umask\\=3D0x21\\,config\\=3D=
0x40433@ / cha@event\\=3D0x36\\,umask\\=3D0x21\\,config\\=3D0x40433\\,thres=
h\\=3D1@",
> +        "BriefDescription": "Average number of parallel data read reques=
ts to external memory. Accounts for demand loads and L1/L2 prefetches",
> +        "MetricGroup": "MemoryBW;SoC",
> +        "MetricName": "MEM_Parallel_Reads"
> +    },
> +    {
> +        "MetricExpr": "( 1000000000 * ( cha@event\\=3D0x36\\,umask\\=3D0=
x21\\,config\\=3D0x40433@_PMM / cha@event\\=3D0x35\\,umask\\=3D0x21\\,confi=
g\\=3D0x40433@_PMM ) / cha_0@event\\=3D0x0@ )",
> +        "BriefDescription": "Average latency of data read request to ext=
ernal 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/=
L2 data-read prefetches",
> +        "MetricGroup": "MemoryLat;SoC;Server",
> +        "MetricName": "MEM_PMM_Read_Latency"
> +    },
> +    {
> +        "MetricExpr": "( ( 64 * imc@event\\=3D0xe3@ / 1000000000 ) / dur=
ation_time )",
> +        "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads=
 [GB / sec]",
> +        "MetricGroup": "MemoryBW;SoC;Server",
> +        "MetricName": "PMM_Read_BW"
> +    },
> +    {
> +        "MetricExpr": "( ( 64 * imc@event\\=3D0xe7@ / 1000000000 ) / dur=
ation_time )",
> +        "BriefDescription": "Average 3DXP Memory Bandwidth Use for Write=
s [GB / sec]",
> +        "MetricGroup": "MemoryBW;SoC;Server",
> +        "MetricName": "PMM_Write_BW"
> +    },
> +    {
> +        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1000000000=
 / duration_time",
> +        "BriefDescription": "Average IO (network or disk) Bandwidth Use =
for Writes [GB / sec]",
> +        "MetricGroup": "IoBW;SoC;Server",
> +        "MetricName": "IO_Write_BW"
> +    },
> +    {
> +        "MetricExpr": "( UNC_CHA_TOR_INSERTS.IO_HIT_ITOM + UNC_CHA_TOR_I=
NSERTS.IO_MISS_ITOM + UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR + UNC_CHA_TO=
R_INSERTS.IO_MISS_ITOMCACHENEAR ) * 64 / 1000000000 / duration_time",
> +        "BriefDescription": "Average IO (network or disk) Bandwidth Use =
for Reads [GB / sec]",
> +        "MetricGroup": "IoBW;SoC;Server",
> +        "MetricName": "IO_Read_BW"
> +    },
> +    {
> +        "MetricExpr": "cha_0@event\\=3D0x0@",
> +        "BriefDescription": "Socket actual clocks when any core is activ=
e on that socket",
> +        "MetricGroup": "SoC",
> +        "MetricName": "Socket_CLKS"
> +    },
> +    {
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
> +        "BriefDescription": "Instructions per Far Branch ( Far Branches =
apply upon transition from application to operating system, handling interr=
upts, exceptions) [lower number means higher occurrence rate]",
> +        "MetricGroup": "Branches;OS",
> +        "MetricName": "IpFarBranch"
> +    },
> +    {
> +        "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
> +        "BriefDescription": "C3 residency percent per core",
> +        "MetricGroup": "Power",
> +        "MetricName": "C3_Core_Residency"
> +    },
> +    {
> +        "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
> +        "BriefDescription": "C6 residency percent per core",
> +        "MetricGroup": "Power",
> +        "MetricName": "C6_Core_Residency"
> +    },
> +    {
> +        "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
> +        "BriefDescription": "C7 residency percent per core",
> +        "MetricGroup": "Power",
> +        "MetricName": "C7_Core_Residency"
> +    },
> +    {
> +        "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
> +        "BriefDescription": "C2 residency percent per package",
> +        "MetricGroup": "Power",
> +        "MetricName": "C2_Pkg_Residency"
> +    },
> +    {
> +        "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
> +        "BriefDescription": "C3 residency percent per package",
> +        "MetricGroup": "Power",
> +        "MetricName": "C3_Pkg_Residency"
> +    },
> +    {
> +        "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
> +        "BriefDescription": "C6 residency percent per package",
> +        "MetricGroup": "Power",
> +        "MetricName": "C6_Pkg_Residency"
> +    },
> +    {
> +        "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
> +        "BriefDescription": "C7 residency percent per package",
> +        "MetricGroup": "Power",
> +        "MetricName": "C7_Pkg_Residency"
> +    }
> +]
> --
> 2.17.1
>
