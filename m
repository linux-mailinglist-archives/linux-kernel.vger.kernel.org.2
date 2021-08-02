Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64FB3DD199
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 09:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhHBH6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 03:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232537AbhHBH6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 03:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627891117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lIN/txXSywnk/cxKQuSc+8OainBGlz8WJcUV6gIdz9Q=;
        b=A6gT3VpEEt2py+wYcF2WWne54o6T4Py1MgjNv325KTB4zwEso8F++eSrWXuOUrbYrvHhNk
        Pp2r+IWKT/Rm6qsNbia2NXS5pCToUEhx1FbNKgAE9pCLN+E5NKYKD5rsUADitpmqaLDrzz
        Y02VONpZZ0js+g6Hp/5l9WANfKIOaQA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-i40sSfiVPQCxhP-lExqbUA-1; Mon, 02 Aug 2021 03:58:35 -0400
X-MC-Unique: i40sSfiVPQCxhP-lExqbUA-1
Received: by mail-ej1-f70.google.com with SMTP id lu19-20020a170906fad3b029058768348f55so4361614ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 00:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lIN/txXSywnk/cxKQuSc+8OainBGlz8WJcUV6gIdz9Q=;
        b=tNhvBXNkBNq/wBZmk4yjxmb//t1u1EvAzgdOBjvIusmy6K+iTl29/uA3g3yiCguIeA
         xXCHBRHE35cru3UN01GSHWmIppxIYPsyeK6v913EcbwQXD3j2QaKsxRLxul/8kNC74iv
         I/9uNExk79T4ZjpAx97DcQzssUaQTkWrk2QXz+l4gCfc7mRurMqGN8LS1hS5HGGnb0dL
         /bCQsnV47GVoS5Cr5ClmPZKu+IFZKt4SJRTzqtIYF8tcHpRpuaJz5TfEiJxXya+zeAAY
         rvg6+EOcLBjDUJ6+WNXuzOxcbCvFXeHIqlDR78WJry4mGy2TRWNJH+ZHiHrVryXGtNb1
         r4Pw==
X-Gm-Message-State: AOAM530qzyVScBtMH/XE8Ft2II1pRMhhJWMXlJDyBfSpeKEHYugQpUyM
        pmrXaHax8KKip1pYKbcg3nb55DeR0W7Yw4G6Ub17TiZmdDBZQBm+lJ3ist+gdFXi8RxQVIi+Xg+
        GTQkKkXwNK5wbOvLOQNeIQLaG
X-Received: by 2002:a17:906:c08e:: with SMTP id f14mr14190024ejz.380.1627891114662;
        Mon, 02 Aug 2021 00:58:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd749wQ0qyrwQfxK6tvHsTGMJytAXV8uGx3Eoco/0erBXuJs8FPXLMIqaMrJ9W6ubS75TOkg==
X-Received: by 2002:a17:906:c08e:: with SMTP id f14mr14190020ejz.380.1627891114560;
        Mon, 02 Aug 2021 00:58:34 -0700 (PDT)
Received: from x1.bristot.me (host-95-239-202-226.retail.telecomitalia.it. [95.239.202.226])
        by smtp.gmail.com with ESMTPSA id c6sm4129953eje.105.2021.08.02.00.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 00:58:34 -0700 (PDT)
Subject: Re: [PATCH] trace: eradicate noisy warning in trace_osnoise.c
To:     Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20210731000055.28876-1-rdunlap@infradead.org>
 <20210730204050.46975ae2@oasis.local.home>
 <d4fdf5f0-ba3b-1260-b320-3045f218e6a6@infradead.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <f8d3b5d4-a539-8f47-eeb4-39b055f131e3@redhat.com>
Date:   Mon, 2 Aug 2021 09:58:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d4fdf5f0-ba3b-1260-b320-3045f218e6a6@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/21 3:11 AM, Randy Dunlap wrote:
> On 7/30/21 5:40 PM, Steven Rostedt wrote:
>> On Fri, 30 Jul 2021 17:00:55 -0700
>> Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>> OK, I'm officially tired of this noise warning coming from
>>> trace_osnoise.c, so shut it up. Also, adding new warnings is not OK.
>> I agree adding "new warnings" is not OK, but this is a stupid warning.
>>
>>> ../kernel/trace/trace_osnoise.c: In function ‘start_kthread’:
>>> ../kernel/trace/trace_osnoise.c:1461:8: warning: ‘main’ is usually a function [-Wmain]
>>>   void *main = osnoise_main;
>>>         ^~~~
>>>
>>> Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>>> ---
>>>  kernel/trace/Makefile |    2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> --- mmotm-2021-0728-1824.orig/kernel/trace/Makefile
>>> +++ mmotm-2021-0728-1824/kernel/trace/Makefile
>>> @@ -36,6 +36,8 @@ CFLAGS_bpf_trace.o := -I$(src)
>>>  CFLAGS_trace_benchmark.o := -I$(src)
>>>  CFLAGS_trace_events_filter.o := -I$(src)
>>>  
>>> +CFLAGS_trace_osnoise.o := -Wno-main
>> Why just add it here. It's a silly warning to have for the kernel at
>> all. Should this not be added in a more global place?
> I don't know of any other places that name something 'main' when it is
> not a main() function.
> 

I would say that we either use -Wno-main for the entire kernel or rename the
main variable to tracer_main....

-- Daniel

