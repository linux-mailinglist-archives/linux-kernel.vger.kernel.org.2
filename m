Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262A93A89E0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 21:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFOUAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 16:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhFOT76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 15:59:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56798C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 12:57:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a1so134151lfr.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 12:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=72EYrw9RzfP268vjh6MWdoHLEFQXKk7235FbNpwtx3g=;
        b=WwtcqbkBumPdzUkIxZ659jqB510yQo5URg63VmBqs/TQQOSYLOn3ORSWsLic1aQ9UX
         LQE86pAPkU1cZEwRf0Tu9m1v+Tx7ooHAYncBMA9CwTEpe3M92FCBcjq7Nz8o/DkCOTl6
         7WkiB8DHw2u1npjx6ihc59MIifQVDxw1eePPmdAWg6zxwdHhH1UrGcJE7Rm9cG7A4Nkm
         p3pwVmGLb1ONBj+UIHj+Wyc1SqXJU5/6BmS04L06gLDXxq9Ogw2N+aPbCWm0EpMZS9RG
         eFsSzQ9HZoXTOKWBHTuxothgqEoe4v5ivzU6YTh5w/FDzND4oGEsYE3J9qG7VZvx3P6u
         2ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=72EYrw9RzfP268vjh6MWdoHLEFQXKk7235FbNpwtx3g=;
        b=NeH7DyAdT9yfwj2TRMf/fKxDGceF6dDx940WVlCUPPg0DM73QIHNbVclrmOH6RVZex
         1ARmvJWmdl4zwX/OgOxE4s3n2ntgwmSo9KAZzBQPGhOo0u5rvcGCiHz+ZIlFxvCM1lkh
         lr5TmLd4v/TUX/J2NzqDyndNDOKxu2hhyl97+x4IybZdE3mp+vn2/UjS/7MAverjKCnZ
         em6JBnpfX5gSfHPCwIMfXEmwx5G1VAUD2Z60juEvVJUXRjca/5sfTgcMAbdQo4Q1lUz5
         c5pqxBJnUni1IlQRQgpyCxZE7yU+XecmMYbADoPbt59dbyV+iTWy8wQtjybjb4hWjPBJ
         ei3w==
X-Gm-Message-State: AOAM531+AcQRalOJL0uWhJZJHHzxbIuXtATktzgZySpHhGZ9nlMrnZms
        j3HumIOZT4my0wGLQeDObpZucSCrs7fgsw==
X-Google-Smtp-Source: ABdhPJyhu49lbhYUwzEnjZlE0Gze0dnQjSRI0d1u8/Atwxv2HJKu9+Bb2OkDzP2W+xH6bISlokQA8Q==
X-Received: by 2002:a05:6512:3d20:: with SMTP id d32mr746509lfv.517.1623787069204;
        Tue, 15 Jun 2021 12:57:49 -0700 (PDT)
Received: from 192.168.1.8 ([212.59.242.58])
        by smtp.gmail.com with ESMTPSA id y5sm914lfa.148.2021.06.15.12.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 12:57:48 -0700 (PDT)
Subject: Re: [PATCH 2/2] Makefile: clang-tools: Omit printing stack trace when
 KeyboardInterrupt is raised
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210520231821.12272-1-maciej.falkowski9@gmail.com>
 <20210520231821.12272-2-maciej.falkowski9@gmail.com>
 <CAKwvOd=32_yNvAWRjyczOoEjsWje9SfaB=S1s9kS1bRFZhuU8g@mail.gmail.com>
 <CAK7LNAQtnX6x1AWUU8+7MtUo4OkCrhKjoP=w0-cbH08u__wGWg@mail.gmail.com>
From:   Maciej Falkowski <maciej.falkowski9@gmail.com>
Message-ID: <53282d70-c217-d65e-2d30-7a5593d6c585@gmail.com>
Date:   Tue, 15 Jun 2021 21:57:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQtnX6x1AWUU8+7MtUo4OkCrhKjoP=w0-cbH08u__wGWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/22/21 5:03 AM, Masahiro Yamada wrote:
> On Sat, May 22, 2021 at 2:18 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>> On Thu, May 20, 2021 at 4:18 PM Maciej Falkowski
>> <maciej.falkowski9@gmail.com> wrote:
>>> When user terminates the script (also implicitly through for example
>>> `make clang-analyzer`) by using
>>> Ctrl+C (or sending SIGINT more generally) the KeyboardInterrupt
>>> is raised printing stack trace of the execution as shown below:
>>>
>>> $ ./scripts/clang-tools/run-clang-tools.py clang-tidy ./compile_commands.json
>>> ^CTraceback (most recent call last):
>>>    File "./scripts/clang-tools/run-clang-tools.py", line 74, in <module>
>>>      main()
>>>    File "./scripts/clang-tools/run-clang-tools.py", line 70, in main
>>>      pool.map(run_analysis, datastore)
>>>    File "/usr/lib64/python3.8/multiprocessing/pool.py", line 364, in map
>>>      return self._map_async(func, iterable, mapstar, chunksize).get()
>>>    File "/usr/lib64/python3.8/multiprocessing/pool.py", line 765, in get
>>>      self.wait(timeout)
>>>    File "/usr/lib64/python3.8/multiprocessing/pool.py", line 762, in wait
>>>      self._event.wait(timeout)
>>>    File "/usr/lib64/python3.8/threading.py", line 558, in wait
>>> Process ForkPoolWorker-6:
>>> Process ForkPoolWorker-1:
>>> Process ForkPoolWorker-5:
>>> Process ForkPoolWorker-7:
>>> Process ForkPoolWorker-2:
>>> Process ForkPoolWorker-3:
>>> Process ForkPoolWorker-4:
>>> Process ForkPoolWorker-8:
>>>      signaled = self._cond.wait(timeout)
>>>    File "/usr/lib64/python3.8/threading.py", line 302, in wait
>>>      waiter.acquire()
>>> KeyboardInterrupt
>> With this applied,
>> $ make LLVM=1 LLVM_IAS=1 -j72 clang-analyzer
>> ^C
>> Process ForkPoolWorker-5:
>> make: *** [Makefile:1902: clang-analyzer] Error 130
>>
>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>>
>> Thanks for the patch!
>
> I am not a python expert, but is
> "Let's suppress back-trace when a user presses an interrupt"
> the common coding style?
I think that is not a common coding style.
In this case, the back-trace is verbose and it is caused
by a bug in multiprocessing Pool.

> If really so, do we need to do something similar in all python scripts?
> I do not know what is special about run-clang-tools.py.
I think no, I misunderstood the nature of the problem.
The verbose back-trace is a result of the multiprocessing Pool
not handling KeyboardInterrupt properly.
It is the old bug(bugs.python.org/issue8296), yet to be 
solved(bugs.python.org/issue22393).
For more info please see:
https://stackoverflow.com/questions/1408356/keyboard-interrupts-with-pythons-multiprocessing-pool

This issue is already once solved in a Linux source tree in a 
scripts/checkkconfigsymbols.py:

scripts/checkkconfigsymbols.py:312
     try:
         return check_symbols_helper(pool, ignore)
     except KeyboardInterrupt:
         pool.terminate()
         pool.join()
         sys.exit(1)

Also the comment:
scripts/checkkconfigsymbols.py:321
"""Helper method for check_symbols(). Used to catch keyboard interrupts in
check_symbols() in order to properly terminate running worker processes."""

> For example, if I press Ctrl-C while building Clang
> by using tc-build, I see a back-trace.
> I have never thought back-tracing was annoying.
>
> The exit code is 130 regardless of this patch.
Okay.
>
> BTW, I prefer not having "Makefile:" in the patch subject
> since this is not touching Makefile at all.
>
> I rather like "clang-tools:" or "scripts/clang-tools:".
>
Okay.

The solution should cover the whole bug, I think this patch
may be dismissed then.
Thank you for your feedback!

Best regards,
Maciej Falkowski

>
>
>
>
>
>>> The patch handles the raise of the KeyboardInterrupt and exits when occurred
>>> with code 130 as documented in: https://tldp.org/LDP/abs/html/exitcodes.html
>>>
>>> Signed-off-by: Maciej Falkowski <maciej.falkowski9@gmail.com>
>>> ---
>>>   scripts/clang-tools/run-clang-tools.py | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
>>> index 38fc311d2e03..eb0e0ecfce24 100755
>>> --- a/scripts/clang-tools/run-clang-tools.py
>>> +++ b/scripts/clang-tools/run-clang-tools.py
>>> @@ -77,4 +77,7 @@ def main():
>>>
>>>
>>>   if __name__ == "__main__":
>>> -    main()
>>> +    try:
>>> +        main()
>>> +    except KeyboardInterrupt:
>>> +        sys.exit(130)
>>> --
>>> 2.26.3
>>>
>>
>> --
>> Thanks,
>> ~Nick Desaulniers
>
>
> --
> Best Regards
> Masahiro Yamada
