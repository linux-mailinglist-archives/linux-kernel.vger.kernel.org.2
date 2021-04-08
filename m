Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496A435871D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhDHOZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:25:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:22056 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231672AbhDHOZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:25:45 -0400
IronPort-SDR: fr1wVnwWdAEwXuvtDMRiyflqveukeTo/SPwHJVG+EymgvjV7oFMQnQQp/yUpBNNkJUNtvtPRJM
 MCBycSbAUbog==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="190348973"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="190348973"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 07:25:34 -0700
IronPort-SDR: 9MLeb5McO4R09T4BOpjpHvg7IV6CfBDy4LORwwBwHqgfqEUazcGSRMbhbvg5A5FoNfLDPtVI23
 3iQCqnuQ1dSQ==
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="458844929"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 07:25:34 -0700
Date:   Thu, 8 Apr 2021 07:25:33 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
Subject: Re: [PATCH v4 09/12] perf record: document parallel data streaming
 mode
Message-ID: <20210408142533.GF3762101@tassilo.jf.intel.com>
References: <6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com>
 <e4a28c4d-ffab-8f3a-7c80-6ebff0e4cefd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4a28c4d-ffab-8f3a-7c80-6ebff0e4cefd@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +--threads=<spec>::
> +Write collected trace data into several data files using parallel threads.
> +<spec> value can be user defined list of masks. Masks separated by colon
> +define cpus to be monitored by a thread and affinity mask of that thread
> +is separated by slash. For example user specification like the following:
> +<cpus mask 1>/<affinity mask 1>:<cpu mask 2>/<affinity mask 2> specifies

You need to be more clear on the exact syntax of a mask. Ideally
some full examples too.

> +parallel threads layout that consists of two threads with corresponding
> +assigned cpus to be monitored. <spec> value can also be a string meaning
> +predefined parallel threads layout:
> +    cpu    - create new data streaming thread for every monitored cpu
> +    core   - create new thread to monitor cpus grouped by a core
> +    socket - create new thread to monitor cpus grouped by a socket
> +    numa   - create new threed to monitor cpus grouped by a numa domain
> +Predefined layouts can be used on systems with large number of cpus in
> +order not to spawn multiple per-cpu streaming threads but still avoid LOST
> +events in data directory files. Option specified with no or empty value
> +defaults to cpu layout. Masks defined or provided by the option value are
> +filtered through the mask provided by -C option.
>  
> 
> 
