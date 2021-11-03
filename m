Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D07D444851
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 19:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhKCShD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 14:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhKCShB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 14:37:01 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F628C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 11:34:24 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id r10so4227777ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 11:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41EnOOu7rOicSF3OQKjugyG9w42QEkaRN15ADDAi+ss=;
        b=gZUxFYnHBzVhgM3UshVbVlYgP6hlBavTM5zWyN5ZbVoAy2kSc+OvjOA9Aaki4hrISu
         FLoR0tGlDRuldTRM5xLz/+cjY8jyTeheCNyozK/wEPf8njY+5Wjwi8OqgdDuJFm2/fDH
         yQd5pE7VlLkrW3fLzbauI2B0m+sOctNkAwMpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41EnOOu7rOicSF3OQKjugyG9w42QEkaRN15ADDAi+ss=;
        b=qyUtsqDptZeVRXwgATJRHRPo1eU8r2oJtEQa6bBYiTGFrH0HgX0scEdiwigVVyW9/d
         zvMiEscNZXqiVVerrucNHyiY7N6SORzspdI7Qtc+r5XUCsgS7vslaT4hxxUr4r11Awes
         I3HDxu8m4S3CWB4mTxZoADyobmeLGcxFOrqVIidUJhFwsNkqfEk9tyhKr8wbzwNayjb5
         WCbeupkrkaYKii7R4tIqFO8HVEjdOqZs0FiWZmjoOznADJfXydB4WTrXQGX82dMxykZ0
         p0wU21/i1GfFo39OMhtMfUSNRFZTD4qr2SoMHlAI6MCs7GHRegf8D0ClK9O4NgHKf22F
         aX4Q==
X-Gm-Message-State: AOAM5315tcMmpEFw7doszQtBNL/EuBwQJDbMmxpC0i74W05ylYP6TiQH
        BWpAicvf7yBRltG8I3RMFb3YD8JZfL9757ZC
X-Google-Smtp-Source: ABdhPJzpFjmvjLrBPiugD8ew5B0lRrYWhbnyCi4DTccA77mR4leXstiq1fzULptV1IkPvfemnsZN2w==
X-Received: by 2002:a05:651c:249:: with SMTP id x9mr18566416ljn.264.1635964462253;
        Wed, 03 Nov 2021 11:34:22 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u4sm201049lji.88.2021.11.03.11.34.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 11:34:21 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id i3so7015533lfu.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 11:34:21 -0700 (PDT)
X-Received: by 2002:a05:6512:13a5:: with SMTP id p37mr40963109lfa.474.1635964461395;
 Wed, 03 Nov 2021 11:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211102142518.3723655-1-linux@roeck-us.net> <202111031011.D0F16D78@keescook>
 <bc18aef2-17ee-dcbc-916c-952794adc658@roeck-us.net>
In-Reply-To: <bc18aef2-17ee-dcbc-916c-952794adc658@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Nov 2021 11:34:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUtTkstJiEwsedWLaq3WdjfW8=0JD6v0qLAFSfzfWBaA@mail.gmail.com>
Message-ID: <CAHk-=wiUtTkstJiEwsedWLaq3WdjfW8=0JD6v0qLAFSfzfWBaA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] string: uninline memcpy_and_pad
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 11:03 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Either case, I'll wait for advice from Linus on how to proceed.

It's a completely unimportant function, used in a couple of places,
not performance-sensitive, not security-sensitive, and not worth any
kind of buffer size checking.

And it's breaking the build because being inline somehow confuses the compiler.

It gets out-of-lined.

Kees - once you have gotten all compilers fixed and everybody using
them, you can send a patch to make it inline again.

I estimate that is in about ten years or so.

             Linus
