Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7B33F3BD2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 19:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhHURpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 13:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhHURpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 13:45:19 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A7BC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:44:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gz13-20020a17090b0ecdb0290178c0e0ce8bso11031541pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPIyta/4/+ogD90OFtauYPB3KoLyDV0Y7IVui0868u8=;
        b=WBdKyJtmWUZHHj9CJHnqV5YBr7tTr5hlY4C7793MHACg7MZNfLx8OyQcFJHb/hckQU
         7EirklONGN4x0fPI6CyVjlmC5VQAVfmycy1Dxtbqndx7DDkAC0AIC5AKJm63vCvwOvR0
         9YXyHgUnoU+WnQF1wXp4Gnv5Jt1cI4kFN4D6/65++NCXRBlvT2nOvMTeyF4pp3cWquwL
         a+02pufiEvsG6jBW1iF8bZIzOPIt5YlsMUSegvzItOhI+rBSve4fyaNO9uPQChSCVsOc
         tvkIUrrbbmbu/J3Cso1claguIUgLCpYUoO5uU4ZY7wAndsk64eURdB5ikSNQvSBQSLNA
         3TYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPIyta/4/+ogD90OFtauYPB3KoLyDV0Y7IVui0868u8=;
        b=AxLY7l0muaM5d1apa1a9NEwYz1uNrHUsZd1Ds3ANGO30LurkzuZQ0C0dPtKMUUOdvA
         FDuigrz9cNM5K/QURiA1uBv4N9/q/N6ZHqmEGhmAlK6vfOHtGCr08uMks4D4Fznh1mgU
         rjuo5uBVVdeXB6HFzBa6ugedlwUs6N4BRruUrLdhU/Qc6MpyZnd7+BDuIUcpmoTEWX44
         f1vt/wjiBVAtLJ5ur+VmvwrrN2d8xc6loNyPrRBAjA9ZRJWKg/uettcIXbEW8YxM5EUg
         u5RNfH2/R1NrrWG2Opj0JCDz3d+hUMjzvZH+Gx0g47JNu4wG0Ni278FS882fSB1HMCuw
         IPuA==
X-Gm-Message-State: AOAM532UHuDJ+bhqLPKoXPgNcD5l+wp1o/AoGp4rzPgxmA5tULw5+YVc
        vGRQ2d5mMg6CjgxbrYfrdtIyCrzcafHmHEYyTBfxJQ==
X-Google-Smtp-Source: ABdhPJyzUSPFsHVi/+6KGHJHSdWHRhlpOTTaHG34ZG3NwhS+EZ30hZFDB2KDbUFeWO+AD1CcX828wFiEjPKWDbKsO3E=
X-Received: by 2002:a17:90a:6906:: with SMTP id r6mr10893701pjj.162.1629567879426;
 Sat, 21 Aug 2021 10:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210821164859.4351-1-martin@kaiser.cx> <20210821164859.4351-3-martin@kaiser.cx>
In-Reply-To: <20210821164859.4351-3-martin@kaiser.cx>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 21 Aug 2021 18:44:28 +0100
Message-ID: <CAA=Fs0=k5GDmML7xy8PFwTKEWTDnO7KbWwv5vyO-sNUz0aO33A@mail.gmail.com>
Subject: Re: [PATCH 03/10] staging: rtl8188eu: use actual request type as parameter
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

On Sat, 21 Aug 2021 at 17:49, Martin Kaiser <martin@kaiser.cx> wrote:
>
> At the moment, usbctrl_vendorreq's requesttype parameter must be set to
> 1 for reading and 0 for writing. It's then converted to the actual
> bmRequestType for the USB control request. We can simplify the code and
> avoid this conversion if the caller passes the actual bmRequestType.
>
> This patch is an adaptation of commit 788fde031027 ("staging: rtl8188eu:
> use actual request type as parameter") for the new r8188eu driver.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/hal/usb_ops_linux.c | 46 ++++++---------------
>  1 file changed, 12 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index a11a0597e515..dccb9fd34777 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -15,7 +15,6 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>         struct usb_device *udev = dvobjpriv->pusbdev;
>         unsigned int pipe;
>         int status = 0;
> -       u8 reqtype;
>         u8 *pIo_buf;
>         int vendorreq_times = 0;
>
> @@ -44,26 +43,24 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>         while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
>                 memset(pIo_buf, 0, len);
>
> -               if (requesttype == 0x01) {
> +               if (requesttype == REALTEK_USB_VENQT_READ) {
>                         pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
> -                       reqtype =  REALTEK_USB_VENQT_READ;
>                 } else {
>                         pipe = usb_sndctrlpipe(udev, 0);/* write_out */
> -                       reqtype =  REALTEK_USB_VENQT_WRITE;
>                         memcpy(pIo_buf, pdata, len);
>                 }
>
>                 status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> -                                        reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
> +                                        requesttype, value, REALTEK_USB_VENQT_CMD_IDX,
>                                          pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
>
>                 if (status == len) {   /*  Success this control transfer. */
>                         rtw_reset_continual_urb_error(dvobjpriv);
> -                       if (requesttype == 0x01)
> +                       if (requesttype == REALTEK_USB_VENQT_READ)
>                                 memcpy(pdata, pIo_buf,  len);
>                 } else { /*  error cases */
>                         DBG_88E("reg 0x%x, usb %s %u fail, status:%d value=0x%x, vendorreq_times:%d\n",
> -                               value, (requesttype == 0x01) ? "read" : "write",
> +                               value, (requesttype == REALTEK_USB_VENQT_READ) ? "read" : "write",
>                                 len, status, *(u32 *)pdata, vendorreq_times);
>
>                         if (status < 0) {
> @@ -75,7 +72,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>                                 }
>                         } else { /*  status != len && status >= 0 */
>                                 if (status > 0) {
> -                                       if (requesttype == 0x01) {
> +                                       if (requesttype == REALTEK_USB_VENQT_READ) {
>                                                 /*  For Control read transfer, we have to copy the read data from pIo_buf to pdata. */
>                                                 memcpy(pdata, pIo_buf,  len);
>                                         }
> @@ -101,19 +98,16 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>
>  static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
>  {
> -       u8 requesttype;
>         u16 wvalue;
>         u16 len;
>         u8 data = 0;
>
>
>
> -       requesttype = 0x01;/* read_in */
> -
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = 1;
>
> -       usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> +       usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_READ);
>
>
>
> @@ -123,57 +117,49 @@ static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
>
>  static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
>  {
> -       u8 requesttype;
>         u16 wvalue;
>         u16 len;
>         __le32 data;
>
> -       requesttype = 0x01;/* read_in */
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = 2;
> -       usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> +       usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_READ);
>
>         return (u16)(le32_to_cpu(data) & 0xffff);
>  }
>
>  static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
>  {
> -       u8 requesttype;
>         u16 wvalue;
>         u16 len;
>         __le32 data;
>
> -       requesttype = 0x01;/* read_in */
> -
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = 4;
>
> -       usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> +       usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_READ);
>
>         return le32_to_cpu(data);
>  }
>
>  static int usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
>  {
> -       u8 requesttype;
>         u16 wvalue;
>         u16 len;
>         u8 data;
>         int ret;
>
>
> -       requesttype = 0x00;/* write_out */
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = 1;
>         data = val;
> -       ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> +       ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_WRITE);
>
>         return ret;
>  }
>
>  static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
>  {
> -       u8 requesttype;
>         u16 wvalue;
>         u16 len;
>         __le32 data;
> @@ -181,14 +167,12 @@ static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
>
>
>
> -       requesttype = 0x00;/* write_out */
> -
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = 2;
>
>         data = cpu_to_le32(val & 0x0000ffff);
>
> -       ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> +       ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_WRITE);
>
>
>
> @@ -197,7 +181,6 @@ static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
>
>  static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
>  {
> -       u8 requesttype;
>         u16 wvalue;
>         u16 len;
>         __le32 data;
> @@ -205,13 +188,11 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
>
>
>
> -       requesttype = 0x00;/* write_out */
> -
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = 4;
>         data = cpu_to_le32(val);
>
> -       ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> +       ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_WRITE);
>
>
>
> @@ -220,7 +201,6 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
>
>  static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata)
>  {
> -       u8 requesttype;
>         u16 wvalue;
>         u16 len;
>         u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
> @@ -228,13 +208,11 @@ static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata
>
>
>
> -       requesttype = 0x00;/* write_out */
> -
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = length;
>         memcpy(buf, pdata, len);
>
> -       ret = usbctrl_vendorreq(pintfhdl, wvalue, buf, len, requesttype);
> +       ret = usbctrl_vendorreq(pintfhdl, wvalue, buf, len, REALTEK_USB_VENQT_WRITE);
>
>         return ret;
>  }
> --
> 2.20.1
>

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
