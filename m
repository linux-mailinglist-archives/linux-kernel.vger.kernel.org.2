Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31AD309519
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 13:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhA3MbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 07:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhA3MbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 07:31:09 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0FFC061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 04:30:29 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id kx7so7200426pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 04:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NwzQouq4wLhBg31vxb6TOAhOsYgc86R3TJHjUdQCgb0=;
        b=aHxEk3rd9Qj8rE4OQcZVBVrEnXjc/D7+4PxrVI4HwWVq44KPjBkPxztBmQmt7R4pGY
         M+hyw/VTsI1JBNQqaqgZH9l4/pufQUUB4paOhd14GlaFvZy4NvZBFUKC37f8JjsiG1uv
         Xpel/cfyW4t7ecuEvWYQ7xobHikLAMxKWT4d/5nNQKohORQr/ckWgcMNSZ7jjHtzM59Q
         08pv3HR1m5FVduPMYq9CbwIpxrGKkj3pY/v54skTSIro5lMAxR0/4dD8Gv7OzcGwGZ1Y
         2Wakpu/FVxSQto2qRaMuV3iGwUBppcN/r3iS6McJzTXEUWReW9pcEw9soEzds2k1obiG
         pDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NwzQouq4wLhBg31vxb6TOAhOsYgc86R3TJHjUdQCgb0=;
        b=kVqNiQBrKY/UQ1umM0QG4N6wknxbuab3CmxxrLPHR7QoxIQCvE5edyDc1rCjBF4CS0
         vBxtRQm6r9MXrVBvCuT8Le6ok8pQ/ywXxYc3+URYAhc2Wak50TEBrcerDI2+5CSI+OtS
         RWA113fnJQ8iIuatdf8fuJxCGso/JlTBOdoDwu9uDNVV2/593JEP2ukXBdGmPq+mN0IP
         UNeMvsz7hbu8ZOFkBx7Y97sMtXqA4f41T2KV5INe6PHdsmyy15cnyslHIbbKIX7fzGbC
         L650+NLwSUnpFpCWMGjh8oDqi7/K1qNta9ekfbwvlJe2OSTtVrzU2lmxI1NRKlQgkN5G
         /Cpw==
X-Gm-Message-State: AOAM530LmxbtIaNYsjcAdXx3+dOyYIstyoNtNebEZwJ86JHBm8vv88dO
        Ti+RIPJxBqzCnp3WapSZ6zOdHA==
X-Google-Smtp-Source: ABdhPJwRSH4lAxG6I42j7tdUsKdfBncPzgnRMlML5jH0T23wcMonoqxDFIqUnlDj8T7jGNFaSJv+HA==
X-Received: by 2002:a17:90a:d02:: with SMTP id t2mr8645860pja.130.1612009828434;
        Sat, 30 Jan 2021 04:30:28 -0800 (PST)
Received: from [192.168.10.23] (124-171-107-241.dyn.iinet.net.au. [124.171.107.241])
        by smtp.gmail.com with UTF8SMTPSA id z2sm2209094pfa.121.2021.01.30.04.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 04:30:27 -0800 (PST)
Subject: Re: [PATCH v5] tracepoint: Do not fail unregistering a probe due to
 memory failure
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matt Mullins <mmullins@mmlx.us>, paulmck <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
References: <20210127170721.58bce7cc@gandalf.local.home>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <ac000ed4-3eeb-60df-f896-c05cabb4c1c9@ozlabs.ru>
Date:   Sat, 30 Jan 2021 23:30:18 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210127170721.58bce7cc@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/01/2021 09:07, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The list of tracepoint callbacks is managed by an array that is protected
> by RCU. To update this array, a new array is allocated, the updates are
> copied over to the new array, and then the list of functions for the
> tracepoint is switched over to the new array. After a completion of an RCU
> grace period, the old array is freed.
> 
> This process happens for both adding a callback as well as removing one.
> But on removing a callback, if the new array fails to be allocated, the
> callback is not removed, and may be used after it is freed by the clients
> of the tracepoint.
> 
> The handling of a failed allocation for removing an event can break use
> cases as the error report is not propagated up to the original callers. To
> make matters worse, there's some paths that can not handle error cases.
> 
> Instead of allocating a new array for removing a tracepoint, allocate twice
> the needed size when adding tracepoints to the array. On removing, use the
> second half of the allocated array. This removes the need to allocate memory
> for removing a tracepoint, as the allocation for removals will already have
> been done.
> 
> Link: https://lkml.kernel.org/r/20201115055256.65625-1-mmullins@mmlx.us
> Link: https://lkml.kernel.org/r/20201116175107.02db396d@gandalf.local.home
> Link: https://lkml.kennel.org/r/20201118093405.7a6d2290@gandalf.local.home
> 
> Reported-by: Matt Mullins <mmullins@mmlx.us>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>


I still need the following chunk (same "if (it_func_ptr)" as in the v2's 
reply) in order to stop crashes:



diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 82eba6a05a1c..b7cf7a5a4f43 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -311,6 +311,7 @@ static inline struct tracepoint 
*tracepoint_ptr_deref(tracepoint_ptr_t *p)
                                                                         \
                 it_func_ptr =                                           \
 
rcu_dereference_raw((&__tracepoint_##_name)->funcs); \
+               if (it_func_ptr) \
                 do {                                                    \
                         it_func = (it_func_ptr)->func;                  \
                         __data = (it_func_ptr)->data;                   \




-- 
Alexey
