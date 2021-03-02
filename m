Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6B932A372
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376871AbhCBJAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377986AbhCBIqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:46:20 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DD9C06121D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 00:45:39 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id p24so1145246vsj.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 00:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BDwFPh89sek8c4gYigyPtmobsd1aoVN5drZwpxRsgFE=;
        b=KVzLefRbNuNm+PTem7wZkaTTCSR5XP88Ln/heJszN9Rsu2bb9ItIHI46eCuvV7BuUy
         26WBpoFMhOzub+R/Gi+FcLChTwb0gCRqYUz4LyJ3IAhWg8uhIOszb5t9lJKA1DWx8PpI
         hLUVBQiz7rBxi2aMAB9T1It2WOsD51RK8OCgu0r10sa81BLCn1IYxHSK1B3/GVX21t4Q
         NzbpbACfpC8yOUXaa0UmH3xJ92YAkDErCPBMzINM2C8sY/6H2ZZr/9UH5VgfPwQ2bb9G
         +Pj6dnOrghAGpk4oTNAlVQ+jQIKK/c1gHLGBPYQFpsVnJn6/WdzLltWs35DWtBoGZtew
         XE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BDwFPh89sek8c4gYigyPtmobsd1aoVN5drZwpxRsgFE=;
        b=fTCHlYvX9sM4AqTulPVjnO6KHpmZZexMd8jISZYUFv3ctkvtip9GASphplFJArO2o+
         H4/YrmQ17wSrHpIvGmk+IEauzo15o+1s8zJNKT7jWjQOTCpMg3OZoK5XylJrrNbORcXO
         rroXv9DO42Ppl18iE1YAdjR9B0pBut6Zx4TPLp/EVZhp63gnt6PQGfFFOldDSzZVAV9K
         wzp1veuDf1doqKFDIA2pgGCMUh571wc05C16852gR89d+xLW+4jG/66ychYHyUqZFdue
         27ZUa9zYTuYL3af4eafi8p69Q7G75zjTR/c+uujmgEJ/ops5E/anDTRDoSYcHAbV65bA
         2M4g==
X-Gm-Message-State: AOAM533jwNs1wpBhxZsEvisKIZlBuW9VWZJKTrc8PezET89r0MC2YwV/
        8zDDPxYLCZkGLnr3Fy4WdDdEJ6Si+YOaovmXpmtZhOaYu8w=
X-Google-Smtp-Source: ABdhPJwltS124Jky7ewef1zQsANHCdXtXFdUUmqwI7r+Tsdk17xjqOLrIAcxy2V84YK0YyM4pBoYJdfxFDB5SkNHQFs=
X-Received: by 2002:a67:8c6:: with SMTP id 189mr1388424vsi.55.1614674738964;
 Tue, 02 Mar 2021 00:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20210216224252.22187-1-marten.lindahl@axis.com>
 <CAPDyKFoASx=U8b1Oqtuo6ikiM=gXfL2x1Gsz=rfAn9zxP0y_iA@mail.gmail.com> <20210301215923.6jfg6mg5ntorttan@axis.com>
In-Reply-To: <20210301215923.6jfg6mg5ntorttan@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Mar 2021 09:45:02 +0100
Message-ID: <CAPDyKFoaKfuwweaEMf1Pz+ECAPU3P9-gmCJcpq+MADH5gH1c=Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: Try power cycling card if command request times out
To:     Marten Lindahl <martenli@axis.com>
Cc:     =?UTF-8?Q?M=C3=A5rten_Lindahl?= <Marten.Lindahl@axis.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel <kernel@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021 at 22:59, Marten Lindahl <martenli@axis.com> wrote:
>
> Hi Ulf!
>
> Thank you for your comments!
>
> On Mon, Mar 01, 2021 at 09:50:56AM +0100, Ulf Hansson wrote:
> > + Adrian
> >
> > On Tue, 16 Feb 2021 at 23:43, M=C3=A5rten Lindahl <marten.lindahl@axis.=
com> wrote:
> > >
> > > Sometimes SD cards that has been run for a long time enters a state
> > > where it cannot by itself be recovered, but needs a power cycle to be
> > > operational again. Card status analysis has indicated that the card c=
an
> > > end up in a state where all external commands are ignored by the card
> > > since it is halted by data timeouts.
> > >
> > > If the card has been heavily used for a long time it can be weared ou=
t,
> > > and should typically be replaced. But on some tests, it shows that th=
e
> > > card can still be functional after a power cycle, but as it requires =
an
> > > operator to do it, the card can remain in a non-operational state for=
 a
> > > long time until the problem has been observed by the operator.
> > >
> > > This patch adds function to power cycle the card in case it does not
> > > respond to a command, and then resend the command if the power cycle
> > > was successful. This procedure will be tested 1 time before giving up=
,
> > > and resuming host operation as normal.
> >
> > I assume the context above is all about the ioctl interface?
> >
>
> Yes, that's correct. The problem we have seen is triggered by ioctls.
>
> > So, when the card enters this non functional state, have you tried
> > just reading a block through the regular I/O interface. Does it
> > trigger a power cycle of the card - and then makes it functional
> > again?
> >
>
> Yes, we have tried that, and it does trigger a power cycle, making the ca=
rd
> operational again. But as it requires an operator to trigger it, I though=
t
> it might be something that could be automated here. At least once.

Not sure what you mean by operator here? In the end it's a userspace
program running and I assume it can deal with error paths. :-)

In any case, I understand your point.

>
> > >
> > > Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
> > > ---
> > > Please note: This might not be the way we want to handle these cases,
> > > but at least it lets us start the discussion. In which cases should t=
he
> > > mmc framework deal with error messages like ETIMEDOUT, and in which
> > > cases should it be handled by userspace?
> > > The mmc framework tries to recover a failed block request
> > > (mmc_blk_mq_rw_recovery) which may end up in a HW reset of the card.
> > > Would it be an idea to act in a similar way when an ioctl times out?
> >
> > Maybe, it's a good idea to allow the similar reset for ioctls as we do
> > for regular I/O requests. My concern with this though, is that we
> > might allow user space to trigger a HW resets a bit too easily - and
> > that could damage the card.
> >
> > Did you consider this?
> >
>
> Yes, that is a valid point, and that is why the power cycle is only tried
> once. But the conditon for this reset is a -ETIMEDOUT, and this is the pa=
rt of
> this patch where I am myself not sure of if it is enough to check for. Wo=
uld
> this be an error that you could expect to happen with ioctl requests in o=
ther
> situations also, but not necessarily cause by a stalled card?

Exactly.

Many different commands can get pushed down to the card through the
mmc ioctl interface. It's difficult to know what error path we should
pick, other than reporting and propagating the error codes.

[...]

Kind regards
Uffe
