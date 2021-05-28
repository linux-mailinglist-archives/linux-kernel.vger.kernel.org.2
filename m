Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4082393EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhE1IZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:25:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39762 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbhE1IZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:25:17 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622190222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r27x5A/mW+JUIMBZzc/wmBulGC3zrTBxzCsoY6/3r4s=;
        b=CaizHuOU50Ys7mkc1GyyEVbbf60RsyWIDyNbQe7eXw0sa+wc8YVmxZ/f21vO7RAWT7+223
        zzugY05kdl1ajE6vFCZA6UJPZ5X4p6ApBurz3SdC3UT7LNEq9u5WhDnHkJz6j8nzWo57XH
        HMN4OL5NRxZTCGeyfPymCa8qYBGJlJwycYPAoDz9Dgk9U6LT5W9AqAHOv1PnAvhU3iITLV
        fLBioZw0tXrrwL4T4ZJLcQzlnXgzCmZ92JI4xYwo6l9c2rylo9OMZ4jy7FYQjeXn4jeHP8
        lwaoVKS80g9bxWlLWiU7SXCElO0V2UG0+oN8CW4NpT3KBRz9wFQcgDRjqFxNwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622190222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r27x5A/mW+JUIMBZzc/wmBulGC3zrTBxzCsoY6/3r4s=;
        b=yf4HRnTXpK4A8KWpLlZZImWwfkRaK+/mXlcyKIqd6s+sH37cH+f9x81fe9fWswy+ufmka9
        zl+mJ+5+rDvYGdBQ==
To:     Borislav Petkov <bp@alien8.de>
Cc:     Borislav Petkov <bp@suse.de>, James Feeney <james@nurealm.net>,
        linux-smp@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        x86-ml <x86@kernel.org>
Subject: Re: [PATCH] x86/thermal: Fix LVT thermal setup for SMI delivery mode
In-Reply-To: <YK/q4RyKhoqFM2nJ@zn.tnic>
References: <YKYqABhSTTUG8cgV@zn.tnic> <a264eaef-1c94-77e1-dfbf-e436a41588be@nurealm.net> <YKjJfu4kRDflQS5e@zn.tnic> <373464e3-b8a0-0fe0-b890-41df0eecf090@nurealm.net> <YKqLSqIM7Gi5x+IA@zn.tnic> <b550a241-2097-cf4b-cc41-e4d0a45cda72@nurealm.net> <YKtbBXZGpVZS1M4R@zn.tnic> <1f6c70f4-6680-d6ea-465a-548dc7698317@nurealm.net> <YK905sC/2cVOYo6I@zn.tnic> <87h7io8kh5.ffs@nanos.tec.linutronix.de> <YK/q4RyKhoqFM2nJ@zn.tnic>
Date:   Fri, 28 May 2021 10:23:42 +0200
Message-ID: <87mtsf6zch.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27 2021 at 20:54, Borislav Petkov wrote:
> On Thu, May 27, 2021 at 01:49:42PM +0200, Thomas Gleixner wrote:
>> Also if disabling this entry is causing the BIOS/SMM gunk to go south, then
>> disabling CONFIG_X86_THERMAL_VECTOR should have the same effect.
>
> Well, I believe the latter was practically impossible:
>
> config X86_THERMAL_VECTOR
> 	def_bool y
> 	depends on X86 && CPU_SUP_INTEL && X86_LOCAL_APIC

So you could disable CPU_SUP_INTEL ... Should still boot with reduced
functionality.

> so *if* the machine was sporting thermal SMI, then it very much needed
> that code in intel_init_thermal() to unstuck the cores. At least it
> looks that way...

What a mess...
