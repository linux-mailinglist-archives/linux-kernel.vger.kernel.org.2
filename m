Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D81342FAC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 22:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhCTVbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 17:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhCTVbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 17:31:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C25CC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 14:31:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616275874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G6fF1chc7bjX4Ecz9X9+bICLN58dtntYbS/G/C+9MRg=;
        b=V+RdaibWq5XNe7LQkTkpSd6N7pzbNDxWQDNyV+ZYtM5TisWioJYraMn5HB8m/9DJCoUjAn
        uBlauX+WSvJwm2npzoKPtS2UNsw9JIm2Tmgdj3KucHRBlS3liboW0l0nJdZAJKP3TVXuaW
        1lPbCSiKvAXwV0mOvb/3vWflBix2YYabb4GkG+eZ3kID65h/zBqwIAc/dlu/mpGQbc2LAN
        Ke2xqGEshlXT3VtRwYcf0E8eP0n/ctVfqfL5rKhFzu+xdJ3f0PpNOlbIb0vuT2wKIFSGb1
        +oHpoUxNOpHD0IICq5AwVyyIdvUa2AFMfynVCQyJ+TWQwcpOoWnA8SsjYtXEJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616275874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G6fF1chc7bjX4Ecz9X9+bICLN58dtntYbS/G/C+9MRg=;
        b=ODHRC7RRNAvmRJO0zUa5MIc8q8m+n6Qc8c13PFVCsOJr2mIlfyItK5+gKZC6Saj/Yl3TU6
        wL3OqLinlngA4MAg==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v4 18/22] x86/fpu/amx: Define AMX state components and have it used for boot-time checks
In-Reply-To: <20210221185637.19281-19-chang.seok.bae@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com> <20210221185637.19281-19-chang.seok.bae@intel.com>
Date:   Sat, 20 Mar 2021 22:31:14 +0100
Message-ID: <87sg4pa4wt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21 2021 at 10:56, Chang S. Bae wrote:
>  
> +static void check_xtile_data_against_struct(int size)
> +{
> +	u32 max_palid, palid, state_size;
> +	u32 eax, ebx, ecx, edx;
> +	u16 max_tile;
> +
> +	/*
> +	 * Check the maximum palette id:
> +	 *   eax: the highest numbered palette subleaf.
> +	 */
> +	cpuid_count(TILE_CPUID, 0, &max_palid, &ebx, &ecx, &edx);
> +
> +	/*
> +	 * Cross-check each tile size and find the maximum
> +	 * number of supported tiles.
> +	 */
> +	for (palid = 1, max_tile = 0; palid <= max_palid; palid++) {
> +		u16 tile_size, max;
> +
> +		/*
> +		 * Check the tile size info:
> +		 *   eax[31:16]:  bytes per title
> +		 *   ebx[31:16]:  the max names (or max number of tiles)
> +		 */
> +		cpuid_count(TILE_CPUID, palid, &eax, &ebx, &edx, &edx);
> +		tile_size = eax >> 16;
> +		max = ebx >> 16;
> +
> +		if (WARN_ONCE(tile_size != sizeof(struct xtile_data),
> +			      "%s: struct is %zu bytes, cpu xtile %d bytes\n",
> +			      __stringify(XFEATURE_XTILE_DATA),
> +			      sizeof(struct xtile_data), tile_size))
> +			__xstate_dump_leaves();
> +
> +		if (max > max_tile)
> +			max_tile = max;
> +	}
> +
> +	state_size = sizeof(struct xtile_data) * max_tile;
> +	if (WARN_ONCE(size != state_size,
> +		      "%s: calculated size is %u bytes, cpu state %d bytes\n",
> +		      __stringify(XFEATURE_XTILE_DATA), state_size, size))
> +		__xstate_dump_leaves();

So we have 2 warnings which complain about inconsistent state and that's
it? Why has this absolutely no consequences? We just keep stuff enabled
and jug along, right?

Which one of the two states is correct? Why don't we just disable that
muck and be done with it to play it safe?

Failing to execute some workload by saying NO due to inconsistency is
far more useful than taking the chance of potential silent data
corruption.

Thanks,

        tglx
