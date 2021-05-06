Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B4637557B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 16:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhEFOSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 10:18:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:48746 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233737AbhEFOSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 10:18:43 -0400
IronPort-SDR: 33ZLxfnA7o8IDcgkDqHAkDvQtilmnt//Uthm41OKf/AmlSinh7oQtYbEpTeDJP9FrtaUbe3AR8
 t4QFmyTTNrnA==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="259761859"
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="259761859"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 07:17:18 -0700
IronPort-SDR: hn02Kj8lMN1tRBnSxSDHsBy1bNo+nrUylKglaI8arSXJDe0mBho9E15Cs/Nm/LWV3A4FDH0h7H
 e2AN+d5DHQuQ==
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="539970015"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.219.76]) ([10.212.219.76])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 07:17:18 -0700
Subject: Re: [PATCH v5 00/20] Introduce threaded trace streaming for basic
 perf record operation
To:     Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>
References: <cover.1619781188.git.alexey.v.bayduraev@linux.intel.com>
 <CAM9d7citW_NGb0vjMM2ytp=Mbq5YNe4GEaWspEkMGf=KAm+ugw@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <4926ae4f-b14b-1048-229b-0b789204c192@linux.intel.com>
Date:   Thu, 6 May 2021 07:17:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7citW_NGb0vjMM2ytp=Mbq5YNe4GEaWspEkMGf=KAm+ugw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/2021 11:20 PM, Namhyung Kim wrote:
>
> Do you have an idea how to improve it?
>
> I have to say again that I don't like merely adding more threads to
> record.  Yeah, parallelizing the perf record is good, but we have to
> think about the perf report (and others) too.

perf report/script can be already parallelized with --time xx/x% and a 
simple shell script that runs multiple processes. While that's a bit 
awkward for interactive use it works fine for scripting. I use it all 
the time for PT batch processing for example. The real bottleneck we 
have is really record on systems with many CPUs (which are more and more 
common), and that can only be fixed with some variant of this patch kit.

-Andi

