Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C247F4243BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbhJFROY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238458AbhJFROU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:14:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5EEC061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 10:12:27 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k23-20020a17090a591700b001976d2db364so2881268pji.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 10:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Et4bMzX3Jqt/S4Y0/c6adC/zVRIkNrC0dGxlQEGLOzg=;
        b=VyFsYxqljECJMwF3cN4AhKi76+PklmjY2B401r11r7FZJHV/SsU/oSYoL0mHyODSwb
         mnAXtbzxQUzsfefZT5lgD2H+fLuAUf9NM/ev5ioBY71gUg6kQXvgfDM6TYs0FrUlHCau
         j0Wm2u/CNbPjC9ayMRoQt1blN+ZvD5srTMjPQfYaPahTJctKAHg8X87nknKDl/wNkvBp
         XSy7hygnjbimdrfGMl33jH9CO6ku3KxCCNOkHExmFVDjOmz1W/i/UUp6oHXJqyZG0azW
         TIjblYzp/X0VlagrFajkQugIfmdPQoYptvmYeyc44czQi5ANv/5LuMrhPgp0yzeZDvHT
         3jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Et4bMzX3Jqt/S4Y0/c6adC/zVRIkNrC0dGxlQEGLOzg=;
        b=3REWLc1WR/JsKLrA6PieOnKVj34IfSWPu3iX1zi+Gyy6/74srgf+5dnqEOWcYaR4OJ
         qPV1e9pNxfGP/mT2Gj6RM2kDKyjRrtxZ9fvZZOfSMYGbU+QfBY7v3n4uXWERIBdjYFqS
         z0bH4UHvsW8gWrG4nk6I7h00A7VY9x1sLqrF2ICjXrB+e3rJ7vf1dKQk5AWnMrjBpCLD
         t++HoIQT5ivdMYDtqQyWhitrZHmcmuCYE2AVNLsjjewK50WpjjnyJKqS4NETqyWuIFFZ
         LwQKommD2xYD3mOcTSBCh5q2eCBIczyQ9r/vIKI/+9kWgNObbpVqz+iPtO1+SbyiNpH6
         sYKg==
X-Gm-Message-State: AOAM532V89DLuNqqICq08LgPEjH9/pJw4zWkbxQ4WMw8qDPTA+1/OGKo
        58N5Fm12vwB0zOmzcs/DarigStkJO//Y2zBs05QLnw==
X-Google-Smtp-Source: ABdhPJyOFeE62kEGZ6fNOfO2fYEeaC7T0+12j8gx48G07IOk315/K809zRiio1ViO/PlDgGQ+cpTJqtJEyrnouZ57Ok=
X-Received: by 2002:a17:90b:3552:: with SMTP id lt18mr12025415pjb.63.1633540346947;
 Wed, 06 Oct 2021 10:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210930222048.1692635-1-dlatypov@google.com> <20210930222048.1692635-4-dlatypov@google.com>
In-Reply-To: <20210930222048.1692635-4-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Oct 2021 10:12:16 -0700
Message-ID: <CAFd5g44=LaO3xh+y2--gfP=rPA3A+ucsnJMykBvrx49ttzgWUQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] kunit: tool: actually track how long it took to
 run tests
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 3:20 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> This is a long standing bug in kunit tool.
> Since these files were added, run_kernel() has always yielded lines.
>
> That means, the call to run_kernel() returns before the kernel finishes
> executing tests, potentially before a single line of output is even
> produced.
>
> So code like this
>   time_start = time.time()
>   result = linux.run_kernel(...)
>   time_end = time.time()
>
> would only measure the time taken for python to give back the generator
> object.
>
> From a caller's perspective, the only way to know the kernel has exited
> is for us to consume all the output from the `result` generator object.
> Alternatively, we could change run_kernel() to try and do its own book
> keeping and return the total time, but that doesn't seem worth it.
>
> This change makes us record `time_end` after we're done parsing all the
> output (which should mean we've consumed all of it, or errored out).
> That means we're including in the parsing time as well, but that should
> be quite small, and it's better than claiming it took 0s to run tests.
>
> Let's use this as an example:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit example
>
> Before:
> Elapsed time: 7.684s total, 0.001s configuring, 4.692s building, 0.000s running
>
> After:
> Elapsed time: 6.283s total, 0.001s configuring, 3.202s building, 3.079s running
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
