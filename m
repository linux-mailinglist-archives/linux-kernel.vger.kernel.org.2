Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49F8388C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346103AbhESLKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240482AbhESLKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:10:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EE4C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 04:09:20 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 69so6827021plc.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 04:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=e62NCutqVCKY1HZkBPIYfPXud7+Npfa1OW39gmbpZNw=;
        b=AqRy7PoVVsGWyaOqAExW+UbJ5G2Hg8v5DwW0yaQa4vR2DJ62ZlwKffibyrBx7d6fdF
         noszNvJZm3l0ad+gbM9y/fbi8ZYxUIS2pJebrXsod087KBCpm/dHj+CHE7b0FpEdy1+d
         z4qlFFQ4qLxwVvk4TLd9wKaa9bZEnv7oeKsukZyS+5uFkZhb3QabrzUCGEXGkEFcBaLI
         2YenGVjj5Y46IJblWrwPHdKCd5Sjbh0BdmEl/XTjMAqFL7p8BJ3G1j+qtXGcs3rkXetg
         OYYrogimMCxT+Sj4BvaJgp7HTqTEb/MhNU9FfgD7YhHdlX873H7AhdoYIR+9cfYWAfG/
         YUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=e62NCutqVCKY1HZkBPIYfPXud7+Npfa1OW39gmbpZNw=;
        b=q1WfaFCeMmgA9nmCg5jVgAzFKacO+8GlRTr0dt4474Md4uzTxl3QbJ+8AQV3bPAxwA
         pIFaNkig5wbYo3wxzxu1z4hDVt6MdcD8rC4JXGJFxo7IKfD1kCuIaOrFGYgPrKM1Mno6
         xKp8i4ZRTDS4hpS6Ut+6LC1Q6wNk2rYezotiKpV8Dt1UFVy2lb4WJ7vtmmc9hjnxoxfl
         HRuVQy7XeOIVIkPmr3JTvNcriWOkQDcigNx5vF9sdJNPt1wrsdDRoUTKz5agNvkDhRd3
         zGhHI/hB31dl5b3SmoOYX8JlnuXLkiaH+XFeiZF3/Go40QBWEn/mziNF4cGDqNvLMDdv
         iFOg==
X-Gm-Message-State: AOAM531iL5rah6/B+JiIX6rNpRu/d0fy5Nm1MeyFO8JwD0LkldfZ3zPt
        5jpbqGMlJgqfSmqucoSHZBs=
X-Google-Smtp-Source: ABdhPJzf5y+PAB13kZ36zpA6LV/PtNoQ5/SsALHEpOBAG8UxoHuBIAaArifwvs7eStDb2yHlpm/PbA==
X-Received: by 2002:a17:90a:a08c:: with SMTP id r12mr10540431pjp.204.1621422560590;
        Wed, 19 May 2021 04:09:20 -0700 (PDT)
Received: from localhost (14-201-155-8.tpgi.com.au. [14.201.155.8])
        by smtp.gmail.com with ESMTPSA id x13sm990257pfn.43.2021.05.19.04.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 04:09:20 -0700 (PDT)
Date:   Wed, 19 May 2021 21:09:14 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 5/6] sched/fair: Consider SMT in ASYM_PACKING load
 balance
To:     Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Aubrey Li <aubrey.li@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Mel Gorman <mgorman@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Quentin Perret <qperret@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20210513154909.6385-1-ricardo.neri-calderon@linux.intel.com>
        <20210513154909.6385-6-ricardo.neri-calderon@linux.intel.com>
        <YJ5HQR943rSFsLxw@hirez.programming.kicks-ass.net>
        <20210515021415.GB14212@ranerica-svr.sc.intel.com>
        <20210518190740.GA15251@ranerica-svr.sc.intel.com>
        <YKThlA2yZBT2KuvW@hirez.programming.kicks-ass.net>
In-Reply-To: <YKThlA2yZBT2KuvW@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1621422058.5rx5cxsjqx.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Peter Zijlstra's message of May 19, 2021 7:59 pm:
> On Tue, May 18, 2021 at 12:07:40PM -0700, Ricardo Neri wrote:
>> On Fri, May 14, 2021 at 07:14:15PM -0700, Ricardo Neri wrote:
>> > On Fri, May 14, 2021 at 11:47:45AM +0200, Peter Zijlstra wrote:
>=20
>> > > So I'm thinking that this is a property of having ASYM_PACKING at a =
core
>> > > level, rather than some arch special. Wouldn't something like this b=
e
>> > > more appropriate?
>=20
>> > Thanks Peter for the quick review! This makes sense to me. The only
>> > reason we proposed arch_asym_check_smt_siblings() is because we were
>> > about breaking powerpc (I need to study how they set priorities for SM=
T,
>> > if applicable). If you think this is not an issue I can post a
>> > v4 with this update.
>>=20
>> As far as I can see, priorities in powerpc are set by the CPU number.
>> However, I am not sure how CPUs are enumerated? If CPUs in brackets are
>> SMT sibling, Does an enumeration looks like A) [0, 1], [2, 3] or B) [0, =
2],
>> [1, 3]? I guess B is the right answer. Otherwise, both SMT siblings of a
>> core would need to be busy before a new core is used.
>>=20
>> Still, I think the issue described in the cover letter may be
>> reproducible in powerpc as well. If CPU3 is offlined, and [0, 2] pulled
>> tasks from [1, -] so that both CPU0 and CPU2 become busy, CPU1 would not=
 be
>> able to help since CPU0 has the highest priority.
>>=20
>> I am cc'ing the linuxppc list to get some feedback.
>=20
> IIRC the concern with Power is that their Cores can go faster if the
> higher SMT siblings are unused.
>=20
> That is, suppose you have an SMT4 Core with only a single active task,
> then if only SMT0 is used it can reach max performance, but if the
> active sibling is SMT1 it can not reach max performance, and if the only
> active sibling is SMT2 it goes slower still.
>=20
> So they need to pack the tasks to the lowest SMT siblings, and have the
> highest SMT siblings idle (where possible) in order to increase
> performance.

That's correct.

Thanks,
Nick
