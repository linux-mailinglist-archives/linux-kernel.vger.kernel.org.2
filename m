Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C508356845
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350221AbhDGJnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:43:43 -0400
Received: from p3plsmtpa07-06.prod.phx3.secureserver.net ([173.201.192.235]:55301
        "EHLO p3plsmtpa07-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231805AbhDGJnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:43:41 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49])
        by :SMTPAUTH: with ESMTPSA
        id U4ihlFvaQbSa5U4iildjoN; Wed, 07 Apr 2021 02:43:32 -0700
X-CMAE-Analysis: v=2.4 cv=OIDiYQWB c=1 sm=1 tr=0 ts=606d7ec4
 a=n7O9czIEQAHQhL92d+l0gQ==:117 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=3YhXtTcJ-WEA:10 a=pFd2Zl5z2vwA:10 a=ZZnuYtJkoWoA:10 a=pGLkceISAAAA:8
 a=4RBUngkUAAAA:8 a=1XWaLZrsAAAA:8 a=VDxRAwm8vqx6A6xO54EA:9 a=QEXdDO2ut3YA:10
 a=cDyXFGGuxjcA:10 a=_sbA2Q-Kp09kWB8D3iXc:22
X-SECURESERVER-ACCT: vthakkar@vaishalithakkar.in
Received: by mail-vs1-f49.google.com with SMTP id t12so9308721vsj.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 02:43:32 -0700 (PDT)
X-Gm-Message-State: AOAM530MtJBfR4NRNTI6c7PfYt+tRLgEf/FYpTOPU0etRgymSjgViGC/
        HlYMtlu5TYjAXJsDCt2Au0zaY4Fwva5ezyyciRQ=
X-Google-Smtp-Source: ABdhPJy1M/fyqnE1o5lW1Et1vqkfqgXbcQbsXSJXp0F3eHyhHPgQoVEfpM+SH58XUlUq6WZybPkDPjWCe1PCugK0zhw=
X-Received: by 2002:a67:c01d:: with SMTP id v29mr1207009vsi.23.1617788611161;
 Wed, 07 Apr 2021 02:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210406160037.27225-1-fmdefrancesco@gmail.com>
 <YG1qxdRtNIIVK3fX@kroah.com> <3526833.TqPzfDAv2q@localhost.localdomain>
In-Reply-To: <3526833.TqPzfDAv2q@localhost.localdomain>
From:   Vaishali Thakkar <vthakkar@vaishalithakkar.in>
Date:   Wed, 7 Apr 2021 11:43:19 +0200
X-Gmail-Original-Message-ID: <CAK-LDb+JGK-m7A9CSQNCicbwMj9dfekeyT9OZwnWgSFdp6U6vg@mail.gmail.com>
Message-ID: <CAK-LDb+JGK-m7A9CSQNCicbwMj9dfekeyT9OZwnWgSFdp6U6vg@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH v3] staging: rtl8723bs: hal: Remove
 camelcase in Hal8723BReg.h
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Outreachy <outreachy-kernel@googlegroups.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CMAE-Envelope: MS4xfEmpHoAiX+CfvNuPuBlC2T1Qg7r+U7biowim8Esc73xj9rx6y1Dw/tcetefqcHud8OQfHbx8gBBV5HATWCRBZFct6IadJvM+ceBGBrm6xMjpvABxYogv
 zGZ+ZXffMBRzAYWiw9FqV/moNrh4vYkzJRp+hFt4zPvdAiww8hmlVKK9w2g71YtFoORZpvX0HjeflPQ0jL7vadj4vr29s0cGY3ZtBRstelW6bHbJLLGhXaki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 10:49 AM Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> On Wednesday, April 7, 2021 10:18:13 AM CEST Greg KH wrote:
> > On Tue, Apr 06, 2021 at 06:00:37PM +0200, Fabio M. De Francesco wrote:
> > > Remove camelcase in some symbols defined in Hal8723BReg.h. These symbols
> > > are not used anywhere else, therefore this patch does not break the driver.
> > >
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > >
> > > Patch v3 changes nothing with respect to v2 and v1. It exists only to cc some recipients that were missing in the header of the previous email.
> > >
> > >  drivers/staging/rtl8723bs/hal/Hal8723BReg.h | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > This patch does not apply to my tree right now.  Can you refresh and
> > rebase your copy of my branch and rebase it and resend?
> >
> Sure. I'm about to submit that patch again in a few minutes.

Also while you're at it, don't forget to put the information under -- about
what has changed since the first version of it. Otherwise it becomes
hard for the reviewers to track the progress of each version.

Ideally it should go like below:

Changes since v2:
Changes since v1:

> Thanks,
>
> Fabio
> >
> > thanks,
> >
> > greg k-h
> >
>
>
>
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/3526833.TqPzfDAv2q%40localhost.localdomain.



-- 
Vaishali
