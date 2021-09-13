Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CFE4089D7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbhIMLGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239171AbhIMLGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:06:06 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B60C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:04:51 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id w1so9615881ilv.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Md2JvVsmZ0Wdbw8wXryrgsK/goNcZBp4oYPd8fIdLts=;
        b=MPtcDVbHxSLjqahYws31mTAkZRO+bb0vLnz9ZAzjqnLNwhUfrFfPSqLht8STj+BfxG
         xH89J1m3/6Knk5nlnVxatYHF7OCwYZeoDHZB0UvLLK1+Jd1M2UgUnVS051LUQQdfq1MQ
         ebUca6pquUFnZh2DwTdoQBNwF8qOYjlT8P9l0j4McHZzwiWqFpSCv1w8bKojPkv58FJA
         lEf1LI6KS6PelDoLGa9FwNW/9v5AxJdKsznMo1IWmBIRYJINBba2NX/zp/gKCBQpMXtb
         MhwmlrsiIps51phTL3tOI0hTZ5YKYAUZh1RXjJYE5oRF/V2jIDoWcS9BReFHQ+7JWsw5
         Dlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Md2JvVsmZ0Wdbw8wXryrgsK/goNcZBp4oYPd8fIdLts=;
        b=suqRNh6PwxAzXgKxd37Yqa1OJ7JWB8h7dLtkJ97d/kv4pR3w5/jL5lDD6Xu4syOtlx
         cSLeHq+bvaIMl7mPj78nc6GEoFGD63BwefVBcwIgKxY7UnsTVFwW6ES1irY0+BX6fu2F
         IMOosXpb9nlKaEHhq9rpa08rIf/TU5XZNNq2EEspOQj0J5nAyeBbS4aFNPL4IdUsQVAN
         vpDqVswseC9bG7V94Tc3koJDZge5wCakUUoxBOtrjTthJx7UpeKcPEX/uAyKlZmxYrzE
         QjOlv3FSD9SjDguIYOPphNvGoNnL+5mwLwsANikCL09AYi1wQvyAjFEoA8RZdq16GoVt
         pGcQ==
X-Gm-Message-State: AOAM532/7t+mhjxRDq0PfzhQ17Bw3SiOsr1BNAdgJTl14Bh9SqXdwRsb
        4D+EIOCQBYb5v4DSIRNQEt9KaItSQsfrD6ufNjlDUZ0Q4fB9sHh1
X-Google-Smtp-Source: ABdhPJy+U4bl0D8d2h9jMc5XUCXzvSTTSjtCeu6niFNWjZjr9+EJMRNiK0sfaDzepQ0b2QSjkd44LPqyGw7gJGyFxPw=
X-Received: by 2002:a05:6e02:1c86:: with SMTP id w6mr7606237ill.52.1631531090772;
 Mon, 13 Sep 2021 04:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <202109111001.XChyxkS3-lkp@intel.com>
In-Reply-To: <202109111001.XChyxkS3-lkp@intel.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 13 Sep 2021 19:04:14 +0800
Message-ID: <CALOAHbBqZ5MgQ958ZG2ne4T5xXw0YjcO2aKutGgS6WX2_+vYew@mail.gmail.com>
Subject: Re: [peterz-queue:sched/core 13/19] kernel/sched/debug.c:453
 print_cfs_group_stats() warn: variable dereferenced before check 'se' (see
 line 444)
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, kbuild test robot <lkp@intel.com>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 4:48 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
> head:   2dfdb3d20ad50e2ae2cb84cbceb0f0fc75e79e5d
> commit: 445d9e8ba05d5e9e4b26956b7fe529223e29d8d1 [13/19] sched: make struct sched_statistics independent of fair sched class
> config: x86_64-randconfig-m001-20210910 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> kernel/sched/debug.c:453 print_cfs_group_stats() warn: variable dereferenced before check 'se' (see line 444)
>

Sorry, my bad.

Hi Peter,

Could you pls. help amend below change to the original commit ?

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 52b4426414c0..d59f33ac06fe 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -440,11 +440,8 @@ void dirty_sched_domain_sysctl(int cpu)
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void print_cfs_group_stats(struct seq_file *m, int cpu, struct
task_group *tg)
 {
-       struct sched_statistics __maybe_unused *stats;
        struct sched_entity *se = tg->se[cpu];

-       stats = __schedstats_from_se(se);
-
 #define P(F)           SEQ_printf(m, "  .%-30s: %lld\n",       #F,
(long long)F)
 #define P_SCHEDSTAT(F) SEQ_printf(m, "  .%-30s: %lld\n",       \
                #F, (long long)schedstat_val(stats->F))
@@ -460,6 +457,8 @@ static void print_cfs_group_stats(struct seq_file
*m, int cpu, struct task_group
        PN(se->sum_exec_runtime);

        if (schedstat_enabled()) {
+               struct sched_statistics *stats =  __schedstats_from_se(se);
+
                PN_SCHEDSTAT(wait_start);
                PN_SCHEDSTAT(sleep_start);
                PN_SCHEDSTAT(block_start);



> vim +/se +453 kernel/sched/debug.c
>
> 3866e845ed5222 kernel/sched/debug.c Steven Rostedt (Red Hat  2016-02-22  439)
> ff9b48c3598732 kernel/sched_debug.c Bharata B Rao            2008-11-10  440  #ifdef CONFIG_FAIR_GROUP_SCHED
> 5091faa449ee0b kernel/sched_debug.c Mike Galbraith           2010-11-30  441  static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group *tg)
> ff9b48c3598732 kernel/sched_debug.c Bharata B Rao            2008-11-10  442  {
> ff9b48c3598732 kernel/sched_debug.c Bharata B Rao            2008-11-10  443    struct sched_entity *se = tg->se[cpu];
> 445d9e8ba05d5e kernel/sched/debug.c Yafang Shao              2021-09-05 @444    struct sched_statistics *stats = __schedstats_from_se(se);
>                                                                                                                                       ^^
> New unchecked dereference.
>
> ff9b48c3598732 kernel/sched_debug.c Bharata B Rao            2008-11-10  445
> 97fb7a0a8944bd kernel/sched/debug.c Ingo Molnar              2018-03-03  446  #define P(F)              SEQ_printf(m, "  .%-30s: %lld\n",       #F, (long long)F)
> 445d9e8ba05d5e kernel/sched/debug.c Yafang Shao              2021-09-05  447  #define P_SCHEDSTAT(F)    SEQ_printf(m, "  .%-30s: %lld\n",       \
> 445d9e8ba05d5e kernel/sched/debug.c Yafang Shao              2021-09-05  448            #F, (long long)schedstat_val(stats->F))
> 97fb7a0a8944bd kernel/sched/debug.c Ingo Molnar              2018-03-03  449  #define PN(F)             SEQ_printf(m, "  .%-30s: %lld.%06ld\n", #F, SPLIT_NS((long long)F))
> 445d9e8ba05d5e kernel/sched/debug.c Yafang Shao              2021-09-05  450  #define PN_SCHEDSTAT(F)   SEQ_printf(m, "  .%-30s: %lld.%06ld\n", \
> 445d9e8ba05d5e kernel/sched/debug.c Yafang Shao              2021-09-05  451            #F, SPLIT_NS((long long)schedstat_val(stats->F)))
> ff9b48c3598732 kernel/sched_debug.c Bharata B Rao            2008-11-10  452
> cd126afe838d7e kernel/sched/debug.c Yuyang Du                2015-07-15 @453    if (!se)
>                                                                                     ^^^
> The old code assumed "se" can be NULL.
>
> 18bf2805d9b30c kernel/sched/debug.c Ben Segall               2012-10-04  454            return;
> 18bf2805d9b30c kernel/sched/debug.c Ben Segall               2012-10-04  455
> ff9b48c3598732 kernel/sched_debug.c Bharata B Rao            2008-11-10  456    PN(se->exec_start);
> ff9b48c3598732 kernel/sched_debug.c Bharata B Rao            2008-11-10  457    PN(se->vruntime);
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>


--
Thanks
Yafang
