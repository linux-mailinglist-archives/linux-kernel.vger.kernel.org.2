Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272F43DE4F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 06:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhHCENt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 00:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhHCENp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 00:13:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E4DC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 21:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=zR/fDV6RTv39eclNFdg9T86KtEEeDwmWabiFGGqrDlc=; b=AzpxZVQnazaEzqO8kQwwXIn9XM
        nszJrpJTZ/LjbvAtkY4iYEZabE22DV+NkSW4vecls8VHHQtFPK7wp/mekj37yuiK4Wvcp0HIHY5fW
        W9NKnZUOguQBDtQUCXlKpynbR+zHXLBpTMR6ZWjj6/dxrcq65nZ/1y/hAusCageCl7UUhgZwJExaR
        vHsJOLruFAleRlcw5nvDW9E0lwmGoxF2Ruthwwsiz510z1kajE4/VcDIkJB5QAEX/+Xk8VugxbcZ6
        ECa/SrKXAJOdwqAc+5Ylt7dhC3b4xy0XErICT2SJaUFXIQK+UOIqiYFEdFq4Gk97UNPq9+N2LS/bI
        J2+nvKbw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAlnX-005Ixc-4u; Tue, 03 Aug 2021 04:13:17 +0000
Subject: Re: [PATCH] trace: eradicate noisy warning in trace_osnoise.c
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20210731000055.28876-1-rdunlap@infradead.org>
 <20210730204050.46975ae2@oasis.local.home>
 <d4fdf5f0-ba3b-1260-b320-3045f218e6a6@infradead.org>
 <f8d3b5d4-a539-8f47-eeb4-39b055f131e3@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eb82accb-442f-7d93-65f1-a6c34b9a4431@infradead.org>
Date:   Mon, 2 Aug 2021 21:12:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f8d3b5d4-a539-8f47-eeb4-39b055f131e3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/21 12:58 AM, Daniel Bristot de Oliveira wrote:
> On 7/31/21 3:11 AM, Randy Dunlap wrote:
>> On 7/30/21 5:40 PM, Steven Rostedt wrote:
>>> On Fri, 30 Jul 2021 17:00:55 -0700
>>> Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>>> OK, I'm officially tired of this noise warning coming from
>>>> trace_osnoise.c, so shut it up. Also, adding new warnings is not OK.
>>> I agree adding "new warnings" is not OK, but this is a stupid warning.
>>>
>>>> ../kernel/trace/trace_osnoise.c: In function ‘start_kthread’:
>>>> ../kernel/trace/trace_osnoise.c:1461:8: warning: ‘main’ is usually a function [-Wmain]
>>>>    void *main = osnoise_main;
>>>>          ^~~~
>>>>
>>>> Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>>>> ---
>>>>   kernel/trace/Makefile |    2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> --- mmotm-2021-0728-1824.orig/kernel/trace/Makefile
>>>> +++ mmotm-2021-0728-1824/kernel/trace/Makefile
>>>> @@ -36,6 +36,8 @@ CFLAGS_bpf_trace.o := -I$(src)
>>>>   CFLAGS_trace_benchmark.o := -I$(src)
>>>>   CFLAGS_trace_events_filter.o := -I$(src)
>>>>   
>>>> +CFLAGS_trace_osnoise.o := -Wno-main
>>> Why just add it here. It's a silly warning to have for the kernel at
>>> all. Should this not be added in a more global place?
>> I don't know of any other places that name something 'main' when it is
>> not a main() function.
>>
> 
> I would say that we either use -Wno-main for the entire kernel or rename the
> main variable to tracer_main....

I'm OK with the latter...

thanks.

