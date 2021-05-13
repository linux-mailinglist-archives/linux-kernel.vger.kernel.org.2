Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D98D37F471
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhEMIwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:52:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:47994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231572AbhEMIww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:52:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53959AEF8;
        Thu, 13 May 2021 08:51:42 +0000 (UTC)
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     iamjoonsoo.kim@lge.com, rientjes@google.com, penberg@kernel.org,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Marco Elver <elver@google.com>
References: <20210511173448.GA54466@hyeyoo>
 <20210512195227.245000695c9014242e9a00e5@linux-foundation.org>
 <20210513031220.GA133011@hyeyoo>
 <20210512204024.401ff3de38649d7d0f5a45e8@linux-foundation.org>
 <20210513062809.GA319973@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] mm, slub: change run-time assertion in kmalloc_index()
 to compile-time
Message-ID: <a36ab9a1-f07a-42ca-bb11-5bd0c70660bb@suse.cz>
Date:   Thu, 13 May 2021 10:51:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210513062809.GA319973@hyeyoo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/21 8:28 AM, Hyeonggon Yoo wrote:
> On Wed, May 12, 2021 at 08:40:24PM -0700, Andrew Morton wrote:
>> On Thu, 13 May 2021 12:12:20 +0900 Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>> 
>> > On Wed, May 12, 2021 at 07:52:27PM -0700, Andrew Morton wrote:
>> > > This explodes in mysterious ways.  The patch as I have it is appended,
>> > > for reference.
>> > > 
>> > > gcc-10.3.0 allmodconfig.
>> > > 
>> > > This patch suppresses the error:
>> 
>> Ah, yes, of course, your patch changes kmalloc_index() to require that
>> it always is called with a constant `size'.  kfence_test doesn't do
>> that.
>> 
>> kfence is being a bit naughty here - the other kmalloc_index() callers
>> only comple up the call after verifying that `size' is a compile-time
>> constant.

Agreed.

>> Would something like this work?

I'd prefer if we kept kmalloc_index() for constant sizes only. The broken build
then warns anyone using it the wrong way that they shouldn't. Besides, it really
shouldn't be used outside of slab.
But if kfence test really needs this, we could perhaps extract the index
determining part out of kmalloc_slab().
Hmm or I guess the kfence tests could just use kmalloc_slab() directly?

>>  include/linux/slab.h    |   12 ++++++++----
>>  mm/kfence/kfence_test.c |    4 ++--
>>  2 files changed, 10 insertions(+), 6 deletions(-)
>> 
>> --- a/include/linux/slab.h~b
>> +++ a/include/linux/slab.h
>> @@ -374,7 +374,8 @@ static __always_inline enum kmalloc_cach
>>   * Note: there's no need to optimize kmalloc_index because it's evaluated
>>   * in compile-time.
>>   */
>> -static __always_inline unsigned int kmalloc_index(size_t size)
>> +static __always_inline unsigned int kmalloc_index(size_t size,
>> +						  bool size_is_constant)
>>  {
>>  	if (!size)
>>  		return 0;
>> @@ -410,7 +411,10 @@ static __always_inline unsigned int kmal
>>  	if (size <=  16 * 1024 * 1024) return 24;
>>  	if (size <=  32 * 1024 * 1024) return 25;
>>  
>> -	BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
>> +	if (size_is_constant)
>> +		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
>> +	else
>> +		BUG();
> 
> 
> kfence is randomly generating size. because kfence is using non-constant
> size, we should do run-time assertion or compile-time assertion depending
> on situation.
> 
> I think we can use __builtin_constant_p here. we don't need to modify
> kmalloc_index's prototype.
> 
> so what about this?
> if you think it makes sense, I'll send patch v4.
> 
> I used KMALLOC_MAX_CACHE_SIZE to assure it's safe size.
> it's safer than putting BUILD_BUG_ON_MSG(1, ...) to below if statements
> because KMALLOC_MAX_CACHE_SIZE can be less than 32MB.
> 
> --- include/linux/slab.h.orig	2021-05-12 17:56:54.504738768 +0900
> +++ include/linux/slab.h	2021-05-13 15:06:25.724565850 +0900
> @@ -346,9 +346,18 @@ static __always_inline enum kmalloc_cach
>   * 1 =  65 .. 96 bytes
>   * 2 = 129 .. 192 bytes
>   * n = 2^(n-1)+1 .. 2^n
> + *
> + * Note: there's no need to optimize kmalloc_index because it's evaluated
> + * in compile-time.
>   */
>  static __always_inline unsigned int kmalloc_index(size_t size)
>  {
> +	if (__builtin_constant_p(size)) {
> +		BUILD_BUG_ON_MSG(size > KMALLOC_MAX_CACHE_SIZE , "unexpected size in kmalloc_index()");
> +	} else if (size > KMALLOC_MAX_CACHE_SIZE) {
> +		BUG();
> +	}
> +
>  	if (!size)
>  		return 0;
> 
> @@ -382,8 +391,6 @@ static __always_inline unsigned int kmal
>  	if (size <=  8 * 1024 * 1024) return 23;
>  	if (size <=  16 * 1024 * 1024) return 24;
>  	if (size <=  32 * 1024 * 1024) return 25;
> -	if (size <=  64 * 1024 * 1024) return 26;
> -	BUG();
> 
>  	/* Will never be reached. Needed because the compiler may complain */
>  	return -1;
> 

