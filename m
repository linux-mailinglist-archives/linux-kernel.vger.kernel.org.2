Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F9F355678
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345080AbhDFOVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbhDFOUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:20:52 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278BCC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 07:20:44 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id n198so13535611iod.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NWxUyfH3SeVekRqeclwg32YztBUxlX380zmW2q6z0sI=;
        b=qLYrftm7RzjRRbRb1vnKgz1smCgxFQ6dAm+0LRd8xp2oFBWd3xsioF6rCsNF1vws/K
         6JV88tx4stuN0/a9T69U6tdVSwImIJzWSDXQ3iYx1du8DKg4T69xlRcZ3/Kne+7DvoNG
         hHj3kQTdIIW8jZlOqb1VHsHgKSie9MyQ37e4mznc396ifjwEYPUH7mhGa4F0TxjC0A1a
         fi86YFFDvgGNQqyesN0xXPsyATvNdfRKCIsADGb/bv+ICe64MzSljkmRK/hXa+w65l6J
         yYiINJwGtFSmdgfpRy0jInt5F6nkvbhPHX3I8/qN1DDAlCKdGu9AdK6jaub5rerMqajs
         dnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NWxUyfH3SeVekRqeclwg32YztBUxlX380zmW2q6z0sI=;
        b=pVhEy58h3MqW+nkKN22Abrn0jibISgNowBK3RkoHPVD16XW8B1lQcZRrTVIrGbgy2T
         W/4OYDZG2mE+dQj1YMuiUALGOBm8IBNFv9+EHo9ghUN8s8NgTx3FOJZYjs49p9KYCCWg
         Jdnr7LVmPalHAqf+Rbjv8238DM68JWHA0QEFNo9kPUtcJhrahu5MmZ5MS+6z6EA0e7u2
         nWlArMZJgnfJ40W3R88QyVPgka+LDTbmI4LVFTKHVLvEc/SXoNjzpFrVCyHFl94HzT7o
         7Broy2pelSDXtaki/V8CVUnjR3gEqUxDVboGTTEbAPXARBfvF2V9fLpyiZqI7pY0Q+hs
         XGdg==
X-Gm-Message-State: AOAM533i8lY3apNY0wrGtTj1AGEaPh0tvR6v340Ja4uifdeaDcQTILOv
        vV/E0NzgQbVscavMQ4h0MroFUuSnyth5ocmZ92A=
X-Google-Smtp-Source: ABdhPJyyYeFqj6+VZf2EN9b61Miw3IWC7vytDK8l5UZ2suFmygvEYLk2mPeYRscKcddeI5VDB6u300JhZcfJpUd8jE8=
X-Received: by 2002:a5e:cb4b:: with SMTP id h11mr24367439iok.108.1617718843630;
 Tue, 06 Apr 2021 07:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210325120601.71584253@xhacker.debian> <20210330082617.GA971075@jade>
 <CAEyMn7a1Ec6WZ24i5kCP-4AmM0=s2qEoOTXFpS72a7n+0P7uaw@mail.gmail.com> <CAHUa44HDrHP6-z=FRkNJtkSe8cVJY-acPDK_r7QrO5QgPwo+iA@mail.gmail.com>
In-Reply-To: <CAHUa44HDrHP6-z=FRkNJtkSe8cVJY-acPDK_r7QrO5QgPwo+iA@mail.gmail.com>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Tue, 6 Apr 2021 16:20:31 +0200
Message-ID: <CAEyMn7br25J9kdZULWjryeXQ-n2w0Ap-O-KgVciBknJGfNmL8A@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: fix build error caused by recent optee
 tracepoints feature
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

Am Di., 6. Apr. 2021 um 14:30 Uhr schrieb Jens Wiklander
<jens.wiklander@linaro.org>:
>
> Hi Heiko,
>
> [+Arnd]
>
> On Tue, Apr 6, 2021 at 12:38 PM Heiko Thiery <heiko.thiery@gmail.com> wro=
te:
> >
> > Hi Jens,
> >
> > Am Di., 30. M=C3=A4rz 2021 um 10:26 Uhr schrieb Jens Wiklander
> > <jens.wiklander@linaro.org>:
> > >
> > > On Thu, Mar 25, 2021 at 12:06:01PM +0800, Jisheng Zhang wrote:
> > > > If build kernel without "O=3Ddir", below error will be seen:
> > > >
> > > > In file included from drivers/tee/optee/optee_trace.h:67,
> > > >                  from drivers/tee/optee/call.c:18:
> > > > ./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h:=
 No such file or directory
> > > >    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> > > >       |                                          ^
> > > > compilation terminated.
> > > >
> > > > Fix it by adding below line to Makefile:
> > > > CFLAGS_call.o :=3D -I$(src)
> > > >
> > > > Tested with and without "O=3Ddir", both can build successfully.
> > > >
> > > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > >
> > > I've picked up this.
> >
> > For what tree did you pick this? I still see this build failure on the
> > latest next tree (next-20210401).
>
> The next tree hasn't been updated since 1th of April so it's not
> unexpected. The fix is supposed to be on its way to
> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=3Darm/=
drivers
> , I can't see it there yet though.

Ah I see. Now it has been landed in the actual next tree.

Thank you,
Heiko
