Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FA33C98B6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 08:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhGOGRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 02:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhGOGRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 02:17:03 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162B1C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 23:14:10 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso4586106wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 23:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iumvt163jDkMqM/bm6t4hJsjhwsrpweE3EWP0akQoGw=;
        b=v0bm2dL3TxiL2iRA2uvNpplZnLGwT4WyT6g4m5P1Ulx1CkWqfEgYinOyNg6r4sIxg9
         VuKXAXVruEtKvE0GmJH0tTigtNY7q86+TS8x6kyiC6e5r/cevRg1HD8qIqhVGkEwmhZE
         HNQxx1RtoF+xQ1QA2bIkxD45h2ptjnaBtrgRPirU8I2CYrEpcqkoIIIyWlTujHE/uNPs
         hj5vDTPRRDLtJNkrYAvh9Wli4YYpymYuoYoDT+t9jzjGZI8cctPJlzp+vCRy7kX0Dc79
         JShKhLoAAGEa3HkzOwX36T8850SJibc9b42ah081Aq+UKKzPlfw8YK71mkEKVkNA4dDj
         WwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iumvt163jDkMqM/bm6t4hJsjhwsrpweE3EWP0akQoGw=;
        b=jRjzpztpO8RGyLY3lKFcKntROsQLl+Aik2U9U7f9/t/VlQuQUqIBqGWeoGejE8jaEm
         3OX6bN7pTMS64vcCO/IyfBiu7hkPesmmmIzA/4+S06Gn8ezkc57t3C/Dyt6WurUfpUj8
         OC4KNdRrZ80aqcqSHWBlbCab+hoE70kBVlFi6TRdf4oO8OwayXG9SGXA+creHiz9eWZ4
         UxMd1by5mUt5fBNa6upW1Dnm0FZMQwAcFioro7SlM9ZAUnTbxFYcKonOFDbCvDlmxU53
         +q9aCN8FvVDx315tyooAki5RzZTqbm536Mh3oe/BZpSe0UA3daLe7lwhfbA/NfRH2MTT
         K8BQ==
X-Gm-Message-State: AOAM532TUOAk7q8dMUzv4uSW2u6RowvjHT3R9V6bXrpuxU1ljX2Okng4
        Hxm4kO7tSJNEBdXS7UcxH31e3CNJHYAgQAq1ILnk/w==
X-Google-Smtp-Source: ABdhPJyAX1wvxD9+8DDTkqHEx4+aLwegkb+vexvERQtz9pZgDaAkFcb1AMnbCE9SzCYkZtQg54XXTQX5Qo0U8+YNbnw=
X-Received: by 2002:a1c:9a51:: with SMTP id c78mr8520824wme.103.1626329648490;
 Wed, 14 Jul 2021 23:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210714231506.886386-1-dlatypov@google.com>
In-Reply-To: <20210714231506.886386-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 15 Jul 2021 14:13:57 +0800
Message-ID: <CABVgOS=b6+KXp8LP5tAoaFev6yDX4gjrD1i9vBv58Y7JkO_E1A@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: add --kernel_args to allow setting module params
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 7:15 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> kunit.py currently does not make it possible for users to specify module
> parameters (/kernel arguments more generally) unless one directly tweaks
> the kunit.py code itself.
>
> This hasn't mattered much so far, but this would make it easier to port
> existing tests that expose module parameters over to KUnit and/or let
> current KUnit tests take advantage of them.
>
> Tested using an kunit internal parameter:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit \
>     --kernel_args=kunit.filter_glob=kunit_status
> ...
> Testing complete. 2 tests run. 0 failed. 0 crashed. 0 skipped.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Thanks! This is probably overdue: while I still think we want to avoid
this being necessary for most uses, it definitely was a gap in
kunit_tool functionality.

I tested this and it worked fine, but did cause several of the
kunit_tool_tests to fail, largely due to there being changes to the
arguments of run_kernel(). Those should just require the associated
tests to be updated.

-- David
