Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F36943D37F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 23:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244176AbhJ0VGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 17:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbhJ0VGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 17:06:52 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94C9C061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 14:04:26 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id r5so2923955pls.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 14:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=zpxuAg7jQUmLnVqRxL0JWYSLNWAqarooYhE4X/IQVfg=;
        b=GUAPfD9ayjAlyKHPQU3VjIDAwQlxhS3qIvuj7mGwiwokMtYlQX5b45kyqoqvNN3m3e
         8zXS6LSHX9qk13v6kkjO6bILphRfq/Sm84S7VIDmr9/Ol1cFL1oRGg3wx0EAYE/g6uLb
         upSd9elqlC6Rf2tjtRD4mkdcb7qr88tPjt94JbQbWKrndYD37npC2Ul37cyoxU78b85F
         JIjwjdCly4le1t9OPGMGeNPk/NCGrx99rzJ5tq1FbU1tXJcHkAinP5yhj7BzduZR1SwL
         l8f8KQb5lodgYZO6qJX7r7jHmHd8lTkAN00II5SJItKWWrdqKkon1GfIVXvoiwJ6MWCr
         50Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=zpxuAg7jQUmLnVqRxL0JWYSLNWAqarooYhE4X/IQVfg=;
        b=je50XDSACG7qzKG6XjfXukPg4mHjucA3V/ty4vZcCYJZ4R9+BxVj+QT9mLo1HJ6w9F
         +RnT1tag65w/4NTjXtGXx5bCSklhXDqbX+Se1+tInY5FXlmEJnZgRiOStY6gmuvLppqE
         InCDFy7EEV6n7WLJ5+QIIWtXzopTdmv44aWNoJRxiRNX+RSrIrtb5713XhrKELZEvabt
         alyqxuhp4FnRytp0Thjs/EVLn767JCMpDhhhvD4BTFyCbZ3qNlEHfxodkwi72Kn3fQ7s
         lnSv32uH0JwggyHIRLjUm7e9x+tpJpT8yhzjVFLvRxM/mvRdYhDpSP2E9YQ5LgLIKljd
         tLlA==
X-Gm-Message-State: AOAM5301EWXRcBw9SrziURKSrErdqbSkQXiCTRujxSmgI7QIZ2hRCoSv
        i7Oz8dYeE4GTeX1qG40NU2WUZlWWZE3gxXlvnHry9g==
X-Received: by 2002:a17:903:183:b0:140:47c1:1f2e with SMTP id
 z3-20020a170903018300b0014047c11f2emt87231plg.69.1635368666027; Wed, 27 Oct
 2021 14:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211027205919.1648553-1-kaleshsingh@google.com>
In-Reply-To: <20211027205919.1648553-1-kaleshsingh@google.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 27 Oct 2021 14:04:15 -0700
Message-ID: <CAC_TJve+h_HuhcLC5hVMOvObTiXuVd5JEBtqV67JnV-S1U12Wg@mail.gmail.com>
Subject: Re: [PATCH 0/3] tracing/kselftest: histogram trigger expression tests
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, rostedt@goodmis.org, mhiramat@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 1:59 PM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> This series adds kselftest for histogram trigger expresions and is
> dependent on the series at [1] and can be applied on top of those after
> dropping the patch 7 in [1].
>
> [1] https://lore.kernel.org/r/20211025200852.3002369-1-kaleshsingh@google.com/
>
> Kalesh Singh (3):
>   tracing/histogram: Document hist trigger variables
>   tracing/kselftests: Remove triggers with references before their
>     definitions
>   tracing/selftests: Add tests for hist trigger expression parsing (v5)

Hi Steve, Masami,

Can you give these changes a try when you can please. I believe it
should not cause any regressions now.

Thanks,
Kalesh
>
>  kernel/trace/trace.c                          | 11 +++
>  .../testing/selftests/ftrace/test.d/functions |  9 +++
>  .../trigger/trigger-hist-expressions.tc       | 72 +++++++++++++++++++
>  3 files changed, 92 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
>
> --
> 2.33.0.1079.g6e70778dc9-goog
>
