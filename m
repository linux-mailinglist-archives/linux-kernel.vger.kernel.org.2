Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FE23B9605
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 20:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbhGASRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 14:17:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:14177 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233223AbhGASQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 14:16:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="269720536"
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="269720536"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 11:14:23 -0700
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="457766172"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.231.202]) ([10.249.231.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 11:14:19 -0700
Subject: Re: [PATCH v8 10/22] perf record: Introduce --threads=<spec> command
 line option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <e0069b09cb53d9149ba651474ce65faf6a001303.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <YNyprxe/0EiImxpF@kernel.org>
 <e2aca481-2623-10fb-850b-88ec7870d9cf@linux.intel.com>
 <00e9de2e-3963-1507-9eb0-40d419bf9a49@linux.intel.com>
 <YN3Qn5mO5cPffPZa@kernel.org>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <3a2353a1-3019-34a6-1bce-24c76dd778c5@linux.intel.com>
Date:   Thu, 1 Jul 2021 21:14:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YN3Qn5mO5cPffPZa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01.07.2021 17:26, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 01, 2021 at 02:50:40PM +0300, Bayduraev, Alexey V escreveu:
>> On 30.06.2021 21:54, Bayduraev, Alexey V wrote:
>>> On 30.06.2021 20:28, Arnaldo Carvalho de Melo wrote:
>>>> I thought you would start with plain:
> 
>>>>   -j N
> 
>>>> And start one thread per CPU in 'perf record' existing CPU affinity
>>>> mask, then go on introducing more sophisticated modes.
> 
>>> As I remember the first prototype [1] and 
>>> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
> 
>>> introduces: 
> 
>>> --thread=mode|number_of_threads
> 
>>> where mode defines cpu masks (cpu/numa/socket/etc)
> 
>>> Then somewhere while discussing this patchset it was decided, for unification,
>>> that --thread should only define CPU/affinity masks or their aliases.
>>> I think Alexei or Jiri could clarify this more.
> 
>>>> Have you done this way because its how VTune has evolved over the years
>>>> and now expects from 'perf record'?
> 
>>> VTune uses only --thread=cpu or no threading.
> 
>> However we would like to have such sophisticated cpu/affinity masks to
>> tune perf-record for different workloads.
> 
> I don't have, a priori, anything against the modes you propose, as you
> have a justification for them, its just how we should introduce that.
> 
> I.e. first doing the simple case of '-j NCPUS' and then doing what you
> need, so that we get more granular patches.
> 
> Not adding too much complexity per patch pays off when/if we find bugs
> and need to bisect.

This is a good idea, especially since this 10/22 patch is the most complex
patch in the patchset. I also think we can keep this simple -threads=NCPUS
form along with the -threads=masks option.

Regards,
Alexey

> 
>> For example, some HPC workloads prefer "numa" mask or most of telecom
>> workloads disallow to use cpus where their non-preemtable
>> communication threads work.
> 
> - Arnaldo
> 
