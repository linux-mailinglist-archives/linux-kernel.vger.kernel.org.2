Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58AB369452
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbhDWODd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhDWODb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:03:31 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DEFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:02:55 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id o2so23003611qtr.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVfMqSBfK2/PqYx0vrefAbZn8CuJJPRDt4Z7FHHTIMk=;
        b=lNZsy6ZRl8T3jl9miUiy1DG8huWs8AoSpr2G+6tVSViQrqjFn1zJE0a/n1Ij0dEqz9
         shw148LUXm7t2bu+AdCZdr5bWS0c/6C6PuRa2vpBH2/C7PU2h9B0JnGTp9oNGByMmKU3
         NBUhdOExu3xpn1y9aPQogQcIbF2SQO+oVLwhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVfMqSBfK2/PqYx0vrefAbZn8CuJJPRDt4Z7FHHTIMk=;
        b=bAJ35mUlzXxWnk30F+8gn4hzkUw1yglGuBShBZ+LLDiU5GIlQc7HnPwCL50Vs1GAe6
         lQDS8qd0Do+vWytQTRPGIU6uUgei5JdMMtpbdDkjrzMv26fd/sqQ2upaN+LgcSnMcGee
         9tOg57LnnNn7QN4SfBHTslSg0VZ8C7/2/ME8beAf94WxrBrda65xe7KLcb5565hZHmWO
         8+IdO2bevd410OZ/3edigDfAyBO8giBZSXacrPCMeD0Q5m9sVLU6W0Zo7e8alFShkiNn
         5Ie0aUxKpVOhjCbVantBbg479d1OL3JAoYC30PySdAahOPhMich+rWeU7ssnETTKBXGK
         5Ktg==
X-Gm-Message-State: AOAM530jYj8hZFoB1xPbS+YiMS4YOQiManzXlm5Twa74Y4zRTKzauFuf
        DAySS2uqLlXOQBTMlSv8ikCxmGf5NPxxyJv6yWlQXg==
X-Google-Smtp-Source: ABdhPJypbM40Wzmt6esHRqkXVYyCEh+2x+nqmYNmzs0o++4f4iqaGJdE2IktnPmCKJxIGfzTPllPj8UPUv5oEwkJuPs=
X-Received: by 2002:a05:622a:14b:: with SMTP id v11mr3909827qtw.33.1619186573440;
 Fri, 23 Apr 2021 07:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210422140945.4131092-1-daniel@0x0f.com> <20210422140945.4131092-2-daniel@0x0f.com>
 <CAK8P3a3fkjy2YYwhmsFQt-MSyOh=1zf1wqzQB7usjsHbUBWdtQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3fkjy2YYwhmsFQt-MSyOh=1zf1wqzQB7usjsHbUBWdtQ@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Fri, 23 Apr 2021 23:02:42 +0900
Message-ID: <CAFr9PX=QeON1C_25tyNK1rWGm3A_Kc2Ad5qLUCfunmdHQUsv_g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] ARM: mstar: Add header with macros for RIU
 register access
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, 23 Apr 2021 at 22:48, Arnd Bergmann <arnd@kernel.org> wrote:
>
> The __iomem token comes after the type, so this should be 'void __iomem *'.
>

Bit of copy/paste fail. Fixed.

> > +       return readw_relaxed(reg + 4) << 16 | readw_relaxed(reg);
>
> This should probably be using 'readw' instead of 'readw_relaxed'. If you
> absolutely need to use one of the relaxed accessors somewhere,
> better add both sets and make sure drivers use the non-relaxed version
> by default.

I'll add a relaxed/non-relaxed version of each.
Because of the heavy memory barrier to access one 32 bit register
we'll hit the barrier twice in the non-relaxed version.
And we don't need to hit the barrier at all because it doesn't
actually matter for IO. Is there something better I can do there?

> Maybe both types of accessors can be in a single header.

That makes sense. I'll merge them. Would this header be something that
could go in alone without anything that uses them in mainline right
now?

Thanks,

Daniel
