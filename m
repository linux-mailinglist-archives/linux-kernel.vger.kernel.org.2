Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D677C35EA6C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 03:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245545AbhDNBbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 21:31:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:25608 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349025AbhDNBbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 21:31:17 -0400
IronPort-SDR: KfTmpWTo813seAk5BX0NCRjAScevYysb0ADP3H+00ej5Ep0/sNccJfRNEwnPFSumQEBjGv1MxR
 zy5bVDrDQpCQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="174645034"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="174645034"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 18:30:54 -0700
IronPort-SDR: zUw6MIcPvnRBnKZ1NgtyFMUfkSAQlDAsSS2ORPG2GuA42Q0yoBXuT7zduOB0HjdKFDTAxYaT1X
 KckYs5lrbZxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="600564828"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 13 Apr 2021 18:30:54 -0700
Received: from [10.209.6.241] (kliang2-MOBL.ccr.corp.intel.com [10.209.6.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0E5D35808CA;
        Tue, 13 Apr 2021 18:30:52 -0700 (PDT)
Subject: Re: [PATCH V3 2/2] perf/x86: Reset the dirty counter to prevent the
 leak for an RDPMC task
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <1618340250-29027-1-git-send-email-kan.liang@linux.intel.com>
 <1618340250-29027-2-git-send-email-kan.liang@linux.intel.com>
 <CALCETrVVPzUd_hQ8xoomHn_wWRQJUvROeCt2do4_D4ROZoAVMg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <ced00596-20af-65b5-9e76-a23456215a64@linux.intel.com>
Date:   Tue, 13 Apr 2021 21:30:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CALCETrVVPzUd_hQ8xoomHn_wWRQJUvROeCt2do4_D4ROZoAVMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/2021 8:34 PM, Andy Lutomirski wrote:
> On Tue, Apr 13, 2021 at 12:05 PM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The counter value of a perf task may leak to another RDPMC task.
>> For example, a perf stat task as below is running on CPU 0.
>>
>>      perf stat -e 'branches,cycles' -- taskset -c 0 ./workload
> 
> I assume this doesn't fix the leak if the sensitive counter is systemwide?
>

Right.

> Could Intel please add proper security and ideally virtualization for
> this?  Ideally RDPMC permission would be a bitmask for all RDPMC-able
> counters, not just a single on/off switch.
> 

Yes, we are working on it.

For now, I think this patch is what we can do so far.

Thanks,
Kan

