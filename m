Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADD43B87DB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 19:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhF3RpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 13:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhF3Ro7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:44:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FFD86147E;
        Wed, 30 Jun 2021 17:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625074948;
        bh=xWWpj5twvOx7Y4AtxL4SiU2orhB/aR6msN0R0RPnt8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mCojysB+NOEseMJtF/iN8SWWOD1SRoZ/3T5pHqlJyOPlgMJ6Zj+XjYA7Q8U0gv5N5
         YHkIHTKOSRQGdLErem2nya4uvC5O19vygEDu8T6nixV4ZIVNBHuSQMdA6/0CGerpwC
         Gag1qmnNBKxlXSDHO1lkKJOyQxSHG851fnQUCMvxVce55PtrteziphCcL/4tuhR4tC
         XixOy/wBlQehf3qeDhmlB3JkOxDE8ULjbgR2cUgggV4m3CRdDoUGfVYrIaLLKuND//
         1/uF/mIK0RiVmETU1q0vWXZ4THmugWyv1bNBAOQ3ZchDvciKeFL2OwMwkfDXzzSun7
         Wale9ZxYwypMA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E848540B1A; Wed, 30 Jun 2021 14:42:24 -0300 (-03)
Date:   Wed, 30 Jun 2021 14:42:24 -0300
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
Subject: Re: [PATCH v8 09/22] tools lib: Introduce bitmap_intersects()
 operation
Message-ID: <YNytANmWGJ1JqPuA@kernel.org>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <f75aa738d8ff8f9cffd7532d671f3ef3deb97a7c.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <YNyoyvXouLyCRRgt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNyoyvXouLyCRRgt@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 30, 2021 at 02:24:26PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jun 30, 2021 at 06:54:48PM +0300, Alexey Bayduraev escreveu:
> > Introduce bitmap_intersects() routine that tests whether
> 
> Is this _adopting_ bitmap_intersects() from the kernel sources?

Ok, clarified that in the changeset comment and applied this patch to
reduce the number of patches in this patchset, there is another patch I
think can cherry picked, checking.

- ARnaldo

> > bitmaps bitmap1 and bitmap2 intersects. This routine will
> > be used during thread masks initialization.
> > 
> > Acked-by: Andi Kleen <ak@linux.intel.com>
> > Acked-by: Namhyung Kim <namhyung@gmail.com>
> > Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> > ---
> >  tools/include/linux/bitmap.h | 11 +++++++++++
> >  tools/lib/bitmap.c           | 14 ++++++++++++++
> >  2 files changed, 25 insertions(+)
> > 
> > diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> > index 330dbf7509cc..9d959bc24859 100644
> > --- a/tools/include/linux/bitmap.h
> > +++ b/tools/include/linux/bitmap.h
> > @@ -18,6 +18,8 @@ int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
> >  int __bitmap_equal(const unsigned long *bitmap1,
> >  		   const unsigned long *bitmap2, unsigned int bits);
> >  void bitmap_clear(unsigned long *map, unsigned int start, int len);
> > +int __bitmap_intersects(const unsigned long *bitmap1,
> > +			const unsigned long *bitmap2, unsigned int bits);
> >  
> >  #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
> >  #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
> > @@ -170,4 +172,13 @@ static inline int bitmap_equal(const unsigned long *src1,
> >  	return __bitmap_equal(src1, src2, nbits);
> >  }
> >  
> > +static inline int bitmap_intersects(const unsigned long *src1,
> > +			const unsigned long *src2, unsigned int nbits)
> > +{
> > +	if (small_const_nbits(nbits))
> > +		return ((*src1 & *src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
> > +	else
> > +		return __bitmap_intersects(src1, src2, nbits);
> > +}
> > +
> >  #endif /* _PERF_BITOPS_H */
> > diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
> > index f4e914712b6f..db466ef7be9d 100644
> > --- a/tools/lib/bitmap.c
> > +++ b/tools/lib/bitmap.c
> > @@ -86,3 +86,17 @@ int __bitmap_equal(const unsigned long *bitmap1,
> >  
> >  	return 1;
> >  }
> > +
> > +int __bitmap_intersects(const unsigned long *bitmap1,
> > +			const unsigned long *bitmap2, unsigned int bits)
> > +{
> > +	unsigned int k, lim = bits/BITS_PER_LONG;
> > +	for (k = 0; k < lim; ++k)
> > +		if (bitmap1[k] & bitmap2[k])
> > +			return 1;
> > +
> > +	if (bits % BITS_PER_LONG)
> > +		if ((bitmap1[k] & bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
> > +			return 1;
> > +	return 0;
> > +}
> > -- 
> > 2.19.0
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
