Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1E23F52DF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 23:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhHWVbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 17:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhHWVbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 17:31:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6397EC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 14:30:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso368193pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 14:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uqxaMQ6hTk2eBZ0XEramsobAfczd0TIkACQ4/0xgpLk=;
        b=sg1X1qtmouHjUB8SY1oHPGs/wqCbmL00lD3orURrqv05AIpnOfADfOkWO59A+LqGhx
         pfjDn2sWAneGyX2Rt5NpZqKx8QQRyMphc1n9GcWeLFPJ5sZTFOvAoeKRzeB2+1TDd742
         zAvY8MKAQXeoqwEqeVRrDxketszarxECmWm/eEiONQgSbAx4UUujKEzqW65RRRuvc+P9
         71jaReWnWZMNxzFc8Y8poxtMMA5BGN125xMc4Pihe2TNIdXGvCdj/InHs514d4eedh2p
         RwivuDLLcVP2Ab6F3uBOyV5jxQfsK5kHEmQEQQM6IypG8OmM4r9bhQbPkrZ0GklXSE4i
         oUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uqxaMQ6hTk2eBZ0XEramsobAfczd0TIkACQ4/0xgpLk=;
        b=O7gLzgUixKDFnYAbbOI68brXE0mDXEvRISsSGCIkdgBBDQqd3JKOJRG1L0cjLIxaQK
         D/pYSW+ht0skyHP7SCbCyZE8mdg/E4OKbVQSV059xmtdfHMScAgP1/OflXvqXnQlyyxA
         hPSPPOPc05VZfgiGEXx5lVs36UegY5kvFNecjXZYXoiHrzPlooKDc2De/7J28Jfsprvm
         IaVAOXEwfoK2eqridLJ0fEOTPUN+AOYN9uVnz70sol2U4/agw+TqB37feHO/kdzilPzG
         iqX323unDLZEMs/mBVKZKXmclrxHucj9WxJhykm0mAIBfpykq/C06KX7AFYx0TSgDqbC
         AWWw==
X-Gm-Message-State: AOAM532H/dakrFB6GvAlnHli57u84g8iiYrTrxRjO33m+AGyv9niEbNN
        2BXu2U7ThPAveGJz9EOusKwbx1W7BoDAxV/2l5FS1Q==
X-Google-Smtp-Source: ABdhPJzbEbz3dB1by0wFx3BMPUCjNSqfbI4dFG2cNBNtKY8QLC+XKwo5p/40mBQa24i9NBG31cf66IltTlJ92AkhGKo=
X-Received: by 2002:a17:902:f704:b029:11a:cdee:490 with SMTP id
 h4-20020a170902f704b029011acdee0490mr30374463plo.37.1629754219920; Mon, 23
 Aug 2021 14:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210823193028.12391-1-straube.linux@gmail.com>
In-Reply-To: <20210823193028.12391-1-straube.linux@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 23 Aug 2021 22:30:09 +0100
Message-ID: <CAA=Fs0ks04VYJ56znpX2BjZX_7GCa=hkK+8TwifB_LwCry+y7g@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove 5 GHz code
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

On Mon, 23 Aug 2021 at 20:31, Michael Straube <straube.linux@gmail.com> wrote:
>
> The driver is for chips that do not operate in the 5 GHz band.
> Remove some 5 GHz related code.
>
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 30 ++++++--------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index ab4a9200f079..81d4255d1785 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -208,17 +208,10 @@ static char *translate_scan(struct adapter *padapter,
>                 else
>                         snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bg");
>         } else {
> -               if (pnetwork->network.Configuration.DSConfig > 14) {
> -                       if (ht_cap)
> -                               snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11an");
> -                       else
> -                               snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11a");
> -               } else {
> -                       if (ht_cap)
> -                               snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11gn");
> -                       else
> -                               snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11g");
> -               }
> +               if (ht_cap)
> +                       snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11gn");
> +               else
> +                       snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11g");
>         }
>
>         start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_CHAR_LEN);
> @@ -737,17 +730,10 @@ static int rtw_wx_get_name(struct net_device *dev,
>                         else
>                                 snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bg");
>                 } else {
> -                       if (pcur_bss->Configuration.DSConfig > 14) {
> -                               if (ht_cap)
> -                                       snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11an");
> -                               else
> -                                       snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11a");
> -                       } else {
> -                               if (ht_cap)
> -                                       snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11gn");
> -                               else
> -                                       snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11g");
> -                       }
> +                       if (ht_cap)
> +                               snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11gn");
> +                       else
> +                               snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11g");
>                 }
>         } else {
>                 snprintf(wrqu->name, IFNAMSIZ, "unassociated");
> --
> 2.32.0
>

Dear Michael,

Looks good to me. Thanks.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
