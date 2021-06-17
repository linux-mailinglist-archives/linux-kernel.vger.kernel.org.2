Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAA43AB3E2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhFQMpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhFQMpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:45:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9547DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 05:43:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623933815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NDiqcX3hjmuHrdR2B6HQDfbpmIBfj2lJroimVBWNBd8=;
        b=zHCddwu8Tn8/peEenylmrHG1uSI1+c8bow9MwBDloxWt8gGRv9sCuGZGUbFQHSKcxsNRAq
        NGrIHKL6Dbd54UTZYiCvj1ksqI5LidO4eN17ukffugcNFmYJujP1ZVFic/aOlas5I1pgqb
        Z5B9MU6tEE69RRFjERbIVT5nzgV2Z26u4ahr0tYs1ekq0YgfK7EiatZ5er8B7k18ALL8ji
        16K5Jvlg9aKXBYr9bih04kinRp2cCpcwkRTyPW7dY6OvUJ2FFv3AO+uR1zkPj6s9FynAI8
        Cv/51S28Q2mG6EefMso9rT+LsFv4VrhzvJ/wyfrsYilRKjkk9Lnr0egrr0jQcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623933815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NDiqcX3hjmuHrdR2B6HQDfbpmIBfj2lJroimVBWNBd8=;
        b=gAiYI+Yrth4cyn31+02SjeBCfHMnMkeWUsvrT5YTZMe/aqpCxbi6W7JiXo32y0NeW62skI
        5e01Llbu6SCWx3BQ==
To:     Borislav Petkov <bp@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch V2 16/52] x86/fpu: Use copy_uabi_xstate_to_membuf() in fpregs_get()
In-Reply-To: <YMs3B6i6mK5F7+gd@zn.tnic>
References: <20210614154408.673478623@linutronix.de> <20210614155355.354479349@linutronix.de> <YMs3B6i6mK5F7+gd@zn.tnic>
Date:   Thu, 17 Jun 2021 14:43:35 +0200
Message-ID: <87tulwfyq0.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17 2021 at 13:50, Borislav Petkov wrote:
>> -	if (!boot_cpu_has(X86_FEATURE_FXSR)) {
>> +	if (!static_cpu_has(X86_FEATURE_FXSR)) {
>
> both: cpu_feature_enabled

I fixed up the whole series already :)
