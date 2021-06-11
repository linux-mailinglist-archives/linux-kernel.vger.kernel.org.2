Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3083A4AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 23:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFKVnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 17:43:23 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:56114 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhFKVnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 17:43:21 -0400
Received: by mail-pj1-f47.google.com with SMTP id k7so6401582pjf.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 14:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aTtVmQE1L0tigro9e4OhQHUvzXLTzBpGS5nmzldfqwc=;
        b=jJx0bhHT/QYKG7u09mfetN83sWnyZl4PppyYjtMbKsPHfgg2j9ZKiCmUh6A6ywKXYM
         PoMXSabPZ2Xe5Qod9BdxbY2OR2loaiT5hgB5SGZsWejMtOR9eQvY+kjmozqDCS4x5q4y
         nmkXMoNVDFNjXIdXDVaviSUjYLD48liOSqII147GBFEFD70fyx2lHtFcyOOSJRaSLwlp
         f7HpaUMCB6Srlbys2kMB2iZowXinKsQDQ/8My0RmLXtcH5wdZTIBzBgK7/70c1jGDQsr
         hbnTOgZtGJmj8y/6vAbNRl3oZmfBWArve8Sv6c5Wbfj7Mvhi2Xr+GNj6fpVmfDArxoYb
         5J9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTtVmQE1L0tigro9e4OhQHUvzXLTzBpGS5nmzldfqwc=;
        b=A9jH5rcOpVzlTEBrF3H7tfvCw8HENRem5cXQQeMl6kEHO79HpNT03OImjtR+DsoBQO
         /gzeKyQ2whWVBcq2yhW7E/pgfV/8p9X1I8Sam3Xbf1LvzpmWWmrEZlc1YqhqvJrCBaj+
         8OXGy8BE3BemBx1lf7q2+HA1JP7gsACTitUlLL5tlEXZ/RfSlyw1lgteTm1YQ5lIvB/Y
         FyqhO9NrstVjyPZJf6nh0UolqM/RyURLuXVxSh5Wjy4hO5Sm/yRhvYZojooyCcwSQm/A
         hZX04XcgsIYOzXT2w6Is9TXHpKT1X1NhIbIbqgJaPab+t6CUGkkZmji5RUlMTMPF9+nn
         w1iQ==
X-Gm-Message-State: AOAM533DL5HixU/D3W27DC+WcJaft52VHBMbNzrWLe4MA3fNdRuzjeNo
        Hx27Pk6zTnZgeS5Hoiwk7ykekfOzixRvWDA6m4vNqg==
X-Google-Smtp-Source: ABdhPJxYQ6rOcj/Pc8nl677xEo50DjwzTY7i/8/w0rKNj2bfYjXeh5/9H1wA16r+c5rLPBLU/bkVky4FgBu2rALP5Ac=
X-Received: by 2002:a17:90a:1941:: with SMTP id 1mr11053249pjh.217.1623447622921;
 Fri, 11 Jun 2021 14:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210421020427.2384721-1-dlatypov@google.com>
In-Reply-To: <20210421020427.2384721-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 11 Jun 2021 14:40:11 -0700
Message-ID: <CAFd5g44TNA7G1mos-f3N87p5BoVnc8ffoyDWN2ikeGc2WKJOMA@mail.gmail.com>
Subject: Re: [PATCH v3] kunit: add unit test for filtering suites by names
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 7:04 PM Daniel Latypov <dlatypov@google.com> wrote:
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

Acked-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
