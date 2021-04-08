Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAB9358F7F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 23:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhDHVxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 17:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232732AbhDHVxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 17:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617918780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jZF2czNzV3hZvT6IoXk6HUdHL7aerkxYExWqcGovA8g=;
        b=KRGFS2G3Wm50OyMI0woIYPWp9wPMugxHC4KAAgHJCF1U2I2V9SK5TESPrimKKK3z+N2f5q
        bpmcs20iNqdfkrypmzFPvaTT3CrxeR2CFufdpuzFMDYvyB4Tcx6iBVepAIgrubLGHVn/CB
        WDjv7J/shVYr+WBuBiaCWhl3FUWEyPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-gb-NgD4pPmivNmjanMmALg-1; Thu, 08 Apr 2021 17:52:57 -0400
X-MC-Unique: gb-NgD4pPmivNmjanMmALg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF28A817469;
        Thu,  8 Apr 2021 21:52:55 +0000 (UTC)
Received: from krava (unknown [10.40.192.110])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9E3EB5B4A8;
        Thu,  8 Apr 2021 21:52:53 +0000 (UTC)
Date:   Thu, 8 Apr 2021 23:52:52 +0200
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
Subject: Re: [PATCH v4 11/12] perf session: load data directory files for
 analysis
Message-ID: <YG97NIcSRyJcFSVY@krava>
References: <6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com>
 <a0659ee9-d03c-38f4-dd8c-729efa98c525@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0659ee9-d03c-38f4-dd8c-729efa98c525@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 11:52:32AM +0300, Bayduraev, Alexey V wrote:
> 
> Introduce decompressor into trace reader object so that decompression
> could be executed on per data file basis separately for every data
> file located in data directory.
> 
> Load data directory files and provide basic raw dump and aggregated
> analysis support of data directories in report mode, still with no
> memory consumption optimizations.
> 
> Design and implementation are based on the prototype [1], [2].
> 
> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
> 
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>

hi,
this and following patch seem to squash several changes from
perf/record_threads:

	21289ea28f2f perf session: Add reader return codes
	44d19279d0e9 perf session: Add eof flag to reader state
	490cece1ff49 perf session: Add reader__read_event function
	ff9d91751367 perf session: Move head/file_offset computation into reader__mmap function
	75a6af52ecae perf session: Move unmap into reader__mmap function
	e1fc76225518 perf session: Add reader__mmap function
	f7f0473104cd perf session: Add reader__init function
	262c08cb7332 perf session: Move head in reader_state
	fd91847190f0 perf session: Move data_size in reader_state
	dcb49769bdde perf session: Move file_offset in reader_state
	69c7f9557e83 perf session: Move file_pos in reader_state
	c5c5c03f09f9 perf session: Add mmap_cur to reader_state
	faf7b7176f2a perf session: Move mmap_idx in reader_state
	42504d97a18f perf session: Move mmap_size in reader_state
	7bf7ccdabc84 perf session: Move mmaps in reader_state
	fc1eb45de565 perf session: Add path to reader object

making this a really big change of important code, which can't
be easily reviewed.. that's why I split it in the first place ;-)

I think we need to bring this code first with incremental changes

jirka

