Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C4C36882A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbhDVUov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbhDVUoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:44:46 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F6FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:44:11 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e14so15260975ils.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOVUzQo28LSmmOywgwII2KjmCVG7Xd72Uk6n1ovFEEU=;
        b=hgkjm6Yy7LFV+uhtOxWUPnxLDrPdElrGvi/37J10Anx0hv90CZlp6OZi4CqyH691DY
         HQ2mwPJfor7IydDNoOxxXKp86qUQeiKfqW8X530mWWDC1FqSE9OjmIZGUL/EtsucHgQ1
         61McCXDUDB45BVjFs1IjZQ7t/gT+A3erFVphjjfeyJ4o0hnvkpCVQMIs9PMAtljPsHtF
         cschpfVgVnduRkWcV6c2+LwIGBuW9crUzzJJGejpBg/G0c4+JyuiDqcKkvZ21fafTqSh
         VX78L1CYXfBFpW4g/lENozy4IOVPQqMl5iQYk5f+QgtEhmufl5qcWx+XKva6Ohavv1u+
         +5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOVUzQo28LSmmOywgwII2KjmCVG7Xd72Uk6n1ovFEEU=;
        b=OD4CBh+ha55bSo3rB9drTSG8/7ZnwWIPnvRtn6G67LNLLopDEbNcv4IjYrDBVKHBX1
         ChcuHhkp3TH70YqQeDIsbIsByiWBS4wkPGKquWqklpnLpOT1cM208yBo8pRgVxhD1c33
         om9ju4SEDrvsRLWZYmD4tU6qNW3GfQ/LfG05L4xIB9AQ0fIIVYQ2rCowGalHylC1MofY
         Us1O3NVWkwovnY2woMPyXonOr8KdQC6R8ERRSSoPmmG7WvI6D50wOJTRBRhQEizQt/gO
         1N3OpFxsxtwn8hBMwBbM/d5mh63esDzUxB82dOgy10OxHnQrA9BJihHmD2dpJG9aVvpj
         KxVw==
X-Gm-Message-State: AOAM531PsoNzDAf0ffIwEq02FLahFYiXvxIwdq+XLD85zFOKB0hiZsI0
        MY4H1OgL8GAnqhcQP9Bod/Z0f/gN4VCZJhxCk3M4wQ==
X-Google-Smtp-Source: ABdhPJzOfuDd+VaeLoWWEJ7JfcwiHjgPKDRNXvR0rgVM7ltI1MeifPRy8GrOu3wBbR28sgNnwsC0+15JZf/uoRTfN0E=
X-Received: by 2002:a92:6011:: with SMTP id u17mr284362ilb.274.1619124250722;
 Thu, 22 Apr 2021 13:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210421183222.2557747-1-dlatypov@google.com> <d7b2b598-7087-0445-4647-8521f3238dc2@redhat.com>
In-Reply-To: <d7b2b598-7087-0445-4647-8521f3238dc2@redhat.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 22 Apr 2021 13:43:59 -0700
Message-ID: <CAGS_qxp6jNDaEjsZKPeJJVYasXqrfvY5KK0QhXaBh68S7anMRQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/test: convert lib/test_list_sort.c to use KUnit
To:     Nico Pache <npache@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 1:16 PM Nico Pache <npache@redhat.com> wrote:
>
> Hi,
>
> Can we change this to CONFIG_LIST_SORT_KUNIT_TEST to follow the convention used by other KUNIT tests?

I mentioned this in the commit description briefly, but I don't know
who is using this test. Nor do I really know who to ask.
So I didn't want to risk breaking anyone's workflow for now (more than
now requiring them to set CONFIG_KUNIT=y/m).

Side note: maybe CONFIG_KUNIT can default to =y when DEBUG_KERNEL is set?
Then there'd be even less change than how this worked before...

If it's not a concern, I'll happily update the file name and config
option to follow the conventions.

>
> Maintainers? thoughts? I recently posted patches to convert some of the other tests that break this format [1].
>
> Cheers,
>
> -- Nico
>
> [1] - https://lkml.org/lkml/2021/4/14/310
>
> On 4/21/21 2:32 PM, Daniel Latypov wrote:
> > [SNIP...]
> >  config TEST_LIST_SORT
> > -     tristate "Linked list sorting test"
> > -     depends on DEBUG_KERNEL || m
> > +     tristate "Linked list sorting test" if !KUNIT_ALL_TESTS
> > +     depends on KUNIT
> > +     default KUNIT_ALL_TESTS
> > [SNAP...]
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/d7b2b598-7087-0445-4647-8521f3238dc2%40redhat.com.
