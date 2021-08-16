Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173353ED9BD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhHPPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:18:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37872 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhHPPST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:18:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D6E6C1FED8;
        Mon, 16 Aug 2021 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629127066;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=znmd6DssRyB2gfAtJKubIBtDRd+udlprmsCrGGY3Om0=;
        b=cQl4TLBb0Tr4QCzIVVearQCOzWbiHhxEk3ZGitlq6qYpKHaM/w4GjDWJymvVO5oKVwHQw6
        wZ3hHwmJ6tOEoFACCFrkQWnF18oFWKp8kUSVD2dmrGsd0Rs/cMlcYjWjYRIshYgtQvEnPz
        8qq6KdYQcWDTtY65pPBvzURAQYVlVQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629127066;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=znmd6DssRyB2gfAtJKubIBtDRd+udlprmsCrGGY3Om0=;
        b=USzbCISfA02HQ5tqSQm8ikO4/GfZngomVPuPTJF4dKm91RxrJ3oMGMl6REEMR0fp3eLTw8
        pUfNxBnZwIa0kIDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BFA7AA3B87;
        Mon, 16 Aug 2021 15:17:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 07B8FDA72C; Mon, 16 Aug 2021 17:14:50 +0200 (CEST)
Date:   Mon, 16 Aug 2021 17:14:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        terrelln@fb.com
Subject: Re: [PATCH] lib/zstd: Fix bitwise vs logical operators
Message-ID: <20210816151450.GF5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        terrelln@fb.com
References: <20210815004154.1781834-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210815004154.1781834-1-nathan@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You should CC Nick Terell for ZSTD patches, added.

On Sat, Aug 14, 2021 at 05:41:54PM -0700, Nathan Chancellor wrote:
> clang warns several times along the lines of:
> 
> lib/zstd/compress.c:1043:7: warning: bitwise and of boolean expressions; did you mean logical and? [-Wbool-operation-and]
>                 if ((offset_1 > 0) & (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) {
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                                    &&
> 
> Bitwise ANDs do not short circuit, meaning that the ZSTD_read32 calls
> will be evaluated even if the first condition is not true. This is not
> always a problem but it is not a standard way to do conditionals so
> replace the bitwise ANDs with logical ones to fix the warning and make
> the code clearer.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  lib/zstd/compress.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/zstd/compress.c b/lib/zstd/compress.c
> index b080264ed3ad..0e515d1d4237 100644
> --- a/lib/zstd/compress.c
> +++ b/lib/zstd/compress.c
> @@ -1040,7 +1040,7 @@ void ZSTD_compressBlock_fast_generic(ZSTD_CCtx *cctx, const void *src, size_t sr
>  		const BYTE *match = base + matchIndex;
>  		hashTable[h] = curr; /* update hash table */
>  
> -		if ((offset_1 > 0) & (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) {
> +		if ((offset_1 > 0) && (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) {
>  			mLength = ZSTD_count(ip + 1 + 4, ip + 1 + 4 - offset_1, iend) + 4;
>  			ip++;
>  			ZSTD_storeSeq(seqStorePtr, ip - anchor, anchor, 0, mLength - MINMATCH);
> @@ -1072,7 +1072,7 @@ void ZSTD_compressBlock_fast_generic(ZSTD_CCtx *cctx, const void *src, size_t sr
>  			hashTable[ZSTD_hashPtr(base + curr + 2, hBits, mls)] = curr + 2; /* here because curr+2 could be > iend-8 */
>  			hashTable[ZSTD_hashPtr(ip - 2, hBits, mls)] = (U32)(ip - 2 - base);
>  			/* check immediate repcode */
> -			while ((ip <= ilimit) && ((offset_2 > 0) & (ZSTD_read32(ip) == ZSTD_read32(ip - offset_2)))) {
> +			while ((ip <= ilimit) && ((offset_2 > 0) && (ZSTD_read32(ip) == ZSTD_read32(ip - offset_2)))) {
>  				/* store sequence */
>  				size_t const rLength = ZSTD_count(ip + 4, ip + 4 - offset_2, iend) + 4;
>  				{
> @@ -1291,7 +1291,7 @@ void ZSTD_compressBlock_doubleFast_generic(ZSTD_CCtx *cctx, const void *src, siz
>  		const BYTE *match = base + matchIndexS;
>  		hashLong[h2] = hashSmall[h] = curr; /* update hash tables */
>  
> -		if ((offset_1 > 0) & (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) { /* note : by construction, offset_1 <= curr */
> +		if ((offset_1 > 0) && (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) { /* note : by construction, offset_1 <= curr */
>  			mLength = ZSTD_count(ip + 1 + 4, ip + 1 + 4 - offset_1, iend) + 4;
>  			ip++;
>  			ZSTD_storeSeq(seqStorePtr, ip - anchor, anchor, 0, mLength - MINMATCH);
> @@ -1350,7 +1350,7 @@ void ZSTD_compressBlock_doubleFast_generic(ZSTD_CCtx *cctx, const void *src, siz
>  			hashLong[ZSTD_hashPtr(ip - 2, hBitsL, 8)] = hashSmall[ZSTD_hashPtr(ip - 2, hBitsS, mls)] = (U32)(ip - 2 - base);
>  
>  			/* check immediate repcode */
> -			while ((ip <= ilimit) && ((offset_2 > 0) & (ZSTD_read32(ip) == ZSTD_read32(ip - offset_2)))) {
> +			while ((ip <= ilimit) && ((offset_2 > 0) && (ZSTD_read32(ip) == ZSTD_read32(ip - offset_2)))) {
>  				/* store sequence */
>  				size_t const rLength = ZSTD_count(ip + 4, ip + 4 - offset_2, iend) + 4;
>  				{
> @@ -1929,7 +1929,7 @@ void ZSTD_compressBlock_lazy_generic(ZSTD_CCtx *ctx, const void *src, size_t src
>  		const BYTE *start = ip + 1;
>  
>  		/* check repCode */
> -		if ((offset_1 > 0) & (ZSTD_read32(ip + 1) == ZSTD_read32(ip + 1 - offset_1))) {
> +		if ((offset_1 > 0) && (ZSTD_read32(ip + 1) == ZSTD_read32(ip + 1 - offset_1))) {
>  			/* repcode : we take it */
>  			matchLength = ZSTD_count(ip + 1 + EQUAL_READ32, ip + 1 + EQUAL_READ32 - offset_1, iend) + EQUAL_READ32;
>  			if (depth == 0)
> @@ -1953,7 +1953,7 @@ void ZSTD_compressBlock_lazy_generic(ZSTD_CCtx *ctx, const void *src, size_t src
>  		if (depth >= 1)
>  			while (ip < ilimit) {
>  				ip++;
> -				if ((offset) && ((offset_1 > 0) & (ZSTD_read32(ip) == ZSTD_read32(ip - offset_1)))) {
> +				if ((offset) && ((offset_1 > 0) && (ZSTD_read32(ip) == ZSTD_read32(ip - offset_1)))) {
>  					size_t const mlRep = ZSTD_count(ip + EQUAL_READ32, ip + EQUAL_READ32 - offset_1, iend) + EQUAL_READ32;
>  					int const gain2 = (int)(mlRep * 3);
>  					int const gain1 = (int)(matchLength * 3 - ZSTD_highbit32((U32)offset + 1) + 1);
> @@ -1974,7 +1974,7 @@ void ZSTD_compressBlock_lazy_generic(ZSTD_CCtx *ctx, const void *src, size_t src
>  				/* let's find an even better one */
>  				if ((depth == 2) && (ip < ilimit)) {
>  					ip++;
> -					if ((offset) && ((offset_1 > 0) & (ZSTD_read32(ip) == ZSTD_read32(ip - offset_1)))) {
> +					if ((offset) && ((offset_1 > 0) && (ZSTD_read32(ip) == ZSTD_read32(ip - offset_1)))) {
>  						size_t const ml2 = ZSTD_count(ip + EQUAL_READ32, ip + EQUAL_READ32 - offset_1, iend) + EQUAL_READ32;
>  						int const gain2 = (int)(ml2 * 4);
>  						int const gain1 = (int)(matchLength * 4 - ZSTD_highbit32((U32)offset + 1) + 1);
> @@ -2021,7 +2021,7 @@ void ZSTD_compressBlock_lazy_generic(ZSTD_CCtx *ctx, const void *src, size_t src
>  		}
>  
>  		/* check immediate repcode */
> -		while ((ip <= ilimit) && ((offset_2 > 0) & (ZSTD_read32(ip) == ZSTD_read32(ip - offset_2)))) {
> +		while ((ip <= ilimit) && ((offset_2 > 0) && (ZSTD_read32(ip) == ZSTD_read32(ip - offset_2)))) {
>  			/* store sequence */
>  			matchLength = ZSTD_count(ip + EQUAL_READ32, ip + EQUAL_READ32 - offset_2, iend) + EQUAL_READ32;
>  			offset = offset_2;
> 
> base-commit: ba31f97d43be41ca99ab72a6131d7c226306865f
> -- 
> 2.33.0.rc2
