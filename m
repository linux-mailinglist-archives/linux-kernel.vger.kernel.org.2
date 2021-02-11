Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1F0319291
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhBKSys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhBKSxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 13:53:54 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A340C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 10:53:14 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id b145so4261652pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 10:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=xpndM70yEhgRGe+KrDE0IH979jxYXm9ttbsYqDRk0G8=;
        b=E06KTUuHa1N69lin9dfmfYrh3O7liQ7sjr9V4elOQ0pI9DtEuIM5pG2uYR0na8s/M6
         y1xZbYr2CEvGVbC36Tob7tY+JTq4jDUSnRPaiBUr+DKoYI+5ba5OITaRwuNTJOTAPFSG
         Aovxw10AMACoyXiGbcmoGniQfdbGRwP+Kg0gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=xpndM70yEhgRGe+KrDE0IH979jxYXm9ttbsYqDRk0G8=;
        b=HmzkyjHNLMdDh0uqJ/Lshwu3b1EiSAl/Ni6jrz+6xkMNj5gSvo7byyAhvHF1dzzxCM
         +yCLgqMgW6EJL103s22wad6Fq4QcpZ7xChDAFWd9XiVtwV8ydWIW9q5A+qGSJcIt6BcX
         6Zkk2c/D20NTOK16V4N4Ye7AbEg0qznqhQpySZr3jp07oOBN4cFyGw48RvLrKDnxJZ2e
         mH8f1a8lCwF8o/e7fykZW0GijB5tk0CDxQaac7ORvUevyH9sIsvBjwH0EYudt8JxXskZ
         zkR8WJ4QkyW6UaZbpDs/xpB0oA9lMir8k4NYcT+IhsXii7SRNYlHx87Jd2QvmMsrlmIy
         AQCA==
X-Gm-Message-State: AOAM533PHUZFLipM3d8vzpaqIK3rmYNiy9ABl2uf/txPq3JG9oMerC+T
        SAiZiLhVc5gea3iD7tSz22FJ+Q==
X-Google-Smtp-Source: ABdhPJw8Blpx5814w0cjHHgcrzerf/Iogn69/ocypYsIcg51r8DSqgTTrtUWGhhJ72/bqO6V3z8odA==
X-Received: by 2002:a65:654e:: with SMTP id a14mr9560819pgw.265.1613069593951;
        Thu, 11 Feb 2021 10:53:13 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:f038:5688:cf3c:eca2])
        by smtp.gmail.com with ESMTPSA id t17sm6812101pfc.43.2021.02.11.10.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 10:53:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YCU9zoiw8EZktw5U@kroah.com>
References: <20201207170533.10738-1-mark.rutland@arm.com> <202012081319.D5827CF@keescook> <X9DkdTGAiAEfUvm5@kroah.com> <161300376813.1254594.5196098885798133458@swboyd.mtv.corp.google.com> <YCU9zoiw8EZktw5U@kroah.com>
Subject: Re: [PATCH] lkdtm: don't move ctors to .rodata
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        stable@vger.kernel.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Thu, 11 Feb 2021 10:53:10 -0800
Message-ID: <161306959090.1254594.16358795480052823449@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg Kroah-Hartman (2021-02-11 06:23:10)
> On Wed, Feb 10, 2021 at 04:36:08PM -0800, Stephen Boyd wrote:
> > Quoting Greg Kroah-Hartman (2020-12-09 06:51:33)
> > > On Tue, Dec 08, 2020 at 01:20:56PM -0800, Kees Cook wrote:
> > > > On Mon, Dec 07, 2020 at 05:05:33PM +0000, Mark Rutland wrote:
> > > > > [    0.969110] Code: 00000003 00000000 00000000 00000000 (0000000=
0)
> > > > > [    0.970815] ---[ end trace b5339784e20d015c ]---
> > > > >=20
> > > > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > >=20
> > > > Oh, eek. Why was a ctor generated at all? But yes, this looks good.
> > > > Greg, can you pick this up please?
> > > >=20
> > > > Acked-by: Kees Cook <keescook@chromium.org>
> > >=20
> > > Now picked up, thanks.
> > >=20
> >=20
> > Can this be backported to 5.4 and 5.10 stable trees? I just ran across
> > this trying to use kasan on 5.4 with lkdtm and it blows up early. This
> > patch applies on 5.4 cleanly but doesn't compile because it's missing
> > noinstr. Here's a version of the patch that introduces noinstr on 5.4.97
> > so this patch can be picked to 5.4 stable trees.
>=20
> Why 5.10?  This showed up in 5.8, so how would it be needed there?
>=20

Sorry for the confusion. Can commit 655389666643 ("vmlinux.lds.h: Create
section for protection against instrumentation") and commit 3f618ab33234
("lkdtm: don't move ctors to .rodata") be backported to 5.4.y and only
commit 3f618ab3323407ee4c6a6734a37eb6e9663ebfb9 be backported to 5.10.y?
