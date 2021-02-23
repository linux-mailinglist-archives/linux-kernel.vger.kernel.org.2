Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543EB322428
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 03:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhBWCc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 21:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhBWCcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 21:32:25 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFE9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 18:31:44 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y202so15551085iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 18:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JEuYJuQRqJcKGWuFA6L1ex4F1e2C+KcEnHJZhT9FdZA=;
        b=kjYopEl2v1bGXaZ3fcTZl8ehpMYQyp4AdStpVTDecP7qg8SCWEtfp1W+/SIfxaZ5qC
         UO6tj7bkHxdq43Jq8ovn4lZsH8SFez5lGU6KQGLSo3kywx0r0UJw3L8ttr+lzVhqAluK
         fHGTnotTk15c4WiWuQZ/TraPWVR5jL8Iv5Tjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JEuYJuQRqJcKGWuFA6L1ex4F1e2C+KcEnHJZhT9FdZA=;
        b=d6GJwVYlJ8+kGqEAAKA1/CVB7/2GLZ6qgJz4GHumdStWB344FsMvvSL0buBmL+WvqL
         /J/88s55XETJG2+8xKvCsASYjijo/eGyjT4ufJWzCz7llomyM9pq1idcwooSKaa1OKF+
         ybUVKONsJvHtSLjJ1/mDUv+FaOnuesug361XPGjMW3QjuCqEBxSHcbfTTOykfHKWYNwy
         8V3sSR844eoRsXMBxfdRBr9N5ILlytQmUtC1HKAwdQlFLdBm27ymwx6Jn3bn5Dc+w8Ld
         UUTmx51NRxl84y4joWz3BJV0MgFVZne0EhnDlfMyCgjaB8CECekkOrsJcqyg0EzXgkhz
         T73w==
X-Gm-Message-State: AOAM533XdocaUU0Oiem9naGUbI4LCQAel10tX1XE56rEzFKW8Si37fe9
        lOCOekqSYFAKeHzLhe1svcmjsOs3kvDVE1z6cya6
X-Google-Smtp-Source: ABdhPJyoayprEz4sgeCBquS8FzGm/skWsKU0aymux5jNIzi2RHq9wZfOimxpoCB1V3GQgIMVeyJ/zUcpEmstN3I35+g=
X-Received: by 2002:a05:6602:3283:: with SMTP id d3mr17836814ioz.53.1614047504319;
 Mon, 22 Feb 2021 18:31:44 -0800 (PST)
MIME-Version: 1.0
References: <CAOnJCUJq4Gfd_YvJz5K2yFwmsSiB3LDM6rSQ2d+O+jV8b0z_wg@mail.gmail.com>
 <mhng-96a8d981-5dff-488d-af25-b3c40815b643@palmerdabbelt-glaptop>
In-Reply-To: <mhng-96a8d981-5dff-488d-af25-b3c40815b643@palmerdabbelt-glaptop>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 22 Feb 2021 18:31:33 -0800
Message-ID: <CAOnJCUJ-gbyz_Oc_S0xMv2ByAMeWhzxH3aJJFzKtMZBT0-u8VQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Add a non-void return for sbi v02 functions
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Atish Patra <Atish.Patra@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 5:52 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Mon, 22 Feb 2021 14:38:28 PST (-0800), atishp@atishpatra.org wrote:
> > On Mon, Feb 22, 2021 at 12:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On Wed, Feb 03, 2021 at 09:26:43PM -0800, Atish Patra wrote:
> >> > SBI v0.2 functions can return an error code from SBI implementation.
> >> > We are already processing the SBI error code and coverts it to the Linux
> >> > error code.
> >> >
> >> > Propagate to the error code to the caller as well. As of now, kvm is the
> >> > only user of these error codes.
> >> >
> >> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> >> > ---
> >> ...
> >> >  #else /* CONFIG_RISCV_SBI */
> >> > -static inline void sbi_remote_fence_i(const unsigned long *hart_mask) {}
> >> > +static inline int sbi_remote_fence_i(const unsigned long *hart_mask) {}
> >>
> >> Error log:
> >> In file included from arch/riscv/kernel/setup.c:29:
> >> arch/riscv/include/asm/sbi.h: In function 'sbi_remote_fence_i':
> >> arch/riscv/include/asm/sbi.h:150:1: error: no return statement in function returning non-void
> >>
> >
> > Sorry for the oversight. The return statement is missing.
> >
> > @Palmer Dabbelt : Can you fix it in for-next or should I send a v2 ?
>
> I just fixed it up.

Thanks!

-- 
Regards,
Atish
