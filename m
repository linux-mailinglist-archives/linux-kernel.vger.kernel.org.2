Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33A64507A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 15:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbhKOO6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 09:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbhKOO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:58:15 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DAEC061714
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 06:55:19 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id k2so28607866lji.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 06:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QDBjuHaI/M6XAQNvDVXSkstOeNPvwT6mcUxnKoTVfL4=;
        b=AwzVbJFUDU3EZfTuWnksSgb+dXT8XY4jgxXBx35XeMkJERwsqCKC1pNuAxDC0AYmlg
         TlXQCMck2GmkkffaXe+AD8Adf4hlaDIMmmSmoEpAm6gRDZTkKjvMAgosfUBjjJsmlXr1
         sJ2krPt4VNHON36Ns3WIG3ewtwe4YH5zON+YrwBFNRwrn+caqZX3F57qAe9iK+yA+uHC
         3GvSSNMU1rYdL4EQE/ZW4WgbCdpKer1XRiXvYFNh0i/cfrUgehclzeyuURCGzzIQm3W+
         RnmpvL34j9z1ulOg/ZTtOUdICBJUxa4ZqKkm5odyQ/VX0PCocwAjEvQe2Vo1SaSMLOqS
         Ukhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDBjuHaI/M6XAQNvDVXSkstOeNPvwT6mcUxnKoTVfL4=;
        b=E4UXTTITIhtdRL6WZlM48JxNudC/EtTUX2ie++2A8U+g1taqUsUGulXjgr/zBAfxa3
         s0+1gbrfTUlV6sj179rtycgfWpHiKVSUTDJ2PMdWVyb+78Y6haE5jkqtoYAfrMUzRbXz
         M8qRAtGO8IhBK3LPJhToNPQ+Xy3IT5l6f73atTvab9x3OrNBj2DVB7moiBLGh1WohXPS
         fgzNaQTwlCtywp/niabr760b0e9jzHaT8340dn2m64Q/c0fM7Oh5Ch9qY823xImI4pk0
         bmJycErhYrUtE+Gv+4ZRPnLvOCpjdNRCG03FgA4oOKhb8/6H8PUpEQop+hII5ue7PQyH
         xGoA==
X-Gm-Message-State: AOAM533Zn7u0eFuTcCBxXER+ubBSe/fp+0YTHBUGTJ4+jlTCa55P0jul
        0rCNKD7Ot0yzI4wDqmAzYO+y/6ynNsVX5Mvi41dxU/ulbkc=
X-Google-Smtp-Source: ABdhPJxKgxsttYhTHkC2LoDZBAYtxZkRitvIhOVrLSIs2jWkLu8dlqJhJnAZdSCa5RkrfEp1Y8gHX84Eua4HH8QjIWw=
X-Received: by 2002:a05:651c:907:: with SMTP id e7mr41936174ljq.300.1636988117478;
 Mon, 15 Nov 2021 06:55:17 -0800 (PST)
MIME-Version: 1.0
References: <CGME20211104063243epcas1p4526b49feac019f3eadb33a23dc132976@epcas1p4.samsung.com>
 <20211104063231.2115-1-huijin.park@samsung.com>
In-Reply-To: <20211104063231.2115-1-huijin.park@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Nov 2021 15:54:41 +0100
Message-ID: <CAPDyKFrxbMvLNxFrsgD9KoG0eo_OSL3F91AU+tVJcf=mAj2c8Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: core: adjust polling interval for CMD1
To:     Huijin Park <huijin.park@samsung.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huijin Park <bbanghj.park@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2021 at 07:32, Huijin Park <huijin.park@samsung.com> wrote:
>
> This series is for adjusting polling interval for CMD1 using
> __mmc_poll_for_busy() common function which provides a stricter
> timeout checking and a throttling mechanism.
>
> v1...v2:
>  - Change __mmc_poll_for_busy() first parameter type to 'mmc_host*'.
>  - Use __mmc_poll_for_busy() common function.
>
> Huijin Park (2):
>   mmc: core: change __mmc_poll_for_busy() parameter type
>   mmc: core: adjust polling interval for CMD1
>
>  drivers/mmc/core/block.c   |  4 +-
>  drivers/mmc/core/mmc.c     |  2 +-
>  drivers/mmc/core/mmc_ops.c | 89 ++++++++++++++++++++++++--------------
>  drivers/mmc/core/mmc_ops.h |  2 +-
>  drivers/mmc/core/sd.c      |  2 +-
>  5 files changed, 62 insertions(+), 37 deletions(-)
>
> --
> 2.17.1
>

Applied for next, thanks!

Kind regards
Uffe
