Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A03E3B9584
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 19:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhGARbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 13:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229978AbhGARbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:31:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCD6261407;
        Thu,  1 Jul 2021 17:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625160541;
        bh=pCjfxocaP3DndHY5cFTEarrw4nycbdJnJvp88DCX8xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rv4VZK8GWwtPXBlfVWOVLHcd4U9YQ7rSjnNxReQjkCdEzAEMS+kYtoG5CkJOfHd3y
         Q4NCeOWoPvB1+RO5qa13cdbXmmZZOtKPaCuBe4FIaCdLHDnExHuJ7yPrAVUy7AL2AJ
         fzs4cHrUGTjd1H5DLsw66yFhCNZTN49J0j7895RTIKNVRKnVVA3CduvhgpKBFDWGC8
         KpxFVk1vWoLZ0Q90uMTC5cjiaTQxJXNII2KJR1uC2kGr5H9cyIIG/B4ecMnlXVwW9t
         VSZ0yQW8qcrnwZrVNfTuczpDNh5jOUdWV8pC/WmkAUhtwSKb4RbabRi6gYCtmVJxZ4
         n/z/M9jtT6EYA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D52C940B1A; Thu,  1 Jul 2021 14:28:57 -0300 (-03)
Date:   Thu, 1 Jul 2021 14:28:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
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
Subject: Re: [PATCH v8 06/22] perf record: Introduce data file at mmap buffer
 object
Message-ID: <YN37WQ/tUb6lS94v@kernel.org>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <ace86f5d00ddb901a79196bb1863ed1395c408fd.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <YNyodxMjNEHjAaFW@kernel.org>
 <2240e335-9991-8792-7437-c3ec88f6a7a2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2240e335-9991-8792-7437-c3ec88f6a7a2@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 01, 2021 at 07:41:18PM +0300, Bayduraev, Alexey V escreveu:
> Hi,
> 
> On 30.06.2021 20:23, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jun 30, 2021 at 06:54:45PM +0300, Alexey Bayduraev escreveu:
> >> Introduce data file and compressor objects into mmap object so
> >> they could be used to process and store data stream from the
> >> corresponding kernel data buffer. Make use of the introduced
> >> per mmap file and compressor when they are initialized and
> >> available.
> > 
> > So you're introducing even compressed storage in this patchset? To make
> > it smaller I thought this could be in a followup cset.
> 
> These patches were slit by request from Jiri:
> 
> Changes in v5:
> - split patch 06/12 to 06/20 and 07/20
> 
> request:
> https://lore.kernel.org/lkml/YG97LMsttP4VEWPU@krava/
> 
> And I'm a bit confused :)

And it is good that this patch is split, I just didn't expect it in the
middle of the first submission for threaded mode.

- Arnaldo
 
> Regards,
> Alexey
> 
> > 
> > - Arnaldo
> >  
> >> Acked-by: Andi Kleen <ak@linux.intel.com>
> >> Acked-by: Namhyung Kim <namhyung@gmail.com>
> >> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> >> ---
> >>  tools/perf/builtin-record.c | 3 +++
> >>  tools/perf/util/mmap.c      | 6 ++++++
> >>  tools/perf/util/mmap.h      | 3 +++
> >>  3 files changed, 12 insertions(+)
> >>
> >> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> >> index cead2b3c56d7..9b7e7a5dc116 100644
> >> --- a/tools/perf/builtin-record.c
> >> +++ b/tools/perf/builtin-record.c
> >> @@ -190,6 +190,9 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
> >>  {
> >>  	struct perf_data_file *file = &rec->session->data->file;
> >>  
> >> +	if (map && map->file)
> >> +		file = map->file;
> >> +
> >>  	if (perf_data_file__write(file, bf, size) < 0) {
> >>  		pr_err("failed to write perf data, error: %m\n");
> >>  		return -1;
> >> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> >> index ab7108d22428..a2c5e4237592 100644
> >> --- a/tools/perf/util/mmap.c
> >> +++ b/tools/perf/util/mmap.c
> >> @@ -230,6 +230,8 @@ void mmap__munmap(struct mmap *map)
> >>  {
> >>  	bitmap_free(map->affinity_mask.bits);
> >>  
> >> +	zstd_fini(&map->zstd_data);
> >> +
> >>  	perf_mmap__aio_munmap(map);
> >>  	if (map->data != NULL) {
> >>  		munmap(map->data, mmap__mmap_len(map));
> >> @@ -291,6 +293,10 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
> >>  	map->core.flush = mp->flush;
> >>  
> >>  	map->comp_level = mp->comp_level;
> >> +	if (zstd_init(&map->zstd_data, map->comp_level)) {
> >> +		pr_debug2("failed to init mmap commpressor, error %d\n", errno);
> >> +		return -1;
> >> +	}
> >>  
> >>  	if (map->comp_level && !perf_mmap__aio_enabled(map)) {
> >>  		map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
> >> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> >> index 9d5f589f02ae..c4aed6e89549 100644
> >> --- a/tools/perf/util/mmap.h
> >> +++ b/tools/perf/util/mmap.h
> >> @@ -13,6 +13,7 @@
> >>  #endif
> >>  #include "auxtrace.h"
> >>  #include "event.h"
> >> +#include "util/compress.h"
> >>  
> >>  struct aiocb;
> >>  
> >> @@ -43,6 +44,8 @@ struct mmap {
> >>  	struct mmap_cpu_mask	affinity_mask;
> >>  	void		*data;
> >>  	int		comp_level;
> >> +	struct perf_data_file *file;
> >> +	struct zstd_data      zstd_data;
> >>  };
> >>  
> >>  struct mmap_params {
> >> -- 
> >> 2.19.0
> >>
> > 

-- 

- Arnaldo
