Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C60430A101
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 06:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhBAFD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 00:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBAFDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 00:03:20 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0263BC061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:02:39 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a25so17959625ljn.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6P04YIn7VTCZKIsBXsqz8fORy5jSwbNZ/tsNn2Tj9xw=;
        b=R5KebApgwd2vaKnReg+pWW5FKG+l78XKttlhEdr0T89n1FFto2FNULSavoCid+zWfD
         yF0HDQPq1YsZidmCcxeR1+YDefO4gT7cpCT/s6TCnDH6nSUGcxE2nSPIinEIO3YH/xvU
         bHgMwIjQzA3D8byCDRm9ek52WlKllIaG2eRXSFtg30OAniPT+6hTlkUfJODqOuI3VNF2
         jieFuRaI0Xb9VeG4igIDIccxUmT9kYFHz9PrIpW+s00e1TEgoDt0ZWvsgFTVLG0ywTjK
         ZiRT+ST4jI/z+CbQow4YAUPshLiLBDdBfcG8Bhkds5Wp0BPOuxXQmiLV9Bzekc2EH1SC
         OJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6P04YIn7VTCZKIsBXsqz8fORy5jSwbNZ/tsNn2Tj9xw=;
        b=Jqj88OT9gxIEBGoamfzkOqx8e7gf0V1ZcW/eKMl+E8gq9F9t3Qo/njdBWFgWcoVdc9
         Y4h6JgKeexoLszDBqnTfS4bwQtCJ0+/VRydATb+S/UQlmIhdrgDn3WIZQ1vCdjjA/MWZ
         cqYE4Z6yM4KxIW7WeBt04ZB9rvo+vffuSdwRl7BtOrsJGjDylSETNJKPTRE2VLfVzcEp
         dD0gNjSoIr31gRPrnSY+cI8l4KTZ4zAy3GeazMa+ic9au+JElcRqphA4pdrRW9aDASKw
         woWXNSKh9jR8WnmGdhpLS4Pl+MkAI8G6RuFlmfWNvxun6vXGyYu4/gKbS4bztYI2vCYi
         UvdA==
X-Gm-Message-State: AOAM531EVSW7+zkl1zrd/zgVhjERQTsW7pGTvUPT14yE3g7qD8YA/RQa
        cAk2E7LNG0BGwyWKKBf9oLY1daxEiQsMYe9CvUsHUw==
X-Google-Smtp-Source: ABdhPJy8sUKnU/liMenZH8tOJDjQMG0HFaKlp9soF4T8g2yQkLrFl6Ae/gvg7raLmF6Auow7NeO1v/l4os2oxp2Rre0=
X-Received: by 2002:a2e:a58b:: with SMTP id m11mr8768628ljp.152.1612155757599;
 Sun, 31 Jan 2021 21:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20210125095445.1524477-1-jens.wiklander@linaro.org>
 <0100017738faac80-87e5cf40-6a5a-4727-9c36-382fb909c8ff-000000@email.amazonses.com>
 <CAHUa44GsbxO=wJ_o-AZsxNvKOhn=y=dexkrN17zCy=7+0=1ZQg@mail.gmail.com>
In-Reply-To: <CAHUa44GsbxO=wJ_o-AZsxNvKOhn=y=dexkrN17zCy=7+0=1ZQg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 1 Feb 2021 10:32:26 +0530
Message-ID: <CAFA6WYMez3c_fT2v2wDuKo5vFvL6MdBXnniYsNvqgFR6LA3+2A@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: remove need_resched() before cond_resched()
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Arnd Bergmann <arnd@kernel.org>,
        op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Fri, 29 Jan 2021 at 18:59, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi Rouven and Sumit,
>
> On Mon, Jan 25, 2021 at 10:58 AM Jens Wiklander via OP-TEE
> <op-tee@lists.trustedfirmware.org> wrote:
> >
> > Hi Rouven and Sumit,
> >
> > On Mon, Jan 25, 2021 at 10:55 AM Jens Wiklander
> > <jens.wiklander@linaro.org> wrote:
> > >
> > > Testing need_resched() before cond_resched() is not needed as an
> > > equivalent test is done internally in cond_resched(). So drop the
> > > need_resched() test.
> > >
> > > Fixes: dcb3b06d9c34 ("tee: optee: replace might_sleep with cond_resched")
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > ---
> > >  drivers/tee/optee/call.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > Can you please test to see that this works in your setups too?
>
> Does this work for you? I'd like to get this patch ready for v5.12.

It does work for me as well.

Tested-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>
> Thanks,
> Jens
