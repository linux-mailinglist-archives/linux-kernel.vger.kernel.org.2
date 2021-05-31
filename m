Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D533966C2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhEaRUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:20:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48756 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232715AbhEaRUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:20:09 -0400
Received: from zn.tnic (p200300ec2f080f00c524a4d22cb87212.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:f00:c524:a4d2:2cb8:7212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E2CF11EC0589;
        Mon, 31 May 2021 19:18:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622481503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Izzz+MpnHaHiczxXxkzMFrftlLiyI7UtOOQBxR+8pYc=;
        b=ClHGdnkHlbDM5buNWj/jtuAHzExgHtyWWWw/Si9+MHLeLfd8UWeWiyPk0d0AKRdETU7NbR
        tfknJ7+dEzxdzkEJm9KkDXJ3abSsdtf4qjlUJqkb24vM01I9tmwVldMIPd5E93e881QzcY
        gP8e2z5RbsbzPmaUlC8swKUdw/h7dC8=
Date:   Mon, 31 May 2021 19:18:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Pu Wen <puwen@hygon.cn>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] perf/x86/rapl: Use CPUID bit on AMD and Hygon parts
Message-ID: <YLUaWKSjwDbUDHFO@zn.tnic>
References: <20210514135920.16093-1-andrew.cooper3@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210514135920.16093-1-andrew.cooper3@citrix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 02:59:20PM +0100, Andrew Cooper wrote:
> diff --git a/arch/x86/kernel/cpu/powerflags.c b/arch/x86/kernel/cpu/powerflags.c
> index fd6ec2aa0303..e2055f51342e 100644
> --- a/arch/x86/kernel/cpu/powerflags.c
> +++ b/arch/x86/kernel/cpu/powerflags.c
> @@ -21,4 +21,6 @@ const char *const x86_power_flags[32] = {
>  	"eff_freq_ro", /* Readonly aperf/mperf */
>  	"proc_feedback", /* processor feedback interface */
>  	"acc_power", /* accumulated power mechanism */
> +	"conn_standby", /* Connected Standby */
> +	"rapl", /* Runtime Average Power Limit */

Yeah, so this repeats the "rapl" bit and that "conn_standby" is probably
not gonna be used. Unless you have a really good reason to add that
hunk, I'll whack it before applying and let this "power management"
thing in /proc/cpuinfo die unchanged.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
