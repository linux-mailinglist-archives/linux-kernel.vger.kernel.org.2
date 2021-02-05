Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1E63111E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbhBESYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhBESWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 13:22:09 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077EEC06174A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 12:03:54 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e7so6916616ile.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 12:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9LzQ0yzRIqea5+VCWiNb3AgYRyWhw05TrVlxXakHq9o=;
        b=BCn49+MA9XNXAcZ+CwOimBFTRu77VcHwdstpfcWNbIcxxz2OiJHkU4Pnn4Zj7nqP0q
         9edGlb/UJZeHxkCiN9THKdEZ6L3LFlbGRJHJ+aEGQ7Jq/nlYWI7zOd6cEwG5adLs+9k3
         4y8TfFdN8bIa886Aons3eR4Slof/O67ATT7+ID1zBkJ80eejS5P8RliS7Rr9UyHLJjpj
         BNe3euFg9UKT5WDPqqYLH1YRzCS+nOLeIwPiaDAixvBF8uY9A2LMK9uzfgGuEOrkC02v
         BGk8N4JGhieyrYQyUprh+5mtzbOXJ4IP4x4ZWmQnqFGtvggzhBLJGFXkgwkNQSyEfDTI
         9Wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9LzQ0yzRIqea5+VCWiNb3AgYRyWhw05TrVlxXakHq9o=;
        b=EfcqPAUR5DSDgnlbUryOmGGxWRHyAXc+iHuq117YJma8YVaU7KY40dBVnWWx+7QxPi
         V95gg13MTLLr86AddpQFBAblUJ1tVghfI5OpzLpWMRgIdBazlItUKnaMIoeA+mAZgTHP
         oIRsiGtlDuHazexQ7P8SbMdpUeYqLvBAfEfgxSY7pzwW2kgVCXm/U9ivICmcd/vrBrL/
         //sHr+JJ0JgHsn9RCjUiTJ1CVX+v4W1n4G1uKZ6zQyyKtkV//qjA3DfIFzawapVU5JkN
         LH/2siL7ADr2hIrCqdcJbB/Mdl4O89Pzmez1PZoGMqdMmgAJWgushjB10MNEnf3MtkQx
         cgMA==
X-Gm-Message-State: AOAM532i/CbNEdQZghDr5exejGtlGIBL/9YolaWqlA28xw2cmtxDrBZm
        /6YCR7kAlSOiISody+MexyMSa9wN9cNQhPpIJdVJXtRPVe16hQ==
X-Google-Smtp-Source: ABdhPJzsgleE8Go2JxRC438aJBVGZoifR0CJMFKPoOXnnZdlJsJ39/Bhk5hTzSyraVWmb3b2q++OTlc3RuiOxqIGwN4=
X-Received: by 2002:a92:d485:: with SMTP id p5mr5019489ilg.114.1612555433554;
 Fri, 05 Feb 2021 12:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20210129082726.19406-1-ruifeng.zhang0110@gmail.com>
 <YBPNAoitmgnTxiqQ@kroah.com> <CAG7+-3NGUgryomKB=_W=p9nADPJVnns_x9oWpAFCEei7RiyrOA@mail.gmail.com>
 <CAJZ5v0gh1y14mipnwJKE+-7FKzasMMTTzZY_dTpuepHGjyK-xg@mail.gmail.com>
 <CAG7+-3N=vonV+8y0bTXXh72vJGUqMrjyu_d4sztzpPkrPj7KeQ@mail.gmail.com> <CAJZ5v0gvkF7y6a7ZeNippUAyWd7FfSKh4BmGS+ckT_HNkpQBTw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gvkF7y6a7ZeNippUAyWd7FfSKh4BmGS+ckT_HNkpQBTw@mail.gmail.com>
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Date:   Sat, 6 Feb 2021 04:03:41 +0800
Message-ID: <CAG7+-3MHSbGt6h+fJUEcF9Hqf8RpJLyG=7ySx_qeMvaQNpubuA@mail.gmail.com>
Subject: Re: [PATCH] RFC syscore: add suspend type to syscore
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, ruifeng.zhang1@unisoc.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>, ke.wang@unisoc.com,
        nianfu.bai@unisoc.com, orson.zhai@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki <rafael@kernel.org> =E4=BA=8E2021=E5=B9=B42=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=887:39=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Feb 5, 2021 at 11:28 AM Ruifeng Zhang
> <ruifeng.zhang0110@gmail.com> wrote:
> >
> > Rafael J. Wysocki <rafael@kernel.org> =E4=BA=8E2021=E5=B9=B42=E6=9C=884=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=889:38=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > On Thu, Feb 4, 2021 at 10:07 AM Ruifeng Zhang
> > > <ruifeng.zhang0110@gmail.com> wrote:
> > > >
> > > > Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2021=E5=B9=B41=E6=9C=
=8829=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:53=E5=86=99=E9=81=93=
=EF=BC=9A
> > > > >
> > > > > On Fri, Jan 29, 2021 at 04:27:26PM +0800, Ruifeng Zhang wrote:
> > > > > > From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> > > > > >
> > > > > > Suspend type contains s2ram and s2idle, but syscore is only
> > > > > > available for S2RAM.
> > > > >
> > > > > Who else needs this?
> > > > In the s2idle suspend and resume, some vendors want to do some
> > > > things, for example the vendor implemented the watchdog driver.
> > >
> > > Do that in the platform operations then.
> > >
> > > Adding the syscore stuff to the suspend-to-idle flow is not an option=
, sorry.
> > Excause me, I really still want to know the reason.
>
> The conditions to run syscore operations are: with one CPU online and
> with disabled interrupts on that CPU.  They are not satisfied in the
> suspend-to-idle flow.  Moreover, none of the existing syscore
> operations need to be executed for suspend-to-idle except for the
> timekeeping suspend, but this is done for a special reason.
>
> > My requirement is that the watchdog need disable when the system s2idle=
.
> > If don't, the watchdog will bark when system resume.
>
> So disabled it from s2idle_ops->prepare() or
> suspend_ops->prepare_late() if device suspend is too early for you.
I will seriously consider your suggestions, thank you very much.
