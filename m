Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB603D353A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhGWGtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhGWGtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:49:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5CCC061757
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 00:29:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ga41so2175544ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 00:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RyKdhfhM2ozADzjoi9snqvshlMAKUsPQuXC9VR1R4bY=;
        b=SuDfJj3oDKJDiz7MT1FAYF4FSwDuxSs2g5RcA4xt64rTeUBtstcti2DpV2dXup53uX
         ojjkF0eiIYXwP7lS3dhnPiFQzNNPTMvAdTfl2dXLCcmsdnrAq4qimMsmWm308ByoL7dj
         RWjnPcX1z4Isr0Bf69Bvxc5shPAmUQi2mPCglcz3nfeHjaI6XCWPkHpW/ppgMabTpXy/
         +UqxwCVOzzCmIsfYhTGApAj1aP8NRCH1o56vXQ7FkX9Yh7uLG2YGJGjHUbZ48twuPseT
         vs+4tR+7exVJSzyweNNJMypsMBSpgUdStwMiller3U5I8D1NE8Z3LOtRZG37i1VNpXQQ
         fvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RyKdhfhM2ozADzjoi9snqvshlMAKUsPQuXC9VR1R4bY=;
        b=hNNhSd6ExlN28GnP/KNc+y+UJBsdWZyBsPnclMIymaqdMd1SN8/E88hInydIwuYKRx
         6IX199UL1bWdbKxrvAhtBWEoCTziLce1el0pIWdTpQzbtMZTHnD76vkXbFh0NV6+660+
         5cDGe7awasauw3wmdcDvev4Ed3bjBkjTk1Vo1CP5ot8XrLxprZkkd54bdlrJA18kUrTq
         /U139HoNX49mHDYXiyeTtVhUKJrhMAEEDraa5jBjDzSH9PwVxRmEr6fBK15a/layf2aH
         A6XtkFryOjypLo5Qfn3N6tgGlGtVzcbNg4i5uuehXIieWf1/4jvPkddhYi032ouvR26H
         YMDg==
X-Gm-Message-State: AOAM533GsjLjZ4gomVZ2Dlp9USvPjjQ9CJ9B/5l79f4NoMLpoC9eS8Xn
        sgAbW229DXmJITHdDDx7iaI=
X-Google-Smtp-Source: ABdhPJy4X5MML4d5I6wlTr50QNM0NZRXqSCt/g6LMOLVd0QxCeG3+clvdMjt92GD7rPFhBfH2+mNQQ==
X-Received: by 2002:a17:906:38ce:: with SMTP id r14mr3375484ejd.268.1627025379124;
        Fri, 23 Jul 2021 00:29:39 -0700 (PDT)
Received: from agape.jhs ([5.171.81.31])
        by smtp.gmail.com with ESMTPSA id da23sm13571604edb.34.2021.07.23.00.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 00:29:38 -0700 (PDT)
Date:   Fri, 23 Jul 2021 09:29:36 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 6/7] staging: rtl8188eu: introduce new supporting files
 for RTL8188eu driver
Message-ID: <20210723072936.GA1613@agape.jhs>
References: <20210723004214.912295-1-phil@philpotter.co.uk>
 <20210723004214.912295-7-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723004214.912295-7-phil@philpotter.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Phillip,

On Fri, Jul 23, 2021 at 01:42:13AM +0100, Phillip Potter wrote:
> This patchset is split in order to keep the file sizes down. These
> supporting files are part of the newer/better driver from GitHub modified by
> Larry Finger. Import this as the basis for all future work going
> forward. Also, modify Makefile so that driver has same module filename
> as original rtl8188eu driver from staging.
> 
> Suggested-by: Larry Finger <Larry.Finger@lwfinger.net>
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/staging/rtl8188eu/COPYING  | 356 ++++++++++++++++++++
>  drivers/staging/rtl8188eu/Kconfig  |  25 ++
>  drivers/staging/rtl8188eu/Makefile | 509 +++++++++++++++++++++++++++++
>  3 files changed, 890 insertions(+)
>  create mode 100644 drivers/staging/rtl8188eu/COPYING
>  create mode 100644 drivers/staging/rtl8188eu/Kconfig
>  create mode 100755 drivers/staging/rtl8188eu/Makefile

Nice work...

a new TODO file is needed.

@Larry, maybe you can help us telling what's needed
to mainline this new rtl8188eu.

thank you,

fabio
