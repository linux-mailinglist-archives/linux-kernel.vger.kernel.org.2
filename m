Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653913B7DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhF3HZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:25:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:28838 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232636AbhF3HZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:25:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="229938551"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="229938551"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 00:22:32 -0700
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="457111144"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.227.67]) ([10.249.227.67])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 00:22:28 -0700
Subject: Re: [PATCH v7 00/20] Introduce threaded trace streaming for basic
 perf record operation
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
References: <cover.1624350588.git.alexey.v.bayduraev@linux.intel.com>
 <CAM9d7ciOMPTbwTzHwDp2sjn59KButCQpPOpQsqttopodGC7_kg@mail.gmail.com>
 <8b738198-c77e-e35e-2bc8-f709d8ec937f@linux.intel.com>
 <CAM9d7ci4M5hNTXm4iqj91=DXnC=qUpeWMXAHsFtgBq=J=VTqKw@mail.gmail.com>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <99af01bf-93e1-31ca-c1bf-bb28c6fcb35b@linux.intel.com>
Date:   Wed, 30 Jun 2021 10:22:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7ci4M5hNTXm4iqj91=DXnC=qUpeWMXAHsFtgBq=J=VTqKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30.06.2021 9:09, Namhyung Kim wrote:
> On Mon, Jun 28, 2021 at 1:11 AM Bayduraev, Alexey V
> <alexey.v.bayduraev@linux.intel.com> wrote:
>>
>> Hello,
>>
>> On 27.06.2021 3:46, Namhyung Kim wrote:
>>> Hello,
>>>
>>> On Tue, Jun 22, 2021 at 1:42 AM Alexey Bayduraev
>>> <alexey.v.bayduraev@linux.intel.com> wrote:
>>>>
>>>> Changes in v7:
>>>> - fixed possible crash after out_free_threads label
>>>> - added missing pthread_attr_destroy() call
>>>> - added check of correctness of user masks
>>>> - fixed zsts_data finalization
>>>>
>> [SNIP]
>>> Thanks for your work, mostly looks good now.
>>>
>>> I have a question, where are the synthesized records saved?
>>> Is it the data.0 file?
>>
>> Thanks for the review.
>>
>> As I understand the synthesized records (as well as other user-space
>> records) are saved to perf.data/data, kernel records are saved to
>> perf.data/data.<CPU>
> 
> Ah, ok.  I saw you added a reader for the file in patch 20/20.
> Maybe we can save all tracking records (task/mmap) there
> in the future.
> 
> For the patchset,
>   Acked-by: Namhyung Kim <namhyung@gmail.com>

Thank you so much for your time spent on this review. 

Can I resend the patchset with additional patch that address your nitpicks?
To not re-review the entire patchset.

Regards,
Alexey
> 
> Thanks,
> Namhyung
> 
