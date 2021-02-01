Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB096309FF0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 02:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhBABVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 20:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhBABTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 20:19:24 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ACBC061574
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 17:18:44 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id e19so10489939pfh.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 17:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ROJ4jk25lFl8Lzkt1Rd7L/1yxMAO6o76SO+nemwWZxQ=;
        b=pVrIEeb+0G07xAKsnNeDo7DQCzMW0k1FgUd8b2LlrzVlLJjJ+Kq6feg3XkpLdtC41K
         ctit4lDBY2b7ugPPppez1i0qNIqEHl6Jluu8moKLKdM+cPLomnDnUr3hYhbkfeMMYZnI
         wpEEyQEISZ2E2nFkke4aTswQNL6iTH2IlyvUBhwJVjM4Irt6LyST5mBmwtHQAhiIPyew
         SVo8+gDTwKeqm+Qv1QV/Kc6bV5ZW/+s0oYly/PT5QnKyPeeLIDvC6HCxZOeDI4jSYlqv
         bABq6uYPL6Uw786WOyuAzEISOR83LeX0DEQZt30S/Dy830yJAVJDpGFQmlJPTXLcSPzr
         4d2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ROJ4jk25lFl8Lzkt1Rd7L/1yxMAO6o76SO+nemwWZxQ=;
        b=WzBTtqLjOMvSkYSUeLeoiCyplxKt35LHq8yOpmmrd6EQ+Xx6g3LhkrU34P9dTGm5cz
         EE8/BV9Iu4iy/CQVoKZhJMaztNTllxTsgNGqpNJ7qg6zY2Xa0k56Sii6sUlXXRHYzzKa
         oL/7fAYtZkHUOrD6n2nEYhfD/gOHEp4vDXZL3AmQNPvRTYh1phgydBWM8f+aqpt6J+TS
         EYhbnoA+pXzJ9DKHPCz/tq0aRmdYLz1iGlh2Mm02zDcaVHiA135ZMcBe6x1ozD+O920x
         CudYszIVzF4jzR+XEquolDuZlSrF2RLF7MoRqPHQsda+QX+NNT6PZ1XVq8fvTlYzz5bD
         hgJw==
X-Gm-Message-State: AOAM530PvMj7KiuxZ5jBJaQfTlOCXKk8YR8CMPYe/FHyHEm0FLQBAQqT
        n3ltdsudO3qTiC2KA7MZHvcSSA==
X-Google-Smtp-Source: ABdhPJzX5HuAZv+T0uXFXzFtEuUWOKwxhuw2c20a+X3ayFZs6ehWrHeFJ2y7eNIEHIJPHdfLeFzi0A==
X-Received: by 2002:a62:8801:0:b029:1b9:c4af:8148 with SMTP id l1-20020a6288010000b02901b9c4af8148mr14088631pfd.18.1612142323831;
        Sun, 31 Jan 2021 17:18:43 -0800 (PST)
Received: from [192.168.10.23] (124-171-107-241.dyn.iinet.net.au. [124.171.107.241])
        by smtp.gmail.com with UTF8SMTPSA id j9sm15401279pgb.47.2021.01.31.17.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 17:18:42 -0800 (PST)
Subject: Re: [PATCH v5] tracepoint: Do not fail unregistering a probe due to
 memory failure
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
 <ac000ed4-3eeb-60df-f896-c05cabb4c1c9@ozlabs.ru>
 <20210130093626.0b7b3b1b@oasis.local.home>
 <20210130094211.719f03a6@oasis.local.home>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <13608cdc-2068-6340-6795-28944c9fe3ca@ozlabs.ru>
Date:   Mon, 1 Feb 2021 12:18:34 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210130094211.719f03a6@oasis.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/01/2021 01:42, Steven Rostedt wrote:
> On Sat, 30 Jan 2021 09:36:26 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> Do you still have the same crash with v3 (that's the one I'm going to
>> go with for now.)
>>
>>   https://lore.kernel.org/r/20201118093405.7a6d2290@gandalf.local.home
> 
> Just curious, does the following patch fix it for v5?


Yes it does!


> 
> -- Steve
> 
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 7261fa0f5e3c..cf3a6d104fdb 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -306,6 +306,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
>   			tp->unregfunc();
>   
>   		static_key_disable(&tp->key);
> +		tracepoint_synchronize_unregister();
>   		rcu_assign_pointer(tp->funcs, tp_funcs);
>   	} else {
>   		rcu_assign_pointer(tp->funcs, tp_funcs);
> 

-- 
Alexey
