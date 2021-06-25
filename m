Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1383B4885
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 19:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhFYRzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 13:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYRzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 13:55:54 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA261C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 10:53:32 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id o10so5545783ils.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 10:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yJBJsM9ajXtVp6Fzt8hy1rMimz6KTG+kuA4EnxYzffE=;
        b=Mm+NR0Yqn2xUv2cW5qE/hI4p/BbctLiKnEdYGlu+sbSPo9ePnZRHMot+XYMFsVqAcU
         2fAH0D6t0/6XM+Ef/4xRdncFkUdw7GvbomjW8dc2Pux4zS02DbytNwdy+zerwU1jpgDC
         8fGqvJeR/iM24WDyzxh86hcAbYaY2lB0OiXx6cJTRTBMXXC6VbrX0d1fWB0Uzg3NmBCl
         0xxGSOT4GWIvifUg9rvHWIW70jAahmBa0YVnfrzFdtgUytJ5irQHAGg5ie0ptf1PZgY9
         RTRklAGK8pW/jnCFKoHH6wpLmLS2MIcFzGljgJ3M2BDhdthqZ48f2xI8erKqZDH/muZ5
         JD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJBJsM9ajXtVp6Fzt8hy1rMimz6KTG+kuA4EnxYzffE=;
        b=WYstX88s91ZomStm4Q/5diB0bEdWwy7N6eTWF/zrqxRG6JuykTp2whe20P8uVUCQ/Y
         Y8Duw1sk3aQBCi1FG60TWWcfF0CiuYCN0QtOnIU/Cb4mGkwrDC4nXNIPJuW+59ZTIFSP
         iS7613df2Gt+tzoXYzpSjkDSROVXfsaoPBOMs+qtZWSgOwxs8HnqEMkP4YkNGqXKtYsv
         lNPI2Dy0WSLWkY5kxjQVRBde0h4OIrQceGx61+SfKRyMuwg4wyS2gRRdHX7Dbfrb8/IQ
         G+MjJvp2rYwuJLzeKa8+/jiLzVpRCF/a4Occtx8Luwt4+cIPjkAPrC8O9ViaP0IaA1e5
         v9kg==
X-Gm-Message-State: AOAM533iRrHymwzLEHswX7kR7Ut6der4O7AJk/dPU6S4z6Oi806o7g6c
        2s990mSi1HO88jGPLGK2KUK0/xmLTtKtTbzQhBrCWg==
X-Google-Smtp-Source: ABdhPJzHuMEE4a37QQdqGNlBNvFXA5rJ+qYGetNhq9D5pL97zLcWDucPVAn/GokOB/oySJuUWrrHOBkOhJyD/dIm+bI=
X-Received: by 2002:a05:6e02:1068:: with SMTP id q8mr8231792ilj.194.1624643612214;
 Fri, 25 Jun 2021 10:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210625195232.3a307e53@canb.auug.org.au>
In-Reply-To: <20210625195232.3a307e53@canb.auug.org.au>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 25 Jun 2021 10:53:20 -0700
Message-ID: <CAGS_qxq4_G7dbefETo57hUZgD+A3QK7rxiY=Nk=m0xZGt35zGw@mail.gmail.com>
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

On Fri, Jun 25, 2021 at 2:52 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the kunit-fixes tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
>
> lib/kunit/executor.c:26:1: error: expected identifier or '(' before '+' token
>    26 | +kunit_filter_subsuite(struct kunit_suite * const * const subsuite,
>       | ^
> lib/kunit/executor.c: At top level:
> lib/kunit/executor.c:140:10: fatal error: executor_test.c: No such file or directory
>   140 | #include "executor_test.c"
>       |          ^~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   c9d80ffc5a0a ("kunit: add unit test for filtering suites by names")

For posterity, David sent out a patch addressing this here:
https://lore.kernel.org/linux-kselftest/20210625111603.358518-1-davidgow@google.com/

>
> --
> Cheers,
> Stephen Rothwell
