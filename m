Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3703133C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 14:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBHNwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 08:52:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:61077 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231136AbhBHNwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 08:52:05 -0500
IronPort-SDR: +9BfV4GWuwRa8xED1chxGuQmiJjMm/OgKtd2X1IVuN39+dXX6R/R8EJytlNACMTRPYX1AaZfsV
 KEou3KDaNRuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9888"; a="160866650"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="160866650"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 05:50:17 -0800
IronPort-SDR: bDUV3VQR9c+H54wtuA7RGydS4vMhYUHCBARREhy7XYhnt01juuXSu7Bln1Zc53mD9h1MyMuYU7
 1boXTDRQCRRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="435635545"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 08 Feb 2021 05:50:16 -0800
Received: from [10.255.228.220] (kliang2-MOBL.ccr.corp.intel.com [10.255.228.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C548E580428;
        Mon,  8 Feb 2021 05:50:15 -0800 (PST)
Subject: Re: [PATCH 6/9] perf report: Support instruction latency
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Yao Jin <yao.jin@linux.intel.com>, maddy@linux.vnet.ibm.com
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-7-git-send-email-kan.liang@linux.intel.com>
 <CAM9d7chGxZc0MA4nqVeJRDXLEzWsQ-ceJ+xgMVmEbQbDVDf72w@mail.gmail.com>
 <a1e837a6-9c6a-c613-d7b9-8e6547dfcf67@linux.intel.com>
 <CAM9d7ci1qQy+oeOvKJE4N8nZxm6h+=vBP_wp_WXOhPnUphpJ-Q@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <00b8e412-6756-630a-c0d2-4be7ad8948d4@linux.intel.com>
Date:   Mon, 8 Feb 2021 08:50:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7ci1qQy+oeOvKJE4N8nZxm6h+=vBP_wp_WXOhPnUphpJ-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/2021 3:09 AM, Namhyung Kim wrote:
> On Fri, Feb 5, 2021 at 11:38 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>> On 2/5/2021 6:08 AM, Namhyung Kim wrote:
>>> On Wed, Feb 3, 2021 at 5:14 AM <kan.liang@linux.intel.com> wrote:
>>>>
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> The instruction latency information can be recorded on some platforms,
>>>> e.g., the Intel Sapphire Rapids server. With both memory latency
>>>> (weight) and the new instruction latency information, users can easily
>>>> locate the expensive load instructions, and also understand the time
>>>> spent in different stages. The users can optimize their applications
>>>> in different pipeline stages.
>>>>
>>>> The 'weight' field is shared among different architectures. Reusing the
>>>> 'weight' field may impacts other architectures. Add a new field to store
>>>> the instruction latency.
>>>>
>>>> Like the 'weight' support, introduce a 'ins_lat' for the global
>>>> instruction latency, and a 'local_ins_lat' for the local instruction
>>>> latency version.
>>>
>>> Could you please clarify the difference between the global latency
>>> and the local latency?
>>>
>>
>> The global means the total latency.
>> The local means average latency, aka total / number of samples.
> 
> Thanks for the explanation, but I think it's confusing.
> Why not call it just total_latency and avg_latency?
> 

The instruction latency field is an extension of the weight field, so I 
follow the same way to name the field. I still think we should make the 
naming consistency.

To address the confusion, I think we may update the document for both 
the weight and the instruction latency fields.

How about the below patch?

 From d5e80f541cb7288b24a7c5661ae5faede4747807 Mon Sep 17 00:00:00 2001
From: Kan Liang <kan.liang@linux.intel.com>
Date: Mon, 8 Feb 2021 05:27:03 -0800
Subject: [PATCH] perf documentation: Add comments to the local/global 
weight related fields

Current 'local' and 'global' prefix is confusing for the weight related
fields, e.g., weight, instruction latency.

Add comments to clarify.
'global' means total weight/instruction latency sum.
'local' means average weight/instruction latency per sample

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
  tools/perf/Documentation/perf-report.txt | 10 ++++++----
  1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt 
b/tools/perf/Documentation/perf-report.txt
index f546b5e..acc1c1d 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -92,8 +92,9 @@ OPTIONS
  	- srcfile: file name of the source file of the samples. Requires dwarf
  	information.
  	- weight: Event specific weight, e.g. memory latency or transaction
-	abort cost. This is the global weight.
-	- local_weight: Local weight version of the weight above.
+	abort cost. This is the global weight (total weight sum).
+	- local_weight: Local weight (average weight per sample) version of the
+	  weight above.
  	- cgroup_id: ID derived from cgroup namespace device and inode numbers.
  	- cgroup: cgroup pathname in the cgroupfs.
  	- transaction: Transaction abort flags.
@@ -110,8 +111,9 @@ OPTIONS
  	--time-quantum (default 100ms). Specify with overhead and before it.
  	- code_page_size: the code page size of sampled code address (ip)
  	- ins_lat: Instruction latency in core cycles. This is the global 
instruction
-	  latency
-	- local_ins_lat: Local instruction latency version
+	  latency (total instruction latency sum)
+	- local_ins_lat: Local instruction latency (average instruction 
latency per
+	  sample) version

  	By default, comm, dso and symbol keys are used.
  	(i.e. --sort comm,dso,symbol)
-- 
2.7.4


Thanks,
Kan


