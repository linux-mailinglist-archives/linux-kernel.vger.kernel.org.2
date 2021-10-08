Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF42427465
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 01:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243928AbhJHXxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 19:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243797AbhJHXxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 19:53:38 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50ADC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 16:51:42 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r134so1320390iod.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 16:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ezETEItaR/J7gVYokGl5RwwQegihaa7iGOTvGlA0fCo=;
        b=Aj5BCG0OeDtBjcw0y+N8PBCSsKH+ppd8XKj64hJe3IOQABTMfuQNw77uJ2FiX3CcGw
         x3TFwr7vUhP8JM+FRTXTrtguDMEeWuBiPIuOsRJ9n8X5aPHNTX7WPWab9VNoAlWMK6kb
         ucVW2Yf1ZL/FcRCwT4yMEcPkYazlI6vEd5JFHXQoJJolu0c0SyO2HZqCt1W2CkmkKD2b
         3dmGEwQjUIes/LMgcd29Tbt69eVDSoaTebhmfILtX2IJUmXvJyI6HLEdVFWJgWl4BcHz
         tft3xzxd2+mQ8CJFJYwmICjV1ljSsdZMmbcQ1M/6+Sv1i+5+GFQ+fulBMNKZEDBGkqaa
         1Cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ezETEItaR/J7gVYokGl5RwwQegihaa7iGOTvGlA0fCo=;
        b=lZvYwjikEQe3vAjmqQZlv3LjoeRczaRU+g8BgBBUY8BDZgbMDr1EOCWrT7IlZCj5lr
         PPC55XLuCuse3/F+v/F/oSL0560S7SFGjIpV+pu5hyoCP4e1OnxjJa9ccnmtm59fs5Jz
         /Lv0k8YT8Hx6lEJ2VuhK9zbsM1bfhrYEUkzXCyLXhyKb8bF42DiOBVnTDDqLs/2cPEKF
         hB09pjAz7izomMvjqc1WeFsN6IgKXq5/1e76unRQyBUBCJOGv1yP9oLHZtnEZmvzEleW
         kAx22Bky+8ao5tbtyi2HSw/S8zSj+lcSOPyYUaIfZRSZGk1KS236VIms8yN40717BoAf
         fo5g==
X-Gm-Message-State: AOAM532vgB960ssFHcyUzFXtBoFgDACvhpy1M+tYyMUqWeMbd7SO9BY+
        23jOglEgdBAb84ngft7jpttpuJ8RnmKB+ICm6Z0NEA==
X-Google-Smtp-Source: ABdhPJxRZSFkhXw4g00xRunPY70k7kUJTWx8xMHPbfr89r83VdZ9Hvh5ToOMRnQk5ukyXaELkAir1AsbB/rEDzzpGr0=
X-Received: by 2002:a6b:b5d8:: with SMTP id e207mr9302657iof.52.1633737100442;
 Fri, 08 Oct 2021 16:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211008210752.1109785-1-dlatypov@google.com>
In-Reply-To: <20211008210752.1109785-1-dlatypov@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 8 Oct 2021 16:51:29 -0700
Message-ID: <CAGS_qxp0iF+7FLbgVyBHXONN8kKjcAr7B+q=kgF1c71pbgybPQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: continue past invalid utf-8 output
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 2:08 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> kunit.py currently crashes and fails to parse kernel output if it's not
> fully valid utf-8.
>
> This can come from memory corruption or or just inadvertently printing
> out binary data as strings.
>
> E.g. adding this line into a kunit test
>   pr_info("\x80")
> will cause this exception
>   UnicodeDecodeError: 'utf-8' codec can't decode byte 0x80 in position 1961: invalid start byte
>
> We can tell Python how to handle errors, see
> https://docs.python.org/3/library/codecs.html#error-handlers
>
> Unfortunately, it doesn't seem like there's a way to specify this in
> just one location, so we need to repeat ourselves quite a bit.
>
> Specify `errors='backslashreplace'` so we instead:
> * print out the offending byte as '\x80'
> * try and continue parsing the output.
>   * as long as the TAP lines themselves are valid, we're fine.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
>  tools/testing/kunit/kunit.py        | 3 ++-
>  tools/testing/kunit/kunit_kernel.py | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 9c9ed4071e9e..28ae096d4b53 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -457,9 +457,10 @@ def main(argv, linux=None):
>                         sys.exit(1)
>         elif cli_args.subcommand == 'parse':
>                 if cli_args.file == None:
> +                       sys.stdin.reconfigure(errors='backslashreplace')

Ugh, pytype doesn't like this even though it's valid.
I can squash the error with
  sys.stdin.reconfigure(errors='backslashreplace')  # pytype:
disable=attribute-error

I had wanted us to avoid having anything specific to pytype in the code.
But mypy (the more common typechecker iirc) hasn't been smart enough
to typecheck our code since the QEMU support landed.

If we don't add this directive, both typecheckers will report at least
one spurious warning.
Should I go ahead and add it, Brendan/David?

>                         kunit_output = sys.stdin
>                 else:
> -                       with open(cli_args.file, 'r') as f:
> +                       with open(cli_args.file, 'r', errors='backslashreplace') as f:
>                                 kunit_output = f.read().splitlines()
>                 request = KunitParseRequest(cli_args.raw_output,
>                                             None,
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index faa6320e900e..f08c6c36a947 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -135,7 +135,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
>                                            stdin=subprocess.PIPE,
>                                            stdout=subprocess.PIPE,
>                                            stderr=subprocess.STDOUT,
> -                                          text=True, shell=True)
> +                                          text=True, shell=True, errors='backslashreplace')
>
>  class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
>         """An abstraction over command line operations performed on a source tree."""
> @@ -172,7 +172,7 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
>                                            stdin=subprocess.PIPE,
>                                            stdout=subprocess.PIPE,
>                                            stderr=subprocess.STDOUT,
> -                                          text=True)
> +                                          text=True, errors='backslashreplace')
>
>  def get_kconfig_path(build_dir) -> str:
>         return get_file_path(build_dir, KCONFIG_PATH)
>
> base-commit: a032094fc1ed17070df01de4a7883da7bb8d5741
> --
> 2.33.0.882.g93a45727a2-goog
>
