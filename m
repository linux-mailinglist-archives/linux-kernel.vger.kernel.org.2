Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAA5311A5C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhBFDl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhBFCbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:31:55 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BF9C08ED7F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 15:33:01 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id s15so4333971plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 15:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6dnZT0AcF3u1j3oEwTbCmRj7PTLoCDXEB/52wfg7Ko=;
        b=BW2izEZ8LP+1njzJY9aNjX5evbtE58IbhhK7JSi0xeTGnONbNRFM9ZCWsUjmxn/m13
         x0f7/Mx2WizyC82kCsYi2JOw7KVDbA22TMEOQCIxNiVpMuH5KZiRR+Fdfm1k/cifJP/t
         FTtR8+pIl96NDvTamKCO3EVv3II5bc4DIHCD1xLQ4gdrWgVOQexL7kkMQnxtlxlaiyIh
         KzOIazyT6wK5RAYDBQIdbyHr/OLCOrHge7x3RaU7oRB2qTe/H7baPdXHgdVb/xxUSntW
         HNytB27A/n5xi1BuBtHgaxvAQQRZARz5XTqoHnps2kp4K0+4Pg4zZ23tHpB9ba83IFDA
         5+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6dnZT0AcF3u1j3oEwTbCmRj7PTLoCDXEB/52wfg7Ko=;
        b=KswasoEK7o6i7mXWdUSzFrPtdScbGwnxj2gVL2EK0+gXsi6vacKQDOwuKqz8swbbaT
         oKIu3I2G/GA59JcPDQK49vj7gx+1tjW3EG6//5qZ4HTKXN7LmYAbn6P6VCkb3H5LzSqj
         CmMrI0cp+uxFkjjn2rsir0fTjnQXBpTuym+0lkmJJxkdO749cBV+YbYms41cN/zuqMQh
         5XrYvfA9tNGXKRgiuMYgDd94+pD/eb08EqM0LLw9MPZ2S9ctFwfQEUrJ5KCqeCtXvsAL
         sSkvL7C52/teWmNhTyHbt/RXuGuKf5N2eE7cUd3sechxmQfWWcZDyTigPlV4Zmyj/nX4
         Ibtw==
X-Gm-Message-State: AOAM5320EjG1bc9LvQngLNDRDpBi016iRlLv7aetCVkSiyXZXXNw7XKb
        tNWG7UhD/b/pryl36nqi4e558OKidfiW0Ckg+q0m+g==
X-Google-Smtp-Source: ABdhPJzezklMQ5JVyDwFXrgTNeuU6Mw9vXbgWRfxYmJ7hYKLCmebTxO1DfQbl2kNTd6DNLmZB8gX07Bk6lHb/YK/VZU=
X-Received: by 2002:a17:902:f686:b029:de:18c7:41f8 with SMTP id
 l6-20020a170902f686b02900de18c741f8mr6235898plg.65.1612567980954; Fri, 05 Feb
 2021 15:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20210125185333.3337463-1-dlatypov@google.com>
In-Reply-To: <20210125185333.3337463-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 5 Feb 2021 15:32:50 -0800
Message-ID: <CAFd5g477HrqPzh38QdbOMvRr3=kvDBnxpx1QjbnUN4hkvCyt7w@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: add tips.rst for small examples
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 10:53 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> ./usage.rst contains fairly long examples and explanations of things
> like how to fake a class and how to use parameterized tests (and how you
> could do table-driven tests yourself).
>
> It's not exactly necessary information, so we add a new page with more
> digestible tips like "use kunit_kzalloc() instead of kzalloc() so you
> don't have to worry about calling kfree() yourself" and the like.
>
> Change start.rst to point users to this new page first and let them know
> that usage.rst is more of optional further reading.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
