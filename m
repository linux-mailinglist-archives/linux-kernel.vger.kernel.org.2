Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C6B3EDBC7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhHPQy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:54:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhHPQyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:54:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9B19604DC;
        Mon, 16 Aug 2021 16:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629132834;
        bh=WBksxGK3HI53qKeZCGClDu8VG0eu2/wywzdloSRmPck=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=AmkdrMNBTzXyOkbZAXm/5oRViO5Fuunj9OLqB5NdLP3me1ZvxqvSkq5pndXMxgdV9
         PezIWeKvBPukewrW2YioE52Qmfe0ForrV07tJsNxzzHDJ9HbWkpUdWUszmziKoFj6C
         k3jv+6MUIpAtAFxg5sbRhSQJdkxS5V+xz0GJlnbEVYfq8Ewkkl9gfVGC4s7T1tnf+Y
         /TI6+NF1xaOHCNemvM92k21Y4c4+Y1EHaPFlKAQtQwaCRdT2jzWwgnAw86Q+TRPmNW
         vsHRFMtSJxbhZ8LO4l7jrY+7slydBVTDJKAwxezXSUjdjk95vo1R0R5ZGZ81AU+Fg9
         nJu7Yus2vFQQA==
Subject: Re: [PATCH] lib/zstd: Fix bitwise vs logical operators
To:     dsterba@suse.cz, Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        terrelln@fb.com
References: <20210815004154.1781834-1-nathan@kernel.org>
 <20210816151450.GF5047@twin.jikos.cz>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <bbb0a92c-4237-c651-3b8b-84dfaa2a2096@kernel.org>
Date:   Mon, 16 Aug 2021 09:53:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210816151450.GF5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/2021 8:14 AM, David Sterba wrote:
> You should CC Nick Terell for ZSTD patches, added.

Thanks for the info and adding him, I did not see an entry for lib/zstd/ 
in MAINTAINERS and there is no consistent person picking up patches 
according to git.

Cheers,
Nathan

> On Sat, Aug 14, 2021 at 05:41:54PM -0700, Nathan Chancellor wrote:
>> clang warns several times along the lines of:
>>
>> lib/zstd/compress.c:1043:7: warning: bitwise and of boolean expressions; did you mean logical and? [-Wbool-operation-and]
>>                  if ((offset_1 > 0) & (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) {
>>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>                                     &&
>>
>> Bitwise ANDs do not short circuit, meaning that the ZSTD_read32 calls
>> will be evaluated even if the first condition is not true. This is not
>> always a problem but it is not a standard way to do conditionals so
>> replace the bitwise ANDs with logical ones to fix the warning and make
>> the code clearer.
>>
>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>> ---
>>   lib/zstd/compress.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/lib/zstd/compress.c b/lib/zstd/compress.c
>> index b080264ed3ad..0e515d1d4237 100644
>> --- a/lib/zstd/compress.c
>> +++ b/lib/zstd/compress.c
>> @@ -1040,7 +1040,7 @@ void ZSTD_compressBlock_fast_generic(ZSTD_CCtx *cctx, const void *src, size_t sr
>>   		const BYTE *match = base + matchIndex;
>>   		hashTable[h] = curr; /* update hash table */
>>   
>> -		if ((offset_1 > 0) & (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) {
>> +		if ((offset_1 > 0) && (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) {
>>   			mLength = ZSTD_count(ip + 1 + 4, ip + 1 + 4 - offset_1, iend) + 4;
>>   			ip++;
>>   			ZSTD_storeSeq(seqStorePtr, ip - anchor, anchor, 0, mLength - MINMATCH);
>> @@ -1072,7 +1072,7 @@ void ZSTD_compressBlock_fast_generic(ZSTD_CCtx *cctx, const void *src, size_t sr
>>   			hashTable[ZSTD_hashPtr(base + curr + 2, hBits, mls)] = curr + 2; /* here because curr+2 could be > iend-8 */
>>   			hashTable[ZSTD_hashPtr(ip - 2, hBits, mls)] = (U32)(ip - 2 - base);
>>   			/* check immediate repcode */
>> -			while ((ip <= ilimit) && ((offset_2 > 0) & (ZSTD_read32(ip) == ZSTD_read32(ip - offset_2)))) {
>> +			while ((ip <= ilimit) && ((offset_2 > 0) && (ZSTD_read32(ip) == ZSTD_read32(ip - offset_2)))) {
>>   				/* store sequence */
>>   				size_t const rLength = ZSTD_count(ip + 4, ip + 4 - offset_2, iend) + 4;
>>   				{
>> @@ -1291,7 +1291,7 @@ void ZSTD_compressBlock_doubleFast_generic(ZSTD_CCtx *cctx, const void *src, siz
>>   		const BYTE *match = base + matchIndexS;
>>   		hashLong[h2] = hashSmall[h] = curr; /* update hash tables */
>>   
>> -		if ((offset_1 > 0) & (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) { /* note : by construction, offset_1 <= curr */
>> +		if ((offset_1 > 0) && (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) { /* note : by construction, offset_1 <= curr */
>>   			mLength = ZSTD_count(ip + 1 + 4, ip + 1 + 4 - offset_1, iend) + 4;
>>   			ip++;
>>   			ZSTD_storeSeq(seqStorePtr, ip - anchor, anchor, 0, mLength - MINMATCH);
>> @@ -1350,7 +1350,7 @@ void ZSTD_compressBlock_doubleFast_generic(ZSTD_CCtx *cctx, const void *src, siz
>>   			hashLong[ZSTD_hashPtr(ip - 2, hBitsL, 8)] = hashSmall[ZSTD_hashPtr(ip - 2, hBitsS, mls)] = (U32)(ip - 2 - base);
>>   
>>   			/* check immediate repcode */
>> -			while ((ip <= ilimit) && ((offset_2 > 0) & (ZSTD_read32(ip) == ZSTD_read32(ip - offset_2)))) {
>> +			while ((ip <= ilimit) && ((offset_2 > 0) && (ZSTD_read32(ip) == ZSTD_read32(ip - offset_2)))) {
>>   				/* store sequence */
>>   				size_t const rLength = ZSTD_count(ip + 4, ip + 4 - offset_2, iend) + 4;
>>   				{
>> @@ -1929,7 +1929,7 @@ void ZSTD_compressBlock_lazy_generic(ZSTD_CCtx *ctx, const void *src, size_t src
>>   		const BYTE *start = ip + 1;
>>   
>>   		/* check repCode */
>> -		if ((offset_1 > 0) & (ZSTD_read32(ip + 1) == ZSTD_read32(ip + 1 - offset_1))) {
>> +		if ((offset_1 > 0) && (ZSTD_read32(ip + 1) == ZSTD_read32(ip + 1 - offset_1))) {
>>   			/* repcode : we take it */
>>   			matchLength = ZSTD_count(ip + 1 + EQUAL_READ32, ip + 1 + EQUAL_READ32 - offset_1, iend) + EQUAL_READ32;
>>   			if (depth == 0)
>> @@ -1953,7 +1953,7 @@ void ZSTD_compressBlock_lazy_generic(ZSTD_CCtx *ctx, const void *src, size_t src
>>   		if (depth >= 1)
>>   			while (ip < ilimit) {
>>   				ip++;
>> -				if ((offset) && ((offset_1 > 0) & (ZSTD_read32(ip) == ZSTD_read32(ip - offset_1)))) {
>> +				if ((offset) && ((offset_1 > 0) && (ZSTD_read32(ip) == ZSTD_read32(ip - offset_1)))) {
>>   					size_t const mlRep = ZSTD_count(ip + EQUAL_READ32, ip + EQUAL_READ32 - offset_1, iend) + EQUAL_READ32;
>>   					int const gain2 = (int)(mlRep * 3);
>>   					int const gain1 = (int)(matchLength * 3 - ZSTD_highbit32((U32)offset + 1) + 1);
>> @@ -1974,7 +1974,7 @@ void ZSTD_compressBlock_lazy_generic(ZSTD_CCtx *ctx, const void *src, size_t src
>>   				/* let's find an even better one */
>>   				if ((depth == 2) && (ip < ilimit)) {
>>   					ip++;
>> -					if ((offset) && ((offset_1 > 0) & (ZSTD_read32(ip) == ZSTD_read32(ip - offset_1)))) {
>> +					if ((offset) && ((offset_1 > 0) && (ZSTD_read32(ip) == ZSTD_read32(ip - offset_1)))) {
>>   						size_t const ml2 = ZSTD_count(ip + EQUAL_READ32, ip + EQUAL_READ32 - offset_1, iend) + EQUAL_READ32;
>>   						int const gain2 = (int)(ml2 * 4);
>>   						int const gain1 = (int)(matchLength * 4 - ZSTD_highbit32((U32)offset + 1) + 1);
>> @@ -2021,7 +2021,7 @@ void ZSTD_compressBlock_lazy_generic(ZSTD_CCtx *ctx, const void *src, size_t src
>>   		}
>>   
>>   		/* check immediate repcode */
>> -		while ((ip <= ilimit) && ((offset_2 > 0) & (ZSTD_read32(ip) == ZSTD_read32(ip - offset_2)))) {
>> +		while ((ip <= ilimit) && ((offset_2 > 0) && (ZSTD_read32(ip) == ZSTD_read32(ip - offset_2)))) {
>>   			/* store sequence */
>>   			matchLength = ZSTD_count(ip + EQUAL_READ32, ip + EQUAL_READ32 - offset_2, iend) + EQUAL_READ32;
>>   			offset = offset_2;
>>
>> base-commit: ba31f97d43be41ca99ab72a6131d7c226306865f
>> -- 
>> 2.33.0.rc2
