Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3AB4164BD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242645AbhIWSAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 14:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241666AbhIWSAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:00:16 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D72C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:58:45 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id v10so10744520oic.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/JGn7mZwyWEwvBIvgUj4s0mm3yX6tvXxieiY/3sFb9c=;
        b=eKHRmobrTKvX9OlfAVlI68moajAjt2gluGkx14vGjyd3eSoXJRifYtu6ETzExJNDkr
         9WwBRBQRLc3x23Cyp5vdF64642s0JcjjOHVOUBSGSHELJOxD+5gKSM1QHkp8H3nCfSXP
         OC/hVyIj3wHa67h9LRYWvipT3Fq7M5m1jUD/jIn4eNtbwv4JsudBZoApuubd9dMhTBRY
         U3zIwG1F/ceeJHIjy0MmryWnFndl/8zfewojlq/DaHlBQwFxEdlhTzTbz4nhPn5kAHE9
         /LTsl7/48rebvyG8OIhIbIPLkDR6Zxusn4aryK5lssbHvf5+TdOrDLHr1UBrsTxmo3k2
         E2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/JGn7mZwyWEwvBIvgUj4s0mm3yX6tvXxieiY/3sFb9c=;
        b=4lrF+inOIEgaYHP5sVwmD7McyGDqffCRL0JSZC3Z+DK9yeUWICz1Can7+8pU10SNdB
         nQVoc4YZ90dks+XhykqYtzuXB4nnbgV6H2dPPxhnMdmSjCXrPbMmsvAw+eOSZ3A75MI0
         gbV4Gf231XweRaw0HTjXegbg29RQ+hheTX+rnSLveXonWi9xxoPJ6sv56Wsw48e/qFlF
         V6Cu8f9oCkQtOsuZSxTi2QujBHWdgJrsCYxCgBv7tkaQu3TqAMh3X+4d2gLninPcO950
         mYn4ArhR6BAXaPCgB6OJ+YC1yjlbRPbiuKnQw/YeWHzcFkqs3Yj/ERk3xmD1XAeyzOFP
         +5iA==
X-Gm-Message-State: AOAM532+e2LwejTlgvAalt5hFM1815oLSQFXL9j4ueTwHrTrxUFL9GyG
        AlAC372zlbT8+byjHrzAReU2eABTPBvs5m97oAQMqQ==
X-Google-Smtp-Source: ABdhPJxP+R5TTtQoY6TPBeTHbuew4eJjCR6xYzCOFeNXQZtxpHfkr15piDJ3FAgupq3hSTTELaf7kJS3m5wF1yVAUVA=
X-Received: by 2002:aca:db06:: with SMTP id s6mr2697081oig.70.1632419924159;
 Thu, 23 Sep 2021 10:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210922182541.1372400-1-elver@google.com> <CABVgOSmKTAQpMzFp6vd+t=ojTPXOT+heME210cq2NA0sMML==w@mail.gmail.com>
In-Reply-To: <CABVgOSmKTAQpMzFp6vd+t=ojTPXOT+heME210cq2NA0sMML==w@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 23 Sep 2021 19:58:32 +0200
Message-ID: <CANpmjNN1VVe682haDKFLMOoHOqSizh9y1sGAc4dZXc4WnBsCbQ@mail.gmail.com>
Subject: Re: [PATCH] kfence: test: use kunit_skip() to skip tests
To:     David Gow <davidgow@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sept 2021 at 19:39, David Gow <davidgow@google.com> wrote:
> On Thu, Sep 23, 2021 at 2:26 AM Marco Elver <elver@google.com> wrote:
> >
> > Use the new kunit_skip() to skip tests if requirements were not met. It
> > makes it easier to see in KUnit's summary if there were skipped tests.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
>
> Thanks: I'm glad these features are proving useful. I've tested these
> under qemu, and it works pretty well.
>
> Certainly from the KUnit point of view, this is:
> Reviewed-by: David Gow <davidgow@google.com>

Thanks!

> (A couple of unrelated complaints about the kfence tests are that
> TRACEPOINTS isn't selected by default, and that the manual
> registering/unregistering of the tracepoints does break some of the
> kunit tooling when several tests are built-in. That's something that
> exists independently of this patch, though, and possibly requires some
> KUnit changes to be fixed cleanly (kfence isn't the only thing to do
> this). So not something to hold up this patch.)

I think there was a reason we wanted it to "depends on TRACEPOINTS".
If it were to select it, then if you do a CONFIG_KUNIT_ALL_TESTS=y,
and also have KFENCE on, you'll always select tracepoints. In certain
situations this may not be wanted. If we didn't have
CONFIG_KUNIT_ALL_TESTS, then certainly, auto-selecting TRACEPOINTS
would be ok.

If you can live with that, we can of course switch it to do "select
TRACEPOINTS".

On a whole I err on the side of fewer auto-selected Kconfig options.

Thanks,
-- Marco
