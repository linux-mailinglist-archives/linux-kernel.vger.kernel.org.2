Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E268F32C2D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353897AbhCDAGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345743AbhCCU45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:56:57 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E53DC061760
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 12:56:17 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d12so14604469pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 12:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+b2zqjjO7XaOk1Sanx6qu5v5MCk7/BvyqD69LNQ9mK0=;
        b=P4KGzAXUBDSu5KGYhcWGT8DHRvIjR3hc0Ix2t1WV85OKP2mB8pDXSaVfDIfdFOgn3E
         A3SLKxR1jk7JqoXoilmnShc2jwflP6hNkeGEgtdfLfeAX828sZ6PfNcGYyKsaKrJcnA4
         +bpDRGS6e/nQSqi8Q+wIYZVIUKKuhI7f95E9SCUiUAUNkQpSDHGAwLUW/pCP+DloyZiK
         pw/n4ODjzAob3nWghEJyNvKXZFb/ZFgn5T1bJqpzOiVG9Cm4Y4qzJoclNYphnacxT4ZX
         xpE87i/KJ9K6YALEIV60dUAl7ubUEqkZPEIAYNW/Fppo9+KKf9GsXvE12QmJRdYykJpO
         FBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+b2zqjjO7XaOk1Sanx6qu5v5MCk7/BvyqD69LNQ9mK0=;
        b=d/IqKw1KNjIxJXF55lEe+TZ+aNMhSijMkrzVB8ceJdsl9CAV6QgwH6RnYnUW43xLSc
         E9pLik2g4tnG+rMfBfrn4J2tS6TybMXyIhVQsGVIE66NKp6lwRYk/y2Oq+UMytusgM5P
         HoKL3OhNYF5XWoHU5vLZq+kINx8GSKkt56eWFD/1HVL/qgBYMMEboRIdGiW6i+SO7YVY
         Dt9oM/c7etPhqpfiWNKCm7lSBB/CaCCvQ37DRIT61HatX/UG/HsrLIyU4o7AGmyq9O4z
         V0GRccUPxQ4MnQmud4jjiD/DA+izOaucUy22jZxsLg0+VkU9II7rpigtY0IAUCGbgKlw
         IdRQ==
X-Gm-Message-State: AOAM5302o9aGIqIL/AoGtfZIoMalZyhUmLwFvXNx7vxnQslgz50x9Q7+
        Qx7T4H7/xJbMj2YjXP2ZtuLAWvJhVXpc7jwNN+uuQw==
X-Google-Smtp-Source: ABdhPJwd4BjAO1i29YWxiQRBR7BMq5kdeqaEtwUQpg+MvmJ609Ns1wK4zYmNmpOEAPwS3mc+0VpCfAWr7wYc7NlDuvs=
X-Received: by 2002:a62:2786:0:b029:1ee:afe7:6bfb with SMTP id
 n128-20020a6227860000b02901eeafe76bfbmr612545pfn.14.1614804976285; Wed, 03
 Mar 2021 12:56:16 -0800 (PST)
MIME-Version: 1.0
References: <20210303020350.4sahuojkqnkcxquf@smtp.gmail.com>
In-Reply-To: <20210303020350.4sahuojkqnkcxquf@smtp.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 3 Mar 2021 12:56:05 -0800
Message-ID: <CAFd5g47rjt7i7JXWsYarqX_dShHiqSg8StKb7KCqOye3=eyZDg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: fix checkpatch warning
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 6:03 PM Lucas Stankus <lucas.p.stankus@gmail.com> wrote:
>
> Tidy up code by fixing the following checkpatch warnings:
> CHECK: Alignment should match open parenthesis
> CHECK: Lines should not end with a '('
>
> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>

Did you change anything other than fixing the Signed-off-by that Shuah
requested?

Generally when you make a small change after receiving a Reviewed-by
(especially one so small as here), you are supposed to include the
Reviewed-by with the other git commit message footers directly below
the "Signed-off-by". Please remember to do so in the future.

Also, when you make a change to a patch and send out a subsequent
revision, it is best practice to make note explaining the changes you
made since the last revision in the "comment section" [1] of the
git-diff, right after the three dashes and before the change log as
you can see in this example [2] (note that everything after
"Signed-off-by: David Gow <davidgow@google.com>\n ---" and before
"tools/testing/kunit/configs/broken_on_uml.config | 2 ++" is discarded
by git am).

Anyway, aside from these minor points of LKML best practices, this
patch still looks good to me:

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

[1] https://stackoverflow.com/questions/18979120/is-it-possible-to-add-a-comment-to-a-diff-file-unified
[2] https://lore.kernel.org/lkml/20210209071034.3268897-1-davidgow@google.com/T/
