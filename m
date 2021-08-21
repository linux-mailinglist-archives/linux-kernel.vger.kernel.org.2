Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F743F3BE8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 19:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbhHURsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 13:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhHURsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 13:48:19 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CCBC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:47:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id t42so8979960pfg.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=weI7dEBVDoKQ1ZWV63hBImrE6uK/njMI0Jn4Use0aPk=;
        b=lJ9TbWcy2L0UP7e4OsNstGjZ+H124xT39Rs/HnWh8Bxcm3mEQDfdLn0CFdY2JwVGLA
         LHkIonRmmdXTUdyamI6V2MrEm4T4spCXQfDt8liYl+xDy4KIrAdEgvzVTQV8q0xpoANa
         b0+y+LuLyXp/7CXFE1zFNhIPue9ILwrZ87SXSZd/yO9JtOiFiggHwr8csRmgK9zO2XoI
         +Uk3+JjvZtmui2Yv5El1j/g6yJlSfa8vBkgyvyUmlWIIx1TOhYdD+Y1kvmedCgsS7Xwg
         rjLtS1TawSz1sE3M1xD8PX7ibMcCm/syaiMs4JxizvtwgDPihFMlJKuSW414/XWn+66p
         9ibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=weI7dEBVDoKQ1ZWV63hBImrE6uK/njMI0Jn4Use0aPk=;
        b=Y7qIDq62GCnrF++/BZpQHp2ggx19Gkc5ozL1593E3TkS9d/W6PXahNN872P3q7pPux
         VYB+qRoMJex79H44fi+M10R0vV2o4wpfXVu6ieo0NTpLFxfBM/e46UZWiU8AfBVPeAJj
         7NK1PDB274kvZSZ3GCbuSK46gVQxVijFyuDCKUoCzqXCvxE0jkEBI5P1EF3+GksSphI3
         Fh1RWk0qpyE/AMvQkPyu332BC0hp1S4+rrnK0KaevJCwi7OWQ1wnNd5wR4Rrh+ezUUrV
         4BtrsXCAgFBuzMEnDNoMHRlE7h20xuWc3eCrCKmCV0rFOKo78uyT/yD2kWkfGeds/3fq
         +BYQ==
X-Gm-Message-State: AOAM531JveCCpqoijfPbWsqLFlk2BRzRItXGBdjQKSbeZdHDg2BgJ7z5
        EEJYfMF78yY7aoNrftQOVmnaO76UhIQurhsmc4WtTQ==
X-Google-Smtp-Source: ABdhPJykbxCkleRKKJlkecwiPdRxh2fNo6umihTj294KDTorcNY1IrVQQCcmJdlXlHhrVqcnn+5jG0NFlH5Im/5uyMQ=
X-Received: by 2002:a63:d910:: with SMTP id r16mr24184591pgg.318.1629568059462;
 Sat, 21 Aug 2021 10:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210821164859.4351-1-martin@kaiser.cx> <20210821164859.4351-10-martin@kaiser.cx>
In-Reply-To: <20210821164859.4351-10-martin@kaiser.cx>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 21 Aug 2021 18:47:28 +0100
Message-ID: <CAA=Fs0mm3=nNkBGbbodSZFcz7hT2NuV6Z_c6a+9qFMr8Vjg+_A@mail.gmail.com>
Subject: Re: [PATCH 10/10] staging: r8188eu: set pipe only once
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

On Sat, 21 Aug 2021 at 17:50, Martin Kaiser <martin@kaiser.cx> wrote:
>
> Set the pipe for reading or writing in usbctrl_vendorreq only once.
> There's no need to set it again for every retry.
>
> This patch is an adaptation of commit 889ed8b5e374 ("staging: rtl8188eu:
> set pipe only once") for the new r8188eu driver.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/hal/usb_ops_linux.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index 5408383ccec3..5a55ee38d7b8 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -40,15 +40,16 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>                 goto release_mutex;
>         }
>
> -       while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
> -               memset(pIo_buf, 0, len);
> +       if (requesttype == REALTEK_USB_VENQT_READ)
> +               pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
> +       else
> +               pipe = usb_sndctrlpipe(udev, 0);/* write_out */
>
> -               if (requesttype == REALTEK_USB_VENQT_READ) {
> -                       pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
> -               } else {
> -                       pipe = usb_sndctrlpipe(udev, 0);/* write_out */
> +       while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
> +               if (requesttype == REALTEK_USB_VENQT_READ)
> +                       memset(pIo_buf, 0, len);
> +               else
>                         memcpy(pIo_buf, pdata, len);
> -               }
>
>                 status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
>                                          requesttype, value, REALTEK_USB_VENQT_CMD_IDX,
> --
> 2.20.1
>

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
