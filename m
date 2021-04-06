Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEBF355110
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 12:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242886AbhDFKi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 06:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbhDFKiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:38:23 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97725C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 03:38:15 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id l9so6531061ils.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 03:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uMptppNT/3Ok+aPctNha5f1dBQCDEP+Ubyh7c7bxwiM=;
        b=N/F5ICJAI3v/qvO/6IpYhTKFyNxn1kBAhB/hm6PCK/MuKyxnqWRNxfn6l8r7t4odIv
         F4lpbVuaTNYyg9Yg+mC/kwCeU1vWREhcBFpiw8nvZMtRiick6plvpKbe8SAG96SzF8jR
         4y7A2rxrqHoVz5mR+qDFBWJLGQaIpQ0bB2tCEmu2VhndcCwL29uZSuwH27j+wjnXNq8d
         vRTumLHZCYIVwiqpzEgtXLVBjmpezxmvc81hC5OnavIim6wXDXzMe5x8sa6j+n9WrJYN
         O+g7jFmofdjed0jow3ncW5P10TEHg9Ul61pJ6VLcA6INj1C9VT6XeeKnzO70m0Ml7VQC
         bmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uMptppNT/3Ok+aPctNha5f1dBQCDEP+Ubyh7c7bxwiM=;
        b=IxdNv8f8VPuU8smjUZO989+ZDja/UaUaWtdP5Rxau+olL8YXrm2J46HmMomGs9pAOm
         A96ysPKoY3du158O0GU5DA71A9D9S/nSnMBfGLGatOwj3FX/TgmEcN1gHYtu3YXUX1XC
         USTqsTMWlfesC7y06Qu9llFLLIHdRnn5s4hrVeuWgNshLjzTlrV8NjN+Os2sG4Zs+UDC
         Wr+xgt0DCgD14mpE9Vah5qB9O33kuzB3EAxFt9DmEHzVGZJYL9iOFvZ92nS0fOZfmfw8
         EhvzWh7Uro0LBzUYllJSpKWuOMn9Oy8yNYDntHdcl1PRflLGKb0C5vdmnjIXx08u69fb
         yuxA==
X-Gm-Message-State: AOAM5311gC2AL9emY+Q7MOeUbzsosabT+NzGPCSufzB9FirS1YCXBVuw
        85+HLvELzMedJeBBrT8kjHBRUfxfxnIdAhZRxAa7NeK74QafnA==
X-Google-Smtp-Source: ABdhPJxdGXoWmlV97t8wyG/Gj5y7R6fri6iOROyo2m4fColbgFgDfjcIC85DQO9X4anQfYG7DIvEdUjGa9m9fwv0kLc=
X-Received: by 2002:a92:d2cb:: with SMTP id w11mr4206061ilg.225.1617705495131;
 Tue, 06 Apr 2021 03:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210325120601.71584253@xhacker.debian> <20210330082617.GA971075@jade>
In-Reply-To: <20210330082617.GA971075@jade>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Tue, 6 Apr 2021 12:38:03 +0200
Message-ID: <CAEyMn7a1Ec6WZ24i5kCP-4AmM0=s2qEoOTXFpS72a7n+0P7uaw@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: fix build error caused by recent optee
 tracepoints feature
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

Am Di., 30. M=C3=A4rz 2021 um 10:26 Uhr schrieb Jens Wiklander
<jens.wiklander@linaro.org>:
>
> On Thu, Mar 25, 2021 at 12:06:01PM +0800, Jisheng Zhang wrote:
> > If build kernel without "O=3Ddir", below error will be seen:
> >
> > In file included from drivers/tee/optee/optee_trace.h:67,
> >                  from drivers/tee/optee/call.c:18:
> > ./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h: No =
such file or directory
> >    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> >       |                                          ^
> > compilation terminated.
> >
> > Fix it by adding below line to Makefile:
> > CFLAGS_call.o :=3D -I$(src)
> >
> > Tested with and without "O=3Ddir", both can build successfully.
> >
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>
> I've picked up this.

For what tree did you pick this? I still see this build failure on the
latest next tree (next-20210401).

>
> Thanks,
> Jens

Thank you,
Heiko
