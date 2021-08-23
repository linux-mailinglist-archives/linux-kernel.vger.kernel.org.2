Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E663F52C3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 23:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhHWVVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 17:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhHWVV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 17:21:28 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BB3C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 14:20:45 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id j187so16477883pfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 14:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzvvjN55G6aH7L+WF3w6Ape9hLyYF6OiJZ3R0SJXV4M=;
        b=HIGlLVOuF6Uc6lqaWgoCbOA+4PANea69PmWibk9pQ90E18OQtQ9NjdVtg4gr9BhRDl
         Y8iGXjNXoBrM+ovH3DlRyzMTJf8WaBrLScu3e9bX0GJ/emLGpg1i/CliT2AWGLNrAo/2
         Bj70SLb9mf50wF+wDyUHSHg8bUa+lWP4fJU3VgjjlWaYor453PplbCRkwIQFqbZCYgjt
         YZ/Urtp/5dJ6vSl6sHYe56p7TVxmPJYTd1cJ0jSIem6JxoA1wkXvJzfqrhbbRpRXNxeA
         vvq+CLtmnbhVXNl+UGRLrxYF3teghLQvhfrui4OMaZ74+DoIWS81UW2Spi92T7uCr473
         kaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzvvjN55G6aH7L+WF3w6Ape9hLyYF6OiJZ3R0SJXV4M=;
        b=KITgQjt0OqYn4B7aZK0XAWr/dCw34yWM9O9TkRahsPhsMuMdyoZcbQkmPbgY7Mvp3/
         Z84D/kAGLuVzfW17gWgWwWtrP5K8UVKLb1A7t8jzJLB2f3hseRE4BU6m8gXfG1pEacIZ
         /1l9F2eXNssyafpmsIOwKeamjkdOccwe2xENcBfSD6mAoCaGLd+an6dh60SnC5yOj556
         xEMtTfACCpz/aODB6h9B9DImYGSHYyMokYITcQDuMnU6Z6AqVcX+9rtyepFH5qT3gXWS
         alapyQ1InWOxDcwzX6v+gEuRPeQtCwn/9iqeCoewf9WCc5TLk+1Ujz5tqZlhx/UM4dqY
         3fXA==
X-Gm-Message-State: AOAM533z/8Oor6s4zal6FDNa4NoO1FSkxNjA7dl407YRAjiy+unOC6O+
        ASPIGKqU+W72jYBsIzecT6wm4/aXot+40yb1DGI6GQ==
X-Google-Smtp-Source: ABdhPJxQV6KlBuY4Uu2+VpUA/lkXnBmb+TaFx3kE0sHNiLkcqjNr3ZG8Z+9MF38Cs+v83qMS731lraUA1+H+OC3X4zk=
X-Received: by 2002:a62:5c6:0:b029:341:e0b1:a72c with SMTP id
 189-20020a6205c60000b0290341e0b1a72cmr35907806pff.71.1629753643794; Mon, 23
 Aug 2021 14:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210823184059.19742-1-paskripkin@gmail.com>
In-Reply-To: <20210823184059.19742-1-paskripkin@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 23 Aug 2021 22:20:32 +0100
Message-ID: <CAA=Fs0mW_4aVNYuLkZMS9ov0CPNKfPB7C=FS2z67Ui+hEvtaRA@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: make rtw_deinit_intf_priv return void
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 at 19:41, Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> rtw_deinit_intf_priv() always return success, so there is no need in
> return value
>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>  drivers/staging/r8188eu/os_dep/usb_intf.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index e002070f7fba..37694aa96d13 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -129,13 +129,10 @@ static u8 rtw_init_intf_priv(struct dvobj_priv *dvobj)
>         return rst;
>  }
>
> -static u8 rtw_deinit_intf_priv(struct dvobj_priv *dvobj)
> +static void rtw_deinit_intf_priv(struct dvobj_priv *dvobj)
>  {
> -       u8 rst = _SUCCESS;
> -
>         kfree(dvobj->usb_alloc_vendor_req_buf);
>         _rtw_mutex_free(&dvobj->usb_vendor_req_mutex);
> -       return rst;
>  }
>
>  static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
> --
> 2.32.0
>

Dear Pavel,

Looks good - going to test your RFC series now btw.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
