Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9223FC640
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 13:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241267AbhHaKrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 06:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241033AbhHaKrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:47:07 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D0FC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 03:46:12 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso11891475otu.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 03:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/7V7+7rWRxslepcC696+4LLIXt+f9974ayEMgxKj90=;
        b=f1+eAA8Bbvw1rIg30yw2PdmVyf5r85w0D9NUeAlDymmLxEBoMAlQ13y3IXGQd115DW
         cBm1S4pxH9D6dMlRZyRmQw4M7EwDL+pMVV6nFejpqyEoWaN+3pY+MzjCOb2GCvNT5N/y
         rqi8+OlO8j89JgGZT2I9vO+FqnELe1sz7rUSqsXBc10qvbtKBO6EDPEvLykpqWk7AjAP
         Dd8UNQMSdIAHbH4qQ6QHJFoVED0gpuaR1FAIWDDpla0pjIyFgOVmuv/SNIcqtBl0BCs1
         3b2cLtZltEmjgG4xM1OAN8eXE3ZRciaG2j2EQgJrAopYNowJxbKz0TfyIMQev1jZxjmo
         +9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/7V7+7rWRxslepcC696+4LLIXt+f9974ayEMgxKj90=;
        b=BL6WjYng2VlyUBnhh4qdcLH9QTKlDd8hvEYyu0lRyy8fXKAFk/xXn9VonK1JPGsIct
         lOE8RcveErqE1HIHsOYtT+4qWEoFhszJI0juREOmc8NzA1PxgdHKDyXaTImsKO7llsGd
         qZr83DCMIut4i/1UdLHythuBcFvEr3VFx7aqA4oWxvg2keEzlPDyQWBVhzlwMR+PwBI8
         IWT7yciiTw1+g+sqvxXTBsXl7TIZL1H/vHZTnevTyuLEmZ5kF138nz88zO2ru/r4iGev
         U3H+nb/fkou8UoeOhAOmRMyQQZnoUtzYUSHFfVqr7k0FpRFsJWuuFS6/NDqmsMzwK9b2
         1AmA==
X-Gm-Message-State: AOAM53059Q8kWVZOAGwxx02qdMHH5n7tLyYRJPSsPJeEuDd/Zka8j1UW
        leX5bICXBVFB+3XBdpVu8Koa495x3ilNI5OHIB32sw==
X-Google-Smtp-Source: ABdhPJyu+Z8Xkx3NWpgNa22ldJTrqozVi6Vovf8TudABz9dYWV/rDq5QZYR7OYHQuMz5qke81X/dIh+qVB3Dt5Nw+vk=
X-Received: by 2002:a9d:4104:: with SMTP id o4mr13616099ote.251.1630406771875;
 Tue, 31 Aug 2021 03:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <YSzZFgBt6nMvpVgc@osiris> <YS2RrUma2oOSYtIc@Ryzen-9-3900X.localdomain>
 <82161448-2770-158c-fdd3-d253b4ae476f@de.ibm.com> <YS4AufXrOCa4rzN0@osiris>
In-Reply-To: <YS4AufXrOCa4rzN0@osiris>
From:   Marco Elver <elver@google.com>
Date:   Tue, 31 Aug 2021 12:46:00 +0200
Message-ID: <CANpmjNPp3dAcr+WfYxM6_uQOmFmDf60aL-LbXF12NCzP6P3-6Q@mail.gmail.com>
Subject: Re: [GIT PULL] s390 updates for 5.15 merge window
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        qemu-s390x <qemu-s390x@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2021 at 12:13, Heiko Carstens <hca@linux.ibm.com> wrote:
[...]
> I really don't think this is QEMU related. The test fails are sort of
> expected: we've seen KCSAN reports when the kernel boots and wanted to
> fix them later.
> However I have to admit that I wasn't aware of the KCSAN KUNIT tests,
> and wouldn't have sent the s390 KCSAN enablement upstream if I would
> have been aware of failing self tests.
>
> We'll fix them, and I let you know if things are supposed to work.
>
> Thanks a lot for making aware of this!

Note: Set `CONFIG_KCSAN_REPORT_ONCE_IN_MS=100` (or smaller) instead of
the default to make the test complete faster.

The pattern I see from what Nathan reported is that all test cases
that expect race reports don't observe them ("not ok" cases), and all
those where no races are meant to be reported are fine ("ok" cases).
Without actually seeing the log, I'm guessing that no races are
reported at all, which is certainly not working as intended.
