Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD0F4011EB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 00:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbhIEWRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 18:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhIEWRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 18:17:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62637C061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 15:16:00 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id c8so9647234lfi.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 15:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EdF8eTd8kKpWzCqKy4Qdxl10507JxyAEtuvJS7LJ1MI=;
        b=EXW6QJMTkxih4uLdIulfVtj8kkdNJUj9ZVgJhBNCciX3HOhQcli4gqqydxY9c3m2Y+
         L2+23FTK49S7qcWelz/2lKHVC1gu/6C4QRnWXT/tJFu0DWn+ITZCtBbb2uVvQeePYPsW
         ukg6FTqYeImuHuxa8h1a7WX3JzysBBGpGAl0wD3CpuzPghXaT0urE9auGcJTMldW2Cfp
         tHLbXJUO06uMfccbxfdwM/B636Fm+3LmTzF+FS35wE0+wurL9FfgF9pQzrrlexAHR8Ab
         scXUnbcoI4LDivihcvms7WnTP22Yj0En4zYY2icbg1ykEHPuylj92F3vofdyMsmkgCoo
         ZbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EdF8eTd8kKpWzCqKy4Qdxl10507JxyAEtuvJS7LJ1MI=;
        b=EazsFYl7wWOelix9JipqFdrKSffDIgSbSeCmXB0hfzowTos145+eEou5l8jvxtS/bl
         UCmO/w8Llu5vLqnvXFCGz+M7YRfkLoaStgJNdXukYoEp/t1F9XY/YyCoLAzKkiJs/mbR
         2OUod/Kn1UrRDVEJagrDIPa3CWb7fC7AyDHFeHKp1Zm4fzAY+1rPLazuGCMnbeCmCZho
         7LBjyckrpd1kXNPK0rwkIRDKMBLPS7DKfDgYzWF59JI2FefetqwncomsqLQGyoVrePK9
         RwrC8x3+8LVDtF7V7on09SNaWBK/VcAqtBx0Cbam0DzT0BjLEgXhoFMpww6XPpSIVOYZ
         KkCQ==
X-Gm-Message-State: AOAM5313zGQ44ALjjGfWmKeRMHpzE3HKvfitWXhJwkcXv1VhP+p/ti3P
        1e0GUQWpqdD4c0dAXnbPBPML/qu/9lmRATrQmDEVLur88mU=
X-Google-Smtp-Source: ABdhPJxmlX3dXPmgnB6Hh77xDi+jpkh8lQ/2eVRzletNPai5vYDEuEL3vbjDqx3eEjDosmulhpU4ptRFDUrSV3w6bTg=
X-Received: by 2002:a05:6512:2202:: with SMTP id h2mr7253775lfu.494.1630880158252;
 Sun, 05 Sep 2021 15:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210902215504.dSSfDKJZu%akpm@linux-foundation.org> <20210905124439.GA15026@xsang-OptiPlex-9020>
In-Reply-To: <20210905124439.GA15026@xsang-OptiPlex-9020>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 5 Sep 2021 15:15:46 -0700
Message-ID: <CALvZod77aP7qdwc5FkaZJf4FikeD0NwSuoJB4N94Uf0yqZFQpQ@mail.gmail.com>
Subject: Re: [memcg] 45208c9105: aim7.jobs-per-min -14.0% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        0day robot <lkp@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hillf Danton <hdanton@sina.com>,
        Huang Ying <ying.huang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Feng Tang <feng.tang@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>, mm-commits@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 5, 2021 at 5:27 AM kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Greeting,
>
> FYI, we noticed a -14.0% regression of aim7.jobs-per-min due to commit:
>
>
> commit: 45208c9105bd96015b98cdf31fbd6a3bcff234b6 ("[patch 097/212] memcg: infrastructure to flush memcg stats")
> url: https://github.com/0day-ci/linux/commits/Andrew-Morton/ia64-fix-typo-in-a-comment/20210903-065028
>
>
> in testcase: aim7
> on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz with 256G memory
> with following parameters:
>
>         disk: 1BRD_48G
>         fs: xfs
>         test: disk_rr
>         load: 3000
>         cpufreq_governor: performance
>         ucode: 0xd000280
>
> test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
> test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/
>
> In addition to that, the commit also has significant impact on the following tests:
>
> +------------------+-------------------------------------------------------------------------------------+
> | testcase: change | reaim: reaim.jobs_per_min -10.0% regression                                         |
> | test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> | test parameters  | cpufreq_governor=performance                                                        |
> |                  | nr_task=100%                                                                        |
> |                  | runtime=300s                                                                        |
> |                  | test=compute                                                                        |
> |                  | ucode=0x5003006                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_process_ops -29.8% regression                      |
> | test machine     | 104 threads 2 sockets Skylake with 192G memory                                      |
> | test parameters  | cpufreq_governor=performance                                                        |
> |                  | mode=process                                                                        |
> |                  | nr_task=100%                                                                        |
> |                  | test=fallocate2                                                                     |
> |                  | ucode=0x2006a0a                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
> | testcase: change | fio-basic: fio.read_iops -20.5% regression                                          |
> | test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 256G memory      |
> | test parameters  | bs=4k                                                                               |
> |                  | cpufreq_governor=performance                                                        |
> |                  | disk=2pmem                                                                          |
> |                  | fs=xfs                                                                              |
> |                  | ioengine=mmap                                                                       |
> |                  | nr_task=50%                                                                         |
> |                  | runtime=200s                                                                        |
> |                  | rw=read                                                                             |
> |                  | test_size=200G                                                                      |
> |                  | time_based=tb                                                                       |
> |                  | ucode=0x5003006                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_process_ops -9.2% regression                       |
> | test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 112G memory     |
> | test parameters  | cpufreq_governor=performance                                                        |
> |                  | mode=process                                                                        |
> |                  | nr_task=50%                                                                         |
> |                  | test=page_fault3                                                                    |
> |                  | ucode=0x42e                                                                         |
> +------------------+-------------------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_thread_ops -2.3% regression                        |
> | test machine     | 144 threads 4 sockets Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory    |
> | test parameters  | cpufreq_governor=performance                                                        |
> |                  | mode=thread                                                                         |
> |                  | nr_task=100%                                                                        |
> |                  | test=tlb_flush1                                                                     |
> |                  | ucode=0x700001e                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_thread_ops -8.9% regression                        |
> | test machine     | 144 threads 4 sockets Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory    |
> | test parameters  | cpufreq_governor=performance                                                        |
> |                  | mode=thread                                                                         |
> |                  | nr_task=16                                                                          |
> |                  | test=tlb_flush1                                                                     |
> |                  | ucode=0x700001e                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_process_ops -6.4% regression                       |
> | test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 112G memory     |
> | test parameters  | cpufreq_governor=performance                                                        |
> |                  | mode=process                                                                        |
> |                  | nr_task=50%                                                                         |
> |                  | test=page_fault2                                                                    |
> |                  | ucode=0x42e                                                                         |
> +------------------+-------------------------------------------------------------------------------------+
> | testcase: change | netperf: netperf.Throughput_Mbps 89.8% improvement                                  |
> | test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> | test parameters  | cluster=cs-localhost                                                                |
> |                  | cpufreq_governor=performance                                                        |
> |                  | ip=ipv4                                                                             |
> |                  | nr_threads=200%                                                                     |
> |                  | runtime=900s                                                                        |
> |                  | test=TCP_MAERTS                                                                     |
> |                  | ucode=0x5003006                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> Details are as below:
> -------------------------------------------------------------------------------------------------->
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install                job.yaml  # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml  # generate the yaml file for lkp run
>         bin/lkp run                    generated-yaml-file
>
> =========================================================================================
> compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase/ucode:
>   gcc-9/performance/1BRD_48G/xfs/x86_64-rhel-8.3/3000/debian-10.4-x86_64-20200603.cgz/lkp-icl-2sp2/disk_rr/aim7/0xd000280
>
> commit:
>   3c28c7680e ("memcg: switch lruvec stats to rstat")
>   45208c9105 ("memcg: infrastructure to flush memcg stats")

I am looking into this. I was hoping we have resolution for [1] as
these patches touch similar data structures.

[1] https://lore.kernel.org/all/20210811031734.GA5193@xsang-OptiPlex-9020/T/#u
