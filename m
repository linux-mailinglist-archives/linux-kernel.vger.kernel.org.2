Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F45B3553E1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343968AbhDFMaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343947AbhDFMat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:30:49 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BF3C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 05:30:41 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id s11-20020a056830124bb029021bb3524ebeso14491816otp.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 05:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vkKEIASx6qyDcGg4n9O2uVhNTfTWXegoiZi1jYE4hUo=;
        b=fVeax7b4T/mvDRoAX6EmTa84FvNhDpUjuouCz58NWQFscr4wleYSSgW6sWT1eAL6nx
         LEQ33jmi8I6KGBtEMTYieyTiZoSYE6yqEmQ65kRYjbqDV3U2jk/Y0rp9Jk9jrmaOl77/
         pVAGFKktaYWqi3zjFQT25wqovt9F9+W96abihPAI5yqOadC1rYGXv1g/EwZCi1YOQUgX
         zfJS0QyuZyJyctxbpMmgM/EdV6NCe6TUkuVhOAlULA0pmwHiH0mA5jl+iaUMKP97xvvw
         FiX1AMHtu0Yk433WwgkILTr/LiUpm4p3eJWqL5goU9JRyQyNxt+PYNz2/23Nyy2Lo5Sv
         RbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vkKEIASx6qyDcGg4n9O2uVhNTfTWXegoiZi1jYE4hUo=;
        b=ZomQn5oDVPiGR7sLmKW50OhL1C7kuPT1vwOPw5N9UUxCd+I6QKR/GbeWq6ZaAMU8KT
         7z84O3keTPKie7sPNzo+2xrkdy1yHsQQqRPsTbJsGh/f85v1FpMTw4km0/fR0LV5G6VY
         4byM/QyRuaWeUppD6NKx/do4kzfqQ9CACwcQu72r1fwZFH1mwlkxb0m2wiRhg8wMhoZC
         M/I253Fg+v5cOngR7d2KGYmJRcURWY3ZepQ6/xkDJuisEQ7eeSqJRGG2Cswbkx1X0AAS
         YfvFq8MgF76EnWDD22mhlMOGkIBTct8CM/ykK/0/ifA0AuKdqpE9N1PAdAbTCa84RZMh
         7dfg==
X-Gm-Message-State: AOAM532fumaoUe317195QU0o7ne/HgBMi30h6+EACoQMlz3rEaGUDmjI
        t3N8zAxp637N04xKRS4V2f4KOr7CqxX54F+sYB61LQ==
X-Google-Smtp-Source: ABdhPJyFqyUgHL2cvT/2x8wXFHgVNNC4S2PCBrDYOOBIfQoNJomnCjWQBKpjGNggzaDDS/LR8dZLmGVTcbVdl3RuTLg=
X-Received: by 2002:a05:6830:1b7a:: with SMTP id d26mr26432628ote.324.1617712240836;
 Tue, 06 Apr 2021 05:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210325120601.71584253@xhacker.debian> <20210330082617.GA971075@jade>
 <CAEyMn7a1Ec6WZ24i5kCP-4AmM0=s2qEoOTXFpS72a7n+0P7uaw@mail.gmail.com>
In-Reply-To: <CAEyMn7a1Ec6WZ24i5kCP-4AmM0=s2qEoOTXFpS72a7n+0P7uaw@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 6 Apr 2021 14:30:30 +0200
Message-ID: <CAHUa44HDrHP6-z=FRkNJtkSe8cVJY-acPDK_r7QrO5QgPwo+iA@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: fix build error caused by recent optee
 tracepoints feature
To:     Heiko Thiery <heiko.thiery@gmail.com>
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

Hi Heiko,

[+Arnd]

On Tue, Apr 6, 2021 at 12:38 PM Heiko Thiery <heiko.thiery@gmail.com> wrote=
:
>
> Hi Jens,
>
> Am Di., 30. M=C3=A4rz 2021 um 10:26 Uhr schrieb Jens Wiklander
> <jens.wiklander@linaro.org>:
> >
> > On Thu, Mar 25, 2021 at 12:06:01PM +0800, Jisheng Zhang wrote:
> > > If build kernel without "O=3Ddir", below error will be seen:
> > >
> > > In file included from drivers/tee/optee/optee_trace.h:67,
> > >                  from drivers/tee/optee/call.c:18:
> > > ./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h: N=
o such file or directory
> > >    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> > >       |                                          ^
> > > compilation terminated.
> > >
> > > Fix it by adding below line to Makefile:
> > > CFLAGS_call.o :=3D -I$(src)
> > >
> > > Tested with and without "O=3Ddir", both can build successfully.
> > >
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> >
> > I've picked up this.
>
> For what tree did you pick this? I still see this build failure on the
> latest next tree (next-20210401).

The next tree hasn't been updated since 1th of April so it's not
unexpected. The fix is supposed to be on its way to
https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=3Darm/dr=
ivers
, I can't see it there yet though.

Cheers,
Jens
