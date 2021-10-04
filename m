Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45137421284
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhJDPVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbhJDPVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:21:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75113C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 08:19:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g2so14781305pfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 08:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bG5N3bpWvmKx3qZADcaC2ucWKhjDZKWo6A93CP7r7Do=;
        b=lzo7gfKvwIsMM5tL4QTGn6SNrwm5I6gKWRj/7E13GRZxbrj06ENSZOD45a0hQ+nMV7
         z7a4m5c+NaESctUA1gOdCfxYiVTB8PWi0JcA/IxiphmlbDcOlGxsVqiCtPgkcZjVy8lQ
         2lTp6Jj6jBS/99BDUmPcFKKc++hJMrgJqtL/7Hk3S6qnr4mqE7l0YYct/uTPAOHR5OHs
         2nmLDT7h45e+xkuORcel+VxRmSCdrVqwn/CTpJFrkGdn8DNx+BqNYOLOC/HaToBoRCl6
         MCCkje4srukc07vi5WCqPO0YXX3TtOZv5O6vaO3/oXK8TqD1RkLHd6cvt3YbxIM88mv3
         MYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bG5N3bpWvmKx3qZADcaC2ucWKhjDZKWo6A93CP7r7Do=;
        b=2i5ohdWdtBDj26KbtZIhtitx1qoC+ot7hGHhMzU4GyQhPhw0AEFBN9qktlN+Q7vbsq
         WAfGNo7saoOUp08CXN+Objvu5M3dy6ejwWsFcpJ0Ex/N7BFPQRGKlT/om5u8XtWE8ZMK
         qCabCiYeL0XE78wzzmqCkCxiirjen84d+77NyZM+TG33PWk4ZV/yl9pk0q/ls4WEMXxM
         V7lbl029/xZtJoFZxD+QYM1Vxa1T9Tel73gH2l2GVEGQPnsM/SdhehDuw5BhQhGFRILJ
         tRHvIIOCzVUZbNgyn0gFL7Mln/HHkTq6u8/lzX8zrycJTXcfe/OzQXchlAXaMiR9oUvV
         Up+g==
X-Gm-Message-State: AOAM5325jybCJ3smNq5MBXwcnQBblXOGi19GrvG7PH5ibHjRcJbI5dcl
        jGTtJpQZxRxZ6VjkFpKNsT4AqA==
X-Google-Smtp-Source: ABdhPJzKPXushPnroxDW3BmBk90XAfnxfi/3LgF6Z8M45bAarq4ejwW4ab1Fziq8pTouDxE7lIeL0A==
X-Received: by 2002:a63:7d46:: with SMTP id m6mr11642983pgn.409.1633360794827;
        Mon, 04 Oct 2021 08:19:54 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.181.210])
        by smtp.gmail.com with ESMTPSA id i5sm14967281pjk.47.2021.10.04.08.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 08:19:54 -0700 (PDT)
Date:   Mon, 4 Oct 2021 23:19:46 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Stephane Eranian <eranian@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
Message-ID: <20211004151946.GA54939@leoy-ThinkPad-X240s>
References: <20210916001748.1525291-1-namhyung@kernel.org>
 <20210916135418.GA383600@leoy-ThinkPad-X240s>
 <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com>
 <20210923142305.GA603008@leoy-ThinkPad-X240s>
 <CAM9d7cixyD6ZmXnBnoB8Zg-JN-tWYXUdqURHGn+2ZMD5x9evew@mail.gmail.com>
 <CABPqkBTW9dnfSz1KrtiGNzbOf7QfzB6ga+EQvK28J+3-SzBsgQ@mail.gmail.com>
 <8cc1574a-29a9-f550-0b09-a23ce69467d3@arm.com>
 <CABPqkBTD9Jst9vXPbU+n_MwPSAUyD5Pa0uwkiQhJN0iXJsjzrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTD9Jst9vXPbU+n_MwPSAUyD5Pa0uwkiQhJN0iXJsjzrQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Fri, Oct 01, 2021 at 11:22:33AM -0700, Stephane Eranian wrote:
> On Fri, Oct 1, 2021 at 3:44 AM James Clark <james.clark@arm.com> wrote:
> > On 30/09/2021 19:47, Stephane Eranian wrote:
> > > On Thu, Sep 23, 2021 at 9:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >> On Thu, Sep 23, 2021 at 7:23 AM Leo Yan <leo.yan@linaro.org> wrote:

[...]

> > >>> Yes, after enabled config PID_IN_CONTEXTIDR, the kernel will always
> > >>> write PID into the system register CONTEXTIDR during process context
> > >>> switching.  Please see the flow:
> > >>>
> > >>>   __switch_to() (arch/arm64/kernel/process.c)
> > >>>     `-> contextidr_thread_switch(next)
> > >>
> > >> Thanks for the info.  I assume it's a light-weight operation.
> > >>
> > > I'd like to understand why it was believed that having SPE record to
> > > PID could be too expensive
> > > vs. what I am seeing with all the tracking of context switches and the
> > > volume of data this generates.
> >
> > I think the justification about it being expensive is that when PID_IN_CONTEXTIDR
> > is set, there is an extra few instructions to write that value on every context
> > switch, whether SPE is enabled or not. So it has a system wide impact.
> 
> You could use a static key to make this conditional to having SPE
> running on the CPU like
> it is done for other PMU features on other architectures.

Good point for using static key to dynamically enable and disable
CONTEXTIDR rather than using config PID_IN_CONTEXTIDR.

For curious, I did a rough testing to compare the performance for using
CONTEXTIDR, there have four testing configurations:
- 'dis': Use the mainline kernel with disabling PID_IN_CONTEXTIDR.
- 'enb': Use the mainline kernel with enablng PID_IN_CONTEXTIDR.
- 'true': Use static key='TRUE' to store PID into CONTEXTIDR.
- 'false': Use static key='FALSE' so don't store PID into CONTEXTIDR.

I used the command 'perf bench sched messaging -t -g 20 -l 1000' as
the testing case, the main reason is this case have total 800 threads
for sending and receiving messages, so it should have huge times for
context switching.

The testing iterates for 5 loops for every configuration, and get the
result for run time (in seconds):

     dis     enb     true    false
     ------------------------------
#1   26.568  26.786  26.056  26.197
#2   26.442  26.457  26.458  26.846
#3   26.719  26.701  27.119  26.281
#4   26.448  27.595  26.953  27.043
#5   27.017  27.263  26.638  26.933
     ------------------------------
avg. 26.638  26.960  26.644   26.66
     ------------------------------
delta pct.    1.21%   0.02%   0.08%

Compared with the base configuration ('dis' with disabling
PID_IN_CONTEXTIDR), we can see the performance is only minor
downgradation in other configurations ('enb': 1.21%, Enable
static key: 0.02%, Disable static key: 0.08%).  So seems to me,
it's feasible to use static key to dynamically control the path for
PID_IN_CONTEXTIDR.

@Catalin, @Will, could you confirm if it is the right direction to
use static key to replace PID_IN_CONTEXTIDR?  Or have any concern for
using the static key, like any secuirty reason?

Also pasted the code for using static key for CONTEXTIDR in the
bottom.

Thanks,
Leo

---8<---

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index f4ba93d4ffeb..857e35a8624a 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -26,9 +26,11 @@
 
 extern bool rodata_full;
 
+DECLARE_STATIC_KEY_FALSE(contextidr_used);
+
 static inline void contextidr_thread_switch(struct task_struct *next)
 {
-	if (!IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR))
+	if (!static_branch_unlikely(&contextidr_used))
 		return;
 
 	write_sysreg(task_pid_nr(next), contextidr_el1);
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 40adb8cdbf5a..f6b6e73fac9d 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -487,6 +487,22 @@ void update_sctlr_el1(u64 sctlr)
 	isb();
 }
 
+DEFINE_STATIC_KEY_FALSE(contextidr_used);
+
+static int __init contextidr_enable(char *str)
+{
+	unsigned int val = 0;
+
+	get_option(&str, &val);
+
+        if (val)
+                static_branch_enable(&contextidr_used);
+
+        return 0;
+}
+early_param("contextidr_enable", contextidr_enable);
+
 /*
  * Thread switching.
  */
