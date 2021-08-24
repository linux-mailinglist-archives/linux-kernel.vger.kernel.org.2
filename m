Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B513F53FC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 02:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhHXAJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 20:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbhHXAJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 20:09:44 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E878FC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 17:09:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id n18so18169372pgm.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 17:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8x3/UqQR8bd8C1qjUbEbZOd8gxC4pFu+vpKcAnvRE5w=;
        b=VesUANvK36el3h6wmJIezyhO4FnEsqkNYKFTws6PZkkPtk1G8++WNn7OUXDrQyYNLg
         rJqdwSUv3BgSIK+kzlmK28i7DyrRn7RKvmterBq/eDBkF7VUNsZgCmMAYwt5c9AsdbAj
         tzpOAWVdaPKOXlfG8cjMzs70rQBOTSmei/2w0lkBKkXFcAH0HGT9Wb5STG2YlLt3AZPE
         6dTl/PhE0e6AolaK0s65duAqLVEOhIF9y7DdmCRp/ygm4wo8nUjilY8kjCkaS9ae866j
         kE4UpRrd3h5jVwtm9Uy/BmjTAwhazVNWQpilNisRFa791YtK9exlyJfET5+mGZIxUnBB
         HMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8x3/UqQR8bd8C1qjUbEbZOd8gxC4pFu+vpKcAnvRE5w=;
        b=uQqFwBdVZbhGaLevJyrGVB+xfrnTYTNnkWAR6rNl4/RYuUEzeIqQA5QmPQURCkYPqp
         mIWXdDpMSg7D4ge4+EJ/XJhy+rzEfJzLlTNZAkCfxBLbwtyGdcYUPbE+/9jhHDI093V+
         3bwJHIvo3KL+3nxC1hx4JbTTOTVQjuf6/e0DfN3/H7RvWizA82pPwi7XO4OfHQ5d07Lc
         fxFgGCfM8/oL+VEw+m28DXDwtoHrfCfpKoY8K8ytvNPixxWxVaRq9NHVxcdYI78wnmYe
         jEmgKQrBDb3O1PJz7qhHu0N71bCk3uP4osZh0W4r38QBarpIM3iv/t56bFXc1fFsqe67
         +tvg==
X-Gm-Message-State: AOAM53139bUc1gXyUmM0AhyvYrCafpbpiK8xwaGnGnH8bUTlbsMzWVS9
        e2U61Ypt9sMH5NLz/u0hQLJI9p6pnhGK7BmFQXbRQRO5VtU=
X-Google-Smtp-Source: ABdhPJz4A8FpV6mxFhCg2sNgTcbZImvVPl0UNcUCu4Wv2YZyB6yhgFRUvkH/IRicjeI8egBSQHCY0yUtpyhTmWAfsjE=
X-Received: by 2002:a63:aa43:: with SMTP id x3mr34608690pgo.208.1629763740430;
 Mon, 23 Aug 2021 17:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210823223751.25104-1-fmdefrancesco@gmail.com> <20210823223751.25104-2-fmdefrancesco@gmail.com>
In-Reply-To: <20210823223751.25104-2-fmdefrancesco@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Tue, 24 Aug 2021 01:08:49 +0100
Message-ID: <CAA=Fs0ki91VvBOd2Wd59KqeCN+BmF-eWv+r0sH+e3fUG61Zxsg@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 at 23:38, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> Replace usb_control_msg() with the new usb_control_msg_recv() and
> usb_control_msg_send() API of USB Core in usbctrl_vendorreq().
>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>
> Thanks to Pavel Skripkin <paskripkin@gmail.com> for his review of the
> RFC patch.
>
> drivers/staging/r8188eu/hal/usb_ops_linux.c | 25 ++++++++++-----------
> 1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index a93d5cfe4635..6f51660b967a 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -15,9 +15,8 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>         struct adapter  *adapt = pintfhdl->padapter;
>         struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
>         struct usb_device *udev = dvobjpriv->pusbdev;
> -       unsigned int pipe;
> +       u8 pipe;
>         int status = 0;
> -       u8 reqtype;
>         u8 *pIo_buf;
>         int vendorreq_times = 0;
>
> @@ -44,22 +43,22 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>         }
>
>         while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
> -               memset(pIo_buf, 0, len);
> -
>                 if (requesttype == 0x01) {
> -                       pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
> -                       reqtype =  REALTEK_USB_VENQT_READ;
> +                       status = usb_control_msg_recv(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> +                                                     REALTEK_USB_VENQT_READ, value,
> +                                                     REALTEK_USB_VENQT_CMD_IDX,
> +                                                     pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
> +                                                     GFP_KERNEL);
>                 } else {
> -                       pipe = usb_sndctrlpipe(udev, 0);/* write_out */
> -                       reqtype =  REALTEK_USB_VENQT_WRITE;
>                         memcpy(pIo_buf, pdata, len);
> +                       status = usb_control_msg_send(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> +                                                     REALTEK_USB_VENQT_WRITE, value,
> +                                                     REALTEK_USB_VENQT_CMD_IDX,
> +                                                     pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
> +                                                     GFP_KERNEL);
>                 }
>
> -               status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> -                                        reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
> -                                        pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
> -
> -               if (status == len) {   /*  Success this control transfer. */
> +               if (!status) {   /*  Success this control transfer. */
>                         rtw_reset_continual_urb_error(dvobjpriv);
>                         if (requesttype == 0x01)
>                                 memcpy(pdata, pIo_buf,  len);
> --
> 2.32.0
>

Dear Fabio,

Thanks for the patch. Sorry, but for some reason with my N10-Nano I
can't get a connection at all with this patch applied - it just won't
associate with my network. Interface shows up and no OOPS in log, but
just disassociates/no IP address/interface down etc. so perhaps
semantics differ slightly here somehow? Tried two separate
rollbacks/builds/runs just to make sure I wasn't losing my mind :-)

Regards,
Phil
