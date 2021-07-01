Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7263B8DBC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 08:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhGAG3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 02:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbhGAG3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 02:29:04 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E2CC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 23:26:34 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id k1-20020a0568200161b029024bef8a628bso1299094ood.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 23:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=weLO0U8CcMdO2GwWr9sKBhxG+qWHdNo4kkTxiwdSbK4=;
        b=SqGXprIAcInGnP7tK3RzkxDFPtE76fgh9ARvCCa7CynU5vIKHM8LIhUULBtT6tjx8N
         qwAYUrFIBI0aO8DYME+OnXVK8NVMazv5UTd95r/fhCJpc1ZfdwQWrx19YftkIIyLM57I
         uhhw2w3/2CjU+Fr811EXVEsI+nWRRi9LpedTh/wNkrsfhXM7sW9Be1j4md9z8ojoLG/e
         eO7l7TCzk2EojkLLOoQrmldA2gYDFbVCla7jxoXjXCaht9NVdxH71hPso7NAg3QHmyZY
         5G61NKyHCsXiZQsg6gdg6MmyQRSWR/Q8v16KHHibtvvED7ygDyUg7JeL1XAE1j6fptrF
         E+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=weLO0U8CcMdO2GwWr9sKBhxG+qWHdNo4kkTxiwdSbK4=;
        b=sZzZHQM3i1aCHZVNk9nO7b+wpGcEdzENO0Mb+nDIVcQ6mHwzKLAkUDjxM3lSJL/yaC
         nUEno3E/l/13h5T/MSCbu1WysdYgIqMwG7MqCaGt++f532Kve2jZcf0qx9jozGIQBeDt
         UU7s7DkojZh1n+nOYty8Z6IcrwKAKFdScteKNETmkGsfVmVCBbnE4WWfaXsTDjonQ89k
         Tq1757Jv1HjyDMsyCe4litEPqQ2tvleoCqOWoXiYPxM/YvXzIuuVnPjHxf+Lu711ZeVi
         DpABj6PJJSRaPuKGgqUyNNI8XRDAPTog1HjjvCaye8GCDJw66XHMi1Qzgbon92i8/T1v
         FHdQ==
X-Gm-Message-State: AOAM5312oRJoX/0IBBXGKANgAO9IJomI99wbaf3zi1CCxCQ2uVAWM6+e
        jipbyuFJF+Ny1/9Ge1HcmyO2akEG5HDEsPxkIsugQA==
X-Google-Smtp-Source: ABdhPJyE6V22IxIuIcUaAU/qzpVLNqrO4pmbeOz/TNrL7m3Q7QtNRt8NZqMaVLud4itqp0JzKz+A5CQRB6xzqHmv2ok=
X-Received: by 2002:a4a:9406:: with SMTP id h6mr11669704ooi.36.1625120793225;
 Wed, 30 Jun 2021 23:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNMh9ef30N6LfTrKaAVFR5iKPt_pkKr9p4Ly=-BD7GbTQQ@mail.gmail.com>
 <mhng-d63a7488-73a5-451e-9bf8-52ded7f2e15c@palmerdabbelt-glaptop>
In-Reply-To: <mhng-d63a7488-73a5-451e-9bf8-52ded7f2e15c@palmerdabbelt-glaptop>
From:   Marco Elver <elver@google.com>
Date:   Thu, 1 Jul 2021 08:26:21 +0200
Message-ID: <CANpmjNM4nJBu_7HyEGdb5x-me25duwH_kLU01XBZANEBTO3EhQ@mail.gmail.com>
Subject: Re: [PATCH -next v2] riscv: Enable KFENCE for riscv64
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     liushixin2@huawei.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, glider@google.com, dvyukov@google.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2021 at 04:38, 'Palmer Dabbelt' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
> On Wed, 16 Jun 2021 02:11:53 PDT (-0700), elver@google.com wrote:
> > On Tue, 15 Jun 2021 at 04:35, Liu Shixin <liushixin2@huawei.com> wrote:
> >> Add architecture specific implementation details for KFENCE and enable
> >> KFENCE for the riscv64 architecture. In particular, this implements the
> >> required interface in <asm/kfence.h>.
> >>
> >> KFENCE requires that attributes for pages from its memory pool can
> >> individually be set. Therefore, force the kfence pool to be mapped at
> >> page granularity.
> >>
> >> Testing this patch using the testcases in kfence_test.c and all passed.
> >>
> >> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> >> Acked-by: Marco Elver <elver@google.com>
> >> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >
> > I can't see this in -next yet. It would be nice if riscv64 could get
> > KFENCE support.
>
> Thanks, this is on for-next.  I'm just doing a boot test with
> CONFIG_KFENCE=y (and whatever that turns on for defconfig), let me know
> if there's anything more interesting to test on the KFENCE side of
> things.

To test if everything still works, CONFIG_KFENCE_KUNIT_TEST=y
(requires CONFIG_KUNIT=y) will run the KFENCE test suite on boot.

Thanks,
-- Marco
