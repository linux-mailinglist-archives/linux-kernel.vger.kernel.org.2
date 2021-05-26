Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59659391321
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhEZI6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbhEZI6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:58:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43464C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:56:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g17so3487wrs.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K7NpCLx+T+/qw2b60MwQ3OuH59+WPyv7Tip9lK6qz9o=;
        b=qqGXkkpBz7nj1ca0VVu0jlluSyMwQnx3aBzbc+KdOnJZLNUISBuqhPMQInApwuHcwJ
         rgVTY1NHQvBwGz5/jtZovYuGT0y9PLUxjckxRieKGxb1XVVNROS4izcXAMVIIsKaJAzt
         ZskdnZA3cklB7Uo1nH/xpyA5f66I1EAHDuo3QMtScSYN81sfOtwxZTNq8vM7UtlcUqIS
         ACUfLhO0DCqhTIIB0zvvl8VvJ+Hx7K96mCUgJ/CKMUUN0R2OecyLuPD3jcc+xXNCV31N
         m4LK+oHu6ZkJakBTF4+xqmFb9DIgWjeEaFLTGTNB6vx8MbNqtSXNSMnwjyaoNjb7Erih
         zoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K7NpCLx+T+/qw2b60MwQ3OuH59+WPyv7Tip9lK6qz9o=;
        b=t37a4T7GlqEp9aWKrtMxAQPY12QHLR+w35JOaa9/vRud4y8B/wQm6TVAvAqySgmydu
         qzxcNU/Sq1n1qgS5WpmdrOeZTaA/sXujL5cF3QrcIxikF0qTLKG/2SfGXenXgGek8vON
         7DQX9aWZP3qzKAKb6WhMpqeXwip4Qp206Q2m8LoZKV5ssjye0TCwGo0h7YDPkKu1gyOS
         ISk0fvty7W7JI3aw5UNVVFcQ0VwvzO4vtvR3MifEY+zBZO0y4yTF+zWzfYlSmwPtTvW4
         dIWzNo9/IETDh4Usk4Mbd+1+VmXpTiVqJrSQDbriDQAbtxSSoh3bKRBG9TNM+R3oG5/O
         XuwQ==
X-Gm-Message-State: AOAM530s6saCNkji4c1zuAIrt0IiSaCWLQTZvxwwxRa0RjQKGAQmImEA
        sRbuPNckOcQp02m9l3CjWGRK0A==
X-Google-Smtp-Source: ABdhPJwftkFqIr2HchtCbJPxZMNNZjAtGNzdX3FM8N4HFhwh22bc/9T9CDev6qiyeU/TEmiTQQrUTw==
X-Received: by 2002:a5d:508e:: with SMTP id a14mr31472403wrt.88.1622019404659;
        Wed, 26 May 2021 01:56:44 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:cd98:de82:208c:cbdb])
        by smtp.gmail.com with ESMTPSA id f1sm21876645wrr.63.2021.05.26.01.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:56:44 -0700 (PDT)
Date:   Wed, 26 May 2021 10:56:38 +0200
From:   Marco Elver <elver@google.com>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kunit: test: Add example_skip test suite which is
 always skipped
Message-ID: <YK4NRlyrYJ8ktsWQ@elver.google.com>
References: <20210526081112.3652290-1-davidgow@google.com>
 <20210526081112.3652290-3-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526081112.3652290-3-davidgow@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 01:11AM -0700, David Gow wrote:
> Add a new KUnit test suite which contains tests which are always
> skipped. This is used as an example for how to write tests which are
> skipped, and to demonstrate the difference between kunit_skip() and
> kunit_mark_skipped().
> 
> Because these tests do not pass (they're skipped), they are not enabled
> by default, or by the KUNIT_ALL_TESTS config option: they must be
> enabled explicitly by setting CONFIG_KUNIT_EXAMPLE_SKIP_TEST=y in either
> a .config or .kunitconfig file.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  lib/kunit/Kconfig                   | 15 +++++++++
>  lib/kunit/Makefile                  |  2 ++
>  lib/kunit/kunit-example-skip-test.c | 52 +++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+)
>  create mode 100644 lib/kunit/kunit-example-skip-test.c

I don't know if this test is useful for a user of KUnit. Given it's not
testing KUnit functionality (I see you added tests that the feature
works in patch 1/3), but rather a demonstration and therefore dead code.
I don't think the feature is difficult to understand from the API doc
text.

Instead, would it be more helpful to add something to
Documentation/dev-tools/kunit? Or perhaps just add something to
lib/kunit/kunit-example-test.c? It'd avoid introducing more Kconfig
options at least.

Thanks,
-- Marco
