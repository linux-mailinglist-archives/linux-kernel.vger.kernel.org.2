Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AC43BA303
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 18:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhGBQEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 12:04:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58134 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhGBQEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 12:04:38 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3DD471FD5F;
        Fri,  2 Jul 2021 16:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625241725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mn/Q5DnYVnGbHSUU+dDhYEqrq1Gh81h6FIe/TRPg10c=;
        b=LwAC5KtDQCQnhV/fxBVCc7B10x0FpbMdkvDDvWeSeEBOtjAnC1S1kB2ccwrWwjFsUXFZBF
        /1tufJWvHLUpMvn83XLzqfHteJN6YLApcYEnqXruaIAUVsWgGUU+0Lfqk6vDpiCWF9oZdB
        UU0f7dUHKORVdwK9lOvZmka4CHNPzOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625241725;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mn/Q5DnYVnGbHSUU+dDhYEqrq1Gh81h6FIe/TRPg10c=;
        b=h/W8bkL+hvjsob7hcBrGbLhVwNXIG0Ckrbpf2faY0AsNkYN2foxVCyJdbTudoEeIf4fKgu
        GZVvsuVgvrtZPjAQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id AF9B411C84;
        Fri,  2 Jul 2021 16:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625241725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mn/Q5DnYVnGbHSUU+dDhYEqrq1Gh81h6FIe/TRPg10c=;
        b=LwAC5KtDQCQnhV/fxBVCc7B10x0FpbMdkvDDvWeSeEBOtjAnC1S1kB2ccwrWwjFsUXFZBF
        /1tufJWvHLUpMvn83XLzqfHteJN6YLApcYEnqXruaIAUVsWgGUU+0Lfqk6vDpiCWF9oZdB
        UU0f7dUHKORVdwK9lOvZmka4CHNPzOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625241725;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mn/Q5DnYVnGbHSUU+dDhYEqrq1Gh81h6FIe/TRPg10c=;
        b=h/W8bkL+hvjsob7hcBrGbLhVwNXIG0Ckrbpf2faY0AsNkYN2foxVCyJdbTudoEeIf4fKgu
        GZVvsuVgvrtZPjAQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id WmFpKHw432AfFQAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Fri, 02 Jul 2021 16:02:04 +0000
Subject: Re: [PATCH] mm/slub: use stackdepot to save stack trace in objects
To:     Guenter Roeck <linux@roeck-us.net>, glittao@gmail.com,
        Alexander Potapenko <glider@google.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210414163434.4376-1-glittao@gmail.com>
 <20210702153703.GA3074165@roeck-us.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <6dc3360d-4295-e3ec-0f92-40ee25e45c21@suse.cz>
Date:   Fri, 2 Jul 2021 18:01:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210702153703.GA3074165@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/21 5:37 PM, Guenter Roeck wrote:
> Hi,
> 
> On Wed, Apr 14, 2021 at 06:34:34PM +0200, glittao@gmail.com wrote:
>> From: Oliver Glitta <glittao@gmail.com>
>>
>> Many stack traces are similar so there are many similar arrays.
>> Stackdepot saves each unique stack only once.
>>
>> Replace field addrs in struct track with depot_stack_handle_t handle.
>> Use stackdepot to save stack trace.
>>
>> The benefits are smaller memory overhead and possibility to aggregate
>> per-cache statistics in the future using the stackdepot handle
>> instead of matching stacks manually.
>>
>> Signed-off-by: Oliver Glitta <glittao@gmail.com>
> 
> With arcv2:allnoconfig, this patch results in:
> 
> Building arcv2:allnoconfig ... failed
> --------------
> Error log:
> arc-elf-ld: lib/stackdepot.o: in function `filter_irq_stacks':
> stackdepot.c:(.text+0x43a): undefined reference to `__irqentry_text_start'
> arc-elf-ld: stackdepot.c:(.text+0x43a): undefined reference to `__irqentry_text_start'
> arc-elf-ld: stackdepot.c:(.text+0x45a): undefined reference to `__irqentry_text_end'
> arc-elf-ld: stackdepot.c:(.text+0x45a): undefined reference to `__irqentry_text_end'
> arc-elf-ld: stackdepot.c:(.text+0x468): undefined reference to `__softirqentry_text_start'
> arc-elf-ld: stackdepot.c:(.text+0x468): undefined reference to `__softirqentry_text_start'
> arc-elf-ld: stackdepot.c:(.text+0x470): undefined reference to `__softirqentry_text_end'
> arc-elf-ld: stackdepot.c:(.text+0x470): undefined reference to `__softirqentry_text_end'

Looks to me this patch exposed an existing problem in stackdepot that's
a result of 505a0ef15f96c "kasan: stackdepot: move filter_irq_stacks()
to stackdepot.c". Looks like that commit added the necessary symbols to
a number of arch's vmlinux.lds.S but not arcv2. Alexander?

What the slub patch does is just to have stackdepot built when
SLUB_DEBUG is enabled:

select STACKDEPOT if STACKTRACE_SUPPORT

But that was already possible with PAGE_OWNER:

config PAGE_OWNER
    depends on DEBUG_KERNEL && STACKTRACE_SUPPORT
    select STACKDEPOT

AFAICS there's nothing to prevent this config on arcv2.
We could perhaps exclude arcv2 but maybe it's easier just to fix up
505a0ef15f96c there?



> 
> Guenter
> 
> ---
> # bad: [fb0ca446157a86b75502c1636b0d81e642fe6bf1] Add linux-next specific files for 20210701
> # good: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
> git bisect start 'HEAD' 'v5.13'
> # good: [f63c4fda987a19b1194cc45cb72fd5bf968d9d90] Merge remote-tracking branch 'rdma/for-next'
> git bisect good f63c4fda987a19b1194cc45cb72fd5bf968d9d90
> # good: [49c8769be0b910d4134eba07cae5d9c71b861c4a] Merge remote-tracking branch 'drm/drm-next'
> git bisect good 49c8769be0b910d4134eba07cae5d9c71b861c4a
> # good: [3b858fe26f206d3c65adfc06c4db473e2dcaacd2] Merge remote-tracking branch 'char-misc/char-misc-next'
> git bisect good 3b858fe26f206d3c65adfc06c4db473e2dcaacd2
> # good: [b7289b49bb2edbe261f3f9a554f02996a4d12c11] Merge remote-tracking branch 'cgroup/for-next'
> git bisect good b7289b49bb2edbe261f3f9a554f02996a4d12c11
> # good: [20bf25c2b863e97a2724092c234e1ce892f83e5c] Merge remote-tracking branch 'pwm/for-next'
> git bisect good 20bf25c2b863e97a2724092c234e1ce892f83e5c
> # good: [1446f64f402a42c74c60df7f255df666fe302412] linux-next-pre
> git bisect good 1446f64f402a42c74c60df7f255df666fe302412
> # good: [312d598a2ea9e0927c3ec1decf24d4f3693e06f1] Merge remote-tracking branch 'mhi/mhi-next'
> git bisect good 312d598a2ea9e0927c3ec1decf24d4f3693e06f1
> # good: [d266180aa2811c7b6a8cf3c44e40a8f02a543a23] Merge remote-tracking branch 'cxl/next'
> git bisect good d266180aa2811c7b6a8cf3c44e40a8f02a543a23
> # bad: [8cf245ab25c7db5c10e7f63dcff2ccf09ade5880] sh: convert to setup_initial_init_mm()
> git bisect bad 8cf245ab25c7db5c10e7f63dcff2ccf09ade5880
> # bad: [125069500be687630bcfe6daa80f5408912fc3ef] mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas-fix
> git bisect bad 125069500be687630bcfe6daa80f5408912fc3ef
> # good: [c6c08f08ff06799b2c84e2a6a6258537a323d584] hexagon: use common DISCARDS macro
> git bisect good c6c08f08ff06799b2c84e2a6a6258537a323d584
> # bad: [e50e7ac989f6c658fd7b28b14274ae230825b1f9] mm/slub: use stackdepot to save stack trace in objects-fix
> git bisect bad e50e7ac989f6c658fd7b28b14274ae230825b1f9
> # bad: [d1be1dcc08d3ba68331dd47cfdea155f016c79db] mm/slub: use stackdepot to save stack trace in objects
> git bisect bad d1be1dcc08d3ba68331dd47cfdea155f016c79db
> # good: [8bf985a45ac528b6bcfbbdec4c3c263240b34264] hexagon: select ARCH_WANT_LD_ORPHAN_WARN
> git bisect good 8bf985a45ac528b6bcfbbdec4c3c263240b34264
> # first bad commit: [d1be1dcc08d3ba68331dd47cfdea155f016c79db] mm/slub: use stackdepot to save stack trace in objects
> 

