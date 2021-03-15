Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD70233C19F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhCOQYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbhCOQXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:23:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59745C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:23:36 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07860038c86f91a939db76.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:8600:38c8:6f91:a939:db76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE36F1EC0288;
        Mon, 15 Mar 2021 17:23:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615825415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=g+S/fbiq14lNgn6xG9TY2RRVc+ITdOAyAgcE+h1o268=;
        b=EQ8BIiVtuT62/d8/ztw+ra5rPwsCkR5VArVUSjrADV8a4CaNhmSGZDbddHZxPh8XH16foP
        jXkgo4siSfWD2JS4AKxwvm9Ts37aHjauJWpadgc3xLa3MK3DALaN1CwHP19+rO+C6sCgaY
        ksvKG5Ps4xJz2a4z3fJts7wJwXzFeVw=
Date:   Mon, 15 Mar 2021 17:23:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, tony.luck@intel.com,
        "Liang, Kan" <kan.liang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: Resort and comment Intel models
Message-ID: <20210315162338.GF20497@zn.tnic>
References: <YE+HhS8i0gshHD3W@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YE+HhS8i0gshHD3W@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 05:12:53PM +0100, Peter Zijlstra wrote:
> 
> The INTEL_FAM6 list has become a mess again. Try and bring some sanity
> back into it.
> 
> Where previously we had one microarch per year and a number of SKUs
> within that, this no longer seems to be the case. We now get dfferent

"different"

> uarch names that share a 'core' design.

Soon it'll be all an unrecognizable mess with IP blocks tetris. :-)

> Add the core name starting at skylake and reorder to keep the cores in
> chronological order. Furthermore, Intel marketed the names {Amber,
> Coffee, Whiskey} Lake, but those are in fact steppings of Kaby Lake, add
> comments for them.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> Note: we don't seem to have CANNONLAKE perf support.
> 
>  arch/x86/include/asm/intel-family.h | 50 +++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 22 deletions(-)

Anything that helps clear more of this names confusion:

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
