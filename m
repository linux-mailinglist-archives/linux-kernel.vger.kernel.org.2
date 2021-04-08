Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29796358F7C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 23:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhDHVxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 17:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232673AbhDHVwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 17:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617918762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qdyszlyP68lkuY3ui443/DQriEP8d/33MZNvIKrUSfw=;
        b=AaoYcV+vSJU9N/NH2PIdMH9A4Ju84m5jxWBxB/ragHfN/gKbgFL2AraCBmwXZWjv8pNp5Y
        8V6p0EubSkZXZW/12nOEuE9l8EY9FewREwRZ7Z7SSInUL6wEZUIomqrWtBBn+2av7Yf82P
        14uy7/hvaIYTd7GFMMl9tqDyYaMBlYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-zN-RI4I9PJaWySlEZg8CHw-1; Thu, 08 Apr 2021 17:52:38 -0400
X-MC-Unique: zN-RI4I9PJaWySlEZg8CHw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 010DE800D53;
        Thu,  8 Apr 2021 21:52:37 +0000 (UTC)
Received: from krava (unknown [10.40.192.110])
        by smtp.corp.redhat.com (Postfix) with SMTP id C14C1196E3;
        Thu,  8 Apr 2021 21:52:34 +0000 (UTC)
Date:   Thu, 8 Apr 2021 23:52:33 +0200
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
Subject: Re: [PATCH v4 08/12] perf record: introduce --threads=<spec> command
 line option
Message-ID: <YG97Id/zNgdFLeWr@krava>
References: <6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com>
 <ad2c112c-d6ae-c7cf-4fa7-a07279df4388@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad2c112c-d6ae-c7cf-4fa7-a07279df4388@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 11:49:06AM +0300, Bayduraev, Alexey V wrote:

SNIP

> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/include/linux/bitmap.h |  11 ++
>  tools/lib/bitmap.c           |  14 ++
>  tools/perf/builtin-record.c  | 317 ++++++++++++++++++++++++++++++++++-
>  tools/perf/util/record.h     |   1 +
>  4 files changed, 341 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> index 477a1cae513f..2eb1d1084543 100644
> --- a/tools/include/linux/bitmap.h
> +++ b/tools/include/linux/bitmap.h
> @@ -18,6 +18,8 @@ int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
>  int __bitmap_equal(const unsigned long *bitmap1,
>  		   const unsigned long *bitmap2, unsigned int bits);
>  void bitmap_clear(unsigned long *map, unsigned int start, int len);
> +int __bitmap_intersects(const unsigned long *bitmap1,
> +			const unsigned long *bitmap2, unsigned int bits);
>  
>  #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
>  
> @@ -178,4 +180,13 @@ static inline int bitmap_equal(const unsigned long *src1,
>  	return __bitmap_equal(src1, src2, nbits);
>  }
>  
> +static inline int bitmap_intersects(const unsigned long *src1,
> +			const unsigned long *src2, unsigned int nbits)
> +{
> +	if (small_const_nbits(nbits))
> +		return ((*src1 & *src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
> +	else
> +		return __bitmap_intersects(src1, src2, nbits);
> +}
> +
>  #endif /* _PERF_BITOPS_H */
> diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
> index 5043747ef6c5..3cc3a5b43bb5 100644
> --- a/tools/lib/bitmap.c
> +++ b/tools/lib/bitmap.c
> @@ -86,3 +86,17 @@ int __bitmap_equal(const unsigned long *bitmap1,
>  
>  	return 1;
>  }
> +
> +int __bitmap_intersects(const unsigned long *bitmap1,
> +			const unsigned long *bitmap2, unsigned int bits)
> +{
> +	unsigned int k, lim = bits/BITS_PER_LONG;
> +	for (k = 0; k < lim; ++k)
> +		if (bitmap1[k] & bitmap2[k])
> +			return 1;
> +
> +	if (bits % BITS_PER_LONG)
> +		if ((bitmap1[k] & bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
> +			return 1;
> +	return 0;
> +}

please move __bitmap_intersects function to the separate patch

jirka

