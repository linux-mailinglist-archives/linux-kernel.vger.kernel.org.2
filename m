Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352353BA3E1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 20:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhGBSSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 14:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhGBSSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 14:18:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02EF8613DC;
        Fri,  2 Jul 2021 18:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625249745;
        bh=0PGfeLOVIYY2WpcoibguCgA2At0IRQvLGVRHR7AppB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjLJpNEy0ZjKRZ4DXwAjerVDqKZJTWLAReg1mUdHG6Om3AlauS8ui+M4gjF+8DsmC
         CnAacGXtl4fhasawY+/E3orpxIU4MnkqIQGBn8s/Bb+kqZccmAeaXMoRQ/VJ3pbOx3
         +0k3SjpLkbAxbIhQN+ys8qMJRyUWzOzqD+kvBT2rOp5S5jsuIIMMqU96pbZ2p/4oWQ
         cTGX5mYTfU3Ntkog27L906h3HAZdaYggUwdwdztD4rK/GKBtOjofKmmbs2OkhfCwmJ
         9Khv40qanG0G/JDdyWigidXr38w31rsTX+HGvxU0BqhiUQ/oxI7QGQuEw01+Pq4lb4
         viz0yNuPKJn5Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 200F340B1A; Fri,  2 Jul 2021 15:15:42 -0300 (-03)
Date:   Fri, 2 Jul 2021 15:15:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
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
Subject: Re: [PATCH v9 02/24] tools lib: Introduce fdarray clone function
Message-ID: <YN9Xzs9q3r8qU90R@kernel.org>
References: <cover.1625227739.git.alexey.v.bayduraev@linux.intel.com>
 <e400806e403d2d607c89c251f72b4ba631b52f14.1625227739.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e400806e403d2d607c89c251f72b4ba631b52f14.1625227739.git.alexey.v.bayduraev@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 02, 2021 at 03:32:10PM +0300, Alexey Bayduraev escreveu:
> Introduce a function to create a copy of an existing file descriptor in
> the fdarray structure. The function returns the position of the copied fd.
> 
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/lib/api/fd/array.c | 17 +++++++++++++++++
>  tools/lib/api/fd/array.h |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index 5e6cb9debe37..de8bcbaea3f1 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -88,6 +88,23 @@ int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_flags
>  	return pos;
>  }
>  
> +int fdarray__clone(struct fdarray *fda, int pos, struct fdarray *base)

The "XX__clone" idiom means "get the XXX instance and get me a clone of
it", i.e. of the whole class, not of an entry, see map__clone(),
evsel__clone(), parse_events_term__clone(), etc.

Please consider:

int fdarray__dup_entry_from(struct fdarray *fda, int pos, struct fdarray *from)

> +{
> +	struct pollfd *entry;
> +	int npos;
> +
> +	if (pos >= base->nr)
> +		return -EINVAL;
> +
> +	entry = &base->entries[pos];
> +
> +	npos = fdarray__add(fda, entry->fd, entry->events, base->priv[pos].flags);
> +	if (npos >= 0)
> +		fda->priv[npos] = base->priv[pos];
> +
> +	return npos;
> +}
> +
>  int fdarray__filter(struct fdarray *fda, short revents,
>  		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
>  		    void *arg)
> diff --git a/tools/lib/api/fd/array.h b/tools/lib/api/fd/array.h
> index 7fcf21a33c0c..4a03da7f1fc1 100644
> --- a/tools/lib/api/fd/array.h
> +++ b/tools/lib/api/fd/array.h
> @@ -42,6 +42,7 @@ struct fdarray *fdarray__new(int nr_alloc, int nr_autogrow);
>  void fdarray__delete(struct fdarray *fda);
>  
>  int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_flags flags);
> +int fdarray__clone(struct fdarray *fda, int pos, struct fdarray *base);
>  int fdarray__poll(struct fdarray *fda, int timeout);
>  int fdarray__filter(struct fdarray *fda, short revents,
>  		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
> -- 
> 2.19.0
> 

-- 

- Arnaldo
