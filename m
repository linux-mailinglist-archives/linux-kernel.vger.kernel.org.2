Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A183A4A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 22:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhFKU3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 16:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhFKU3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 16:29:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE89C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 13:27:23 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623443242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lF71zDQCkK8xMRQ3oGFHi2IwA2oSbk34KX9t6lqfVa4=;
        b=YaT/N8WeoD3lHXWFDNfnUuwjDBP+WV51Ga/hb8FwhCL6ot/+gYWlRTKSzEya15Uks0gLNW
        Fru0Bbe2cBSPgWS0f9E9zIZkVUI6mxlxlYMEW67EulJXUxPgf9EC4TjLOEyydj73eLSj57
        Wy2dKX3VqR0VOqfkhJYrZzjcTMF8mvDizgcEuEQ04zFQBpXeAGa5ft2DTUtKRPy5EGJfZb
        9tjdYY9il/UhV4YiHNYwGjBtUV9C0mBOK+XZvl+ecWVWbXRlxrW0NY21wbRMVgBWdq5b9B
        MdNqKpgdMUFnhFh8OQAwhc5G6Z0KnM5wEeDm2jhiryCEflj3BHGK13onz2LMew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623443242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lF71zDQCkK8xMRQ3oGFHi2IwA2oSbk34KX9t6lqfVa4=;
        b=lSfY26TtcInofABZGWXPt/4YHo+23S/96714b+Jp3488PbZniT/bIE8rtT4umZsM2U2bQZ
        O3dGk3tHLC96qMBQ==
To:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch 08/41] x86/fpu: Restrict fpstate sanitizing to legacy components
In-Reply-To: <2be2ef6c-fcb8-46cf-976c-2b3a9537b660@kernel.org>
References: <20210611161523.508908024@linutronix.de> <20210611163111.820639606@linutronix.de> <2be2ef6c-fcb8-46cf-976c-2b3a9537b660@kernel.org>
Date:   Fri, 11 Jun 2021 22:27:22 +0200
Message-ID: <87h7i4w3it.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11 2021 at 12:03, Andy Lutomirski wrote:
> On 6/11/21 9:15 AM, Thomas Gleixner wrote:
>> xstateregs_get() does not longer use fpstate_sanitize_xstate() and the only
>> +/*
>> + * When executing XSAVEOPT (or other optimized XSAVE instructions), if
>
> The kernel doesn't use XSAVEOPT any more.  How about:

You sure? 

#define XSTATE_XSAVE(st, lmask, hmask, err)				\
	asm volatile(ALTERNATIVE_2(XSAVE,				\
				   XSAVEOPT, X86_FEATURE_XSAVEOPT,	\
				   XSAVES,   X86_FEATURE_XSAVES)	\
Thanks,

        tglx


