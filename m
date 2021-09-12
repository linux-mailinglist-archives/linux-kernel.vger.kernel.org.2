Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9EA407FB6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 21:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbhILTbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 15:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbhILTbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 15:31:23 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836D8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:30:09 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v10so15882909ybq.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UuoqtgGI9pAGQN8Y6m26XydaC7phPwWnEF+TaXT3N4c=;
        b=ji8/RqZFdNel1UF6te6l/m153QCt3tdH73mDbuG/tVpYlqClqlH4VS1d3AFugAnbHs
         XpzU0xAGboBX3MzYgIEBZgUTDUzoFnqDcCXr/dhL7LhYAvwkNVU1VL50mfLCgXifQj4H
         rTtk4cSotxm9E0QAod/1YOdiItn9bEspMAcL3vGwBX8pp3O2RBn8a9KeSOVPV56myw/0
         D4Qw2I5+H49s3dj0jZhTvKSY/Ho1Fq7wEeMJ4fcJSlVPW9e0JdPr8N5rz7VgEorYaF2y
         RpARjXB9l8BXrFy/BzWnLxuFcSYHVj8h3FxYJk+6RpYdDmBxA2qrEuAo72m8KMe82OQM
         hbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuoqtgGI9pAGQN8Y6m26XydaC7phPwWnEF+TaXT3N4c=;
        b=BRcQ6wpimb8zkD54vX8OqpuPR8HZU4TClVeVM0soLgpwJhaS/OGUX06iRYE38B8gxD
         fBlwqbNCM25T4NHxjX8jE47D8/V3FTwvEQ9pdqpYOGnJO6bZNf1manJ/ZL0AK+bZpCcO
         IUt+Wgn5j6PSLKcbNYPrRutJ4DCZBfMv7e3tLXPFEHq9s36YDo1slYTaeLn5PU3/PwlZ
         rHyIz8Cj0MPAFn/6vlsFdKeqvAsjOJOle4/Wa38mM9I5BsPdGDCnlXcY5+4FfH7A/n9U
         lD0xy2Fpicyd0VIX8gJtU64RwzJFUR7nTDvH5c2aQflEpbI7gT7wAI6Ax8UZeU9fIVzM
         Tl1w==
X-Gm-Message-State: AOAM532M6lujfaJCRxMAKG9dhfl9QOIKT0BJWxXxQ2gqAdbLIygzpe6F
        BriiTIXcCASJz0tZml47xo2XnDDJzOo8ugZI92q8thm8
X-Google-Smtp-Source: ABdhPJxEnpWEKy68DnIjRAOrFaOKvsYUtkuRQbWl3SgOa2xBZXB6i0ddfP3iw4BUJAABYwQ/UQFhRddt/EQM1ua7i24=
X-Received: by 2002:a25:520a:: with SMTP id g10mr10284384ybb.117.1631475008715;
 Sun, 12 Sep 2021 12:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh75ELUu99yPkPNt+R166CK=-M4eoV+F62tW3TVgB7=4g@mail.gmail.com>
 <CADVatmP8HQfZBPevLuuWtWh=1eBD=cmY84iJoMcoHh0n480Bag@mail.gmail.com> <CAHk-=wjz+RhR8rr4rAZBPf-mxZXvn2RQe-XTQcL8X+HXBAFxBA@mail.gmail.com>
In-Reply-To: <CAHk-=wjz+RhR8rr4rAZBPf-mxZXvn2RQe-XTQcL8X+HXBAFxBA@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sun, 12 Sep 2021 20:29:32 +0100
Message-ID: <CADVatmOcdhJDJw6DRSVXSMzAQZPaVdXi7fgpfkfQ2LYxO4saOg@mail.gmail.com>
Subject: Re: Linux 5.14
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Aug 30, 2021 at 4:17 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Aug 30, 2021 at 2:12 AM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > We were recently working on openqa based testing and is a very basic
> > testing for now.. Build the kernel for x86_64 and arm64, boot it on
> > qemu and rpi4 and test that the desktop environment is working. And,
> > it now tests mainline branch every night. So, last night it tested
> > "5.14.0-7d2a07b76933" and both tests were ok.
>
> Thanks. The more the merrier, and if you do this every night, having a
> fairly low-latency "it stopped working" will be good.
>
> Of course, if you can find some other slightly more oddball
> configuration that you would also like to test, that it would be even
> better.
>
> Because while it's lovely to have more automated testing, if
> _everybody_ only tests x86-64 and arm64, the less common cases get
> little to no testing.
>
> No big deal, but I thought I'd just mention it in case you go "Yeah, I
> know XYZ is entirely irrelevant, but I happen to like it, so I could
> easily add that to the testing too".

A late reply, but better late than never.
I have now added a ppc64 qemu test which will run every night along
with the previous two arch.
We are also working on adding a risc-v board to the tests.


-- 
Regards
Sudip
