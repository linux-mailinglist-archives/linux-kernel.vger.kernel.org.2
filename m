Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5CE3FAF36
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 02:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbhH3AUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 20:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236134AbhH3AUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 20:20:43 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0905DC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 17:19:51 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id c17so11847167pgc.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 17:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7sOgxh5lem9cj1KEc6iLijk0s6lVtzJesrQOxI4gds=;
        b=uHimCnK1Nx6nSJI1ckIog8xmVyEcgTbj8/8lr+Co5tESOxjFw/kMy5VphX1OhNziDI
         sjLI1Rwe6X07PfGWL5LNbMaChqTMwXOk8MJfHa7Pc2K5AqAoXGgEz/sfWZbjT53Xxb+e
         qMRaXfrCeuQKe7WlGAlAxuEJiZsDYh2WabR0/8DkLz3qWwNIYVtjLcudUOWmHXZQKDOE
         Ox20pKVzBzIZzKMHMREXoQWeG6fWeFrUFJ4oXTQYSDDY2vNf8m5kFaL1eX+9Oe/9fN+m
         ywICRtDU42L7MuTYXdzd/F0zeOLRK/MYgIFm29qyx8C0xK7/CAR7C0hq1Ith4e9gAIsd
         11vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7sOgxh5lem9cj1KEc6iLijk0s6lVtzJesrQOxI4gds=;
        b=LPxlqOeNnxRj6CKF6n0vRbyn3F4ylMn+3FSzrDiMGZdTtBZ7LD4SNRLgmzTzKROolp
         IYfUtWAHMfMFaxnmiwhgjwwIlNIaI39dF18rOOhrVrPYjI/gCvs/YntzyRGdEdgIP2NK
         ijAHz3qej7oRipfcXL9SOyTNArhdlzpq1wMz9LZU/t3+U37fl4xo2DYcm5i1/5X/njT7
         VYSgWHzc03Nv3SRyBa6dNzuvPuZVFR/9P5PXrlNZ29Vs4tV1cY8S7ZlMEyKSmMyijfjN
         DR1oSLPKrmJ9x9/9TQCeOpX7Ul0/4ZpNt+Peb6DdiSSd+rHVgCWJfY/WJr0epe2hv12D
         PMIQ==
X-Gm-Message-State: AOAM530eM6qGt7F2p/nyNMdMUO/fuJ2jFe640TPqrNj6N9W5MSuJ+Hns
        P/xokq9cQHZEniA0wiHQQvWo25FE2lYaVvg5X4iBxg==
X-Google-Smtp-Source: ABdhPJwKlOTWeEPfQEVZRR7XtLkcR6KCPwIGPD6VLKroMmyDLZlA05Wr0RIjpw6JJm4zQG2bTf4QjvtRx0rhnzp9os8=
X-Received: by 2002:a63:d910:: with SMTP id r16mr18988975pgg.318.1630282790557;
 Sun, 29 Aug 2021 17:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210829180717.15393-1-straube.linux@gmail.com>
In-Reply-To: <20210829180717.15393-1-straube.linux@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 30 Aug 2021 01:19:39 +0100
Message-ID: <CAA=Fs0mf+Ay_xLY6xqY2rjNTqbLLw8kH0=ia0ZjUDzGyUJXE1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: r8188eu: remove unused constants from wifi.h
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

On Sun, 29 Aug 2021 at 19:07, Michael Straube <straube.linux@gmail.com> wrote:
>
> The constants WLAN_REASON_PWR_CAPABILITY_NOT_VALID and
> WLAN_REASON_SUPPORTED_CHANNEL_NOT_VALID defined in wifi.h
> are unused, remove them.
>
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/include/wifi.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
> index 0b3fd94cea18..eb07ac9b8943 100644
> --- a/drivers/staging/r8188eu/include/wifi.h
> +++ b/drivers/staging/r8188eu/include/wifi.h
> @@ -126,8 +126,6 @@ enum WIFI_REASON_CODE       {
>  #define WLAN_REASON_DISASSOC_STA_HAS_LEFT 8
>  #define WLAN_REASON_STA_REQ_ASSOC_WITHOUT_AUTH 9 */
>  /* IEEE 802.11h */
> -#define WLAN_REASON_PWR_CAPABILITY_NOT_VALID 10
> -#define WLAN_REASON_SUPPORTED_CHANNEL_NOT_VALID 11
>
>  /* IEEE 802.11i
>  #define WLAN_REASON_INVALID_IE 13
> --
> 2.33.0
>

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
