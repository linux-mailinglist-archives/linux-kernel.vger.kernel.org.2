Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8472F3E9B41
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 01:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhHKXbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 19:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhHKXbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 19:31:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1DAC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:30:54 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso7655320pjy.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oGjft6uK2qjPni3rYs2xkfv9Qr3hWhHlCu61Lfg9dwo=;
        b=KGF7OvjM6xpm2dcnV4TZt94/0PP/6rryAn51TQtMI8PMyNstZiqpR4o4M6dhTamRWs
         g9EOZxb5D89XEfktvUEHHhPkpXy+Hmi05VOWRgwTVd9OLvFSv4xWFXhNWjEyIN09KyKs
         4fyqkWNdWLKgAPlcPDpAcmVW8lSwcX6cLZVgTZo6u78f/aDCPj+/UighVkaCNH/VsJGQ
         7hZeajrWOtjCr0mUDPSGbr2zvZ/0e2Z3s/NNdhwxHuoGSZq50liLutTN/XQtkRapPCgV
         FF6Bcix3tq/Al/ufi1oP33g4e6gANYimhDTdAXfmGgi4fPZkt9KFhhdzxGEY6dDmG5KC
         +BNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oGjft6uK2qjPni3rYs2xkfv9Qr3hWhHlCu61Lfg9dwo=;
        b=dYMwJByDg421zo/xP/YLNJGswwHc7jVZq4scDTBVXHBuTxYOYJQNVQ9FbMLwFC77t2
         AmN6ux8rZ8zvyzv2VQKwmUUWun8CTEMRDua5Y1dl4FCTUqbsdXVfoKotlosTQAcZWESB
         yrs2xGi4XTo2cAiQ9uKYMmGqdGcDmjRo2d4dtYwokFzgRAwQca6rRFgf8VS1g4Wag24x
         jiOb7NKAkd+y7d7nZ6vqc5deG3+J93luiTQW5EcUg9rvlf7NA6iN5TInKJvfUQ5a7a4r
         t8LNSA8l1BLATbIKe3aurAjZ5VneiBOqoYMoNApVlT51aZZa8dTlrCGvgrBjnbuVi/RK
         e3nQ==
X-Gm-Message-State: AOAM531y4bkXpvWr32Sx03J1YfJuIZ6tp8W6gUkzcCXQymBBqCbhqWy3
        MmRCnIs0IZvEjI1Lv2jXR/AcgEkiWaLBH0Sz9NtIAA==
X-Google-Smtp-Source: ABdhPJxlna/Ynzwk5Dff6Ys7vZddkj55PSC1UknedewCBNdz+1n2p06B5wLltjn/hQhKtMBQvZDWD+WnZ2/JP5T0TSs=
X-Received: by 2002:a17:90a:1b2e:: with SMTP id q43mr1054428pjq.217.1628724653564;
 Wed, 11 Aug 2021 16:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210810235047.177883-1-phil@philpotter.co.uk> <37fc4e87-3131-eb54-d47d-8ed4dc85e983@gmail.com>
In-Reply-To: <37fc4e87-3131-eb54-d47d-8ed4dc85e983@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Thu, 12 Aug 2021 00:30:42 +0100
Message-ID: <CAA=Fs0nkmsnewA8z_XKB--0bcxOoPnxZgn-_1fD3CccfN4nt3A@mail.gmail.com>
Subject: Re: [PATCH 0/8] staging: r8188eu: cleanup several warnings
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 at 07:39, Michael Straube <straube.linux@gmail.com> wrote:
>
> On 8/11/21 1:50 AM, Phillip Potter wrote:
> > This series does a lot of cleanup, and came about due to me noticing
> > that the Makefile contains several lines that silence build warnings
> > about unused variables, functions and so on.
> >
> > It accomplishes does three things therefore:
> > (1) Removes the unused functions no longer called by rtw_ioctl, which
> >      was deleted in a previous patch (with the exception of the android
> >      code, which I will add back in once ndo_siocdevprivate is merged in).
> > (2) Cleanup all build warnings resulting from removing the offending
> >      Makefile lines.
> > (3) Remove the offending Makefile lines so that future build warnings
> >      can be caught locally before submission as well.
> >
> > Phillip Potter (8):
> >    staging: r8188eu: remove unused functions from os_dep/ioctl_linux.c
> >    staging: r8188eu: remove unused oid_null_function function
> >    staging: r8188eu: remove unused label from recv_indicatepkt_reorder
> >    staging: r8188eu: remove rtw_mfree_sta_priv_lock function
> >    staging: r8188eu: remove unused variable from rtl8188e_init_dm_priv
> >    staging: r8188eu: remove unused variable from rtw_init_drv_sw
> >    staging: r8188eu: remove unused variable from rtw_init_recv_timer
> >    staging: r8188eu: remove lines from Makefile that silence build
> >      warnings
> >
> >   drivers/staging/r8188eu/Makefile             |    9 -
> >   drivers/staging/r8188eu/core/rtw_recv.c      |    2 -
> >   drivers/staging/r8188eu/core/rtw_sta_mgt.c   |    9 -
> >   drivers/staging/r8188eu/hal/rtl8188e_dm.c    |    1 -
> >   drivers/staging/r8188eu/include/rtw_ioctl.h  |    6 -
> >   drivers/staging/r8188eu/os_dep/ioctl_linux.c | 1538 ++----------------
> >   drivers/staging/r8188eu/os_dep/os_intfs.c    |    1 -
> >   drivers/staging/r8188eu/os_dep/recv_linux.c  |    2 -
> >   8 files changed, 127 insertions(+), 1441 deletions(-)
> >
>
> Acked-by: Michael Straube <straube.linux@gmail.com>
>
> Michael

Thank you Michael :-)

Regards,
Phil
