Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC753B482F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 19:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFYR1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 13:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFYR1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 13:27:19 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF84C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 10:24:58 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k16so13306114ios.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LHVmYb7qh3Gk1c+JxsgnaWrjMoM5mdAbEnRvagWc1KA=;
        b=Vn6YZq1cCY8udPYJU/K7YC2O0uC6ZOyupMUqjLfo2UpZFbFSiYYmfiGSa6ZqnHujxj
         BgM9v2i47yquTml742aY3dJI4Vs1knz2wQhGyE9zf52unG7g+npayk8DEcDBT+kUq35c
         1sRVRMw4h0hDZbWhsBR8tLXecirUHAikuY7Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LHVmYb7qh3Gk1c+JxsgnaWrjMoM5mdAbEnRvagWc1KA=;
        b=KgG2k78n6khZz/i/zeAFfpt9I/AMaul5aWno42V2MwqEqMmgG9MLQz7CU8eHypJAt5
         RDWJDTsG+goGhdNC/UpRsKTimHjp66tzx+nL9gjfxuCyZPbO4zviQBSJC/SBBdf03A/X
         u7MVfDEN4PZYQNw3q8hJ8zez35EDndTe2tnsBnMe9+1nz0Sm+5GIQ4/no/l2L4+3cTS3
         KvrgfzPsyLDGIC5lDXnoXlaY+HLEV7x1r72o9ouZgGzhdq1irTWcPs6BD8pSiY9thAt0
         9UAgwGQ2L8M/YFgyCgqXhY878G+vK7q55QRewWE5RxUU2TS9jUEgLx//dK9eeZu6iZ7Y
         pGCQ==
X-Gm-Message-State: AOAM531SCzw4U4gCqKZdulq9b8zifOHJlopuRPlHNFj8g6/gR5NTVacr
        UCQ1NDgWG1SXYqW50ZMZqflUBg==
X-Google-Smtp-Source: ABdhPJxLsh8wAcDMpoCUmXN/zrDNKEJlixdqAZQjj3+dTefpBtHhGQ3rKeWoiaeCyxMvY3i9x3JtkA==
X-Received: by 2002:a02:a99e:: with SMTP id q30mr10393187jam.69.1624641897011;
        Fri, 25 Jun 2021 10:24:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m184sm3600828ioa.17.2021.06.25.10.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 10:24:56 -0700 (PDT)
Subject: Re: [PATCH] kunit: Fix merge issue in suite filtering test
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210625111603.358518-1-davidgow@google.com>
 <99c2564c-4175-7e3e-84c3-3bcb6d4f9d58@linuxfoundation.org>
 <CAGS_qxqCBZy+b1-pFc4Eh9AExc7XRkB2LZ2b776bX=oY2C4qfw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ec43df62-36dd-03b5-0a8c-8387938f83fc@linuxfoundation.org>
Date:   Fri, 25 Jun 2021 11:24:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAGS_qxqCBZy+b1-pFc4Eh9AExc7XRkB2LZ2b776bX=oY2C4qfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/21 11:08 AM, Daniel Latypov wrote:
> On Fri, Jun 25, 2021 at 9:11 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 6/25/21 5:16 AM, David Gow wrote:
>>> There were a couple of errors introuced when
>>> "kunit: add unit test for filtering suites by names"[1] was merged in
>>> c9d80ffc5a.
>>>
>>> An erroneous '+' was introduced in executor.c, and the executor_test.c
>>> file went missing. This causes the kernel to fail to compile if
>>> CONFIG_KUNIT is enabled, as reported in [2,3].
>>>
>>> As with the original, I've tested by running just the new tests using
>>> itself:
>>> $ ./tools/testing/kunit/kunit.py run '*exec*'
>>>
>>> [1]: https://lore.kernel.org/linux-kselftest/20210421020427.2384721-1-dlatypov@google.com/
>>> [2]: https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/6IKQX5JXZF7I3NFH4IAWUMHXEQSCPNDP/
>>> [3]: https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/EKY7ZH5YDCCTSJF2G7XFPMGIXQSUVD3Y/
>>>
>>> Fixes: c9d80ffc5a ("kunit: add unit test for filtering suites by names")
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: David Gow <davidgow@google.com>
>>> ---
>>>
>>> This is another fix for the kunit-fixes branch, where there seems to
>>> have been an issue merging the "kunit: add unit test for filtering
>>> suites by names" patch here:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=c9d80ffc5a0a30955de0b8c5c46a05906d417800
>>>
>>> Again, feel free to squash this into the original patch if that works
>>> better.
>>>
>>
>> Thank you. My bad. Applied to kunit-fixes now.
> 
> Hmm, it looks like executor_test.c might not have made it into kunit-fixes.
> I believe this is the applied version of this patch:
> 
> $ git show d833ce7480864d4d7eb2dbb04320858be3578b2a --stat
> commit d833ce7480864d4d7eb2dbb04320858be3578b2a
> Author: David Gow <davidgow@google.com>
> Date:   Fri Jun 25 04:16:03 2021 -0700
> 
>      kunit: Fix merge issue in suite filtering test
> ...
>   lib/kunit/executor.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> The result looks like this:
> $ ./tools/testing/kunit/kunit.py run
> ...
> $ make ARCH=um --jobs=8 O=.kunit
> ERROR:root:../lib/kunit/executor.c:140:10: fatal error:
> executor_test.c: No such file or directory
>    140 | #include "executor_test.c"
>        |          ^~~~~~~~~~~~~~~~~
> 
> 
> I just `git am` or something just really doesn't like executor_test.c :)
> 
>

My mistake it looks like in merging the patch. I had to fix merge
conflicts and made a mistake. I will fix it now.

Odd that my local compile didn't catch the problem. I used the
tools/testing/kunit/kunit.py build

thanks,
-- Shuah
