Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6093FAF30
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 02:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbhH3ARW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 20:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhH3ARV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 20:17:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E333C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 17:16:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so8824978pjt.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 17:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lfvUPoqcsdtWp2xQNM0SN6X8Hkd9bKLbzzZB8u6GYqA=;
        b=s1RBr2BDjIqmSADqZJM0821Es4cznWSVszRMOTWsNkxJj1SaG2/cZK89mot5U7lcE6
         e5wI0RQVsYWB6V3cYeiepqfpDyM9VZ9EpT/FeszNQA3wrnbAi1yJo1m0EFCdrEd0ODw4
         on21sa3P4CgPLO8d5wNjFzhCZYD66ZooEYqe1voTzIUdj/PiUG4BIDz/MuIv7N+RJCCh
         2KtiiCMGIpVem6XMVY34j2+aCBIj1NzXS69DcYlnsaUgBBYTCiuOVcAD1JyPgmP4oCi4
         9YcxJDvuDAJkSU/FbbYyf7Y+2GD8MT9f+pHn/36VtjLNp6kiWKli8cAqsRhA1Xfo9Nhp
         0B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfvUPoqcsdtWp2xQNM0SN6X8Hkd9bKLbzzZB8u6GYqA=;
        b=SJTbn+bi2v1avTv3QhrUPZBLnDnrDSubMetYB9ykTsbXgsCA2fJrJeRjGRXxw5BUOC
         dBqo1dyML5kFWjbELlMGAyHGYwP8Fu8ODgmOAxq4SCJklt+rra+DgEUdR2erURv3Y8H/
         9Dwgn7dNtMIPktH+tlNUk+kKeTnX9C7nuc+yZTqEcJLsKCXvfx5xHY8t5fJpX0mIgs15
         T81ZMlio67/nSLVHQEeURZqNQjujkjWNaCoFCGunZ7pafsYN5qZ+RfIrDTaKYyB4EES8
         PXIYm2opRNibbuG9SQb6zCaqoKsXRRXjTQ53alnv5OUns/LTloT9X5FhvXSFcRGIT6y8
         huLQ==
X-Gm-Message-State: AOAM530PAX0Avk4xq8RmRu6NR2/sCnWZddtYliNj/Sta8UfoYd/8xaxm
        hW17wC9zZ+WVjuEwQD5RxPFoj7zwl3fiiaqDJ0t/qQ==
X-Google-Smtp-Source: ABdhPJzPA7ddCc4MfwJdTsKB2/CaMhpr98rYQhnXm4B9fIZpU/+zj9PvJZh5uu8BMvhtLbl5SiBY6MEX6ZSr56XuT6w=
X-Received: by 2002:a17:902:f704:b029:11a:cdee:490 with SMTP id
 h4-20020a170902f704b029011acdee0490mr19290977plo.37.1630282588598; Sun, 29
 Aug 2021 17:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210829112555.8726-1-straube.linux@gmail.com>
In-Reply-To: <20210829112555.8726-1-straube.linux@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 30 Aug 2021 01:16:17 +0100
Message-ID: <CAA=Fs0==H6_Jne-hRoQWFedPE02zaoL=Mov0mJam52+YQtEHKQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] staging: r8188eu: clean up unnecessary type casts
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2021 at 12:26, Michael Straube <straube.linux@gmail.com> wrote:
>
> This series removes unnecessary type casts from de/encrypt functions
> in core/rtw_security.c.
>
> Tested with Inter-Tech DMG-02 adapter connected to a CCMP network.
>
> Michael Straube (3):
>   staging: r8188eu: convert type of second parameter of rtw_*_encrypt()
>   staging: r8188eu: convert type of second parameter of rtw_*_decrypt()
>   staging: r8188eu: remove unnecessary type casts
>
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  2 +-
>  drivers/staging/r8188eu/core/rtw_recv.c       |  6 +-
>  drivers/staging/r8188eu/core/rtw_security.c   | 61 +++++++++----------
>  drivers/staging/r8188eu/core/rtw_xmit.c       |  6 +-
>  .../staging/r8188eu/include/rtw_security.h    | 12 ++--
>  5 files changed, 42 insertions(+), 45 deletions(-)
>
> --
> 2.32.0
>

Dear Michael,

Looks good to me, built/run fine again, for whole series:

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil Potter
