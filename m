Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C543F3EE1F5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 03:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbhHQBGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 21:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233201AbhHQBGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:06:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BCB060E52;
        Tue, 17 Aug 2021 01:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1629162333;
        bh=FaZD2xXlHilIQhZTMiC/mFOYgZKBVf/1Ng1NrJcMgxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RMntPHMeRK6jJktTJrprZQVk5K5yHs+NsgfaHIxe8naVqt9vFhL7lS9yZOe05m8YR
         qOWABudrZ7cwxS8TIkRTODLQDmJWI4tU/Suq2L1KWDFkn8j5DajSXaIW7dpXjRip3W
         4gH8foMFBFZ2TkYrgdvCYSbyU70h4P7KwP+zL97U=
Date:   Mon, 16 Aug 2021 18:05:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        terrelln@fb.com
Subject: Re: [PATCH] lib/zstd: Fix bitwise vs logical operators
Message-Id: <20210816180532.6e85c93f84d62dc720d21178@linux-foundation.org>
In-Reply-To: <20210815004154.1781834-1-nathan@kernel.org>
References: <20210815004154.1781834-1-nathan@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Aug 2021 17:41:54 -0700 Nathan Chancellor <nathan@kernel.org> wrote:

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
> ...
>
> --- a/lib/zstd/compress.c
> +++ b/lib/zstd/compress.c
> @@ -1040,7 +1040,7 @@ void ZSTD_compressBlock_fast_generic(ZSTD_CCtx *cctx, const void *src, size_t sr
>  		const BYTE *match = base + matchIndex;
>  		hashTable[h] = curr; /* update hash table */
>  
> -		if ((offset_1 > 0) & (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) {
> +		if ((offset_1 > 0) && (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) {

yeah, this is a late night party trick which is sometimes used to
attempt to speed things up by avoiding a branch.  It is perhaps
beneficial if the LHS is almost always true.  I guess.

I'd prefer that the code not do this - it's silly, looks wrong and I
bet it's unmeasurable.

But I think this code is supposed to be kept in sync with an
out-of-tree upstream version so this change might be problematic.

Dunno, let's see what Nick thinks.

