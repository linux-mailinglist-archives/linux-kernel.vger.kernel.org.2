Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44D83B428D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 13:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhFYLdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhFYLdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:33:45 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53385C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 04:31:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a13so10192033wrf.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 04:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7pDUGYHjUXtM+KzpMg/5fieAgKF5U8Yh3hVTk009qQI=;
        b=FCN+AjlS1RgIV3VnJu/eBuwZ9HhLeWlqDDRM4criEw9vthC96mxfnfQQNRcZC5qiBU
         3ShdsChmPOCmiwNg55rMgGj7qekXJjVjTNDv4ZZQ9/HRk+7k/Lt+4InNRabmg6KlwJq8
         sc51mE9/DKe4+mq3DvCijRuwzS3pzPo8cf2J+viji4jv+rqgd/AUrGlSQ2TOL1xK3U0h
         uYxiMl6bLwF+L116DfCgfh49cEn+Hs370pY/x5u+oNt+1mxBdVz5aAwLNzGxQ5bBnsIY
         irkFSI409CqeTopQZ8srgLT2rwMo3jV9UWRJRBTK7/qusv+D7iaTcj4k92po+1fYYY8y
         zu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7pDUGYHjUXtM+KzpMg/5fieAgKF5U8Yh3hVTk009qQI=;
        b=egk2vrRQF3l2/cq8iXxPMXOud1GR0yw+uAyQAFzvERcNH7ZN45/hSbq7j8240gtknF
         bSFTGN6WlOpQ3GX/kXoDvy5nSei8BrrV6oGio1qAdXGaI93xM2Tf3dSAMPm/KxF2Xhvi
         JKrGcF+Q+vDt3ss/9bMt9q4OIREV5mCMqUTloFS4uEiiADl9ZbhAks38Hf0ZpjvPHjDm
         5017/a1GrA4WvFIgwCmsS6woh3cWDspghs4iuxOkvAtIiZ2JXQI6R/kTfzvOe4BIL1on
         UpvpURCU9Hgud55nMjZ8YA4um46cXYbi6qMV/YzshZMEYarWRMuTBs7jWJuTuPloprQn
         dYBg==
X-Gm-Message-State: AOAM530/yTnV92Y7lGwqH3kDBTM4Rzx0GXJgFgextg2Yqm7XH0fMvIeJ
        hmt+uZRFYPGt5/9uGJMK3VJ9CSXYr+1Js3IYJrHD0QFzsdYEJt3z
X-Google-Smtp-Source: ABdhPJzgl8MqeYZoBHr3dhfYJiXL0YzhFFkQ/vkT2EejvnIlndPW+U2kPJdTmyz1PfJVUP1aXzgzOmJcevmTUrbJsHo=
X-Received: by 2002:adf:ea8e:: with SMTP id s14mr10573107wrm.38.1624620682776;
 Fri, 25 Jun 2021 04:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210625200520.7e44f38e@canb.auug.org.au>
In-Reply-To: <20210625200520.7e44f38e@canb.auug.org.au>
From:   David Gow <davidgow@google.com>
Date:   Fri, 25 Jun 2021 19:31:11 +0800
Message-ID: <CABVgOSm6MZ4mtRigj-gtp5s4XDH_Fj0kd9BZ7Y7yx-92NEENrg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kunit-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 6:05 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the kunit-fixes tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
>
> In file included from drivers/thunderbolt/test.c:9:

[...snip...]

>
> Caused by commit
>
>   8f0877c26e4b ("thunderbolt: test: Remove some casts which are no longer required")
>

These are fixed by this patch, which hopefully will be in kunit-fixes soon:
https://lore.kernel.org/linux-kselftest/20210624084823.15031-1-davidgow@google.com/

There's also another issue which can cause a build failure, fixed here:
https://lore.kernel.org/linux-kselftest/20210625111603.358518-1-davidgow@google.com/

With those two patches applied, the kselftest/kunit-fixes branch
should build fine, and all of the thunderbolt tests pass.

Sorry about the fuss!

Cheers,
-- David
