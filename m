Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841D23A8A89
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhFOVD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhFOVDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:03:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFFCC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:01:20 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id z22so602299ljh.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CoAyLiwzAABeU8evuRFmHRs7KdWsfzJoiB5zqUSRKLU=;
        b=RGspZKjKfe5UEq5fXSAxyfxLiMjZgAj9xSvVuw5qYO0OmjbSFGpApLjx27BLp/qzr8
         x1FGp1CjXna3EqevQlSGoQyaNXpMkAt9dhDYQcE+XWk0vSgCuzA9PjxDvkYtuDSCkTES
         3iqj+qpUvZ/Xz4/+7+roFDUg+bTgmiBIVTXXg5iePg7PsHDMZR7QX0EEJN5jEWWMmyLm
         yKDRR79jBhZhejZ3dVpd5RYq1s32gqsphLOLKZTu08VxsoCbWdO5ggMGFudRCh1/r1Ud
         pLj6JkOBJtwAw3KkBDj4hvtp5VoKDWBFhvr73EiPw8ofSSCTqEJFjApCy1ZaQq9ixd3h
         3JNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CoAyLiwzAABeU8evuRFmHRs7KdWsfzJoiB5zqUSRKLU=;
        b=T0KOdejYYxIH6aTu73rT2zRvt1eOWFx7XKAucmcQD62SyjkfRMhQKMn3BqvBctke11
         gvpan7E17W4aapUcE8WFlAAPQ7V5G6bz4N226wxg4VN47qMM/PKpQbDRcTScSaeuSzQn
         ooNQ+ReXDfGlxsUPyLt31YaQIyPqmran4nVERvGr/BGUfEws9dNZ+Q9P6Nv0erF+O9Bx
         WrlXWSZjAPc2OYzppY9i19Hh3PPmIMClpoAkz+sIAKtHD9pkTf6nq9LGLMwr2r+tAUsm
         BhVgmNPYqoLZ9sdWsQ4Zg+wBbljXWYYTli6Nru9smxE+HrxZTpwPWqDqmy0P0J9bRIj7
         bRLw==
X-Gm-Message-State: AOAM531C9C55K4xgvnGXJo2HDPlYUwUt9O5TzDR+h1ycg+PQyJBJ43D9
        ebiH+bE7fZsKSbHC9C5zXRRcOYuyMfLYevbw3G2kKQ==
X-Google-Smtp-Source: ABdhPJyFtC6Zzpj78nBIqyTJD2CXDrr/iWoXgrpVWWQ9oqJ0tlWNde05yv4fWzh8iI3O73NG/IETKCdwy4i05BkDvpg=
X-Received: by 2002:a2e:9ac1:: with SMTP id p1mr1397778ljj.10.1623790877077;
 Tue, 15 Jun 2021 14:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210513200350.854429-1-davidgow@google.com>
In-Reply-To: <20210513200350.854429-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 15 Jun 2021 14:01:05 -0700
Message-ID: <CAFd5g47bbFdWmGHZQN=P93XPG2Bj=tBgK1W1n=LMFLHdO869gA@mail.gmail.com>
Subject: Re: [PATCH] kunit: Add gnu_printf specifiers
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 1:03 PM David Gow <davidgow@google.com> wrote:
>
> Some KUnit functions use variable arguments to implement a printf-like
> format string. Use the __printf() attribute to let the compiler warn if
> invalid format strings are passed in.
>
> If the kernel is build with W=3D1, it complained about the lack of these
> specifiers, e.g.:
> ../lib/kunit/test.c:72:2: warning: function =E2=80=98kunit_log_append=E2=
=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format attribu=
te [-Wsuggest-attribute=3Dformat]
>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
