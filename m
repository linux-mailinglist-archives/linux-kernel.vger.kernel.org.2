Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6744B420AE9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhJDMdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhJDMdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:33:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D5DC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 05:31:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g8so64367971edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 05:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j3+NTrKGFxPGR5lMV22TDnmiT6BfVPVV1SDrEBp3aXk=;
        b=O6lUjgv5/RmkoDv75GKCiEFyuEGSKsFUCencENjUDqGrkgJQVkxIZtZjU8VnAdfwt6
         gEyzSam26qVPlIwwtf1K2Ktx8bYDsaB7oFybuW8dtS3OOngk00UZ8MAKDs6oKGKgZ0pA
         eY7mnh5tym7TIsoWXHX6zo8RKhK7g6aBiBpQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j3+NTrKGFxPGR5lMV22TDnmiT6BfVPVV1SDrEBp3aXk=;
        b=cVCuKr0kyGHE/ClyPM5KGtJrPzfcIcfXC8/7a/T672QYs1dav6Cr6YBqdks0n0M8Za
         UZD9fkNXe7JLETgTVLWjE2yy3rB92s/J/QV/r/t0yjMMDf2gPr1sj9/MOZ4cqXLlofV9
         eSPotp5U9MAgk8y3c88ZxHQWp3GY2Yyj5KGUnGnPJPsYlhWrLzshSxaDi9DfK3jC+vht
         sC8BDL2opJb/j18JFaihMq7wNV1xHXOTTuyjWrVF1CExe0NXkdbZ4MURfqMoNzEYNFjV
         RSB6hOESZxv2OJm0wEZO4l30j+vTVBnpg9QRYLIIKjyGVDNl1CWZG7blJYw4lFV0iY5l
         w7aQ==
X-Gm-Message-State: AOAM5309/JOijQAzHFN914G8j3o06GxJtujR0mmfEBT4w41icUwmxX7X
        2gt6wpLPPTqojgbcIKXv8XyqXw==
X-Google-Smtp-Source: ABdhPJyCTMYab3bhdSRWmXA9IxDIE79OlIAQP4zIl/PVIgqhZErhowcR1kJRIn0y6/gf+MUY2jp7eQ==
X-Received: by 2002:a50:da0a:: with SMTP id z10mr17910180edj.95.1633350687042;
        Mon, 04 Oct 2021 05:31:27 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:d19e])
        by smtp.gmail.com with ESMTPSA id s21sm4658614eji.3.2021.10.04.05.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 05:31:26 -0700 (PDT)
Date:   Mon, 4 Oct 2021 13:31:25 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        YueHaibing <yuehaibing@huawei.com>, Jessica Yu <jeyu@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] [v2] printk: avoid -Wsometimes-uninitialized warning
Message-ID: <YVr0HRnfzttC/wqX@chrisdown.name>
References: <20210928093456.2438109-1-arnd@kernel.org>
 <YVLrttKajDU+1ZvX@chrisdown.name>
 <YVrH5MUdS6uE/zDj@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YVrH5MUdS6uE/zDj@alley>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek writes:
>On Tue 2021-09-28 11:17:26, Chris Down wrote:
>> Arnd Bergmann writes:
>> > From: Arnd Bergmann <arnd@arndb.de>
>> >
>> > clang notices that the pi_get_entry() function would use
>> > uninitialized data if it was called with a non-NULL module
>> > pointer on a kernel that does not support modules:
>> >
>> > kernel/printk/index.c:32:6: error: variable 'nr_entries' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>> >        if (!mod) {
>> >            ^~~~
>> > kernel/printk/index.c:38:13: note: uninitialized use occurs here
>> >        if (pos >= nr_entries)
>> >                   ^~~~~~~~~~
>> > kernel/printk/index.c:32:2: note: remove the 'if' if its condition is always true
>> >        if (!mod) {
>> >
>> > Rework the condition to make it clear to the compiler that we are always
>> > in the second case. Unfortunately the #ifdef is still required as the
>> > definition of 'struct module' is hidden when modules are disabled.
>> >
>> > Fixes: 337015573718 ("printk: Userspace format indexing support")
>>
>> This changelog should make it clear that this is theoretical and will never
>> actually happen, which is salient information for people who are considering
>> whether it should go in stable or similar.
>
>IMHO, the sentence "Rework the condition to make it clear that this
>is theoretical and will never actually happen" is rather clear.

Sounds good to me, thanks!

I guess it's unneeded at this point, but feel free to add:

Acked-by: Chris Down <chris@chrisdown.name>

>Well, I am not a native speaker.
>
>Anyway, I have pushed the patch into printk/linux.git, branch
>for-5.16.
>
>Best Regards,
>Petr
