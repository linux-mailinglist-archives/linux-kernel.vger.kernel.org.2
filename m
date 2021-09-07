Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA03402CFC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344409AbhIGQkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbhIGQkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:40:19 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93B7C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 09:39:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id bg1so6156869plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ggBt1/XcGMk1GgPoYY4NtuKRl2ZcdoZPPws/++QS6M=;
        b=M/0bt3uVF/S98xnbmyKOSCrfR6OJRZ8a7V0/XeKbliG/m4etlFlvkR5SPf7pHssQ/O
         61ITWuKkHQGMlzJFK0o4JNaJq8gzXoFNC2UX4d23udONpUN5Y9A/xDS21VQ3FrUzN4c8
         ZKPHjI9vCVhePAXLiDFf26TGWwdUaiMJlyTEXxdKZ1t1DUylM/RqWIRfgU4rWWzdK2an
         FpJ7QEj0mVWmOu83p9aDoUG2UXqyT0GF3//x7S25otwLnBqc344OYSvEeU1wVkPdASip
         WvQESURIGFnvFCQIKwxtv7PFvC79zf4e7RLSNvgJtWAdGBzi7uWe5jafiZ0muLOngPVe
         gymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9ggBt1/XcGMk1GgPoYY4NtuKRl2ZcdoZPPws/++QS6M=;
        b=DPA+Ynt6EekQwrToT+74YxNDZa1UtMcYqyZzs2F4+wkn2WlnDKaA46bjzGJGlpOkc9
         dSyQlHoQrfZ1eGsybadGg5EWIA4hVBR0IW7D1UfEw+mrTpaaDXIfirUM9CFPDOqNSQz6
         9ltufTYEWWjVTlxx90dXkxfu6TiyAeIeAE5ndOqhSmcSTDc/QtogT7c7Kcf2Ac3YwZYk
         HZgwXdQnyld/Rxx9WTU5Y6I/AMapNJ+2pO5p7vxyBPP1829LF/CzwvdGcOT+889384Wf
         8RPJDfywzsK/vLG0NuXpdNqBttsyGHstCBjypc8YEIHB+Oau3oobCKHBIUTcXiPABelv
         idSQ==
X-Gm-Message-State: AOAM532C+wTmbhzGO5r2HJwbPOc1ymJPOD6lqDqcKB51Kv7+QLFl4IMT
        IZJZWwoF6DM40hsCvMpcogg=
X-Google-Smtp-Source: ABdhPJzZ1x983+WmHHXiknDxIoG/x56wROgmY8ow7uoOsy/TPLq1jvWmCXTf0c8UMALMcClEc3xjCg==
X-Received: by 2002:a17:90b:1e4a:: with SMTP id pi10mr4393075pjb.135.1631032752193;
        Tue, 07 Sep 2021 09:39:12 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id 126sm14850350pgi.86.2021.09.07.09.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 09:39:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 7 Sep 2021 06:39:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>
Subject: Re: [PATCH 6/6] workqueue, kasan: avoid alloc_pages() when recording
 stack
Message-ID: <YTeVriit6r82gWGz@slm.duckdns.org>
References: <20210907141307.1437816-1-elver@google.com>
 <20210907141307.1437816-7-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907141307.1437816-7-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 04:13:07PM +0200, Marco Elver wrote:
> Shuah Khan reported:
> 
>  | When CONFIG_PROVE_RAW_LOCK_NESTING=y and CONFIG_KASAN are enabled,
>  | kasan_record_aux_stack() runs into "BUG: Invalid wait context" when
>  | it tries to allocate memory attempting to acquire spinlock in page
>  | allocation code while holding workqueue pool raw_spinlock.
>  |
>  | There are several instances of this problem when block layer tries
>  | to __queue_work(). Call trace from one of these instances is below:
>  |
>  |     kblockd_mod_delayed_work_on()
>  |       mod_delayed_work_on()
>  |         __queue_delayed_work()
>  |           __queue_work() (rcu_read_lock, raw_spin_lock pool->lock held)
>  |             insert_work()
>  |               kasan_record_aux_stack()
>  |                 kasan_save_stack()
>  |                   stack_depot_save()
>  |                     alloc_pages()
>  |                       __alloc_pages()
>  |                         get_page_from_freelist()
>  |                           rm_queue()
>  |                             rm_queue_pcplist()
>  |                               local_lock_irqsave(&pagesets.lock, flags);
>  |                               [ BUG: Invalid wait context triggered ]
> 
> The default kasan_record_aux_stack() calls stack_depot_save() with
> GFP_NOWAIT, which in turn can then call alloc_pages(GFP_NOWAIT, ...).
> In general, however, it is not even possible to use either GFP_ATOMIC
> nor GFP_NOWAIT in certain non-preemptive contexts, including
> raw_spin_locks (see gfp.h and ab00db216c9c7).
> 
> Fix it by instructing stackdepot to not expand stack storage via
> alloc_pages() in case it runs out by using kasan_record_aux_stack_noalloc().
> 
> While there is an increased risk of failing to insert the stack trace,
> this is typically unlikely, especially if the same insertion had already
> succeeded previously (stack depot hit). For frequent calls from the same
> location, it therefore becomes extremely unlikely that
> kasan_record_aux_stack_noalloc() fails.
> 
> Link: https://lkml.kernel.org/r/20210902200134.25603-1-skhan@linuxfoundation.org
> Reported-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
