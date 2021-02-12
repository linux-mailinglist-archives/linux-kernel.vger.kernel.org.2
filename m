Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4CF31A229
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhBLP4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhBLP4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:56:07 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DE1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 07:55:26 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u11so50689plg.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 07:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QGXZc1o/E5yY0/DoayDNN4315W3yMowMuOsqwgznJ0Q=;
        b=ge4mMgWlThRX7X2eJlg3fKRbDfY22gCZqzHmrTyCemS9ao/PXpvgwcRgF1pd+d8+KS
         WCTF0/9gmjyx1pjVLvkYNY4gYLcJ7hF6B3tiQL5Wl4PiRfo1ICKoRvSZRYRmcMxvGpA1
         xBDl2sU4h5TRVZ39Ba7uSHbgu+bhLbMm1pssCrpYmfihMEHzRLHYekPZ3lU5tYVqW380
         fA2KxgtJRzugVyE7CcfPJlqF0lHPHcNAOqzrVQI1gGq6cH6aYNdlfgzAh8/OKHNuJLr7
         zw1LG0ldszeRiPd3682tZQf90yn3/Vta7ce9VqoxWGhmR9B4C3CqefFI7VQUrOrALq6z
         /u9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QGXZc1o/E5yY0/DoayDNN4315W3yMowMuOsqwgznJ0Q=;
        b=PItSO5fYcopUv2BczzK99COeUdSwye73INy8/9IKlOPkUCNJf0p+lN6vi6UyxNSMfc
         3qMTfJiDlYian2l2oFGC5+pxWZbmfVe43zjkp/sDOOEUapxlgb/Slg4gcQInnq5lkRvq
         5VCkE8UMytY1JApEwCevb/YiQmU6mD5SNSVgjjekYl+qKJFErTCvo1ASzfd783I3KJ1s
         XvPPFRqGADGyoxaZnyH2xX0G35543PDjUeo37lsDeju1vdIW+VXOcHq3eA1BGyPArpnF
         HORGFIKo4tiF60Qwr3zY1RvsLCmnePZTJ6jzNGuFClAEY0NQMb+oSvhiAzgtPIBXeU+C
         yigg==
X-Gm-Message-State: AOAM533p0QBmhvFF2EWJR8F/5fsIaYCgXawVMfCFmaNi813nVrRINPXL
        TEiA97L+HynhoAdlOoYmg4dnx/gSVoa7L3Y5nyk=
X-Google-Smtp-Source: ABdhPJxIHi1gXbONzQOBnvEjeCwfq9aQmwa/OSQSuoOFfd5fu7F/NMEw7ieNN1INSgZQKLjUePPeUlIoSz8lnTw+Uc0=
X-Received: by 2002:a17:902:7c18:b029:e2:de98:59c9 with SMTP id
 x24-20020a1709027c18b02900e2de9859c9mr3511845pll.4.1613145326338; Fri, 12 Feb
 2021 07:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20210211214848.536626-1-jason.gerecke@wacom.com>
 <20210212094059.5f8d05e8@gandalf.local.home> <YCaebvpeLjY5oRAs@hirez.programming.kicks-ass.net>
In-Reply-To: <YCaebvpeLjY5oRAs@hirez.programming.kicks-ass.net>
From:   Jason Gerecke <killertofu@gmail.com>
Date:   Fri, 12 Feb 2021 07:55:15 -0800
Message-ID: <CANRwn3SZpdNqp__RH8cUtVLA1-Cz3c+uOG+eyisd9vrZVW1EKQ@mail.gmail.com>
Subject: Re: [PATCH] RFC: x86/jump_label: Mark arguments as const to satisfy
 asm constraints
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 7:27 AM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
> On Fri, Feb 12, 2021 at 09:40:59AM -0500, Steven Rostedt wrote:
> > On Thu, 11 Feb 2021 13:48:48 -0800
> > Jason Gerecke <killertofu@gmail.com> wrote:
> >
> > > When compiling an external kernel module with `-O0` or `-O1`, the fol=
lowing
> > > compile error may be reported:
> > >
> > >     ./arch/x86/include/asm/jump_label.h:25:2: error: impossible const=
raint in =E2=80=98asm=E2=80=99
> > >        25 |  asm_volatile_goto("1:"
> > >           |  ^~~~~~~~~~~~~~~~~
> > >
> > > It appears that these lower optimization levels prevent GCC from dete=
cting
> > > that the key/branch arguments can be treated as constants and used as
> > > immediate operands. To work around this, explicitly add the `const` l=
abel.
> >
> > Yes this makes sense. The "i" constraint needs to be a constant.
>
> Right, using -O[01] seems a little daft though. But yeah, that patch is
> correct and won't cause harm.
>
> I've queued it for after the next merge window.

Thanks. Only reason I even tried compiling at those levels was to play
around with GCC's new static analyzer options. They seem to be
ineffective at more normal optimization levels.
