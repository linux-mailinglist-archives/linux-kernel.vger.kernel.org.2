Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD573DC23C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 03:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhGaBMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 21:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhGaBME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 21:12:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010BCC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 18:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=NgYJFFWzUHM3zcEoA5gx+sVNg6nWN0rmXGQDCj9xjk8=; b=SmZVZTm/nxNdfBTgTEe2jPNb1/
        FXKfdjYFGpgr9VbhExls1PqzUvBzHqQ2Msh2438krx7WENxexT3vDyn9nGNBZMP83qBuCubu/paey
        KuUX01mjn/9cqnuw+guQzhZUSVBKjSdrD5cPuQUhWuztvMJSFTNZ4fMOH3kr8zRyAMbs51XO300q9
        XInKddH6EHajvJCJJzvWLWMe5r8GFYrc7DGqBD6oBCOt8SLY6VUG1qEcWeoHefk82CNKntND0zuKH
        eigK3EkUqbpd74nTAz++gSVhYDuoOgrH6Kk3VMDcxqndmhhKj4kkjBH8/hZYPwQ6ppe4JbYZ+1gMA
        ABMzZQkw==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9dXf-00AgER-A0; Sat, 31 Jul 2021 01:11:55 +0000
Subject: Re: [PATCH] trace: eradicate noisy warning in trace_osnoise.c
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <20210731000055.28876-1-rdunlap@infradead.org>
 <20210730204050.46975ae2@oasis.local.home>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d4fdf5f0-ba3b-1260-b320-3045f218e6a6@infradead.org>
Date:   Fri, 30 Jul 2021 18:11:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210730204050.46975ae2@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/21 5:40 PM, Steven Rostedt wrote:
> On Fri, 30 Jul 2021 17:00:55 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> OK, I'm officially tired of this noise warning coming from
>> trace_osnoise.c, so shut it up. Also, adding new warnings is not OK.
> 
> I agree adding "new warnings" is not OK, but this is a stupid warning.
> 
>>
>> ../kernel/trace/trace_osnoise.c: In function ‘start_kthread’:
>> ../kernel/trace/trace_osnoise.c:1461:8: warning: ‘main’ is usually a function [-Wmain]
>>   void *main = osnoise_main;
>>         ^~~~
>>
>> Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>> ---
>>  kernel/trace/Makefile |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> --- mmotm-2021-0728-1824.orig/kernel/trace/Makefile
>> +++ mmotm-2021-0728-1824/kernel/trace/Makefile
>> @@ -36,6 +36,8 @@ CFLAGS_bpf_trace.o := -I$(src)
>>  CFLAGS_trace_benchmark.o := -I$(src)
>>  CFLAGS_trace_events_filter.o := -I$(src)
>>  
>> +CFLAGS_trace_osnoise.o := -Wno-main
> 
> Why just add it here. It's a silly warning to have for the kernel at
> all. Should this not be added in a more global place?

I don't know of any other places that name something 'main' when it is
not a main() function.

> -- Steve
> 
> 
>> +
>>  obj-$(CONFIG_TRACE_CLOCK) += trace_clock.o
>>  
>>  obj-$(CONFIG_FUNCTION_TRACER) += libftrace.o
> 


-- 
~Randy

