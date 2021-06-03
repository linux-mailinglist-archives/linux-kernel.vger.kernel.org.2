Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1F2399F62
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFCLCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:02:05 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:39671 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFCLCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:02:04 -0400
Received: by mail-pj1-f49.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so5243188pjp.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 04:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fex-emu.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1VjVedJNbR3cC1rsiSvElOZvSMxeRoEp+QBJ16MrOEo=;
        b=B3vOct4mzzAsCr5Au8sGF4g0jJ+6Ip2LvvQi6B+flVNVHYL0/HlYs/E9PnEZaMOWXd
         QAVHytaTLk2tehOUrGXIotd79JhnoJRhnRavKa0rQg2A6Am8OHzXEs5bnIMRNgdPkmB0
         t3fUwvvHD8YW109CoeofzzPwdidlUTb6AD6LvffN5KRHQ2vkVgvSYyH4rmIedJqLrz6s
         Mmeq/a5wFr9U2D0bLYGCtRs6blPE8+dV/AzI0+v+jO/dcNDYiYuHw37L/ibiy+g6iNPM
         Ic3PVsQl8sr5+Ee+T5Mn8Va2sLYeQvezqFZvcd5XVDZM4mXVWZ5wUx9I7fBUd9IHO06c
         t5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1VjVedJNbR3cC1rsiSvElOZvSMxeRoEp+QBJ16MrOEo=;
        b=fojIYUDPOI2HRC74HQE2ACGpO2IFnr/fi4NRP3d8//YHOYx/ds/ZxElwNT4eyHxozk
         kKZHAw0qeyI5oE5XKcDG58vftI5fLEOUzuV5R4wwqyFiI7madpaxREFNSb072gHlO5Q0
         ScS1kWA6of9U3TiB2ZiMFnQxkH99TRYOaMMJ5cF5zsrV8apA8m508jskKxVPhv+o96s9
         50YoagpURprcB7B/5fbbHtGLbp4DnywbFMHhergtJRyqyyMfj9bLtS1npy2PmjyjCLU+
         0pbyphjuQGe/Uqb2j8gLqVBSFPXJqtcPpUFYB3dZCHi9/sFwbjGbMOX7Fz7bt/ZYOj44
         +n6w==
X-Gm-Message-State: AOAM533k5Q9Sjwu56FyQx1ULR3Waw8kQHnXmuyhgKjMXANzCtz1huHcc
        j8m8lGyccPAA8WiJ6LEABoxaNe8WLaG2fP29jlJkUg==
X-Google-Smtp-Source: ABdhPJw3NCIkxzGHqdyGtAPAEFtjIHlWBcnbWrsFqCGyqmZSeLLn13eu+PVVxirViJd9zoHdwdXlHe2sbET4Afg46BQ=
X-Received: by 2002:a17:90a:c68f:: with SMTP id n15mr34498931pjt.112.1622717944512;
 Thu, 03 Jun 2021 03:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210529081620.164422-1-Houdek.Ryan@fex-emu.org>
 <20210529081620.164422-2-Houdek.Ryan@fex-emu.org> <871r9k1dfi.ffs@nanos.tec.linutronix.de>
In-Reply-To: <871r9k1dfi.ffs@nanos.tec.linutronix.de>
From:   Ryan Houdek <houdek.ryan@fex-emu.org>
Date:   Thu, 3 Jun 2021 03:58:53 -0700
Message-ID: <CAPpY1ukO64rg6Ov=3pA2c0eV3ULEXLF+RjiR_KY4XMfQgD2Mhw@mail.gmail.com>
Subject: Re: [PATCH 1/4] Move userspace syscall dispatch outside of common entry
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay. I will carry this patchset in a downstream fork until that happens then.

On Wed, Jun 2, 2021 at 8:41 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, May 29 2021 at 01:16, houdek ryan wrote:
> > From: Ryan Houdek <Houdek.Ryan@fex-emu.org>
> >
> > This will allow other architectures to support userspace syscall
> > dispatch without supporting the syscall common entry.
>
> NAK.
>
> This is in common entry on purpose and won't go anywhere else. The every
> arch has it's own broken entry code ordering mess needs to go away and
> not proliferated further.
>
> Move ARM to common entry first.
>
> Thanks,
>
>         tglx
