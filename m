Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E774319B46
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 09:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhBLIfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 03:35:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229788AbhBLIfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 03:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613118847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WxNHVEgpNNwZuiwCDNXGG8EKsm5KWrdDzWcFeE7C1cU=;
        b=cphYjR4jIrr46JzVFhg9dXYVNbpz2CX0gsvSD8LpxsCwKrbcT+Oz49gIhTsBHXohGgUtFb
        kgBMgSTIQcxjTlwrY89Zf8iH2anBsM+VUjGtpdsGUNKRg8A0l3pnCzM7QEHD+GoOvfRj12
        c/QA1+wdfW4UGK7Dn4YgUXTympJZqUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-xGT5U5suM5Ors0Gw91CAQQ-1; Fri, 12 Feb 2021 03:34:03 -0500
X-MC-Unique: xGT5U5suM5Ors0Gw91CAQQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7C3A19611A2;
        Fri, 12 Feb 2021 08:34:01 +0000 (UTC)
Received: from krava (unknown [10.40.193.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7E407104F0;
        Fri, 12 Feb 2021 08:33:59 +0000 (UTC)
Date:   Fri, 12 Feb 2021 09:33:58 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf libperf: Remove unused xyarray.c
Message-ID: <YCY9dtFKwTLjTq+w@krava>
References: <20210212043803.365993-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212043803.365993-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 08:38:03PM -0800, Ian Rogers wrote:
> Migrated to libperf in:
> commit 4b247fa7314c ("libperf: Adopt xyarray class from perf")

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/xyarray.c | 33 ---------------------------------
>  1 file changed, 33 deletions(-)
>  delete mode 100644 tools/perf/util/xyarray.c
> 
> diff --git a/tools/perf/util/xyarray.c b/tools/perf/util/xyarray.c
> deleted file mode 100644
> index 86889ebc3514..000000000000
> --- a/tools/perf/util/xyarray.c
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include "xyarray.h"
> -#include <stdlib.h>
> -#include <string.h>
> -#include <linux/zalloc.h>
> -
> -struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size)
> -{
> -	size_t row_size = ylen * entry_size;
> -	struct xyarray *xy = zalloc(sizeof(*xy) + xlen * row_size);
> -
> -	if (xy != NULL) {
> -		xy->entry_size = entry_size;
> -		xy->row_size   = row_size;
> -		xy->entries    = xlen * ylen;
> -		xy->max_x      = xlen;
> -		xy->max_y      = ylen;
> -	}
> -
> -	return xy;
> -}
> -
> -void xyarray__reset(struct xyarray *xy)
> -{
> -	size_t n = xy->entries * xy->entry_size;
> -
> -	memset(xy->contents, 0, n);
> -}
> -
> -void xyarray__delete(struct xyarray *xy)
> -{
> -	free(xy);
> -}
> -- 
> 2.30.0.478.g8a0d178c01-goog
> 

