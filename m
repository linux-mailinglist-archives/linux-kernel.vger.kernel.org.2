Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402403F0CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 22:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhHRUfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 16:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbhHRUfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 16:35:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D601BC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:34:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y190so3375894pfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHAShe2ZZZIC3ikmSrmgq0PWvhk6AlENUGfgwID98ag=;
        b=B1TY3A4EquqGKmOxkNxqpEF6Yau2sOmo2aGYv7IXhSz9vWWX1FzxEMc8L+MpzGVIS+
         arpPiDciXMIMoR0edg6Xht1sbtNOQRgOdrOcYzXR6Fu28ogqvVG9cVvhH1OylS0FufmZ
         DgUmmP6PplJKlLhVF7dKriY4e7APK5s5DImrLQff+BIr6BangBrCfnXnk/zrTMO9PH03
         xdp92qeQqOtMy302qd2HGJ57VWaNXG/V0n7bdzjnHISCm8z210HUqcF+en8uzF9WC97X
         cWvyI9VpCQrgeIn5AdxsOKIFBN7Bo2yCuxFNNDNcIBcQkob3z/POYo2CKV6iX42i4VpY
         W3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHAShe2ZZZIC3ikmSrmgq0PWvhk6AlENUGfgwID98ag=;
        b=CuFRLdpUoF3HUQgKJfqXoCMPTA78ykJTv8dGAwkwm7/ReJ9k5rJ2czQTWW5Dl4Z721
         JqBtsjfFCZ73Lr5Mol3qCxYg6poW8Kr94wAqS3i1xon3dH2RD+YJaco1zipfE8aADn1L
         Jo6Ue2VdPomLJiiYVROGUw7DiExhakZvRutzu8jfH7vV5PhZPfmrW0QgbJcFJ++6WXxc
         DoDw9HTG6BEzZ86aR83QvdAHhHtswwZkb+gT8geqeY/G6JkqmG4NJ5EEaLtECQwkq4g6
         kZzLuAt60Z3T1n6IDyyrTe2EyWwVkvtdg7fyM2KPki/Q+e8Cj4qnr2MUyQeuSQj7+eXh
         1ZzQ==
X-Gm-Message-State: AOAM5316jPhBpYYFfG7s5fr7I7kNToELEMwnWPW5m16iqTk8VTNABRSC
        zWIrAkiDd2pZjyuseCPTdnEJXyC2t152idGgJ0ff/g==
X-Google-Smtp-Source: ABdhPJyPILcJZiHXsIn184+numDWK81weiNXSDGmxRPp46df1Rw3UDh5ZF1UoM5GRC/X8NC+XYLgfaTWnOcmBa9+8sI=
X-Received: by 2002:a63:aa43:: with SMTP id x3mr10665794pgo.208.1629318874433;
 Wed, 18 Aug 2021 13:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210818200041.10870-1-martin@kaiser.cx> <20210818200041.10870-2-martin@kaiser.cx>
In-Reply-To: <20210818200041.10870-2-martin@kaiser.cx>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Wed, 18 Aug 2021 21:34:23 +0100
Message-ID: <CAA=Fs0k5b1XzUJbHX=W9AZzaG+bm9K9rLshwRzcMRS=zE0=5rQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: r8188eu: ctrl vendor req index is not used
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

On Wed, 18 Aug 2021 at 21:01, Martin Kaiser <martin@kaiser.cx> wrote:
>
> The index for r8188eu's vendor-specific control requests is not used.
> Remove the index parameter from usbctrl_vendorreq and pass index 0 to
> usb_control_msg.
>
> This patch is an adaptation of commit 3d0be94f62fd ("staging: rtl8188eu:
> ctrl vendor req index is not used") for the new r8188eu driver.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/hal/usb_ops_linux.c | 33 +++++++--------------
>  1 file changed, 10 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index 2583e3a941fd..953fa05dc30c 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -10,7 +10,7 @@
>  #include "../include/recv_osdep.h"
>  #include "../include/rtl8188e_hal.h"
>
> -static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, u16 index, void *pdata, u16 len, u8 requesttype)
> +static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata, u16 len, u8 requesttype)
>  {
>         struct adapter  *adapt = pintfhdl->padapter;
>         struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
> @@ -56,7 +56,8 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, u16 index, vo
>                 }
>
>                 status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> -                                        reqtype, value, index, pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
> +                                        reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
> +                                        pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
>
>                 if (status == len) {   /*  Success this control transfer. */
>                         rtw_reset_continual_urb_error(dvobjpriv);
> @@ -104,19 +105,17 @@ static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
>  {
>         u8 requesttype;
>         u16 wvalue;
> -       u16 index;
>         u16 len;
>         u8 data = 0;
>
>
>
>         requesttype = 0x01;/* read_in */
> -       index = 0;/* n/a */
>
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = 1;
>
> -       usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
> +       usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
>
>
>
> @@ -128,15 +127,13 @@ static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
>  {
>         u8 requesttype;
>         u16 wvalue;
> -       u16 index;
>         u16 len;
>         __le32 data;
>
>         requesttype = 0x01;/* read_in */
> -       index = 0;/* n/a */
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = 2;
> -       usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
> +       usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
>
>         return (u16)(le32_to_cpu(data) & 0xffff);
>  }
> @@ -145,17 +142,15 @@ static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
>  {
>         u8 requesttype;
>         u16 wvalue;
> -       u16 index;
>         u16 len;
>         __le32 data;
>
>         requesttype = 0x01;/* read_in */
> -       index = 0;/* n/a */
>
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = 4;
>
> -       usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
> +       usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
>
>         return le32_to_cpu(data);
>  }
> @@ -164,18 +159,16 @@ static int usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
>  {
>         u8 requesttype;
>         u16 wvalue;
> -       u16 index;
>         u16 len;
>         u8 data;
>         int ret;
>
>
>         requesttype = 0x00;/* write_out */
> -       index = 0;/* n/a */
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = 1;
>         data = val;
> -       ret = usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
> +       ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
>
>         return ret;
>  }
> @@ -184,7 +177,6 @@ static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
>  {
>         u8 requesttype;
>         u16 wvalue;
> -       u16 index;
>         u16 len;
>         __le32 data;
>         int ret;
> @@ -192,14 +184,13 @@ static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
>
>
>         requesttype = 0x00;/* write_out */
> -       index = 0;/* n/a */
>
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = 2;
>
>         data = cpu_to_le32(val & 0x0000ffff);
>
> -       ret = usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
> +       ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
>
>
>
> @@ -210,7 +201,6 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
>  {
>         u8 requesttype;
>         u16 wvalue;
> -       u16 index;
>         u16 len;
>         __le32 data;
>         int ret;
> @@ -218,13 +208,12 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
>
>
>         requesttype = 0x00;/* write_out */
> -       index = 0;/* n/a */
>
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = 4;
>         data = cpu_to_le32(val);
>
> -       ret = usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
> +       ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
>
>
>
> @@ -235,7 +224,6 @@ static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata
>  {
>         u8 requesttype;
>         u16 wvalue;
> -       u16 index;
>         u16 len;
>         u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
>         int ret;
> @@ -243,13 +231,12 @@ static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata
>
>
>         requesttype = 0x00;/* write_out */
> -       index = 0;/* n/a */
>
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = length;
>         memcpy(buf, pdata, len);
>
> -       ret = usbctrl_vendorreq(pintfhdl, wvalue, index, buf, len, requesttype);
> +       ret = usbctrl_vendorreq(pintfhdl, wvalue, buf, len, requesttype);
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
