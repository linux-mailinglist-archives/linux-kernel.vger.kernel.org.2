Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FD53F0CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 22:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbhHRUeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 16:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhHRUee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 16:34:34 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFDDC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:33:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id bo18so3518049pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bFkCi7jA1bugf/PcyFaBe4iHuILgFqmYVrnySRbzbc=;
        b=bEiH2eEJkvdIiSvVOmkbSn1YwQZsT8u+HUuS/J7Oc7zymWQEpR9a7NC/f4TfIwo0p6
         h4T8P0PGQsHcO8IUvvX3FA27LVzeO4V+4z2nuH2T0J6ZWntEiiLx73uyQ3t7QT/l86tS
         qOBxYouwXka46rTNsVNKLprfmlz8Mr5EtI4kzHbQZAZrm6AtZCjhTAnhvzjKtbGShDTy
         WcWptxL5HmY16TZOgFEGsilOYewshcwlH+OhZ8iszVxQRGQ0fBpnQT/F/mKBt1+6Hgb/
         7nVd5lvuqORz0u0W3PMgidANSwUfsDprWOuYOY4tIyfSzzL4RHmWOBujpieKg+y9tzxr
         i8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bFkCi7jA1bugf/PcyFaBe4iHuILgFqmYVrnySRbzbc=;
        b=jgk0X/Hdp/5n97dIHPKvOpDgCPSmgNy59ejU0+8/GMIoJAhCWVgK6RUrpMfptUJDxQ
         nkTVuIFkDNzU1VuK3UX2pJ4JYq5T5YhElydKW190bGlJnNAtgQEymHdc2g9iWWj9r/nq
         O441f7udAr2nQF46LbZTvF9CALvsKMj8ETOwijVtE48Dz1y7DeG+7EmzfdutcnG0w3Y8
         uJF9kyGDFB2Vl+O//hj4bV3/h4perF9j31/0HprXiqXbq9bNfggk2eC9m2d6F1dqAWDP
         H9/rp3lsHAZ934u5meoYFpV5fjta5QXnImbN9NSi7QK45oaLK+2nR5rw0dRwdtsTJC18
         DNVw==
X-Gm-Message-State: AOAM532oE7jmQQN58lv2ALmQd/yG8oJnd35qNJ0Ftc0+RXJUWHyROx5j
        seMh/m63yNj1XCZgEw3FMcTcm2uNO1+Qhx0kJrmiRgdmMjQ=
X-Google-Smtp-Source: ABdhPJxTsC5NLxrjrvWplK6GdOHzdxpNekJij6P31JMSeXSehnFHXQiPLqxXdM3NVn4lhJxJY7jbzJbX7BsoYHEAd3M=
X-Received: by 2002:a17:90a:1f49:: with SMTP id y9mr11221430pjy.225.1629318838458;
 Wed, 18 Aug 2021 13:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210818200041.10870-1-martin@kaiser.cx>
In-Reply-To: <20210818200041.10870-1-martin@kaiser.cx>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Wed, 18 Aug 2021 21:33:47 +0100
Message-ID: <CAA=Fs0mOv=VfjV94NgA=dhKEDoSijWMxa-7LtyRwg3NuLNHPjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: r8188eu: ctrl vendor req value is always 0x05
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021 at 21:00, Martin Kaiser <martin@kaiser.cx> wrote:
>
> The bRequest value for the vendor specific control requests sent by this
> driver is always 0x05. Replace the function parameter with the define from
> usb_ops.h.
>
> This patch is an adaptation of commit eeb4661560ff ("staging: rtl8188eu:
> ctrl vendor req value is always 0x05") for the new r8188eu driver.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/hal/usb_ops_linux.c | 33 +++++++--------------
>  1 file changed, 10 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index b4edbfda9a18..2583e3a941fd 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -10,7 +10,7 @@
>  #include "../include/recv_osdep.h"
>  #include "../include/rtl8188e_hal.h"
>
> -static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u8 request, u16 value, u16 index, void *pdata, u16 len, u8 requesttype)
> +static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, u16 index, void *pdata, u16 len, u8 requesttype)
>  {
>         struct adapter  *adapt = pintfhdl->padapter;
>         struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
> @@ -55,7 +55,8 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u8 request, u16 value, u
>                         memcpy(pIo_buf, pdata, len);
>                 }
>
> -               status = usb_control_msg(udev, pipe, request, reqtype, value, index, pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
> +               status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> +                                        reqtype, value, index, pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
>
>                 if (status == len) {   /*  Success this control transfer. */
>                         rtw_reset_continual_urb_error(dvobjpriv);
> @@ -101,7 +102,6 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u8 request, u16 value, u
>
>  static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
>  {
> -       u8 request;
>         u8 requesttype;
>         u16 wvalue;
>         u16 index;
> @@ -110,14 +110,13 @@ static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
>
>
>
> -       request = 0x05;
>         requesttype = 0x01;/* read_in */
>         index = 0;/* n/a */
>
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = 1;
>
> -       usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
> +       usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
>
>
>
> @@ -127,47 +126,42 @@ static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
>
>  static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
>  {
> -       u8 request;
>         u8 requesttype;
>         u16 wvalue;
>         u16 index;
>         u16 len;
>         __le32 data;
>
> -       request = 0x05;
>         requesttype = 0x01;/* read_in */
>         index = 0;/* n/a */
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = 2;
> -       usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
> +       usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
>
>         return (u16)(le32_to_cpu(data) & 0xffff);
>  }
>
>  static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
>  {
> -       u8 request;
>         u8 requesttype;
>         u16 wvalue;
>         u16 index;
>         u16 len;
>         __le32 data;
>
> -       request = 0x05;
>         requesttype = 0x01;/* read_in */
>         index = 0;/* n/a */
>
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = 4;
>
> -       usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
> +       usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
>
>         return le32_to_cpu(data);
>  }
>
>  static int usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
>  {
> -       u8 request;
>         u8 requesttype;
>         u16 wvalue;
>         u16 index;
> @@ -176,20 +170,18 @@ static int usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
>         int ret;
>
>
> -       request = 0x05;
>         requesttype = 0x00;/* write_out */
>         index = 0;/* n/a */
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = 1;
>         data = val;
> -       ret = usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
> +       ret = usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
>
>         return ret;
>  }
>
>  static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
>  {
> -       u8 request;
>         u8 requesttype;
>         u16 wvalue;
>         u16 index;
> @@ -199,7 +191,6 @@ static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
>
>
>
> -       request = 0x05;
>         requesttype = 0x00;/* write_out */
>         index = 0;/* n/a */
>
> @@ -208,7 +199,7 @@ static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
>
>         data = cpu_to_le32(val & 0x0000ffff);
>
> -       ret = usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
> +       ret = usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
>
>
>
> @@ -217,7 +208,6 @@ static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
>
>  static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
>  {
> -       u8 request;
>         u8 requesttype;
>         u16 wvalue;
>         u16 index;
> @@ -227,7 +217,6 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
>
>
>
> -       request = 0x05;
>         requesttype = 0x00;/* write_out */
>         index = 0;/* n/a */
>
> @@ -235,7 +224,7 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
>         len = 4;
>         data = cpu_to_le32(val);
>
> -       ret = usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
> +       ret = usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
>
>
>
> @@ -244,7 +233,6 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
>
>  static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata)
>  {
> -       u8 request;
>         u8 requesttype;
>         u16 wvalue;
>         u16 index;
> @@ -254,7 +242,6 @@ static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata
>
>
>
> -       request = 0x05;
>         requesttype = 0x00;/* write_out */
>         index = 0;/* n/a */
>
> @@ -262,7 +249,7 @@ static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata
>         len = length;
>         memcpy(buf, pdata, len);
>
> -       ret = usbctrl_vendorreq(pintfhdl, request, wvalue, index, buf, len, requesttype);
> +       ret = usbctrl_vendorreq(pintfhdl, wvalue, index, buf, len, requesttype);
>
>         return ret;
>  }
> --
> 2.20.1
>

Looks good.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
