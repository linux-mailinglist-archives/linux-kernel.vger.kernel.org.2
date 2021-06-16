Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8D43AA566
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 22:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhFPUjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 16:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbhFPUjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 16:39:09 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476EEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 13:37:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d62so1184428pfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/iyaCYOVFTgGt+uLyKcOuwMWraHntMrfp9c4Wvuygsw=;
        b=ozk9b/x9ThmBWrjEaelNW21eP5a7iRJdlV2CCTgf37kQf96+3dtQlK8fT5gDAJUGD6
         DoqqU7iPY42js1IrnSrZAs51SNZuE4YSBqwhCxLJqI0SUQbSmx0EocnWZal25Y2uLaeX
         y8FlJ2epoAYw8VrTJ6c+mPu0L0TXgM6AbaiAlF3dUaO+oLja5SbAZ860YmGZ08ORSYW8
         /Yxsv4BONI8sHpeOSt+G/UHUfbJA2nGZYzZFtoxiGnj2N/jSJkYdrVPKaXKK6zPKlzFK
         nIKVKwGUESHVozEVHgVuoh0FX58K/8UmjfspgpbSLXKOzp3ETt7SlylUjuG+xWOLzVZR
         YmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/iyaCYOVFTgGt+uLyKcOuwMWraHntMrfp9c4Wvuygsw=;
        b=NkgxT9lTHxnMqlnZXmHrrXlJv7/vmKL58OQokfpiDudgCcSU34p9qjU0lAywDAMnrp
         MfNugNN92CR8aPo/FzstsM5SVm4PukZTRdbWPjSqPEIX0uS20e8usJEIPsLSEX5gZxEO
         ITYbtKnPcLwWy+7/ywqmILOvE1KfQ/5PFafIxzkkzYWNaDZbOtsQQL8VvGJCZtiUU7A1
         kPoARM1NXowvMw1tohQtO3bSKqBc3zN+DgLlYjwARCR2pAomEmvsIgk+L1UOWCpiRfRu
         blbkhU4Be0XLmWicsbVAQ2VQ/9JN+iuTHFNNPwCNVppOsOnZr3KIUNGBQvbHXGGFaUmI
         qgNA==
X-Gm-Message-State: AOAM531zmOgxAg6mDI1wEBCBdp8hCNwb98MnXR7o3/2fnV4Cyrldj9wU
        jvjp+XpM1xvY71ds8UVCGO428vUlH7pPb6m6fy5s8A==
X-Google-Smtp-Source: ABdhPJxjnJLJ8Cv1ZHYaqWXR3wF9ISnILfK3oF+Xc3ZEJKCH7abCZfLs1EX3lq0+oyQVuxYpRaebxpvKs51I4p7cy18=
X-Received: by 2002:a63:485a:: with SMTP id x26mr1427134pgk.159.1623875817786;
 Wed, 16 Jun 2021 13:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210522044241.2763088-1-davidgow@google.com> <20210522044241.2763088-2-davidgow@google.com>
In-Reply-To: <20210522044241.2763088-2-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 16 Jun 2021 13:36:46 -0700
Message-ID: <CAFd5g44-zP7VWwBMxSMv=PNPQWNHB-y90kQ4E8WVqs2mWCE2dQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kunit: Move default config from arch/um -> tools/testing/kunit
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 9:43 PM David Gow <davidgow@google.com> wrote:
>
> The default .kunitconfig file is currently kept in
> arch/um/configs/kunit_defconfig, but -- with the impending QEMU patch
> -- will no-longer be exclusively used for UML-based kernels.
>
> Move it alongside the other KUnit configs in
> tools/testing/kunit/configs, and give it a name which matches the
> existing all_tests.config and broken_on_uml.config files.
>
> Also update the Getting Started documentation to point to the new file.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
