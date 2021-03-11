Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CCC337CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhCKSlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhCKSjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:39:10 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0323CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:39:10 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id q25so41408697lfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gZMsl4SrnDNQhd4ss3KWwc1HYh6yuRdaCQt7xbLMh8A=;
        b=TVObpuTugYdYCxrt4yJ7mLxCcGcVZpumSlcHjoubdC/5aM8aXfiADtCv0mkmJbWhnv
         Qu2CVI6nHvbwPY0udk1XCEcsFLrnBDAPZMx8p32XngB0l5XOSIKuhHaxBXnlJQT5hP2x
         716Fo6M1Lx3GTW7RriA35f53OKhxn31f0ffZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZMsl4SrnDNQhd4ss3KWwc1HYh6yuRdaCQt7xbLMh8A=;
        b=dPjWNt+gFPV1MOQ6HwVh4ClO7ejhNgpOt6AJS5IIrkwj1oJcPuO1cuxDDXcZdc/e3+
         tzf7OAZ+dm0qLdMSbu7TDkd42v1p0RPy4Rsmli4jtYu//MiO98rUUJxRzSksnyldy8LU
         CztTr1x/J+12KqGIcVb5ogKdsxVRzFAFR/++FW6TOpAPUY49CHF26umAHmSU2G/N9N7P
         myYgwSCd+Bz5UPOPNiyLXZUfiKXehivTD5dsuf5/2HuCzjp8KoRpqv0i0FhbZ41xHeB4
         wfqVd9SQvPBkejBVwnJgrbe4ge7VQv23qs6KM6MURPiRT7MwQc9Dy1ExO1EXLJlxpM/W
         X1Wg==
X-Gm-Message-State: AOAM5320eV3VH9qTrbma74kAeDz12N5QSEGKpDn9VHqh06ZVcml+4xh3
        d5qhOtJ04hkQFR4DuQi9Ut3+pSkyIp29Lw==
X-Google-Smtp-Source: ABdhPJwtcCT3yK8WNOhEV9c4v7ZwvRt80onD71JzyKEcZfZQHoQK+CHFAYvBY8ukXur2gVqKsTL/7g==
X-Received: by 2002:a05:6512:3cc:: with SMTP id w12mr2921203lfp.650.1615487948148;
        Thu, 11 Mar 2021 10:39:08 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id v70sm1064665lfa.106.2021.03.11.10.39.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 10:39:07 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id f1so41448922lfu.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:39:07 -0800 (PST)
X-Received: by 2002:a05:6512:33cc:: with SMTP id d12mr2891513lfg.487.1615487947099;
 Thu, 11 Mar 2021 10:39:07 -0800 (PST)
MIME-Version: 1.0
References: <20210311130328.2859337-1-oberpar@linux.ibm.com>
In-Reply-To: <20210311130328.2859337-1-oberpar@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Mar 2021 10:38:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmwT-_VJJ72C1Wyzbzb_rRb9c7bc5RpGhdOXsyz4FDKQ@mail.gmail.com>
Message-ID: <CAHk-=whmwT-_VJJ72C1Wyzbzb_rRb9c7bc5RpGhdOXsyz4FDKQ@mail.gmail.com>
Subject: Re: [PATCH] gcov: fail build on gcov_info size mismatch
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 5:07 AM Peter Oberparleiter
<oberpar@linux.ibm.com> wrote:
>
> This patch adds a compile-time check to ensure that the kernel's version
> of struct gcov_info has the same length as the one used by GCC as
> determined by looking at GCC's assembler output.

So I don't think this is a bad idea, but if you end up test-compiling
something, could we not verify things a bit more?

If you actually build the object file, you should be able to then
check much more. You'll find the pointer to the struct gcov_info in
"__gcov_.fn", which is admittedly hard to then link against a test
program (because of that dot in the name that means that you can't
even use "attribute((alias..))" to generate some other name for it).

But then you could test not only the size, but you could verify that
the "filename" field matches, that the n_functions field should be 1
etc.

IOW, it feels like some ELF munging (possibly even with just scripting
with "objdump") should be able to add verification for a bit more than
just the size.

I guess the size is kind of critical, because of how GCOV_COUNTERS has
changed, but if any other layout issue changes, the size might not be
all that relevant.

For example, looking at the current "struct gcov_info" gcc uses, it's
very badly packed, with 32-bit fields literally interspersed with
64-bit fields. So I could easily imagine that somebody goes "heyt,
guys, we need to add another GCOV counter, but we don't need to change
the size of the gcov_info, because we can just out the "version" and
"stamp" integers next to each other and getting rid of the padding
makes up for the extra counter".

I dunno. The gcov code has obviously never actually done anything like
this before, so maybe I'm just taking the "we could verify
_something_" and my reaction is that there could be even more
verification if we really want to go down that rabbit hole..

           Linus
