Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27091310A81
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhBELnz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 Feb 2021 06:43:55 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:37111 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbhBELkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:40:23 -0500
Received: by mail-oi1-f169.google.com with SMTP id y199so5093064oia.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 03:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hUf+h3vOzAlkwsnLcgANOENSBC1Dag9FWwATuaUP+yw=;
        b=qNvfQHPI2KAps5flodyMLy7b8UgSbsPiMRZnp3un1/8Z/aZDjtKQvupfGmenCGpbUl
         KT0B2NJTQRmAwMKm01fDsWkHTP2wWgGL4kVklAqSA/wa6CsW8eMoM2QpLD24JxovNiUY
         LKCd2NAWuzgLVptqUhFmFJ6vF8ik/xnCVV+ATpmMiYRzgk9SOKVTOMV8mSBcsVGKhXiv
         8RVDDVw3a7DTKAQ4smIlADbqN4gaKgPkAK9TR5Ngg5OEEV5g2OGu6hTn5l9NHINrakuA
         6uer02QhQbbtaO1i5lqJEkCxEY68ZnPdYTnkMLXHOzr8TNPyrNtXKuB0Scevq4SjxZlu
         pLoQ==
X-Gm-Message-State: AOAM531Xmwix9eF8x1/MAYjjOE9X5dhBz2zI1wFAfuPBc3h+c1tT20Du
        1DkwSSnXP738+2OJjjuwvFJgEii8ZEtcb9SQltQ=
X-Google-Smtp-Source: ABdhPJz6XtF0+aPZ/YsPOOnAS4WBtM26gB+Ywf7+xrG718eUl3R8rWZJ9gwn78L7rwkGSWN675NT07ZYvgLsLfXSohM=
X-Received: by 2002:aca:d14:: with SMTP id 20mr2771628oin.157.1612525182315;
 Fri, 05 Feb 2021 03:39:42 -0800 (PST)
MIME-Version: 1.0
References: <20210129082726.19406-1-ruifeng.zhang0110@gmail.com>
 <YBPNAoitmgnTxiqQ@kroah.com> <CAG7+-3NGUgryomKB=_W=p9nADPJVnns_x9oWpAFCEei7RiyrOA@mail.gmail.com>
 <CAJZ5v0gh1y14mipnwJKE+-7FKzasMMTTzZY_dTpuepHGjyK-xg@mail.gmail.com> <CAG7+-3N=vonV+8y0bTXXh72vJGUqMrjyu_d4sztzpPkrPj7KeQ@mail.gmail.com>
In-Reply-To: <CAG7+-3N=vonV+8y0bTXXh72vJGUqMrjyu_d4sztzpPkrPj7KeQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Feb 2021 12:39:28 +0100
Message-ID: <CAJZ5v0gvkF7y6a7ZeNippUAyWd7FfSKh4BmGS+ckT_HNkpQBTw@mail.gmail.com>
Subject: Re: [PATCH] RFC syscore: add suspend type to syscore
To:     Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        ruifeng.zhang1@unisoc.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>, ke.wang@unisoc.com,
        nianfu.bai@unisoc.com, orson.zhai@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 11:28 AM Ruifeng Zhang
<ruifeng.zhang0110@gmail.com> wrote:
>
> Rafael J. Wysocki <rafael@kernel.org> 于2021年2月4日周四 下午9:38写道：
> >
> > On Thu, Feb 4, 2021 at 10:07 AM Ruifeng Zhang
> > <ruifeng.zhang0110@gmail.com> wrote:
> > >
> > > Greg KH <gregkh@linuxfoundation.org> 于2021年1月29日周五 下午4:53写道：
> > > >
> > > > On Fri, Jan 29, 2021 at 04:27:26PM +0800, Ruifeng Zhang wrote:
> > > > > From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> > > > >
> > > > > Suspend type contains s2ram and s2idle, but syscore is only
> > > > > available for S2RAM.
> > > >
> > > > Who else needs this?
> > > In the s2idle suspend and resume, some vendors want to do some
> > > things, for example the vendor implemented the watchdog driver.
> >
> > Do that in the platform operations then.
> >
> > Adding the syscore stuff to the suspend-to-idle flow is not an option, sorry.
> Excause me, I really still want to know the reason.

The conditions to run syscore operations are: with one CPU online and
with disabled interrupts on that CPU.  They are not satisfied in the
suspend-to-idle flow.  Moreover, none of the existing syscore
operations need to be executed for suspend-to-idle except for the
timekeeping suspend, but this is done for a special reason.

> My requirement is that the watchdog need disable when the system s2idle.
> If don't, the watchdog will bark when system resume.

So disabled it from s2idle_ops->prepare() or
suspend_ops->prepare_late() if device suspend is too early for you.
