Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D093400C4E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 19:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbhIDRym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 13:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhIDRyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 13:54:41 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AC1C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 10:53:40 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c17so2370196pgc.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 10:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QnhrKb9fsy/ZBD0qfjeHSev1bAl3ZIGL9b4MHAvFavg=;
        b=1GocTiMk4sq3+M4s/GkMG0fW6ATqHhJevDe/U8ZczJh8ZT2O7zuS8KUVtTIGvN9EIy
         IG5bWFYmtmk+2GzNIly9dIKsmoIVA1P4zs7nPzPsoutGXhotFmW+L0igHog677jS2IdK
         67n8Wsh6UGb25McHCQZIzQrc9kTu8xAp68AQ89ocbNBzYa9oAeTtlAXc78CBxebY4LMf
         p8WASJZxyfSRkPtqKV89ivauHU4mkjdFTznd9AMxb5wkG15PVhqz46EqNRAW571Zh0eC
         PwM/AvomHFsOoS2Ysp0xjWKRJ9KXZ6ZgKv0TtwYt0LLjbN37n7jFQLVkHxvxr/JQsHqx
         yKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QnhrKb9fsy/ZBD0qfjeHSev1bAl3ZIGL9b4MHAvFavg=;
        b=VJQpP0dFOsHYUHfDpiVNjxt88Dow5QKmmd7CQqx2Mlv42O7ExgeSeVyn4gQ0FzCOgG
         bKIGsGl+R268xUF3muuKlL83jxnqkTBm0aCAc3J7kP02w7+H5EpzRdaCwjeyHQN2QJab
         M9Mj8GdpawtZ/Yfk/7G73mOrYj7AxmyEJMpvI8VxXOSyUYB7sXbSZ0nNUyac18BTReap
         N4PZBucgO2zlSJ8iJSE3NxpIXJ/lXdB7VwedRGvGVhRMYrT5agwUyO2flObO3WEKg+lk
         ZfJR3jofdHIo+K0TyiOEFv/uxGyVsscSPqXrTSJ9oyDQ+VHrxFDVmJv1KbM7Er12zg90
         5EHQ==
X-Gm-Message-State: AOAM5328H2+vC3ETQYMzXcu8KNzlel2hqdNi3rqzOF8MYqvrt648cWzs
        u3o+pL8w6SqtcbhLKxDJ4za9fy9IHPgFCvQkd4NyM/sH342GUg==
X-Google-Smtp-Source: ABdhPJxYfJgqnyk3VuUHulejj2+44RV8+pgXi1bCUYVuN7MpyZYVC89NpwtNPKIiztcu4lS71NNbNyqHQlYSt302MV8=
X-Received: by 2002:a63:1a65:: with SMTP id a37mr4433700pgm.338.1630778019574;
 Sat, 04 Sep 2021 10:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <YTNrjG1y05ByN54+@user>
In-Reply-To: <YTNrjG1y05ByN54+@user>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 4 Sep 2021 18:53:28 +0100
Message-ID: <CAA=Fs0ki06L55d080iUVT=HUG3boOw0zf17e8VKoBtomUHeMcg@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: core: remove condition never execute
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        saurav.girepunje@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Sept 2021 at 13:50, Saurav Girepunje
<saurav.girepunje@gmail.com> wrote:
>
> Remove condition which never get execute.
> as pattrib->mdata is always zero before if condition check.
>
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index 4178b3c1ff57..f314f55997bf 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -5669,9 +5669,6 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
>         else if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE)
>                 SetToDs(fctrl);
>
> -       if (pattrib->mdata)
> -               SetMData(fctrl);
> -
>         qc = (unsigned short *)(pframe + pattrib->hdrlen - 2);
>
>         SetPriority(qc, tid);
> --
> 2.32.0
>

Thanks for this.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
