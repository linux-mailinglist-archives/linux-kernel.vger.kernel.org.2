Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A1F3A05A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhFHVYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFHVYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:24:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4EAC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 14:22:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d5-20020a17090ab305b02901675357c371so141496pjr.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=071Uzgb9AY+jh540o5fVaKWqKER6FWRCb0I4nIFdjJE=;
        b=TKjkBp9vgc4xMse6tHrX/f3ZDC8j76Em477PbsmPyUVQ7nH+4VC5ZxOg4PReHbo/NH
         lxuNaMX1h04Jx/bod2jnFQy+ao3Q8bSxG1DeCUA6RxgVUK8FNhTL2+Ave95+vZ/bN6Pc
         +xIQY9/0NXfrgFUU7wEyUBQpFUXgluDifoyPx5VqkLZXC7aC1zV4/XarSse38ZX+3t8b
         qD1lYQ3ZxzVn3LedPy2rNclyJFH5bR0UbNqZveFwqRzJ/TZJM/Pdew27EtB6cfLiqalW
         FTc2g//nGSc9UZ9bWOEIzZZ7hsuDM0+DoK9YaJP2wYXqJPGhS4Zw/k/IQjyyhMAfZNe8
         h2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=071Uzgb9AY+jh540o5fVaKWqKER6FWRCb0I4nIFdjJE=;
        b=CAf7g6n5H2VFmBVKBlYBn102qp6wpWj6a/LLyTg4TVhahMyIjSJ1R21HJFH0fTIksa
         DB7BykhnMM4asmhsdlgHH9j1Py6nBo/ymJbYxTaWzFtsaqLlgK37ClReZhJDE87bKVMs
         7uUzMpUG6zZDUJrPYl8nVoV3a3vqrAEhx4XJO5+ZhtriZyLe6bfBRJUDv6wSJbTnMnhV
         YSH+AGFxkLN0wKD3MlB2aezoPiK0Fho2qO5JGpfmlTCqHRJP9pL3AHh0WONEccSc2kel
         gn5XCBqhJKeDfObcoO6u2LLOB0zmKfsTJdT6hCmdwvo0Rgy/vioN7vdR1KM9XYNK06Q6
         0sPw==
X-Gm-Message-State: AOAM530E24ccid66ChjDsfxMlnWYdBCTqHnV7vBEq91GV2EIt2oTjVAP
        8RqTtVxrwYklDPJVt7o/ttPudqlfOEHRJ+Q8rusAyA==
X-Google-Smtp-Source: ABdhPJxTN0nT9qC3EjgYzKw7fEO3F799lJjsHiLV+0TAjjn5yW4tlFXulzVcdqGfplgk14yWVWBPIB0xEWl2tgDe9lE=
X-Received: by 2002:a17:90b:47c4:: with SMTP id kc4mr385967pjb.217.1623187352663;
 Tue, 08 Jun 2021 14:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210608064852.609327-1-davidgow@google.com> <20210608065111.610297-1-davidgow@google.com>
In-Reply-To: <20210608065111.610297-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 8 Jun 2021 14:22:21 -0700
Message-ID: <CAFd5g45PkKjU5mH2n9EJcJGLDnjJ6XZJ6HLxPP5a3pw6qQ=g5A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] kunit: test: Add example tests which are always skipped
To:     David Gow <davidgow@google.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 11:51 PM David Gow <davidgow@google.com> wrote:
>
> Add two new tests to the example test suite, both of which are always
> skipped. This is used as an example for how to write tests which are
> skipped, and to demonstrate the difference between kunit_skip() and
> kunit_mark_skipped().
>
> Note that these tests are enabled by default, so a default run of KUnit
> will have two skipped tests.
>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
