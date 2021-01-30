Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F5A3097CE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 20:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhA3THH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 14:07:07 -0500
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:48624 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229990AbhA3THA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 14:07:00 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 37528181D302B;
        Sat, 30 Jan 2021 19:06:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:1:41:69:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1593:1594:1605:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:2639:2828:2898:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:4321:4605:5007:6117:6119:7652:7875:7904:8603:8957:9036:10004:10848:11026:11232:11473:11658:11914:12043:12291:12297:12438:12555:12683:12740:12895:12986:13439:13894:14110:14659:21080:21324:21451:21611:21627:21990:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: walk05_16060fc275b3
X-Filterd-Recvd-Size: 14526
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 Jan 2021 19:06:16 +0000 (UTC)
Message-ID: <7b689b90f021c57b8c45caa3aa40099fd401b262.camel@perches.com>
Subject: Re: [PATCH 26/29] lib: zstd: Avoid comma separated statements
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Date:   Sat, 30 Jan 2021 11:06:15 -0800
In-Reply-To: <9f8d25bfc5c43f481d05265ef05270a63d3e6502.1598331149.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
         <9f8d25bfc5c43f481d05265ef05270a63d3e6502.1598331149.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
> Use semicolons and braces.

ping?

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  lib/zstd/compress.c     | 120 ++++++++++++++++++++++++++--------------
>  lib/zstd/fse_compress.c |  24 +++++---
>  lib/zstd/huf_compress.c |   6 +-
>  3 files changed, 100 insertions(+), 50 deletions(-)
> 
> diff --git a/lib/zstd/compress.c b/lib/zstd/compress.c
> index b080264ed3ad..d8587e458665 100644
> --- a/lib/zstd/compress.c
> +++ b/lib/zstd/compress.c
> @@ -629,12 +629,17 @@ ZSTD_STATIC size_t ZSTD_compressSequences_internal(ZSTD_CCtx *zc, void *dst, siz
>  	/* Sequences Header */
>  	if ((oend - op) < 3 /*max nbSeq Size*/ + 1 /*seqHead */)
>  		return ERROR(dstSize_tooSmall);
> -	if (nbSeq < 0x7F)
> +	if (nbSeq < 0x7F) {
>  		*op++ = (BYTE)nbSeq;
> -	else if (nbSeq < LONGNBSEQ)
> -		op[0] = (BYTE)((nbSeq >> 8) + 0x80), op[1] = (BYTE)nbSeq, op += 2;
> -	else
> -		op[0] = 0xFF, ZSTD_writeLE16(op + 1, (U16)(nbSeq - LONGNBSEQ)), op += 3;
> +	} else if (nbSeq < LONGNBSEQ) {
> +		op[0] = (BYTE)((nbSeq >> 8) + 0x80);
> +		op[1] = (BYTE)nbSeq;
> +		op += 2;
> +	} else {
> +		op[0] = 0xFF;
> +		ZSTD_writeLE16(op + 1, (U16)(nbSeq - LONGNBSEQ));
> +		op += 3;
> +	}
>  	if (nbSeq == 0)
>  		return op - ostart;
>  
> 
> @@ -1025,10 +1030,13 @@ void ZSTD_compressBlock_fast_generic(ZSTD_CCtx *cctx, const void *src, size_t sr
>  	ip += (ip == lowest);
>  	{
>  		U32 const maxRep = (U32)(ip - lowest);
> -		if (offset_2 > maxRep)
> -			offsetSaved = offset_2, offset_2 = 0;
> -		if (offset_1 > maxRep)
> -			offsetSaved = offset_1, offset_1 = 0;
> +		if (offset_2 > maxRep) {
> +			offsetSaved = offset_2;
> +			offset_2 = 0;
> +		}
> +		if (offset_1 > maxRep) {
> +			offsetSaved = offset_1; offset_1 = 0;
> +		}
>  	}
>  
> 
>  	/* Main Search Loop */
> @@ -1273,10 +1281,14 @@ void ZSTD_compressBlock_doubleFast_generic(ZSTD_CCtx *cctx, const void *src, siz
>  	ip += (ip == lowest);
>  	{
>  		U32 const maxRep = (U32)(ip - lowest);
> -		if (offset_2 > maxRep)
> -			offsetSaved = offset_2, offset_2 = 0;
> -		if (offset_1 > maxRep)
> -			offsetSaved = offset_1, offset_1 = 0;
> +		if (offset_2 > maxRep) {
> +			offsetSaved = offset_2;
> +			offset_2 = 0;
> +		}
> +		if (offset_1 > maxRep) {
> +			offsetSaved = offset_1;
> +			offset_1 = 0;
> +		}
>  	}
>  
> 
>  	/* Main Search Loop */
> @@ -1686,8 +1698,10 @@ static size_t ZSTD_insertBtAndFindBestMatch(ZSTD_CCtx *zc, const BYTE *const ip,
>  		if (matchLength > bestLength) {
>  			if (matchLength > matchEndIdx - matchIndex)
>  				matchEndIdx = matchIndex + (U32)matchLength;
> -			if ((4 * (int)(matchLength - bestLength)) > (int)(ZSTD_highbit32(curr - matchIndex + 1) - ZSTD_highbit32((U32)offsetPtr[0] + 1)))
> -				bestLength = matchLength, *offsetPtr = ZSTD_REP_MOVE + curr - matchIndex;
> +			if ((4 * (int)(matchLength - bestLength)) > (int)(ZSTD_highbit32(curr - matchIndex + 1) - ZSTD_highbit32((U32)offsetPtr[0] + 1))) {
> +				bestLength = matchLength;
> +				*offsetPtr = ZSTD_REP_MOVE + curr - matchIndex;
> +			}
>  			if (ip + matchLength == iend) /* equal : no way to know if inf or sup */
>  				break;		      /* drop, to guarantee consistency (miss a little bit of compression) */
>  		}
> @@ -1916,10 +1930,14 @@ void ZSTD_compressBlock_lazy_generic(ZSTD_CCtx *ctx, const void *src, size_t src
>  	ctx->nextToUpdate3 = ctx->nextToUpdate;
>  	{
>  		U32 const maxRep = (U32)(ip - base);
> -		if (offset_2 > maxRep)
> -			savedOffset = offset_2, offset_2 = 0;
> -		if (offset_1 > maxRep)
> -			savedOffset = offset_1, offset_1 = 0;
> +		if (offset_2 > maxRep) {
> +			savedOffset = offset_2;
> +			offset_2 = 0;
> +		}
> +		if (offset_1 > maxRep) {
> +			savedOffset = offset_1;
> +			offset_1 = 0;
> +		}
>  	}
>  
> 
>  	/* Match Loop */
> @@ -1940,8 +1958,11 @@ void ZSTD_compressBlock_lazy_generic(ZSTD_CCtx *ctx, const void *src, size_t src
>  		{
>  			size_t offsetFound = 99999999;
>  			size_t const ml2 = searchMax(ctx, ip, iend, &offsetFound, maxSearches, mls);
> -			if (ml2 > matchLength)
> -				matchLength = ml2, start = ip, offset = offsetFound;
> +			if (ml2 > matchLength) {
> +				matchLength = ml2;
> +				start = ip;
> +				offset = offsetFound;
> +			}
>  		}
>  
> 
>  		if (matchLength < EQUAL_READ32) {
> @@ -1957,8 +1978,11 @@ void ZSTD_compressBlock_lazy_generic(ZSTD_CCtx *ctx, const void *src, size_t src
>  					size_t const mlRep = ZSTD_count(ip + EQUAL_READ32, ip + EQUAL_READ32 - offset_1, iend) + EQUAL_READ32;
>  					int const gain2 = (int)(mlRep * 3);
>  					int const gain1 = (int)(matchLength * 3 - ZSTD_highbit32((U32)offset + 1) + 1);
> -					if ((mlRep >= EQUAL_READ32) && (gain2 > gain1))
> -						matchLength = mlRep, offset = 0, start = ip;
> +					if ((mlRep >= EQUAL_READ32) && (gain2 > gain1)) {
> +						matchLength = mlRep;
> +						offset = 0;
> +						start = ip;
> +					}
>  				}
>  				{
>  					size_t offset2 = 99999999;
> @@ -1966,7 +1990,7 @@ void ZSTD_compressBlock_lazy_generic(ZSTD_CCtx *ctx, const void *src, size_t src
>  					int const gain2 = (int)(ml2 * 4 - ZSTD_highbit32((U32)offset2 + 1)); /* raw approx */
>  					int const gain1 = (int)(matchLength * 4 - ZSTD_highbit32((U32)offset + 1) + 4);
>  					if ((ml2 >= EQUAL_READ32) && (gain2 > gain1)) {
> -						matchLength = ml2, offset = offset2, start = ip;
> +						matchLength = ml2, offset = offset2; start = ip;
>  						continue; /* search a better one */
>  					}
>  				}
> @@ -1978,8 +2002,11 @@ void ZSTD_compressBlock_lazy_generic(ZSTD_CCtx *ctx, const void *src, size_t src
>  						size_t const ml2 = ZSTD_count(ip + EQUAL_READ32, ip + EQUAL_READ32 - offset_1, iend) + EQUAL_READ32;
>  						int const gain2 = (int)(ml2 * 4);
>  						int const gain1 = (int)(matchLength * 4 - ZSTD_highbit32((U32)offset + 1) + 1);
> -						if ((ml2 >= EQUAL_READ32) && (gain2 > gain1))
> -							matchLength = ml2, offset = 0, start = ip;
> +						if ((ml2 >= EQUAL_READ32) && (gain2 > gain1)) {
> +							matchLength = ml2;
> +							offset = 0;
> +							start = ip;
> +						}
>  					}
>  					{
>  						size_t offset2 = 99999999;
> @@ -1987,7 +2014,7 @@ void ZSTD_compressBlock_lazy_generic(ZSTD_CCtx *ctx, const void *src, size_t src
>  						int const gain2 = (int)(ml2 * 4 - ZSTD_highbit32((U32)offset2 + 1)); /* raw approx */
>  						int const gain1 = (int)(matchLength * 4 - ZSTD_highbit32((U32)offset + 1) + 7);
>  						if ((ml2 >= EQUAL_READ32) && (gain2 > gain1)) {
> -							matchLength = ml2, offset = offset2, start = ip;
> +							matchLength = ml2, offset = offset2; start = ip;
>  							continue;
>  						}
>  					}
> @@ -2110,8 +2137,11 @@ void ZSTD_compressBlock_lazy_extDict_generic(ZSTD_CCtx *ctx, const void *src, si
>  		{
>  			size_t offsetFound = 99999999;
>  			size_t const ml2 = searchMax(ctx, ip, iend, &offsetFound, maxSearches, mls);
> -			if (ml2 > matchLength)
> -				matchLength = ml2, start = ip, offset = offsetFound;
> +			if (ml2 > matchLength) {
> +				matchLength = ml2;
> +				start = ip;
> +				offset = offsetFound;
> +			}
>  		}
>  
> 
>  		if (matchLength < EQUAL_READ32) {
> @@ -2138,8 +2168,11 @@ void ZSTD_compressBlock_lazy_extDict_generic(ZSTD_CCtx *ctx, const void *src, si
>  							    EQUAL_READ32;
>  							int const gain2 = (int)(repLength * 3);
>  							int const gain1 = (int)(matchLength * 3 - ZSTD_highbit32((U32)offset + 1) + 1);
> -							if ((repLength >= EQUAL_READ32) && (gain2 > gain1))
> -								matchLength = repLength, offset = 0, start = ip;
> +							if ((repLength >= EQUAL_READ32) && (gain2 > gain1)) {
> +								matchLength = repLength;
> +								offset = 0;
> +								start = ip;
> +							}
>  						}
>  				}
>  
> 
> @@ -2150,7 +2183,7 @@ void ZSTD_compressBlock_lazy_extDict_generic(ZSTD_CCtx *ctx, const void *src, si
>  					int const gain2 = (int)(ml2 * 4 - ZSTD_highbit32((U32)offset2 + 1)); /* raw approx */
>  					int const gain1 = (int)(matchLength * 4 - ZSTD_highbit32((U32)offset + 1) + 4);
>  					if ((ml2 >= EQUAL_READ32) && (gain2 > gain1)) {
> -						matchLength = ml2, offset = offset2, start = ip;
> +						matchLength = ml2, offset = offset2; start = ip;
>  						continue; /* search a better one */
>  					}
>  				}
> @@ -2173,8 +2206,11 @@ void ZSTD_compressBlock_lazy_extDict_generic(ZSTD_CCtx *ctx, const void *src, si
>  										   EQUAL_READ32;
>  								int gain2 = (int)(repLength * 4);
>  								int gain1 = (int)(matchLength * 4 - ZSTD_highbit32((U32)offset + 1) + 1);
> -								if ((repLength >= EQUAL_READ32) && (gain2 > gain1))
> -									matchLength = repLength, offset = 0, start = ip;
> +								if ((repLength >= EQUAL_READ32) && (gain2 > gain1)) {
> +									matchLength = repLength;
> +									offset = 0;
> +									start = ip;
> +								}
>  							}
>  					}
>  
> 
> @@ -2185,7 +2221,7 @@ void ZSTD_compressBlock_lazy_extDict_generic(ZSTD_CCtx *ctx, const void *src, si
>  						int const gain2 = (int)(ml2 * 4 - ZSTD_highbit32((U32)offset2 + 1)); /* raw approx */
>  						int const gain1 = (int)(matchLength * 4 - ZSTD_highbit32((U32)offset + 1) + 7);
>  						if ((ml2 >= EQUAL_READ32) && (gain2 > gain1)) {
> -							matchLength = ml2, offset = offset2, start = ip;
> +							matchLength = ml2, offset = offset2; start = ip;
>  							continue;
>  						}
>  					}
> @@ -3159,10 +3195,12 @@ static size_t ZSTD_compressStream_generic(ZSTD_CStream *zcs, void *dst, size_t *
>  				size_t cSize;
>  				size_t const iSize = zcs->inBuffPos - zcs->inToCompress;
>  				size_t oSize = oend - op;
> -				if (oSize >= ZSTD_compressBound(iSize))
> +				if (oSize >= ZSTD_compressBound(iSize)) {
>  					cDst = op; /* compress directly into output buffer (avoid flush stage) */
> -				else
> -					cDst = zcs->outBuff, oSize = zcs->outBuffSize;
> +				} else {
> +					cDst = zcs->outBuff;
> +					oSize = zcs->outBuffSize;
> +				}
>  				cSize = (flush == zsf_end) ? ZSTD_compressEnd(zcs->cctx, cDst, oSize, zcs->inBuff + zcs->inToCompress, iSize)
>  							   : ZSTD_compressContinue(zcs->cctx, cDst, oSize, zcs->inBuff + zcs->inToCompress, iSize);
>  				if (ZSTD_isError(cSize))
> @@ -3171,8 +3209,10 @@ static size_t ZSTD_compressStream_generic(ZSTD_CStream *zcs, void *dst, size_t *
>  					zcs->frameEnded = 1;
>  				/* prepare next block */
>  				zcs->inBuffTarget = zcs->inBuffPos + zcs->blockSize;
> -				if (zcs->inBuffTarget > zcs->inBuffSize)
> -					zcs->inBuffPos = 0, zcs->inBuffTarget = zcs->blockSize; /* note : inBuffSize >= blockSize */
> +				if (zcs->inBuffTarget > zcs->inBuffSize) {
> +					zcs->inBuffPos = 0;
> +					zcs->inBuffTarget = zcs->blockSize;
> +				} /* note : inBuffSize >= blockSize */
>  				zcs->inToCompress = zcs->inBuffPos;
>  				if (cDst == op) {
>  					op += cSize;
> diff --git a/lib/zstd/fse_compress.c b/lib/zstd/fse_compress.c
> index ef3d1741d532..99a21c35d0ac 100644
> --- a/lib/zstd/fse_compress.c
> +++ b/lib/zstd/fse_compress.c
> @@ -271,8 +271,10 @@ static size_t FSE_writeNCount_generic(void *header, size_t headerBufferSize, con
>  			previous0 = (count == 1);
>  			if (remaining < 1)
>  				return ERROR(GENERIC);
> -			while (remaining < threshold)
> -				nbBits--, threshold >>= 1;
> +			while (remaining < threshold) {
> +				nbBits--;
> +				threshold >>= 1;
> +			}
>  		}
>  		if (bitCount > 16) {
>  			if ((!writeIsSafe) && (out > oend - 2))
> @@ -569,8 +571,10 @@ static size_t FSE_normalizeM2(short *norm, U32 tableLog, const unsigned *count,
>  		   find max, then give all remaining points to max */
>  		U32 maxV = 0, maxC = 0;
>  		for (s = 0; s <= maxSymbolValue; s++)
> -			if (count[s] > maxC)
> -				maxV = s, maxC = count[s];
> +			if (count[s] > maxC) {
> +				maxV = s;
> +				maxC = count[s];
> +			}
>  		norm[maxV] += (short)ToDistribute;
>  		return 0;
>  	}
> @@ -578,8 +582,10 @@ static size_t FSE_normalizeM2(short *norm, U32 tableLog, const unsigned *count,
>  	if (total == 0) {
>  		/* all of the symbols were low enough for the lowOne or lowThreshold */
>  		for (s = 0; ToDistribute > 0; s = (s + 1) % (maxSymbolValue + 1))
> -			if (norm[s] > 0)
> -				ToDistribute--, norm[s]++;
> +			if (norm[s] > 0) {
> +				ToDistribute--;
> +				norm[s]++;
> +			}
>  		return 0;
>  	}
>  
> 
> @@ -644,8 +650,10 @@ size_t FSE_normalizeCount(short *normalizedCounter, unsigned tableLog, const uns
>  					U64 restToBeat = vStep * rtbTable[proba];
>  					proba += (count[s] * step) - ((U64)proba << scale) > restToBeat;
>  				}
> -				if (proba > largestP)
> -					largestP = proba, largest = s;
> +				if (proba > largestP) {
> +					largestP = proba;
> +					largest = s;
> +				}
>  				normalizedCounter[s] = proba;
>  				stillToDistribute -= proba;
>  			}
> diff --git a/lib/zstd/huf_compress.c b/lib/zstd/huf_compress.c
> index 08b4ae80aed4..ca12ab400086 100644
> --- a/lib/zstd/huf_compress.c
> +++ b/lib/zstd/huf_compress.c
> @@ -404,8 +404,10 @@ static void HUF_sort(nodeElt *huffNode, const U32 *count, U32 maxSymbolValue)
>  		U32 const c = count[n];
>  		U32 const r = BIT_highbit32(c + 1) + 1;
>  		U32 pos = rank[r].curr++;
> -		while ((pos > rank[r].base) && (c > huffNode[pos - 1].count))
> -			huffNode[pos] = huffNode[pos - 1], pos--;
> +		while ((pos > rank[r].base) && (c > huffNode[pos - 1].count)) {
> +			huffNode[pos] = huffNode[pos - 1];
> +			pos--;
> +		}
>  		huffNode[pos].count = c;
>  		huffNode[pos].byte = (BYTE)n;
>  	}


