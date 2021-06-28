Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D901C3B693F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbhF1Tox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237204AbhF1Tod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:44:33 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15262C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:42:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so791629pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjGlaXcqvudKX33z/RwB9jCslwfmADWtBbTwqHYvPzs=;
        b=MV6IzLlAlKnm1q3c4aLPsllvsLDmyRAv/FdjB2hh0QaLKMlC6Tn7HpaPXQ/uO7FFgX
         dnyMZ52oDyeKzgGVl+6/uFjAcX7Ageo2VPkk+E5viqp+HLSQYW38YHoavQTSahva+oWu
         wT2Q3tsSUhFv4cyCUaXZum5nmeZ9T2joIwFHCNLBfaUcCFkz/dpf5IKgWx6deWz0h1Qb
         cJqJQ9RaL3GMyzShUGJctdq7vOAI6uyPB2RTUl3UmrrIcJkDa0KtfH/YEThVMYYC+h6B
         YXbkk8KE4/GmE6jdKZH6z80quqO9xq4YGSBu971vA8VvAjzpYOBQqb5TrmhgD4x0aDem
         XCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjGlaXcqvudKX33z/RwB9jCslwfmADWtBbTwqHYvPzs=;
        b=LXvaP2FWMn/s8rmEOaHkBv+SQdEU6ZCdTijq+0YaW0tuVR73rbWATLbj6lnPONghUd
         HD2MrR24+CZ2r9TlVaolwmSO3FQzy2ygd2et3bGq7wZrTEnwLRAbuCYv0Gd2H0vfiDRh
         S0UQFIMAKqOdsQXkb7/l5g8SY2+S5hEUUEev/qP89mIm3LM2LgS/FuLwIUi0iyjiXm8J
         +j4D2VlhzgiOZcCzSl7qlvKv2EXrJPJIpqLPXRJa5WlV5u9r+oTyzyTTtzKefqnDk4bt
         lXSnwBKss+dAbwDoziVUekTI6LVxPjMhRVcHKHvacnFuYmJZ+qCDN7L3iLIbJzZcbyUS
         WQVQ==
X-Gm-Message-State: AOAM531bCEwdZk4Y+WMqYewRZ5kIFr+NknKXd0Zky4cS2Kt4UwM8UOeU
        QWdbOjHpJIMlxXP3+oKBbrJC9F6w8mnze5HIIhyoiA==
X-Google-Smtp-Source: ABdhPJwv14rBTtgg6oD0x6IW4cETXf8vqsei1g1BiBb5jobrzELCaRfP+u2iPPscADpEXM2xaJmLte1F0fIlFsnhDJI=
X-Received: by 2002:a17:90a:1941:: with SMTP id 1mr39790400pjh.217.1624909327367;
 Mon, 28 Jun 2021 12:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210617073937.16281-1-sjpark@amazon.de> <20210617074638.16583-1-sjpark@amazon.de>
In-Reply-To: <20210617074638.16583-1-sjpark@amazon.de>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 28 Jun 2021 12:41:56 -0700
Message-ID: <CAFd5g44Y0a6HneG+RA-brhJSG+S7GEJSuwGgHCkFssy9vbmuzg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: Assert the version requirement
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     dlatypov@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 12:46 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> Commit 87c9c1631788 ("kunit: tool: add support for QEMU") on the 'next'
> tree adds 'from __future__ import annotations' in 'kunit_kernel.py'.
> Because it is supported on only >=3.7 Python, people using older Python
> will get below error:
>
>     Traceback (most recent call last):
>       File "./tools/testing/kunit/kunit.py", line 20, in <module>
>         import kunit_kernel
>       File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 9
>         from __future__ import annotations
>         ^
>     SyntaxError: future feature annotations is not defined
>
> This commit adds a version assertion in 'kunit.py', so that people get
> more explicit error message like below:
>
>     Traceback (most recent call last):
>       File "./tools/testing/kunit/kunit.py", line 15, in <module>
>         assert sys.version_info >= (3, 7), "Python version is too old"
>     AssertionError: Python version is too old
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Acked-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
