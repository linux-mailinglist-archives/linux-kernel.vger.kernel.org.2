Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB58400559
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351299AbhICSyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351186AbhICSyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:54:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF69C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 11:53:41 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n18so84609plp.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cYg95UwxTL2wMWqBMmt8+HU/FFQUMY2wtY0M2szhJz8=;
        b=QIp/9/b95JTMk9GYZ/8RlI4mVoQv4y2yt6N+yut/ximLGMu+tuqgZ16WFcVWV1mqGq
         fepqe7v2A20HFYssg1nO6q3PyQblDX7qDazWYNC3Pc4VhRasd1EvBTpM67pwafkmKzDG
         8ZwaEw4euZAjKAjqzI5lRX4/sF1I7IIB4936jkCUQS49BrMluF7f8P0mevm9wlS7ku4e
         hqgcayKLbLvuVb/IOKLhAUOVhyk+g8yH4rXzxJUWxtaXS1b9YKwwWvnEEsSVj+yGWCeM
         /MQVfEbjm1zYGzx5w2DGXmIzOVBMQhysdwrnSbZKmhRZ5B1HpMAWs21lk0F51MSBhyYE
         Z3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYg95UwxTL2wMWqBMmt8+HU/FFQUMY2wtY0M2szhJz8=;
        b=YU5slN4ELsT2BlghOmtfh2T5PYpNuiFupuLBjzHJj9ES07ES0AOnMfj4OmLc3UlCXF
         ZS+N3gTAaTAfh8smLJGCc0ayat0+1zr+fVwY1sePjDyf5SXUpp5YGGJWTy1iktry2aLE
         xty47DXOdFB5CpNBRPnwv3cN+s1EDmHJLtoDzPPLmpsFQhZ7lO7GS4VfBBVQjL7jXSnv
         Opp42PfcjBmv8TSEgL38hTsfo57pOkUHaD9jlJTZjm24CnwFWEbJsq+sYyHF1okgIQvv
         QeaFqhq3W8CjnUbgWrfR6HvCF725a4ZT4Da05SwbU2NaxAzBOu94ykx5k6yxvKfG/bry
         PJuw==
X-Gm-Message-State: AOAM530mDjHDePoocnawKE/6LNmYk/OQIlTEBTmIAzDTPuKzWkGtyqZZ
        /q6j++V7DsvGSqpLAcn3pswJHo1arO11zHalwMmUMg==
X-Google-Smtp-Source: ABdhPJzaqbi+WTtOyW8aEzKZGLrWRFG0rYEWODEzLKf/vG09PU01udkGwV0zaahhozokMiR2kCRYO8U8/ekTQehdJDk=
X-Received: by 2002:a17:902:6b84:b029:ee:f966:1911 with SMTP id
 p4-20020a1709026b84b02900eef9661911mr224187plk.69.1630695220952; Fri, 03 Sep
 2021 11:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <YTJhwQstKPUYRwN+@user>
In-Reply-To: <YTJhwQstKPUYRwN+@user>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Fri, 3 Sep 2021 19:53:29 +0100
Message-ID: <CAA=Fs0mP7xqiS7+EX+J5MYH-AkEN_5SgtLrxAd669kXHG7Jk+A@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: os_dep: use kmemdup instead of kzalloc
 and memcpy
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        saurav.girepunje@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sept 2021 at 18:56, Saurav Girepunje
<saurav.girepunje@gmail.com> wrote:
>
> Fixes coccicheck warning:WARNING opportunity for kmemdup in ioctl_linux.c
>
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 81d4255d1785..495fadd2b8c8 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -585,14 +585,12 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
>         }
>
>         if (ielen) {
> -               buf = kzalloc(ielen, GFP_KERNEL);
> +               buf = kmemdup(pie, ielen, GFP_KERNEL);
>                 if (!buf) {
>                         ret =  -ENOMEM;
>                         goto exit;
>                 }
>
> -               memcpy(buf, pie, ielen);
> -
>                 /* dump */
>                 {
>                         int i;
> --
> 2.32.0
>

Dear Saurav,

Looks good, thanks:
Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
