Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD18E3066E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbhA0V56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbhA0V4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:56:00 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69462C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:55:04 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id s18so3917869ljg.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXrtCyCjYsLyQB5J5HVNKZC2dJFTtjHISSLSn1Pu5nw=;
        b=nEiBaXMx+39kTkBJIH2ehcKIGphFLcY49T+9/BZ1X2sFWUpKoligjubX0wwHVO4LLi
         7NOGEmOdLwxER5zkv29LIUb0/1hsrNmS6g1KM7yMlxW+qeZIHCIFaX4xW8xKCoMfYQha
         FBY8teYnKkZECrKVYbrPSb+hm7+urPwRc4SbRei9JqET8A+Mit0hdNV4RiRdDh5ba4rr
         cwStutQD/2+eaC6ZeyHWzgiD9hr2GazsvhykPy4jjhyFhvjbO5w1IaK4DSu+aCuXfukf
         hz2bknfL1f2kdwe28WJJQuz5Yr4sFSodVdyO9E0yLyoWOIN8GTZuBwmWKdr3JDwczGf6
         r1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXrtCyCjYsLyQB5J5HVNKZC2dJFTtjHISSLSn1Pu5nw=;
        b=WwWMA5UDSwie1AooLpunYm7sjZmhXbMjOk/ymsJKbU6ZCgZ5YbLjzr/3l8aRcZ+oKi
         VDqtJVIXzVmHo4/RU3pl5seqiBJ/7i3rlQjZCDipl/kryb2KrvTWM0ZxziP8oLyWhpEZ
         BR1aQy4yU9JvTgSq4AihhBQ8OdTHPX7siHWEojMUYaVGJMCY4fniA9H6v6tviGKq9KZT
         manZRj9Yj5SOvCVwhs6OXrfDe8PsTUlv9R8Y0rbGs+amgDWmTPnOPJwOFvLLbC5v8s6q
         PG0QWktOFTHeFnw9l401FNsQGjtovj9wnzCkNe5QbzMoWIpEBr2nIkMLMv0AHwC9qEjn
         50VQ==
X-Gm-Message-State: AOAM530rSeEZPtD9VTLovp1EmO7YRsg060kA0fWGoChg3CQ17KAys+wQ
        lre7bXXJEHJObci53cMg80g1ypVpMwtOVY7Iyi+cDw==
X-Google-Smtp-Source: ABdhPJxLT9lSak4xY2i/k7POK3Rl/Ji4L2FrI7CKy6oLRSaOHVNrh5TdryYiwuVa0F2etxzBLk/6pAfaJWIG2WjmegA=
X-Received: by 2002:a2e:8ec3:: with SMTP id e3mr6405043ljl.467.1611784502902;
 Wed, 27 Jan 2021 13:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20201228150052.2633-1-nikita.shubin@maquefel.me> <20210127104617.1173-1-nikita.shubin@maquefel.me>
In-Reply-To: <20210127104617.1173-1-nikita.shubin@maquefel.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Jan 2021 22:54:52 +0100
Message-ID: <CACRpkdYPYua-NuxVC7aBxJtLYFEECL-60jr4pYgK4=fd5Mb-6g@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] gpio: ep93xx: fixes series patch
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 11:46 AM Nikita Shubin
<nikita.shubin@maquefel.me> wrote:

> Series of patches to fix ep93xx gpio driver to make IRQ's working.
>
> The following are fix patches (these are enough to get gpio-ep93xx
> working with modern kernel):

I see that there is a strange level of attention to patches to this
platform!

Since you fix all my mistakes made in converting this driver
in the past I will just say:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

For all of them.

There are some nitpicks from the reviewers to fix up but
overall this looks very very good.

Yours,
Linus Walleij
