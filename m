Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C90D38BA99
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 01:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbhETX6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 19:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbhETX6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 19:58:14 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DB2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 16:56:52 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id p20so21882183ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 16:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWlNFmJ79w+TkVknTxM+4nCh7KlLiCGXQa0Fg/YBlH0=;
        b=E7vGMVD+dkYS2CIfXp6POZ+DEQ2YU+qEJteMLMwDGK7Jh7xasDtQFyde+5bLKqZ43D
         /X3+ARQ+gPFX62DriE7Dqhy0FNXFHgqFYglQmW803E1Et8bg6A/z21KyEZLtH7pho1XM
         YZs/1u6TulQ6rbmIaqJ2zJEj4Y+jr1ij1INLKU2NfNYUu4ZixOwj4OpTX0IDLxSyhr31
         nlK+tXed7EKpYNtBWljvY9dRwg8otn+JhsM/TzQlhyLU4OB3txilikvhGkf0tt821vCz
         JO97v+GmFIscHpbVLKi5Qvi1icK9/PNLV+XtdloSb7J0+3CBTBBQmDEEh78Wr5pE+a87
         VMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWlNFmJ79w+TkVknTxM+4nCh7KlLiCGXQa0Fg/YBlH0=;
        b=U3NdDCgB5Cr31bCYb/ercg7sT81Am5iZ+lbO9nVL9e+dwCDXH1vcft+BDbHIuUnadl
         VR7QFFyQb9WLjZkF8mMWIKyHprMDaSHymZJIDA46d/2hYsRyFCrJm50QkWLg0JWunQ/D
         4Ex0+lYjNWIlW/cM0/p5ZM/UAuf6FaikgGYTkawZpHsweP8DnueAPurB6AhgLOGxBrYv
         CoZqEFX81UspxzDAj0Q7XynXeOPWtj3KpgToP4jCiNz7qgwD5YDYlrxowb+t6T+5Jke8
         PSkgzs4k84/1Vq72O0hEw8+Jd3ZFQZ+MwyQ8u+V2/Bha1H5OwezfRlzm6K+ZTY/brwm0
         pcFg==
X-Gm-Message-State: AOAM5306f5DT5zO+KHl+ncTO5aUAf0NT4hReaGjJVivT/JLBMVjCijCv
        ubPVoinjog6BnX4R5HpJEFdG1hB9wU06yEIkrOa8Sg==
X-Google-Smtp-Source: ABdhPJwoa5D9Ge6nfRq0cQ6H8ADf8Ge1uO66SK+0rnJusjrVGOb1FgKLOkd4o3KinhhvQsqkprnEIjKthJkNS5/QqfE=
X-Received: by 2002:a2e:805a:: with SMTP id p26mr4445306ljg.495.1621555010593;
 Thu, 20 May 2021 16:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210520231821.12272-1-maciej.falkowski9@gmail.com>
In-Reply-To: <20210520231821.12272-1-maciej.falkowski9@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 20 May 2021 16:56:39 -0700
Message-ID: <CAKwvOdnONTfTQiv-oDK9y6bQetZdaMOYZ16MVNO4npbhEsUcsQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Makefile: clang-tools: Print information when
 clang-tidy tool is missing
To:     Maciej Falkowski <maciej.falkowski9@gmail.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 4:18 PM Maciej Falkowski
<maciej.falkowski9@gmail.com> wrote:
>
> When `clang-tidy` tool is missing in the system, the FileNotFoundError
> exception is raised in the program reporting a stack trace to the user:
>
> $ ./scripts/clang-tools/run-clang-tools.py clang-tidy ./compile_commands.json
> multiprocessing.pool.RemoteTraceback:
> """
> Traceback (most recent call last):
>   File "/usr/lib64/python3.8/multiprocessing/pool.py", line 125, in worker
>     result = (True, func(*args, **kwds))
>   File "/usr/lib64/python3.8/multiprocessing/pool.py", line 48, in mapstar
>     return list(map(*args))
>   File "./scripts/clang-tools/run-clang-tools.py", line 54, in run_analysis
>     p = subprocess.run(["clang-tidy", "-p", args.path, checks, entry["file"]],
>   File "/usr/lib64/python3.8/subprocess.py", line 489, in run
>     with Popen(*popenargs, **kwargs) as process:
>   File "/usr/lib64/python3.8/subprocess.py", line 854, in __init__
>     self._execute_child(args, executable, preexec_fn, close_fds,
>   File "/usr/lib64/python3.8/subprocess.py", line 1702, in _execute_child
>     raise child_exception_type(errno_num, err_msg, err_filename)
> FileNotFoundError: [Errno 2] No such file or directory: 'clang-tidy'
> """
>
> The above exception was the direct cause of the following exception:
>
> Traceback (most recent call last):
>   File "./scripts/clang-tools/run-clang-tools.py", line 74, in <module>
>     main()
>   File "./scripts/clang-tools/run-clang-tools.py", line 70, in main
>     pool.map(run_analysis, datastore)
>   File "/usr/lib64/python3.8/multiprocessing/pool.py", line 364, in map
>     return self._map_async(func, iterable, mapstar, chunksize).get()
>   File "/usr/lib64/python3.8/multiprocessing/pool.py", line 771, in get
>     raise self._value
> FileNotFoundError: [Errno 2] No such file or directory: 'clang-tidy'
>
> The patch adds more user-friendly information on the missing tool by
> catching FileNotFoundError for `clang-tidy` file and raising exception
> again for possible other files:
>
> $ ./scripts/clang-tools/run-clang-tools.py clang-tidy ./compile_commands.json
> Command `clang-tidy` is missing in the system.

This is much nicer when I run:
$ make LLVM=1 LLVM_IAS=1 -j72 clang-analyzer
without clang-tidy built or installed locally, thank you for the patch.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Please make sure to include the results from running
./scripts/get_maintainer.pl on your patch files for the CC list.

>
> Signed-off-by: Maciej Falkowski <maciej.falkowski9@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1342
> ---
>  scripts/clang-tools/run-clang-tools.py | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
> index fa7655c7cec0..38fc311d2e03 100755
> --- a/scripts/clang-tools/run-clang-tools.py
> +++ b/scripts/clang-tools/run-clang-tools.py
> @@ -67,7 +67,13 @@ def main():
>      # Read JSON data into the datastore variable
>      with open(args.path, "r") as f:
>          datastore = json.load(f)
> -        pool.map(run_analysis, datastore)
> +        try:
> +            pool.map(run_analysis, datastore)
> +        except FileNotFoundError as not_found:
> +            if not_found.filename == 'clang-tidy':
> +                print('Command `clang-tidy` is missing in the system.')
> +            else:
> +                raise not_found
>
>
>  if __name__ == "__main__":
> --
> 2.26.3
>


-- 
Thanks,
~Nick Desaulniers
