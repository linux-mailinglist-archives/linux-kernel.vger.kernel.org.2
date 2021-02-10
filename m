Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8C4316A93
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhBJP6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhBJP6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:58:07 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E76C061788
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:57:27 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id b14so2113598qkk.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LnZWvw8W5/u6xVpD2aRPGMhTAoQ90h5OzwG4rDggYUs=;
        b=bssqGK7+59QEdqvEH0MdZXbJPgOElE0Ss6fUDy8PWHhWf2c5lGeO2Bf7TA1ANZtOIj
         +SzNiLM8hDnWrJ6TAwmAV6LfQ00GY1YL1PLqdG0Rp/Dn8Xkff1I8ho2ostTqFyp/xRud
         Bs8BrWM46A2MloXeZkSEBqE0wGLsOv3B1b/ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnZWvw8W5/u6xVpD2aRPGMhTAoQ90h5OzwG4rDggYUs=;
        b=RyPNCNoopulXpjmxv6Q/Yoq556BOO7LXnBYyYigAdSuTpaSlgYi1879opQrGZ0L0SN
         SMRllEq4Kcexp/knBioQx8+GrlRQgUQNZAn2cfEYBU4B06d1UR5gdyukmCjZe8HgMq2r
         7LNolyQvBi8cu+B80OLXAHbjQB7r/Tvsn6ScWr4mXmy1vnj0CPdtW8GoeEWoRcLqFBQM
         LtTecr4haeiZmQAbl8w42cDwtxampnbUUeJ3EA07SO4tMWvMULqeg13xDnxOSxhyRyvJ
         4UjEvXwMPmqAu1Mgx4CHq6WLQievcwgXRg0nj36F0unVFhbIxyq0xdXHngRK8WCEfrOM
         zv8g==
X-Gm-Message-State: AOAM533BmAV/t2WF4JyhRESQiGn/dATRgNw3FqxMbhHXd4AR/UhEt0GA
        qqzFJuZ+zidcP0VxFFbxsxYsLO4poUn54A==
X-Google-Smtp-Source: ABdhPJw7WJE+Ah0Q26dsGvIH7XQgCiPEFtj4+Jwb620DJquMIX6AtbDhXfi/6QStQO7X4umKGfte+Q==
X-Received: by 2002:a37:a191:: with SMTP id k139mr3795715qke.61.1612972645865;
        Wed, 10 Feb 2021 07:57:25 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id s129sm1768804qkh.37.2021.02.10.07.57.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 07:57:25 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id r2so2448927ybk.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:57:25 -0800 (PST)
X-Received: by 2002:a25:4fc3:: with SMTP id d186mr4703625ybb.343.1612972644635;
 Wed, 10 Feb 2021 07:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20210210142525.2876648-1-daniel.thompson@linaro.org>
In-Reply-To: <20210210142525.2876648-1-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 10 Feb 2021 07:57:12 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W9MUKYMusgUbq9RW8Hm9b+TtEMyrj6jfHrpe9twy5tvA@mail.gmail.com>
Message-ID: <CAD=FV=W9MUKYMusgUbq9RW8Hm9b+TtEMyrj6jfHrpe9twy5tvA@mail.gmail.com>
Subject: Re: [PATCH] kgdb: Remove kgdb_schedule_breakpoint()
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Emil Renner Berthing <kernel@esmil.dk>,
        kgdb-bugreport@liss.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 10, 2021 at 6:25 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> To the very best of my knowledge there has never been any in-tree
> code that calls this function. It exists largely to support an
> out-of-tree driver that provides kgdb-over-ethernet using the
> netpoll API.
>
> kgdboe has been out-of-tree for more than 10 years and I don't
> recall any serious attempt to upstream it at any point in the last
> five. At this stage it looks better to stop carrying this code in
> the kernel and integrate the code into the out-of-tree driver
> instead.
>
> The long term trajectory for the kernel looks likely to include
> effort to remove or reduce the use of tasklets (something that has
> also been true for the last 10 years). Thus the main real reason
> for this patch is to make explicit that the in-tree kgdb features
> do not require tasklets.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>
> Notes:
>     During this cycle two developers have proposed tidying up the
>     DECLARE_TASKLET_OLD() in the debug core. Both threads ended with a
>     suggestion to remove kgdb_schedule_breakpoint() but I don't recall
>     seeing a follow up patch for either thread... so I wrote it myself.
>
>  include/linux/kgdb.h      |  1 -
>  kernel/debug/debug_core.c | 26 --------------------------
>  2 files changed, 27 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
