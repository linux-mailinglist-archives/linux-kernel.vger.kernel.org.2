Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536DC4205EF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 08:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhJDGoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 02:44:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232131AbhJDGoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 02:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633329744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3PAbdho+sexXabtIdCyK9bM1LxrTk+pOxQu/u9OB5RQ=;
        b=go2vM3zRVeHnRqIMTi57n5qJeSfALcV4M7rrUFAh6ckNAvd8Pbz7K0pkkwPutiyEW+ArOL
        TfvGt7XUO1bvNKUnn4+OqxPor953zwEV9urIZOLneRd4xHyMxfBRK/o/PbY6FHCZQ7ctCT
        AJ5OAwA19H7C7ivGtAB6iPuPVEtdS3s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-mRHs21HWN06OIo4lnCv7cg-1; Mon, 04 Oct 2021 02:42:23 -0400
X-MC-Unique: mRHs21HWN06OIo4lnCv7cg-1
Received: by mail-wr1-f72.google.com with SMTP id e12-20020a056000178c00b001606927de88so4260739wrg.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 23:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3PAbdho+sexXabtIdCyK9bM1LxrTk+pOxQu/u9OB5RQ=;
        b=EuO3bcqz/LglHNGFvxqu5OYi2yHgjRu++vbwT2C+m0bEWtLVtU4L/t+h9voWYQrNxj
         /u1nikuolCpzsVtI+Ljln+kdt9YOCiXTCtBdgV/TipnbWjca8qDhbvC6p1tdYFpDJiVv
         SSeyth+XNItLm5sWF7uY/p5K1vhjRdAJus8cp/oF7TiHDgBWNED4eLaZ2CPW7Gpj0m2Z
         V3iXcRbOqejQndCJ/VexTK25YjiPb4Bsextpy7HI7n/6ABJIV9/KYFRKUJRJsUHZgZPM
         ITcfgtYF1NUSGAvjDOccQ9F0L9AHQTJzz5kmRC62tsNZFDjfTFXO+mvAX4qpdbvQp+2X
         k6LA==
X-Gm-Message-State: AOAM531NGm5l065fvBM3z2jw9FSZKYzxJ35g9TMvSvMROXVK8DtlbbbO
        X/3YauopvOW4YpzgLTQQfTia9e0IzvFVgLZI3nhVIfpW0TlMlQJfEtcB1tTB03olXcsZ8924Kj1
        ZPuiVUiQYC7fWg3VXPOl5KBcy
X-Received: by 2002:a1c:44d6:: with SMTP id r205mr16411755wma.174.1633329742207;
        Sun, 03 Oct 2021 23:42:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAFP1W5a39rSPDPfM8Jh91SVdjZcV0PWRnOsIkDCiRzw6Ce3+A/fGu2KuSPJEfeyL2IxMffA==
X-Received: by 2002:a1c:44d6:: with SMTP id r205mr16411740wma.174.1633329742020;
        Sun, 03 Oct 2021 23:42:22 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id p3sm266955wrs.10.2021.10.03.23.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 23:42:21 -0700 (PDT)
Date:   Mon, 4 Oct 2021 08:42:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH] perf report: Output non-zero offset for decompressed
 records
Message-ID: <YVqiS0lzxuVlblrN@krava>
References: <20210929091445.18274-1-alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929091445.18274-1-alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 12:14:45PM +0300, Alexey Bayduraev wrote:
> Print offset of PERF_RECORD_COMPRESSED record instead of zero for
> decompressed records in raw trace dump (-D option of perf-report):
> 
> 0x17cf08 [0x28]: event: 9
> 
> instead of:
> 
> 0 [0x28]: event: 9
> 
> The fix is not critical, because currently file_pos for compressed
> events is used in perf_session__process_event only to show offsets
> in the raw dump.

hi,
I don't mind the change just curious, because I see also:

  perf_session__process_event
    perf_session__process_user_event
      lseek(fd, file_offset, ...

which is not raw dump as the comment suggests

thanks,
jirka

> 
> This patch was separated from patchset:
> https://lore.kernel.org/lkml/cover.1629186429.git.alexey.v.bayduraev@linux.intel.com/
> and was already rewieved.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
> Tested-by: Riccardo Mancini <rickyman7@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/util/session.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 069c2cfdd3be..352f16076e01 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2116,7 +2116,7 @@ fetch_decomp_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
>  static int __perf_session__process_decomp_events(struct perf_session *session)
>  {
>  	s64 skip;
> -	u64 size, file_pos = 0;
> +	u64 size;
>  	struct decomp *decomp = session->decomp_last;
>  
>  	if (!decomp)
> @@ -2132,7 +2132,7 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
>  		size = event->header.size;
>  
>  		if (size < sizeof(struct perf_event_header) ||
> -		    (skip = perf_session__process_event(session, event, file_pos)) < 0) {
> +		    (skip = perf_session__process_event(session, event, decomp->file_pos)) < 0) {
>  			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
>  				decomp->file_pos + decomp->head, event->header.size, event->header.type);
>  			return -EINVAL;
> -- 
> 2.19.0
> 

