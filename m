Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF43366523
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 08:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhDUGEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 02:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbhDUGEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 02:04:04 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D81AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 23:03:31 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x19so34694310lfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 23:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZS2JpeIkIMBK4UXRFMJIanBPQAOTd8QwR3u/vBehNeo=;
        b=bQzTOEBpMGZH5H3dbm7xA1VkK7OKLJT2pLKpW2Q8n+CV7TN8ICVMGm4NUsXMvdLOPu
         s4QkC4uAB6x5neZJ7tj4W8QTdmArEQOFMjpbNgEyyWXbCurd4ryqFG5t4EoBxDwVrS1g
         PPpqxQ5lTcvfQPKB8d/lJjn9AXvtAMQXqvtZj0uUwa0rrBrFR8i850e4cTI0RB70h3zA
         VZUMUxbZl5thFT+jX/WMRwaueZopavHWg/cR2p8RQNxB23C1xlAS8agUsxoRgomB3ZU7
         C/WEgHYKzlk3WlqlaLpq7jWwU+duhfJEGJ8PLIOPz49b40K7Y0PvJhCdBbvrTju32rLK
         7m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZS2JpeIkIMBK4UXRFMJIanBPQAOTd8QwR3u/vBehNeo=;
        b=L9CP9IG+n6be7+olJPFFDXYe96EnVNPagwZykHtXdfIWtT1prNjs0rIprreUPGpGSv
         vuHX+hTyt9HWYNj7JehI6GExjUsbJl3WzuNv9NmmJZSfLodLhBmbq7kSrIl9N1eEZFZJ
         2YEHe2HIfKg1wo6zQYQAbMYD3RWdsFemXBRAHVIBiZpdgA7SYpPfcmiJdj/yvuITC34e
         n/JWanCOWB9m9KPXZOuh9mS427xjdablwaKG0RFABbdE5wz1xHfLa7aUkfdsSpOX4liO
         q4GrLu6jMLNHSQdUmnjRNMypCfubCFCIQoh51wLsxdtM2x+wWry0uwjHMCtPLqRFdt3h
         D5xQ==
X-Gm-Message-State: AOAM530UlZxrjWbgFOgsPYFBzm8j17YsaVO8nJMo1GcZVo3ZZkSkJaID
        hsWuxL1aVfm0RF/RGWdscC15olDaO6Q790zxNXJE00pw+g9aug==
X-Google-Smtp-Source: ABdhPJzIkJofST36Xj70YcRHBhuVfM0v6d7YRdW8jMeo7bmioWl4fVNzGM/e3S5WkV7dfbPy6lk5iU118kK6mM2Ge34=
X-Received: by 2002:a05:6512:b0f:: with SMTP id w15mr18818927lfu.333.1618985009814;
 Tue, 20 Apr 2021 23:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210421020427.2384721-1-dlatypov@google.com>
In-Reply-To: <20210421020427.2384721-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 21 Apr 2021 14:03:18 +0800
Message-ID: <CABVgOSkgGr+_RVkzsThP_OJjytAqygB7VubcuTaZxznBhpu6Mw@mail.gmail.com>
Subject: Re: [PATCH v3] kunit: add unit test for filtering suites by names
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 10:04 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> This adds unit tests for kunit_filter_subsuite() and
> kunit_filter_suites().
>
> Note: what the executor means by "subsuite" is the array of suites
> corresponding to each test file.
>
> This patch lightly refactors executor.c to avoid the use of global
> variables to make it testable.
> It also includes a clever `kfree_at_end()` helper that makes this test
> easier to write than it otherwise would have been.
>
> Tested by running just the new tests using itself
> $ ./tools/testing/kunit/kunit.py run '*exec*'
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

I tested this version as well, and it still works fine.

Thanks.
-- David

> ---
> v2 -> v3:
> * Rename variable for filter_glob module param to avoid compiler
> warnings. Couldn't think of a better name for the argument.

Neither can I:  filter_glob_param is fine by me.

> v1 -> v2:
> * Fix missing free in kfree_subsuites_at_end()
> ---
