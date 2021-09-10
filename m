Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BEF406D51
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 16:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhIJOJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 10:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbhIJOJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 10:09:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF21C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 07:08:15 -0700 (PDT)
Date:   Fri, 10 Sep 2021 16:08:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631282891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bSyyP9yahgxFA1b8RnoWYThoroPSM6gbfo1YmaotaKo=;
        b=tIMCArcKFzMnU5Qw4KZv75f/XpNJ5QosPdywYAK3mKVRKDj5ndlnpeKcU0PrPzXo5kttMs
        qIdgMQNlbhMZyRcg9T5/nEqUa8CKeFwLcdWfILSSF/BHyBxars+Tu159CdlCBb82vuASq2
        hDAfeAviVKKpylcfxQdRCRN64G4+XoY5fXQsfP0voveFFIa/QkL7mjQT1/99ewfARlMgX/
        QxjD/taJlOCV1O3Axu/4uQfPcnr4BHPLQHdR74ogN/faNjLLQYfBMpGiiuP1VY2RANo2q1
        JmZo0nwSl+4mqSXPCEMekVj5buFVemOqu8kVy5T2BRZkPkiJRBNqwrYZoI+Ang==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631282891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bSyyP9yahgxFA1b8RnoWYThoroPSM6gbfo1YmaotaKo=;
        b=7JsiFf4a9XWtWjkLYLcPu7V7CzWcBWXfEhw7EmXVMPCJ9OuhjMWbhKdaNnEcvd8ugkIuEy
        B/C0bg7ZrlSuLcBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
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
Subject: Re: [PATCH 3/6] lib/stackdepot: introduce __stack_depot_save()
Message-ID: <20210910140810.jxb6sfgkdzefqgio@linutronix.de>
References: <20210907141307.1437816-1-elver@google.com>
 <20210907141307.1437816-4-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210907141307.1437816-4-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-07 16:13:04 [+0200], Marco Elver wrote:
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index c80a9f734253..cab6cf117290 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -339,6 +350,25 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
>  fast_exit:
>  	return retval;
>  }
> +EXPORT_SYMBOL_GPL(__stack_depot_save);
> +
> +/**
> + * stack_depot_save - Save a stack trace from an array
> + *
> + * @entries:		Pointer to storage array
> + * @nr_entries:		Size of the storage array
> + * @alloc_flags:	Allocation gfp flags
> + *
> + * Context: Contexts where allocations via alloc_pages() are allowed.

Could we add here something like (see __stack_depot_save() for details)
since it has more verbose.

Sebastian
