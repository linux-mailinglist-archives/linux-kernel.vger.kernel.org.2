Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717433B87C7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 19:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhF3Rgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 13:36:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:54091 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhF3Rgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:36:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="206574695"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="206574695"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 10:33:50 -0700
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="457340742"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.227.67]) ([10.249.227.67])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 10:33:47 -0700
Subject: Re: [PATCH v8 09/22] tools lib: Introduce bitmap_intersects()
 operation
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <f75aa738d8ff8f9cffd7532d671f3ef3deb97a7c.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <YNyoyvXouLyCRRgt@kernel.org>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <da33716e-eb5a-8bba-df93-7a2357c1c097@linux.intel.com>
Date:   Wed, 30 Jun 2021 20:33:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNyoyvXouLyCRRgt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.06.2021 20:24, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 30, 2021 at 06:54:48PM +0300, Alexey Bayduraev escreveu:
>> Introduce bitmap_intersects() routine that tests whether
> 
> Is this _adopting_ bitmap_intersects() from the kernel sources?

Yes, __bitmap_intersects is copy-pasted from the kernel sources,
like the others in bitmap.h

Regards,
Alexey

> 
>> bitmaps bitmap1 and bitmap2 intersects. This routine will
>> be used during thread masks initialization.
>>
>> Acked-by: Andi Kleen <ak@linux.intel.com>
>> Acked-by: Namhyung Kim <namhyung@gmail.com>
>> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
>> ---
>>  tools/include/linux/bitmap.h | 11 +++++++++++
>>  tools/lib/bitmap.c           | 14 ++++++++++++++
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
>> index 330dbf7509cc..9d959bc24859 100644
>> --- a/tools/include/linux/bitmap.h
>> +++ b/tools/include/linux/bitmap.h
>> @@ -18,6 +18,8 @@ int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
>>  int __bitmap_equal(const unsigned long *bitmap1,
>>  		   const unsigned long *bitmap2, unsigned int bits);
>>  void bitmap_clear(unsigned long *map, unsigned int start, int len);
>> +int __bitmap_intersects(const unsigned long *bitmap1,
>> +			const unsigned long *bitmap2, unsigned int bits);
>>  
>>  #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
>>  #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
>> @@ -170,4 +172,13 @@ static inline int bitmap_equal(const unsigned long *src1,
>>  	return __bitmap_equal(src1, src2, nbits);
>>  }
>>  
>> +static inline int bitmap_intersects(const unsigned long *src1,
>> +			const unsigned long *src2, unsigned int nbits)
>> +{
>> +	if (small_const_nbits(nbits))
>> +		return ((*src1 & *src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
>> +	else
>> +		return __bitmap_intersects(src1, src2, nbits);
>> +}
>> +
>>  #endif /* _PERF_BITOPS_H */
>> diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
>> index f4e914712b6f..db466ef7be9d 100644
>> --- a/tools/lib/bitmap.c
>> +++ b/tools/lib/bitmap.c
>> @@ -86,3 +86,17 @@ int __bitmap_equal(const unsigned long *bitmap1,
>>  
>>  	return 1;
>>  }
>> +
>> +int __bitmap_intersects(const unsigned long *bitmap1,
>> +			const unsigned long *bitmap2, unsigned int bits)
>> +{
>> +	unsigned int k, lim = bits/BITS_PER_LONG;
>> +	for (k = 0; k < lim; ++k)
>> +		if (bitmap1[k] & bitmap2[k])
>> +			return 1;
>> +
>> +	if (bits % BITS_PER_LONG)
>> +		if ((bitmap1[k] & bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
>> +			return 1;
>> +	return 0;
>> +}
>> -- 
>> 2.19.0
>>
> 
