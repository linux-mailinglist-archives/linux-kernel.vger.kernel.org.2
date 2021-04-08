Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8D2358F79
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 23:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhDHVwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 17:52:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50529 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232387AbhDHVwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 17:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617918752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=92NIhN9ZuELd+NWbfoJmx7vzaPknY/LY6xv15ibOSNY=;
        b=bg6J0cN18lOO+0/FwAGFZ0kr8efwNBuqoNfdFZU1DQEqvQ3XjD9OLpqxgl4DzXwOSCO6ti
        ksEIwUOQkm1xOzUrEJAcG2VA0mk0XlsuEZTe4hyMaWS+HRPeiDEaRTg0h0drfzufCec9OP
        Yz5LKvIgITWZlPEJVRMyrkgYPyio0Yw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-GyMX-SVtOXGoZD13Fho9Pw-1; Thu, 08 Apr 2021 17:52:28 -0400
X-MC-Unique: GyMX-SVtOXGoZD13Fho9Pw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D364801814;
        Thu,  8 Apr 2021 21:52:27 +0000 (UTC)
Received: from krava (unknown [10.40.192.110])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5D16B60BE5;
        Thu,  8 Apr 2021 21:52:23 +0000 (UTC)
Date:   Thu, 8 Apr 2021 23:52:22 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
Subject: Re: [PATCH v4 00/12] Introduce threaded trace streaming for basic
 perf record operation
Message-ID: <YG97FgUuqp/fCH0a@krava>
References: <6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 11:37:26AM +0300, Bayduraev, Alexey V wrote:
> 
> Changes in v4:
> - renamed 'comm' structure to 'pipes'
> - moved thread fd/maps messages to verbose=2
> - fixed leaks during allocation of thread_data structures
> - fixed leaks during allocation of thread masks
> - fixed possible fails when releasing thread masks
> 
> v3: https://lore.kernel.org/lkml/7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com/

hi,
I recall there was some issue wrt threading and intel_pt,
which we either need to fixed or we need to disable threads
for it

	[root@krava perf]# ./perf record -e intel_pt// --threads=cpu
	^C[ perf record: Woken up 121 times to write data ]
	Warning:
	AUX data lost 95 times out of 206!

	[ perf record: Captured and wrote 211.364 MB perf.data ]

	[root@krava perf]# ./perf script
	Segmentation fault (core dumped)

the fix should already be in the perf/record_threads branch,

jirka

