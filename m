Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B005C3F72C4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbhHYKPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239654AbhHYKPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:15:37 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46469C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:14:52 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso49111468otp.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ex9BVVFADdOQoNAST2PICmKZlAuG8UXgh5xdQmKSPzE=;
        b=UfV7KZLIX0IHqDWQWMtq6etSMh8CW/SmOIIQh+/JSfNIlakrP2NbX1XRziwQ4EXv+C
         HIpRfFgs+UL2qYAk3cWDwmR+MZ/qNitZk/8xptk4XDlAkxAFf+zKqNdYIMunxR/FfSFr
         oMhD4y8xWeMtF31ZBlui5yTV44QnscFPJP28iw2L1yG7khcELZ9k5FIX601iEbsDKhXK
         UBQu2y9r4a2g+C+q8bLYzfLBS2Y8aQn6rQlpOQD/+NlBYdD9HxyQxyxthjvmVAXe0bu3
         PgpBRcyUjYyiUoYSoO5saxHAMYqWusuYcnhAGsGghRY1m2RMsx6DAybLWiJztg1mrAFi
         LzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ex9BVVFADdOQoNAST2PICmKZlAuG8UXgh5xdQmKSPzE=;
        b=m3VBPDiNpVcnQZLm5cfpwjhmJDkTGQ3URXGyBu1aa+I4wbvDa1PbmJrvPLksCAfmqv
         QjMWlIxbS0S4x3c047YjEBE8d1iA+z1IeHw0bs2o/MGSXO8uJohEdYqkAbNq/8oOnped
         59p3xmdJSceifZBerpwoEheSoQy70syhL0aofRfPqRkqc5rIDEoeqUqwM3gkyuEXMBWt
         913njB1pxrEyje2ADq7QIOiwVKne4dy6Z3zwAPa1L1NOaKyF48eEIfoX2ib8aS/MqQlj
         jmiFF0g4YOdLzf3lj84M+9ziGWz0KlUJImYEmR6PiVKh/osuVvJeVPxGC7+aVyb+XPWR
         NG2w==
X-Gm-Message-State: AOAM531PqMNquhZCNUa1KgQEqYO81X5KO9POtoH/rekk6E0RVGxFOE5q
        fgM85l0rRIAtn/PvhnuvLOxxUzt3hkttbP7DJXgJ3A==
X-Google-Smtp-Source: ABdhPJxSew18MfiAoXwSPwPzfLYPIZcMkg+5tvv4NchP9NYLMV9ufqzmPcFrrvWWqEKA4vqImmMnPrELh9RVoqj4er4=
X-Received: by 2002:aca:4589:: with SMTP id s131mr6177609oia.121.1629886491492;
 Wed, 25 Aug 2021 03:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210825092116.149975-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20210825092116.149975-1-wangkefeng.wang@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 25 Aug 2021 12:14:40 +0200
Message-ID: <CANpmjNMnU5P9xsDhgeBKQR7Tg-3cHPkMNx7906yYwEAj85sNWg@mail.gmail.com>
Subject: Re: [PATCH 0/4] ARM: Support KFENCE feature
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021 at 11:17, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> The patch 1~3 is to support KFENCE feature on ARM.
>
> NOTE:
> The context of patch2/3 changes in arch/arm/mm/fault.c is based on link[1],
> which make some refactor and cleanup about page fault.
>
> kfence_test is not useful when kfence is not enabled, skip kfence test
> when kfence not enabled in patch4.
>
> I tested the kfence_test on ARM QEMU with or without ARM_LPAE and all passed.

Thank you for enabling KFENCE on ARM -- I'll leave arch-code review to
an ARM maintainer.

However, as said on the patch, please drop the change to the
kfence_test and associated changes. This is working as intended; while
you claim that it takes a long time to run when disabled, when running
manually you just should not run it when disabled. There are CI
systems that rely on the KUnit test output and the fact that the
various test cases say "not ok" etc. Changing that would mean such CI
systems would no longer fail if KFENCE was accidentally disabled (once
KFENCE is enabled on various CI, which we'd like to do at some point).
There are ways to fail the test faster, but they all complicate the
test for no good reason. (And the addition of a new exported function
that is essentially useless.)

Thanks,
-- Marco
