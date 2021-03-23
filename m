Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD4D346171
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhCWO1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhCWO1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:27:01 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E60C061574;
        Tue, 23 Mar 2021 07:27:00 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id z1so10536143ybf.6;
        Tue, 23 Mar 2021 07:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1UKA4D9x9QmZ1+15HTh/Ges6E1m3MBK/glmFQ+WIEA=;
        b=kuI5z7BTwTCzb12byWHvnez5Mri863aUQ3Lj3wB4GHCyfdrM6k/PvMxgsDLB4Q56Du
         Oxsn7JJ1zTtYNbr+YMmHvo6+bSmAhFKqpRsRl/nUyYPyQYUnvqE2CkV6pZCpEPho8r7H
         iqwsDC953u7rl0alzpfcXzROoV7ZCUkD+yPfl1BRJp5RXXPidKuNgSjSa1EDTy5rb5C9
         udHkwgLnN9LTrHQcLroeHvLDQIAIelJWHyRQ4Ot9kLYJofbjoaEPhk4WmZAjuJhBcjxv
         NMRUwLmWeC6RbgjskE7+IApMwa1xCSPkjAzLo89sQxdH6lmwytLDKK29WysJnQOKW+Me
         b7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1UKA4D9x9QmZ1+15HTh/Ges6E1m3MBK/glmFQ+WIEA=;
        b=GpwnM6S9TZkKaHIwaDFvHe6c0UI5FhSgDPzJ3nKAdbcCScOHd59FVAY7lO07G72KLC
         TYpea4RzqDhGH866hePdV8Ia8V9D/k115MKuOQde73bZd+rylPWXYSxFJ2br0bVzrX3o
         iNXThGo5UgBKFRij0HYMi/EcNNMOF80f2ajkKPFTIp9CBxqSCUgdUJZmrGe2oWcBjbh3
         qChpdyUustHKBweAIt754zojSW1b4hEhUasOsVImn8x2dToEHlxbbr+HWGhrEUsLtuAk
         74v83CeuJFaHMnnSb/5IyMWwGbzjwqXmkT5dyJYaG+SK07qVvOWuSiKIAkBwpszwZPDE
         uutA==
X-Gm-Message-State: AOAM532znPJB6A0O82ZokM+k0LXtiivtXFErzuPdpwH9+1NHWM1eY1cZ
        G+Cr9gbA/N9hzXqggdKgqUwrKI7yjW8Dv4QRxfMYKz/9rTg=
X-Google-Smtp-Source: ABdhPJybD3ce1ekRim1ZhIjnmLmlL/O7qPnH3M5AavmL+8L6MPDtRHWU2dnXIV05AjFpWSQvRk0Q2y0+VBJ4qWnrVSI=
X-Received: by 2002:a5b:449:: with SMTP id s9mr5786215ybp.115.1616509620027;
 Tue, 23 Mar 2021 07:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210323032624.1039422-1-mpe@ellerman.id.au> <CANiq72n-tMww2U+eQ=iHOh5u1JQgjM0b1E3XQ9jpWMfpdQ5+=g@mail.gmail.com>
 <87mtuugj61.fsf@mpe.ellerman.id.au>
In-Reply-To: <87mtuugj61.fsf@mpe.ellerman.id.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 23 Mar 2021 15:26:49 +0100
Message-ID: <CANiq72nx6Z=m-Fye7QYuQdjq9q0ZvH2+rkbrfQq-yQRMAadTYg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Rust for Linux for ppc64le
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     rust-for-linux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 1:16 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> It would be nice to be in the CI. I was building natively so I haven't
> tried cross compiling yet (which we'll need for CI).

Indeed -- in the CI we already cross-compile arm64 (and run under QEMU
both arm64 as well as x86_64), so it is easy to add new ones to the
matrix.

> I can send a pull request if that's easiest.

No worries, I will pick the patches. But, of course, feel free to join
us in GitHub! :-)

Cheers,
Miguel
