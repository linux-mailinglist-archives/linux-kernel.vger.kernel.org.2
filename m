Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A700A36BC96
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 02:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbhD0AUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 20:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234700AbhD0AUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 20:20:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6842D61178;
        Tue, 27 Apr 2021 00:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1619482779;
        bh=fDEJVTUnri24E7Jrh06sk0QoFFdDc0lOuKpF38xaBIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X/6GdL0/Rgg9fAEYmiTXIB9D+9ercaOzhrjB/u+ZQBEhWuFiz1JUrwk4NWKcml7+c
         STEB8ib07nE7S1yB8Ha/XeboKDRvwyFdati/6pJbeQIt7ORQsyN0LlLHyCL/PRDkCr
         JA6iQg0hdaUEyDE3sKeUuXiIpmt+Td0dPDtvwNWQ=
Date:   Mon, 26 Apr 2021 17:19:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: wrong patch order
Message-Id: <20210426171938.60060f21f03963e2bf374e03@linux-foundation.org>
In-Reply-To: <20210426171451.GA133505@yury-ThinkPad>
References: <20210426171451.GA133505@yury-ThinkPad>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2021 10:14:51 -0700 Yury Norov <yury.norov@gmail.com> wrote:

> Hi Andrew,
> 
> In the next-20210426 I see the commit 7c3c0a5796a8 "h8300:
> rearrange headers inclusion order in asm/bitops" is applied after
> a54cbe7fa597 "lib: add fast path for find_next_*_bit()".
> 
> This may cause cause build failure for h8300 while bisecting.
> 
> Can you please change order of the patches so that 7c3c0a5796a8 would
> follow 68b80f24c2f6 "arch: rearrange headers inclusion order in
> asm/bitops for m68k and sh"? It's also possible to merge 7c3c0a5796a8
> and 68b80f24c2f6 because they address the same issue.

I renamed
lib-add-fast-path-for-find_first__bit-and-find_last_bit-fix.patch to
arch-rearrange-headers-inclusion-order-in-asm-bitops-for-m68k-and-sh-fix.patch
and queued it immediately after
arch-rearrange-headers-inclusion-order-in-asm-bitops-for-m68k-and-sh.patch,
as a fix against
arch-rearrange-headers-inclusion-order-in-asm-bitops-for-m68k-and-sh.patch,
to be folded into
arch-rearrange-headers-inclusion-order-in-asm-bitops-for-m68k-and-sh.patch

tools-disable-wno-type-limits.patch
tools-bitmap-sync-function-declarations-with-the-kernel.patch
tools-sync-bitmap_last_word_mask-macro-with-the-kernel.patch
arch-rearrange-headers-inclusion-order-in-asm-bitops-for-m68k-and-sh.patch
arch-rearrange-headers-inclusion-order-in-asm-bitops-for-m68k-and-sh-fix.patch
lib-extend-the-scope-of-small_const_nbits-macro.patch
tools-sync-small_const_nbits-macro-with-the-kernel.patch
lib-inline-_find_next_bit-wrappers.patch
tools-sync-find_next_bit-implementation.patch
lib-add-fast-path-for-find_next__bit.patch
lib-add-fast-path-for-find_first__bit-and-find_last_bit.patch
tools-sync-lib-find_bit-implementation.patch
maintainers-add-entry-for-the-bitmap-api.patch

