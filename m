Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD060342125
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhCSPpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhCSPok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:44:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9983DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:44:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ce10so10443693ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ls4UbC3zQvMulNVQ/pzUqFMVRoVv8OmcfnU28m1vLHo=;
        b=Evz7dwHZb+efp4Pq4AqV8Nb7VV9VCNabDdCret5McBxPBFpY7i9yQ7mheYOI/Sdja+
         ZwfIzFO3BKiaRLW+QahodyXhcExLCWvHXT34D7aknOgE2+zA9vUXDVRxabENC9UB+bnX
         dLP9BZwcy/mvKsKDBLgDbJONJYlEneD22DVdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ls4UbC3zQvMulNVQ/pzUqFMVRoVv8OmcfnU28m1vLHo=;
        b=RLXp5IDU/i3KviArMc7EFFakSjvCMvenuRVWInpwuLgRD4mFzRHO3Q1PWOG+1114jr
         +IcrXLyGl99gGEJH4tztUt+2+ir1M0VY9xi28dUhgiqveXaAvv58SuiY+/p9V5xbHPEC
         bcCFqsYlm/wDynok1QeuBSq4prDUVYVKVDp3w9FwtCD+1d0/0bEPBw9CPKcLr/IPPsNy
         ke6PTJ8XJ0y1M9iMugECeNHhcrsUi4GMfMOSehJ4LDjn0HaH4NSD1IRuvkka3W24YtEQ
         7S7gU/KZ+58qQOp2LGOTf4CwVxd+1EqH8Tvg/Za18WReE3AI4zAdHXCysnmboP/NRvwW
         uzYg==
X-Gm-Message-State: AOAM532Iux5FiGp/rpOmuGLbAdxOLwGL/xrwdGnI+8bNTRQOhvq+clfr
        OdG2a6cLz0Wsdy9lobpL+Tdbzg==
X-Google-Smtp-Source: ABdhPJyoLiI3eFgfRhDN6nf9CkE/M7C3LDMykb7J9jakIo5L+2EvQB38hBWgbDaLrLtpNUojaljVCw==
X-Received: by 2002:a17:906:3f88:: with SMTP id b8mr5244412ejj.36.1616168678354;
        Fri, 19 Mar 2021 08:44:38 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id a22sm4282725edu.14.2021.03.19.08.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 08:44:37 -0700 (PDT)
Subject: Re: [PATCH 2/3] static_call: Align static_call_is_init() patching
 condition
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org, linux-kernel@vger.kernel.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org
References: <20210318113156.407406787@infradead.org>
 <20210318113610.636651340@infradead.org>
 <f5ce3975-bda6-0e83-3a59-2fac25cc4f08@rasmusvillemoes.dk>
 <YFSxorIVeuA2zCXt@hirez.programming.kicks-ass.net>
 <c4e9dfdf-c83a-3314-8c55-5b2371a56ec8@rasmusvillemoes.dk>
Message-ID: <34ceee59-4276-90b5-871b-cda303901ce3@rasmusvillemoes.dk>
Date:   Fri, 19 Mar 2021 16:44:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c4e9dfdf-c83a-3314-8c55-5b2371a56ec8@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2021 15.40, Rasmus Villemoes wrote:
> On 19/03/2021 15.13, Peter Zijlstra wrote:
> 
>>> Dunno, probably overkill, but perhaps we could have an atomic_t (or
>>> refcount, whatever) init_ref inited to 1, with init_ref_get() doing an
>>> inc_unless_zero, and iff you get a ref, you're free to call (/patch)
>>> __init functions and access __initdata, but must do init_ref_put(), with
>>> PID1 dropping its initial ref and waiting for it to drop to 0 before
>>> doing the *free_initmem() calls.
>>
>> I'd as soon simply add another SYSTEM state. That way we don't have to
>> worry about who else looks at RUNNING for what etc..
> 
> I don't understand. How would that solve the
> 
> PID1                           PIDX
>                                ok = system_state < INIT_MEM_GONE;
> system_state = INIT_MEM_GONE;
> free_initmem();
> system_state = RUNNING;
>                                if (ok)
>                                    poke init mem
> 
> race? I really don't see any way arbitrary threads can reliably check
> how far PID1 has progressed at one point in time and use that
> information (a few lines) later to access init memory without
> synchronizing with PID1.
> 
> AFAICT, having an atomic_t object representing the init memory 

something like

--- a/init/main.c
+++ b/init/main.c
@@ -1417,6 +1417,18 @@ void __weak free_initmem(void)
        free_initmem_default(POISON_FREE_INITMEM);
 }

+static atomic_t init_mem_ref = ATOMIC_INIT(1);
+static DECLARE_COMPLETION(init_mem_may_go);
+bool init_mem_get(void)
+{
+       return atomic_inc_not_zero(&init_mem_ref);
+}
+void init_mem_put(void)
+{
+       if (atomic_dec_and_test(&init_mem_ref))
+               complete(&init_mem_may_go);
+}
+
 static int __ref kernel_init(void *unused)
 {
        int ret;
@@ -1424,6 +1436,8 @@ static int __ref kernel_init(void *unused)
        kernel_init_freeable();
        /* need to finish all async __init code before freeing the memory */
        async_synchronize_full();
+       init_mem_put();
+       wait_for_completion(&init_mem_may_go);
        kprobe_free_init_mem();
        ftrace_free_init_mem();
        kgdb_free_init_mem();

