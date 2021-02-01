Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCD830AE94
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhBAR5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:57:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:60307 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232415AbhBAR5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:57:34 -0500
IronPort-SDR: YcIfYK9xlP6WlzpSxjKdr5HYS8WaeJ+px3/RFnt0Yr+hehFr2Bu6wpWANnAc9COMeugljhW+r7
 5FgIi55SOANg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="177217669"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="177217669"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 09:55:48 -0800
IronPort-SDR: /aYXIKv6iQ7ryKOpqm45AA34jmqJYoPWMaoOpjgwB/mVaMS39tKVgzsdomiD22tH3FzslIwHwG
 wxKrBSoiPEgg==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="391017369"
Received: from aantonov-mobl.ccr.corp.intel.com (HELO [10.249.230.90]) ([10.249.230.90])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 09:55:44 -0800
Subject: Re: [PATCH v3 3/5] perf stat: Helper functions for PCIe root ports
 list in iostat mode
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210126080619.30275-1-alexander.antonov@linux.intel.com>
 <20210126080619.30275-4-alexander.antonov@linux.intel.com>
 <CAM9d7cgg1Xv1QhBPQBj_KR1i0yU3ci8-8DatdfC1+7+ZnJdTww@mail.gmail.com>
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
Message-ID: <01d8c8f5-da91-983d-dc3a-9c1c8c3633de@linux.intel.com>
Date:   Mon, 1 Feb 2021 20:55:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7cgg1Xv1QhBPQBj_KR1i0yU3ci8-8DatdfC1+7+ZnJdTww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/29/2021 11:26 AM, Namhyung Kim wrote:
> Hello,
>
> On Tue, Jan 26, 2021 at 5:06 PM Alexander Antonov
> <alexander.antonov@linux.intel.com> wrote:
>> Introduce helper functions to control PCIe root ports list.
>> These helpers will be used in the follow-up patch.
>>
>> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
>> ---
> [SNIP]
>> +static int iio_root_ports_list_insert(struct iio_root_ports_list *list,
>> +                                     struct iio_root_port * const rp)
>> +{
>> +       struct iio_root_port **tmp_buf;
>> +
>> +       if (list && rp) {
>> +               rp->idx = list->nr_entries++;
>> +               /* One more for NULL.*/
>> +               tmp_buf = realloc(list->rps,
>> +                                 (list->nr_entries + 1) * sizeof(*list->rps));
> Why is this +1 needed since you already have the number of
> entries in the list?
>
> Thanks,
> Namhyung

Hello,

My first approach for iteration through root ports list was using 
NULL-terminated array.
And seems like I just forgot to remove this code. I will fix it.

Thank you,
Alexander

>
>> +               if (!tmp_buf) {
>> +                       pr_err("Failed to realloc memory\n");
>> +                       return -ENOMEM;
>> +               }
>> +               tmp_buf[rp->idx] = rp;
>> +               tmp_buf[list->nr_entries] = NULL;
>> +               list->rps = tmp_buf;
>> +       }
>> +       return 0;
>> +}
>> --
>> 2.19.1
>>
