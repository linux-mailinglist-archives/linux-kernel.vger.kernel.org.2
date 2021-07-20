Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5323CF423
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 07:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhGTFPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 01:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhGTFO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 01:14:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5A6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 22:55:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so27075565eds.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 22:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W+eCdobjn3+ulB5NKygDiZMliBbGEgLHHiAuMSuNm64=;
        b=jx0WhC+Qq5yZySQNzp4alTyVk+wJPmhKKMji4+PDuJC07+xX+GmAXtN4vN7nWFCpvo
         i2ssSret5TX0qeToyf8gMQ+eWhA4v05eZLCosJFtjFFgeaWdLcE7NqjSEfNYiRKIpZ10
         LFW+88TtPi3vrrjByxYUQifxp91Li2eNmszWGQA1nTQ/tIhTQ+2V5FAnwwfKIbLs2enm
         o5NLuCyhSUFKJNFt0vtSYlE/z0WA1wfcxrGrLoU17nOlB/F6cK9I4kb0glTTawC38an9
         l3wyt/aqXzEaO/aetwZjPaaT/g52rK4BKsxVejWPA2BxsKN/7HvuxcslaKxO8H7gPGrE
         o0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W+eCdobjn3+ulB5NKygDiZMliBbGEgLHHiAuMSuNm64=;
        b=jSrp0GIANRtZeawt8Jrkut+I982unNTVNaV5yJ549co87Q8fCOH0CXJxiG4lmDNNiT
         ZDue8dB2lW7X50OebTpHYIIozjrfdA/nMfKKrnSq0cqqHfWrxHNNRgZyC5wWMm6Syn4w
         wC21hYLsAhWXfpSaDFAtbcGEufDOYJjECC+hSahTsA/5axji6aYRqVQIbLZaT1ZCXVUT
         IO7cAbSrcfcTHLoeXZZOaL1cDSa/Q1gp4zHYKVFxs8TDESTk5uDvRYWC2LWSnFWuu7e5
         fwH7iEXe2kAFFs6Bcas+z1f0VrraJYEikzVW4EOQr8L7SyHtdTCvalbUfmv7vqxPU4RJ
         aJ3w==
X-Gm-Message-State: AOAM531QnQgNqNYv7jYOophYyMhL4SKN5aXSfjTkDOj2stu0BPpPBh+j
        BivIcFupMyb5o9r0fZBSF4VDf/lkEI2pqPwazWvx+g==
X-Google-Smtp-Source: ABdhPJzyXpQN+izTAyFJ9JUPxr3rEHure5nCgtKyRzus+QckOhGYE5oXxwOr7hjftM0k4cNfxQyG86a1Wt0Y8mDvvDE=
X-Received: by 2002:a05:6402:1771:: with SMTP id da17mr38850996edb.23.1626760533288;
 Mon, 19 Jul 2021 22:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210719184335.198051502@linuxfoundation.org>
In-Reply-To: <20210719184335.198051502@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 20 Jul 2021 11:25:22 +0530
Message-ID: <CA+G9fYtAN7y5Z82nO59daxD=AtYOyu2J7ECFjY2P64JR9Fqifg@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/420] 4.19.198-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2021 at 00:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.198 release.
> There are 420 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Jul 2021 18:42:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.198-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Perf fails to compile in 4.19 on Arm, Arm64, i386 and x86 with gcc 7.3
It was also reported on 5.4.134-rc2.

  perf-1.0/perf-in.o: In function `tasks_setup':
  tools/perf/builtin-report.c:664: undefined reference to `process_attr'
  perf-in.o: In function `stats_setup':
  tools/perf/builtin-report.c:644: undefined reference to `process_attr'

Bisection points to ee7531fb817c ("perf report: Fix --task and --stat
with pipe input" [upstream commit
892ba7f18621a02af4428c58d97451f64685dba4]).


> Namhyung Kim <namhyung@kernel.org>
>     perf report: Fix --task and --stat with pipe input

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
