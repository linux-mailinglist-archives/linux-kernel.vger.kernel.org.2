Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03DF401ACA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 13:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhIFLxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 07:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238741AbhIFLxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 07:53:08 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAE1C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 04:52:04 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id p15so10960003ljn.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cNdWdE9zckeK0P4G8eZT1h84dDVanfximzzDa+p2Hjc=;
        b=KYhSOQG18JjAbN5qQ+S1nwOavgQfQYe3Bcx6vZFJqcnn+bCMwr8n6YN5OOpzPlvlnA
         ZTf6QabKYStvwp8SL8zfsKRcmTiFqnswRqzbASjRfJTL5IGUoHPGpLL2zHI1vPjcdM95
         LqnOjq9ZkBH30XmOeL50M/09OddRKL0PFIKWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cNdWdE9zckeK0P4G8eZT1h84dDVanfximzzDa+p2Hjc=;
        b=tPlPeDQ/zYQt1P29sNeEP7SMta4Y1M5giQxcsn/GlVfpnhf2OKUJYuIuc4lotleHWG
         cdt6JVHgHX4uNQ+uJxMaCPAVc4pMYlFW8Wa1msXwe4MWqXh4dbdvive5KJXasSen7npJ
         Viqi1irKerqB+XJkpU0TZ2f5geH26b8a5LHhMeXHcbrzRebVSklSruob/m812UZmXkjW
         f0d/y83WkEAKL5cXgVSt26HRi1zpH1V74XIndp227nTo7i7/+C3P6e/4jrhiTguo7KFo
         QhTQiVm3t2doXLJRQmiEAkgFtrVEO3fg0GVYJDZWBIDAEP7wgmbAoHdLDGKWuoNGpLOZ
         M+SA==
X-Gm-Message-State: AOAM530uEiXuvvHL2/Xm1sEyCKGbN2Sxxzy81PUL1fG7vLjqJtQuDANC
        hFci/DVvkleK86WQIJh1QUCMIQ==
X-Google-Smtp-Source: ABdhPJzjf3SxyBbYMwgiN7/Hol83iAhEfGDBi6kG4p76C7Bivt8ICcoLzUG8YNPJ6wi0G3AE8m0UQw==
X-Received: by 2002:a05:651c:1593:: with SMTP id h19mr10508572ljq.117.1630929122409;
        Mon, 06 Sep 2021 04:52:02 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y32sm723896lfa.171.2021.09.06.04.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 04:52:01 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] lib: add sputchar() helper
To:     Yury Norov <yury.norov@gmail.com>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Down <chris@chrisdown.name>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Ingo Molnar <mingo@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
References: <20210904231020.331185-1-yury.norov@gmail.com>
 <20210904231020.331185-2-yury.norov@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <04164ecc-ba60-a0c6-1975-694b2d02c4ae@rasmusvillemoes.dk>
Date:   Mon, 6 Sep 2021 13:51:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210904231020.331185-2-yury.norov@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2021 01.10, Yury Norov wrote:
> There are 47 occurrences of the code snippet like this:
> 	if (buf < end)
> 	        *buf = ' ';
> 	++buf;
> 
> This patch adds a helper function sputchar() to replace opencoding.
> It adds a lot to readability, and also saves 43 bytes of text on x86.
> 
> v2: cleanup cases discovered with coccinelle script.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  include/linux/kernel.h |   8 ++

Sorry, but 47 cases, mostly in one .c file, is not enough justification
for adding yet another piece of random code to
the-dumping-ground-which-is-kernel.h, especially since this helper is
very specific to the needs of the vsnprintf() implementation, so
extremely unlikely to find other users.

I'm also not a fan of the sputchar name - it's unreadable at first
glance, and when you figure out it's "a _s_tring version of putchar",
that doesn't help, because its semantics are nothing like the stdio putchar.

Rasmus
