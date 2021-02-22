Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9474332223E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhBVWj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhBVWjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:39:20 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AC1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 14:38:40 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id w1so12343822ilm.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 14:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+bRTmjwUn3uBzqoT+jMaNbtbzbUVi4q8qV4RGj6hQY=;
        b=EgH6YhENDcXw0kF2Lm0gvd7DSF0AdF8mGL6MkxAGbZ1FixDC4XmaEkJfB9fe7SpEsC
         EHYkrqPUje5df/yuI6UDgecqj1IdaGuAt3d/6+P26Q5ZCrJ73BdFlXECVIXsZucTCN3X
         wHbCC6rZvQJLYOdgvF0Mf92a26AbdPv1GvvWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+bRTmjwUn3uBzqoT+jMaNbtbzbUVi4q8qV4RGj6hQY=;
        b=ZJ7dLDPNgq/MyFoYrO/+brcdxsdUvi6W++4Rx87XSvCGk4J5oaIzki7B7OsBvONBKE
         7LUmMkfXneFo4nj6TDsZQpr3Ms2Kkcj8ICNHfNHQyxv0X4vSgTBbdjp5WEFaI3kUFwlM
         MX8MBQzzMLlbovryjhNJ7bfWeBm/tsoFTw82Z3znRtxRg0C42eBIOp65cBxHGsF7w1KN
         TG/2gEup+QwZnohMzaicQpgpJX3cJHXL26WiYQUDlRNkzNNeFjnjLWQSQ1vcBdWeSbTO
         YuGfRF01YApUIhe2/mxJYsd4CUWTFNtfmwNinRZLj/fBQiM8FukBaqSHlnRtmBmGi9vH
         YfAg==
X-Gm-Message-State: AOAM531f/OeCC/2QCmvQcjOuEi/kT96nM+AT1jTJRCE0avdNGx/c4lYx
        Y9br52gm/taxvl26Usp3HOJTNru9mrXv8ouCDqRO8HCPig==
X-Google-Smtp-Source: ABdhPJw2TIj0o52iS6C93kPC5ubNmLckikW0/NOuSjuDGxRpxJiLWiY/8Uw03gMhec9boJyB0dzpYovmHDPrLT3gaes=
X-Received: by 2002:a05:6e02:4a3:: with SMTP id e3mr16432525ils.77.1614033519752;
 Mon, 22 Feb 2021 14:38:39 -0800 (PST)
MIME-Version: 1.0
References: <20210204052643.1608586-1-atish.patra@wdc.com> <20210222202241.GA82802@roeck-us.net>
In-Reply-To: <20210222202241.GA82802@roeck-us.net>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 22 Feb 2021 14:38:28 -0800
Message-ID: <CAOnJCUJq4Gfd_YvJz5K2yFwmsSiB3LDM6rSQ2d+O+jV8b0z_wg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Add a non-void return for sbi v02 functions
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 12:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Feb 03, 2021 at 09:26:43PM -0800, Atish Patra wrote:
> > SBI v0.2 functions can return an error code from SBI implementation.
> > We are already processing the SBI error code and coverts it to the Linux
> > error code.
> >
> > Propagate to the error code to the caller as well. As of now, kvm is the
> > only user of these error codes.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> ...
> >  #else /* CONFIG_RISCV_SBI */
> > -static inline void sbi_remote_fence_i(const unsigned long *hart_mask) {}
> > +static inline int sbi_remote_fence_i(const unsigned long *hart_mask) {}
>
> Error log:
> In file included from arch/riscv/kernel/setup.c:29:
> arch/riscv/include/asm/sbi.h: In function 'sbi_remote_fence_i':
> arch/riscv/include/asm/sbi.h:150:1: error: no return statement in function returning non-void
>

Sorry for the oversight. The return statement is missing.

@Palmer Dabbelt : Can you fix it in for-next or should I send a v2 ?

> Guenter
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
