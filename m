Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9586930FD34
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbhBDTr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbhBDTry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:47:54 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5BBC061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 11:47:14 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b145so2773628pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 11:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M71/0+4/VPdITa6DX0e4x8GpxsKtJ+qFh8ESOZeP7Dc=;
        b=jthU5IMT8bGmrxmtDYWqfxQLlMrYewykUAS8xgvJTl5tztr5hJLifwL5fcoFOcmEFA
         +la2ZcSyETWeMwUOEVSVOgmaCP3WWsjYYu/aFWKhAxeBGJQ+JAsluk3kIG+FyT56tCBa
         51C62Z1yof1LhPxJP6BsbfOtqxMhfXOwgmJdsl/cKFS3dJNpFqH5hUicpsELkhRXIV1O
         dqLG2PCUz+6NBt8NM+D2wbNjcKZicBZfhOgq+s2ARZyjmETtm6aMHy0UIiDw+D3mVUyn
         xSvmkh/tXqHT88epfAg6velP2Yx5JFHCLRey1zNkNrts4Ox3nTgrqkPx/cKTQ/sowMKM
         9Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M71/0+4/VPdITa6DX0e4x8GpxsKtJ+qFh8ESOZeP7Dc=;
        b=CzYAQQclQB9+Pqz2XLx9bGL0VFKkxNB5TeBRwPgvj6qtlMJr0Lby7L9QTvjxzXCZNq
         9m6OkvfNM4qpMurcivVhmsdrdcNLt7GIgU4Alt2asch5erOWRF5l/xsFrX1TNd5xVLBq
         w7XYIYuOElwC0tuNXGJ5R6xYb3qpghPsRZllwlCAv1bwhZXSoVWizwgMYlTc2wNGoI8x
         n26y2JdPmFl5ad1xG6HW2QHixF0X96OEBVLze/CZ2LbiWkcT9sXik6vhrLF8meuZmeTL
         ta0XE/hLFv3koBHflJ31gld8ba8cEFacyny4VI4Uj/ezj+7qjJGmO6DJVnsfdJoiKRe4
         2+xQ==
X-Gm-Message-State: AOAM531ll3JMh9PPDqz7OzbRcgLciAAfum0v98S2NDNq27EpTEqiVgW3
        oHva32rzi+DfeMNDT8VdyXZsy2e60H9+I3nBr8zlBQxb+NQy+A==
X-Google-Smtp-Source: ABdhPJzVtYp2aDG4dPbYfDQH+IIb9J7pzYykY8WzxVxFBR2E4sZ627eieZqffbjTwHwQjMCu8dwASM4FIc20VRqrMgI=
X-Received: by 2002:a62:fc84:0:b029:1ba:9b85:2e92 with SMTP id
 e126-20020a62fc840000b02901ba9b852e92mr871767pfh.38.1612468033581; Thu, 04
 Feb 2021 11:47:13 -0800 (PST)
MIME-Version: 1.0
References: <20210204173045.1138504-1-dlatypov@google.com> <20210204173045.1138504-3-dlatypov@google.com>
In-Reply-To: <20210204173045.1138504-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 4 Feb 2021 11:47:02 -0800
Message-ID: <CAFd5g45_j-uw0tLVv_i6yHXOE46RKpJ7HoXJyfDBGk8=2jxdcA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kunit: tool: add support for filtering suites by glob
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 9:31 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> This allows running different subsets of tests, e.g.
>
> $ ./tools/testing/kunit/kunit.py build
> $ ./tools/testing/kunit/kunit.py exec 'list*'
> $ ./tools/testing/kunit/kunit.py exec 'kunit*'
>
> This passes the "kunit_filter.glob" commandline option to the UML
> kernel, which currently only supports filtering by suite name.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
