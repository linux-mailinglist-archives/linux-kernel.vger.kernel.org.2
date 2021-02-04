Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1FD30EF50
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhBDJKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbhBDJHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:07:44 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50618C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 01:07:04 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id q12so3363919lfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 01:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r6BogldXjQyjkDZUGOAPuSCy8AEz5VkJEXQr2ZU1Z4s=;
        b=HPFXzG9cSB+XUJXK8sfCXJqri+mMtbmYBRMO4MtDoiKR5nn2Hb410B3IUtkRNkuiT3
         5jqzh9BSSXmdYmTneBuJaBP443zFBp7xKNZVHU8uJWsnXTu23B/QQ4FerNxlSDq9kPkv
         LAb7Iq7X+JZ/s/3x3K25fitrgF33vHhNEBiKcG2El7ul061a1brEurGjL8a124bjPEYI
         CbdR1CpvV49y8MnYHwCg76JmLknVoXnyeo3ehppnlHvvRg+UP4gh5GbBTELIVCQEWwoc
         rGwIER/DFEHzFi8A4yAE6oNdyEpUzwFKcrU9jT8PWeR6wMzfjpbVYr1KUoSFpE5DiLCe
         3rHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r6BogldXjQyjkDZUGOAPuSCy8AEz5VkJEXQr2ZU1Z4s=;
        b=cODYdBLfDxf+foc3a+WHE7l9Y73vN7XfICzw8lYAVXxs/TOC3V0X3R1+e7y0ReF6pf
         1mf6Llc2Cv9nOU2qPE6pCNAQP1bqT/gYdFbwECLxNipVMfX7ck/5uwWnjWt5g/lWd/Oe
         sGEYWx3SvQMglsz5nK/EDrU0NIs8Vh57FL0X/ibz31AQzgQG0iXpryMe3AI5D1E+6eP8
         0gxYGqtQ5YPKRofPwmM+srSNbPmXvp3Kh6BOdLPqXz5IwEjtCMAIQkhCu4DZK8a4wa6q
         v7H1GJROSrCNuFsoqSyWZabPrOuX820CbfGQJ1yz30YLXRHj0SCOgAlQs/QekJe4hnHQ
         BmZw==
X-Gm-Message-State: AOAM5328BlpbK4G9eqYIVt7507Xv2e1JT+i6f3qhAP2I7lTi5qeMScSU
        M3xekZ2rttkMGkJZWyzxPo8nuF8/FILGsDY5LUTnNVeLdlk=
X-Google-Smtp-Source: ABdhPJyMTZTCUJKqnyKdsVAKWOHu19t+WADXlvBVssHP+8Wn6pY1x4NHZNihNhDshUaekjreaeeVX+HmgWJstMG2m5U=
X-Received: by 2002:a05:6512:36cf:: with SMTP id e15mr4083062lfs.617.1612429622868;
 Thu, 04 Feb 2021 01:07:02 -0800 (PST)
MIME-Version: 1.0
References: <20210129082726.19406-1-ruifeng.zhang0110@gmail.com> <YBPNAoitmgnTxiqQ@kroah.com>
In-Reply-To: <YBPNAoitmgnTxiqQ@kroah.com>
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Date:   Thu, 4 Feb 2021 17:06:25 +0800
Message-ID: <CAG7+-3NGUgryomKB=_W=p9nADPJVnns_x9oWpAFCEei7RiyrOA@mail.gmail.com>
Subject: Re: [PATCH] RFC syscore: add suspend type to syscore
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, ruifeng.zhang1@unisoc.com,
        linux-kernel@vger.kernel.org, chunyan.zhang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2021=E5=B9=B41=E6=9C=8829=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jan 29, 2021 at 04:27:26PM +0800, Ruifeng Zhang wrote:
> > From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> >
> > Suspend type contains s2ram and s2idle, but syscore is only
> > available for S2RAM.
>
> Who else needs this?
In the s2idle suspend and resume, some vendors want to do some
things, for example the vendor implemented the watchdog driver.

The GKI requires that no modification of the kernel source is allowed,
so an syscore_s2idle is added for use.

The reason device_suspend was not chosen was that I wanted it to
monitor for longer periods, such as between device_suspend and
syscore_suspend.
>
> > S2idle requires a similar feature, so a new parameter
> > "enum suspend_type" is added to distinguish it.
>
> Who requires this export?
>
> I don't see a user of this new code/api in this patch, so why would it
> be accepted?
>
> Also, you are doing many different things in the same patch, please
> break this up into a patch series where you only do one logical change
> at a time.
I think it's only one things in patch
0001-RFC-syscore-add-suspend-type-to-syscore.patch,
add a new s2ildle type for syscore.
>
> thanks,
>
> greg k-h

From 1abd09045639dafdbf713514d4f1323b572dd2ec Mon Sep 17 00:00:00 2001
From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
Date: Thu, 4 Feb 2021 13:29:56 +0800
Subject: [PATCH 2/2] RFC time: add syscore suspend ops to s2idle

Some vendors need do more things when s2idle.

The required GKI does not allow modification of the
kernel source code, so provide the syscore operation
interface.

Signed-off-by: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
---
 kernel/time/tick-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 9d3a22510bab..8c4509250456 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/hrtimer.h>
 #include <linux/interrupt.h>
+#include <linux/list.h>
 #include <linux/nmi.h>
 #include <linux/percpu.h>
 #include <linux/profile.h>
@@ -528,6 +529,7 @@ void tick_freeze(void)
        trace_suspend_resume(TPS("timekeeping_freeze"),
                     smp_processor_id(), true);
        system_state =3D SYSTEM_SUSPEND;
+       syscore_suspend(SUSPEND_S2IDLE);
        sched_clock_suspend();
        timekeeping_suspend();
    } else {
@@ -553,6 +555,7 @@ void tick_unfreeze(void)
    if (tick_freeze_depth =3D=3D num_online_cpus()) {
        timekeeping_resume();
        sched_clock_resume();
+       syscore_resume(SUSPEND_S2IDLE);
        system_state =3D SYSTEM_RUNNING;
        trace_suspend_resume(TPS("timekeeping_freeze"),
                     smp_processor_id(), false);
--
2.17.1

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2021=E5=B9=B41=E6=9C=8829=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jan 29, 2021 at 04:27:26PM +0800, Ruifeng Zhang wrote:
> > From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> >
> > Suspend type contains s2ram and s2idle, but syscore is only
> > available for S2RAM.
>
> Who else needs this?
>
> > S2idle requires a similar feature, so a new parameter
> > "enum suspend_type" is added to distinguish it.
>
> Who requires this export?
>
> I don't see a user of this new code/api in this patch, so why would it
> be accepted?
>
> Also, you are doing many different things in the same patch, please
> break this up into a patch series where you only do one logical change
> at a time.
>
> thanks,
>
> greg k-h
