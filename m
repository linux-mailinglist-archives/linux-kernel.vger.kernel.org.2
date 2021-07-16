Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E573CB7A7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 15:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbhGPNFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 09:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbhGPNF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:05:29 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E42C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 06:02:35 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id t4-20020a05683014c4b02904cd671b911bso1699409otq.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 06:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bkq9P2VFsm4ppYWuB9WINu1JS/LrWhKDtoo14HRcB2Q=;
        b=GfkhMt2V4wJ6lezJdIVpsqvAaAA3nesByteX7oepAsPKu2JImJDL4PdtVuu3P4AmRy
         X/HdTt0/EjWfSorA2Wb7mayEhHcrZ3lWKqQqwRvSTybAlbDa2wEfzb45Jsqv31vfaOad
         CpLWBqtIHoWf2HmYvYMze50CQcrl6Sdaox3FR1pCzsH/T53AEbVeJv7Qx/KxAlvk8crW
         IzZqqvLbqYeLf0f/ym5JZcujv8D2EBGj/94SnIkqyQj8bdUVK/agUdHglcX3RbU55gUO
         0qEAmzs8DLPzdoOft/uF/WRqZ6fQfpDRlHCp/WVp395QWPYYFDFHpR+VoZLPLsF0k3FS
         4IQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bkq9P2VFsm4ppYWuB9WINu1JS/LrWhKDtoo14HRcB2Q=;
        b=WI1jGS9SWSK6Q4dII+MToSBQnjnbeciMnniahKSn1K0u/NyxyBLdZgjig41NYaTe1P
         mXjlg9EJg9FBuz3TUPtTsGB4rPC3ttRBixN33iBmPOD0KNqwlrvT8FCs7cJ+IuxODwbK
         hcUCqadpAvZVKl/TSg0NeOvvRafkZhzgrrvsGGx481+4rpAIOM8ngKvFdMbm2YAA3Qwg
         xiKmSGk3Q+QVAJ4YxCI7RMq3cRlmHEn3fpUlIDMrayb7xPesVO9++wEZSvX5k3tEQ1NN
         Iou0ziO2CFurbRx50Py7p4cBoqwsbHQF/7Lr7LeC94Yw8zNM1uXn1WekFl5m0oZrtKnH
         2uNw==
X-Gm-Message-State: AOAM532p7vbHxFSqgY0fii/jzAKiq84WYQQD0+aYG8kZ6mAFJqpIRExF
        mmP+EqIMaKSh1XGOXxa6c9vVHNZNHW5zG/ltoszhXw==
X-Google-Smtp-Source: ABdhPJwS7nAJobBYCRZHfSZkgnzqMzhDHnbmdmkjTVBgfhCm3sfnhI/61j8ANgLkH2yO2BLyJuzcept76mUQziVYJZA=
X-Received: by 2002:a9d:6c9a:: with SMTP id c26mr2780403otr.17.1626440554357;
 Fri, 16 Jul 2021 06:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210713105253.7615-1-mark.rutland@arm.com> <20210713105253.7615-6-mark.rutland@arm.com>
 <YPFkzNvUFUfc1vVp@elver.google.com> <20210716122114.GB78984@C02TD0UTHF1T.local>
In-Reply-To: <20210716122114.GB78984@C02TD0UTHF1T.local>
From:   Marco Elver <elver@google.com>
Date:   Fri, 16 Jul 2021 15:02:21 +0200
Message-ID: <CANpmjNNVn4UxBCMg1ke9xaQNv52OMuQjr17GxUXojZKwiAFzzg@mail.gmail.com>
Subject: Re: [PATCH 5/5] locking/atomic: add generic arch_*() bitops
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Daniel Axtens <dja@axtens.net>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 at 14:21, Mark Rutland <mark.rutland@arm.com> wrote:
[...]
> > Why not just:
> >
> >       #define test_bit arch_test_bit
> >
> > and similar for the ones that use plain accesses?
> >
> > And not include instrumented-non-atomic.h here nor do the
> > __is_defined(*_uses_plain_access) change to the instrumented header,
> > which seems to overcomplicate things as it effectively just aliases the
> > non-arch_ name to the arch_ name if *_uses_plain_access is defined.
>
> I'd done that to still permit the compiler to out-of-line the non-arch
> forms if it wanted to. That said, I see that for the atomics we forced
> those to be __always_inline anyway, so maybe that's not a concern.
>
> I'm happy either way.

I'd prefer simplicity. In an optimized build, I think even if it
decided to not inline, the perf and code size difference is a wash.
Intuition tells me that inlining would even be preferred either way,
but I've been wrong about that in the past.

I think originally we turned the atomics __always_inline because of
uaccess regions. Because debugging tools do work in uaccess regions,
arch_* aren't necessarily appropriate. So something like a test_bit()
in an uaccess region might actually generate a warning. This might be
a valid argument for __always_inline irrespective of optimization
potential (if there is any).

Thanks,
-- Marco
