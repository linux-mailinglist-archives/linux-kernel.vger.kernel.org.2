Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4709A3F5341
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhHWWQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhHWWP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:15:58 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16590C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:15:15 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id x4so17928191pgh.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RfdR9T5mZGKV6zTbvG9lN48TBpGfeb0ci4Ov6cLVODE=;
        b=XLlQyOR1TZ84fqnkKvmA5L1aYwtoI6/yyTnBLXhj0MUkxsRtFTL92CSa2Poa1HpbeW
         HNfiFyhu5K/uGj/LLOOtX21f98XnGYCB7+eekRvG9REDRbIVULgDFhMfiuzTsyEkg1lU
         IiV36AtV4FrBr0RUDVI8vQgODPfvq6sxZFf/NiejOayr84ME1Fo1XSj+iAS1DhQr5V2E
         RKy0cpY6S8FLuuWHO1c3uoOWSCruiLBitdCB7DJOTgKOUUJOYZiKAbOcswPcYLhg4+OG
         khbEp4vCYkhG6bOdxrgh6zIXbO+FdGmowvTiNKODeo15FdFB1iTm4/unoTpQFansWTg5
         PDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RfdR9T5mZGKV6zTbvG9lN48TBpGfeb0ci4Ov6cLVODE=;
        b=hXRfG9yGGzZjPCrX76XwuRSHqqDNKbvw2rKXu2O46CPB5p2eycguF3mz2f5Q7jxHDi
         k/b8e9nilDRfmferoXUP6ZXY0fIZwVaUmQQYCKIaKi8PZ4qjpWB83GRBJws//CoiTS3b
         /wd/wlYyyvpIZvunbXIO8YOboG1fecNW0vjWN6WdzSyNIhO6YFn0MnUEH5ILLcC2pBhq
         3EplZB/6VnhUFEC2Ls26xaOZf4pW7hsvb3A6hCShIvXqM0c8f7ffD126kmLPbsDI8v3h
         0+PPEtyolnNCqDwtznyEEkF4om9uTj5tdWc7MVFcsfdbWCVgjteAHcTSXYQBLeQMYA/l
         zuKA==
X-Gm-Message-State: AOAM530wJ5mqqPaQ9YgdHP1ZuIBpngvIR0cvqstT0mz9E7M/KEWVCiBu
        rAaZw3xSFcCArYTBOvSO1J9yHD2vuBRF/4/jO6Gxew==
X-Google-Smtp-Source: ABdhPJxp9KG95R1Y/hUK17QG53Sp8biAn/VMAUkMHbnmn6dbXi3Ry7luK6mPBChTKa0dR67/WYb+goSaRqISAIva4sY=
X-Received: by 2002:aa7:90d4:0:b029:3b3:2746:5449 with SMTP id
 k20-20020aa790d40000b02903b327465449mr35970535pfk.81.1629756914544; Mon, 23
 Aug 2021 15:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210823120106.9633-1-straube.linux@gmail.com>
In-Reply-To: <20210823120106.9633-1-straube.linux@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 23 Aug 2021 23:15:03 +0100
Message-ID: <CAA=Fs0=Yq9PMEProT4RPTan4K=aL-zkQw=y855vQu+iBTPztHQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] staging: r8188eu: use is_multicast_ether_addr instead
 of IS_MCAST
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

On Mon, 23 Aug 2021 at 13:02, Michael Straube <straube.linux@gmail.com> wrote:
>
> This series replaces most uses of the custom IS_MCAST macro with
> is_multicast_ether_addr. The goal is to get rid of IS_MCAST.
> There is only one usage left in rtw_sta_mgt.c, but that one needs
> more effort to verify that the buffers are properly aligned, so I
> left it as is for now.
>
> Michael Straube (8):
>   staging: r8188eu: ensure proper alignment for eth address buffers
>   staging: r8188eu: use is_multicast_ether_addr in core/rtw_mlme.c
>   staging: r8188eu: use is_multicast_ether_addr in core/rtw_mp.c
>   staging: r8188eu: use is_multicast_ether_addr in core/rtw_recv.c
>   staging: r8188eu: use is_multicast_ether_addr in core/rtw_security.c
>   staging: r8188eu: use is_multicast_ether_addr in core/rtw_xmit.c
>   staging: r8188eu: use is_multicast_ether_addr in hal/rtl8188eu_xmit.c
>   staging: r8188eu: use is_multicast_ether_addr in os_dep/recv_linux.c
>
>  drivers/staging/r8188eu/core/rtw_mlme.c      |  4 ++--
>  drivers/staging/r8188eu/core/rtw_mp.c        |  4 ++--
>  drivers/staging/r8188eu/core/rtw_recv.c      | 20 ++++++++++----------
>  drivers/staging/r8188eu/core/rtw_security.c  |  8 ++++----
>  drivers/staging/r8188eu/core/rtw_xmit.c      | 15 ++++++---------
>  drivers/staging/r8188eu/hal/rtl8188eu_xmit.c |  3 +--
>  drivers/staging/r8188eu/include/rtw_recv.h   | 10 +++++-----
>  drivers/staging/r8188eu/include/rtw_xmit.h   |  8 ++++----
>  drivers/staging/r8188eu/os_dep/recv_linux.c  |  2 +-
>  9 files changed, 35 insertions(+), 39 deletions(-)
>
> --
> 2.32.0
>

Dear Michael,

Based on my limited knowledge, looks good to me. Also I built and
runtime tested it with my N10-Nano, driver works well still. Many
thanks.

For whole series:
Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
