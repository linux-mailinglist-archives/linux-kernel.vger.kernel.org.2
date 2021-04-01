Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F02351811
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbhDARnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234428AbhDARhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617298641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aTM0m+T7HagwUJawH1QxhZKr0xo014VG1/6PrsDZwlc=;
        b=O+hg/rXDUjXDxSVRw3+v8QYHeZYyqpJXTqmbxU3jjbnLEvnUd1pTvAY7O++DLkrlvzTDiq
        1g2zGZoeYFp6iRzLDWpofNQo04xdufTcqe1jolwiryjcUM6nzek9rCx8kk6K4HZFnDa2v+
        jwo07R9tNmqsNDBQdIGqL5cm1lv/fFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-9D5ybMm_PiSVmnVMGRqGvQ-1; Thu, 01 Apr 2021 08:15:21 -0400
X-MC-Unique: 9D5ybMm_PiSVmnVMGRqGvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0649801814;
        Thu,  1 Apr 2021 12:15:19 +0000 (UTC)
Received: from krava (unknown [10.40.193.98])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0BA0B5C233;
        Thu,  1 Apr 2021 12:15:16 +0000 (UTC)
Date:   Thu, 1 Apr 2021 14:15:16 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Nicholas Fraser <nfraser@codeweavers.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf data: export to JSON
Message-ID: <YGW5VLOL4UVfNYUT@krava>
References: <4687bbe5-4ff3-af3a-fcec-06d8bfe5591c@codeweavers.com>
 <YFuC5ONRvAPKwtKX@krava>
 <2d78b018-df5a-36cb-2f78-d3ca11bf9513@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d78b018-df5a-36cb-2f78-d3ca11bf9513@codeweavers.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 06:38:16AM -0400, Nicholas Fraser wrote:
> Hi Jiri,
> 
> Thanks for the review. I've addressed your suggestions; some notes are
> below. I'll send a new patch.
> 
> 
> On 2021-03-24 2:20 p.m., Jiri Olsa wrote:
> > On Wed, Mar 24, 2021 at 09:06:50AM -0400, Nicholas Fraser wrote:
> >> [...] We use this to import the data into a tool on Windows
> >> where integrating perf or libbabeltrace is impractical.
> > 
> > hi,
> > exciting ;-) and curious, which tool is that?
> > 
> 
> The tool is called gpuvis. The perf JSON parsing support is here:
> 
> https://github.com/ludocode/gpuvis
> 
> The idea is to be able to line up samples from perf with GPU trace events, so
> you can do things like timebox all perf samples in a particular frame of
> rendering.

I recall you did not add support for walltime clock,
don't you need it to sync with other events?

> 
> 
> > we already have zstd support compiled in for compressing samples,
> > should be easy to use it for compressing the output of this right
> > away
> 
> This would require that apps that consume this integrate zstd as well. It's
> simpler (both conceptually and from an integration standpoint) to just compress
> on command-line if you need with whatever compressor you want. You can even do
> this inline by writing to /dev/stdout, e.g.:
> 
>     perf data convert --to-json /dev/stdout --force | zstd > out.json.zstd
> 
> Since we're transferring to Windows, more likely we'd output the JSON and then
> put it in a .zip container.
> 
> 

ok

> > I understand not supporting opts.all or opts.tod, but 'force'
> > support means just assigning 'force' to struct perf_data
> 
> It's not clear to me what 'force' does on 'struct perf_data' since we're only
> reading it. I assumed for data export it meant the output file should be
> overwritten. I've made it do both in the replacement patch.
> 

it tells perf to skip ownership validation, perf will not
open other user data file if it's not forced

jirka

