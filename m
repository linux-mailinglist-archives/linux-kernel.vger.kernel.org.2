Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769FA340542
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhCRMP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhCRMPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:15:34 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D8DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:15:34 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id z25so7188557lja.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Omp7PwWz4ZsnJGI0VayNjvXuWI6KCYnYna3gK48VOEI=;
        b=cPZ6Oq03T8DupUvI5LdJmafI7po/IOUvEu3R54j9cIvjSuwnioYo8aMw+qcxTByGz6
         G5VL71L1ob3QI8X6BTCJVSa2ZZB8PXofVkjXwfFFfSph7dgxPttxA1pDNi/mZ8uWLJfp
         r+shIZ7sWMxRlb/RK/8MdI66VT7Asei+d1AWNaFOx5UEciCWmeJcBNzceha7mXBeLGZ9
         meYPbQoHMVcVgtBk/s7VjMcvvnWNwd/+CBUvn/tXpMQ1wQa8vHm41QXSZp1ZckAdgcg7
         +hE9XY5VOz1OwAVgQ7+bDFRpANKJQ1ct2UNtnHXe0qUf3RdFawXc2LZIP788vYgCjp/o
         RdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Omp7PwWz4ZsnJGI0VayNjvXuWI6KCYnYna3gK48VOEI=;
        b=LVVEDFrr7QANerwlv6jDvSosfbASh1+MeTihDFBWA95UgXO/m3b9UPyeLW7ZYrLO1o
         ixLsEzW/wpHlNXLdL/9nh6aequDIsIeiaWGUzvoyGlwXBOTIVspAISLfZCctzuX69c4k
         UmxZeNLvVZa5GZt0y/Ub9u40Qx97RaPHmx15UhyOCnkOZLx2sgn/gpwRchn7mbjpSpMc
         Kmy+T+vcxu/yOu+Xcs7r9CjG6Bi2h5l2qdPea7aR2w7Y2xJi9xftSgKTY2uGZVb/RLwZ
         WOvXuiI4fHh4kdiFDEuwNiizb+OilgcYO8PPcKEuucvHMZXH0nbS5EVGRROTiXrezWuM
         pbdA==
X-Gm-Message-State: AOAM533iPp3Q5RhqS2GIiH0YVFBRw2fiWnL7+y2xuavZKZq2WSos0O/S
        vhH7VNjHNhutg/3Q0DXzALOCnFwWUATW78gbgb+C+A0jWBxVjg==
X-Google-Smtp-Source: ABdhPJy+D73A6ED0lKJT1NKbl6EursFKTIQG4TfUq2xoTzNQxieOxJIBqrA7M5rYKHNElbeos1zxIGjguAezDZrJWsk=
X-Received: by 2002:a2e:9791:: with SMTP id y17mr4970412lji.343.1616069732469;
 Thu, 18 Mar 2021 05:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210318113156.407406787@infradead.org>
In-Reply-To: <20210318113156.407406787@infradead.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 18 Mar 2021 17:45:21 +0530
Message-ID: <CAFA6WYPJ6QYBCWKbMG5AzssMVtz0YpKxOFQThw998ChSG3OLUg@mail.gmail.com>
Subject: Re: [PATCH 0/3] static_call() vs __exit fixes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        jbaron@akamai.com, Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021 at 17:10, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hi,
>
> After more poking a new set of patches to fix static_call() vs __exit
> functions. These patches replace the patch I posted yesterday:
>
>   https://lkml.kernel.org/r/YFH6BR61b5GK8ITo@hirez.programming.kicks-ass.net
>
> Since I've reproduced the problem locally, and these patches do seem to fully
> cure things, I'll shortly queue them for tip/locking/urgent.
>

Thanks Peter for these fixes, works fine for me.

FWIW:

Tested-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit
