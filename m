Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C9C443970
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhKBXTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:19:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50955 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhKBXTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:19:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC71916B9D7;
        Tue,  2 Nov 2021 19:17:05 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=nXoR4EohZKa3PNqXvEx+YNoV8DLWN+Lc6JXmM8
        lobxQ=; b=LTTx3JjeC7nVp1pBT232FcEiybFfMKc1zdp92NHqXn1yh8bTJHulGy
        4Rh0ijszuI8WKhOyDXqhr6VgQZQYmS1r4WT/0RujoGKVAwtEOFb7JUsAZrWA4u3I
        Yjw3SbPgZXm/kwaWVe8AlceExI5x49w4mjKU1IejxoAt9RE2gTPkk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4C2916B9D6;
        Tue,  2 Nov 2021 19:17:05 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=nXoR4EohZKa3PNqXvEx+YNoV8DLWN+Lc6JXmM8lobxQ=; b=ehjT0mQHL34PeSbbA4sl+bF7IIkB6ZymilaJ1ov0YztUMYu/1W4u82m2rOWmeZLIfg1vRQOU9dZ+YB/+Cl/BuN4zEwPo1PDOz/xwagfNgQuiG+yS3lJqB1vDYToqoHaHngjgUcq6E0Z45f1S//niwak+QsPhNCDzmRRV1ny2TAU=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C843E16B9D4;
        Tue,  2 Nov 2021 19:17:01 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id C65FA2DA004D;
        Tue,  2 Nov 2021 19:16:59 -0400 (EDT)
Date:   Tue, 2 Nov 2021 19:16:59 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Jonathan Corbet <corbet@lwn.net>
cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/9] Remove unused header <linux/cnt32_to_63.h>
In-Reply-To: <20211102220203.940290-4-corbet@lwn.net>
Message-ID: <s9qss5o-3330-n3n3-no59-q9p5883o8o1@syhkavp.arg>
References: <20211102220203.940290-1-corbet@lwn.net> <20211102220203.940290-4-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: FC2B2EAC-3C32-11EC-83C5-F327CE9DA9D6-78420484!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Nov 2021, Jonathan Corbet wrote:

> Commit fb37409a01b0 ("arch: remove unicore32 port) deleted the last file
> that included <linux/cnt32_to_63.h>, but left that header file behind.
> Nothing uses it, delete it now.
> 
> Cc: Nicolas Pitre <npitre@baylibre.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> ---
>  include/linux/cnt32_to_63.h | 104 ------------------------------------
>  1 file changed, 104 deletions(-)
>  delete mode 100644 include/linux/cnt32_to_63.h
> 
> diff --git a/include/linux/cnt32_to_63.h b/include/linux/cnt32_to_63.h
> deleted file mode 100644
> index 064428479f2d..000000000000
> --- a/include/linux/cnt32_to_63.h
> +++ /dev/null
> @@ -1,104 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  Extend a 32-bit counter to 63 bits
> - *
> - *  Author:	Nicolas Pitre
> - *  Created:	December 3, 2006
> - *  Copyright:	MontaVista Software, Inc.
> - */
> -
> -#ifndef __LINUX_CNT32_TO_63_H__
> -#define __LINUX_CNT32_TO_63_H__
> -
> -#include <linux/compiler.h>
> -#include <linux/types.h>
> -#include <asm/byteorder.h>
> -
> -/* this is used only to give gcc a clue about good code generation */
> -union cnt32_to_63 {
> -	struct {
> -#if defined(__LITTLE_ENDIAN)
> -		u32 lo, hi;
> -#elif defined(__BIG_ENDIAN)
> -		u32 hi, lo;
> -#endif
> -	};
> -	u64 val;
> -};
> -
> -
> -/**
> - * cnt32_to_63 - Expand a 32-bit counter to a 63-bit counter
> - * @cnt_lo: The low part of the counter
> - *
> - * Many hardware clock counters are only 32 bits wide and therefore have
> - * a relatively short period making wrap-arounds rather frequent.  This
> - * is a problem when implementing sched_clock() for example, where a 64-bit
> - * non-wrapping monotonic value is expected to be returned.
> - *
> - * To overcome that limitation, let's extend a 32-bit counter to 63 bits
> - * in a completely lock free fashion. Bits 0 to 31 of the clock are provided
> - * by the hardware while bits 32 to 62 are stored in memory.  The top bit in
> - * memory is used to synchronize with the hardware clock half-period.  When
> - * the top bit of both counters (hardware and in memory) differ then the
> - * memory is updated with a new value, incrementing it when the hardware
> - * counter wraps around.
> - *
> - * Because a word store in memory is atomic then the incremented value will
> - * always be in synch with the top bit indicating to any potential concurrent
> - * reader if the value in memory is up to date or not with regards to the
> - * needed increment.  And any race in updating the value in memory is harmless
> - * as the same value would simply be stored more than once.
> - *
> - * The restrictions for the algorithm to work properly are:
> - *
> - * 1) this code must be called at least once per each half period of the
> - *    32-bit counter;
> - *
> - * 2) this code must not be preempted for a duration longer than the
> - *    32-bit counter half period minus the longest period between two
> - *    calls to this code;
> - *
> - * Those requirements ensure proper update to the state bit in memory.
> - * This is usually not a problem in practice, but if it is then a kernel
> - * timer should be scheduled to manage for this code to be executed often
> - * enough.
> - *
> - * And finally:
> - *
> - * 3) the cnt_lo argument must be seen as a globally incrementing value,
> - *    meaning that it should be a direct reference to the counter data which
> - *    can be evaluated according to a specific ordering within the macro,
> - *    and not the result of a previous evaluation stored in a variable.
> - *
> - * For example, this is wrong:
> - *
> - *	u32 partial = get_hw_count();
> - *	u64 full = cnt32_to_63(partial);
> - *	return full;
> - *
> - * This is fine:
> - *
> - *	u64 full = cnt32_to_63(get_hw_count());
> - *	return full;
> - *
> - * Note that the top bit (bit 63) in the returned value should be considered
> - * as garbage.  It is not cleared here because callers are likely to use a
> - * multiplier on the returned value which can get rid of the top bit
> - * implicitly by making the multiplier even, therefore saving on a runtime
> - * clear-bit instruction. Otherwise caller must remember to clear the top
> - * bit explicitly.
> - */
> -#define cnt32_to_63(cnt_lo) \
> -({ \
> -	static u32 __m_cnt_hi; \
> -	union cnt32_to_63 __x; \
> -	__x.hi = __m_cnt_hi; \
> - 	smp_rmb(); \
> -	__x.lo = (cnt_lo); \
> -	if (unlikely((s32)(__x.hi ^ __x.lo) < 0)) \
> -		__m_cnt_hi = __x.hi = (__x.hi ^ 0x80000000) + (__x.hi >> 31); \
> -	__x.val; \
> -})
> -
> -#endif
> -- 
> 2.31.1
> 
> 
