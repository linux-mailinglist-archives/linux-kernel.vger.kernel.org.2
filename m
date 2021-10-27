Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556B243CC66
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242612AbhJ0Okd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Oct 2021 10:40:33 -0400
Received: from mail-qv1-f43.google.com ([209.85.219.43]:33708 "EHLO
        mail-qv1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbhJ0Okc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:40:32 -0400
Received: by mail-qv1-f43.google.com with SMTP id kd16so1930294qvb.0;
        Wed, 27 Oct 2021 07:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IIc3VM+0QP6tW1izmsIwRCOe4zK0xch73rEnQe2rldc=;
        b=bZRL694X7ag7gRm4SDz2tWTMYt6k0l087Ca7LvU3tgMTKFAi3HyF0SbFCTUEye2hPp
         4VQZSy86N/WDzEuwLmHyQ6klEYGfaOCVJPNc+MEaSOsp/R+cu1ORKDSnCMFuWBVHfbMb
         dgGubVm1fc7jARx+bt3eL9uT5s2oGI4lVXlzkxNMkxAXQCENIX6YtGlL4aUaLGHBv8Ys
         eHmrrtJ9LM7yn1+bCqi+I8sSREUbr0O44yHPp0Ehq9ay7GVaNX2cJS56e45ygkliIqhI
         HgpIX/6FHCfU2c+tEXa3SIhriI5T4vCxzQlFfHc436RcXRdHmszOycMfUppYslwj0k1E
         VGfw==
X-Gm-Message-State: AOAM5337qJDkO4lI5Z5WeyA96QewIkCuqI9qVqs2idLLaWLFGfDXc3Ro
        9DRQ1gK4IaBCybdMx8I8QA3el6czwfM=
X-Google-Smtp-Source: ABdhPJwQLaWZVWb/nNgd+6aO+EyS1atPXnwaSX94Bmfgmuz2/KU1BfeuqCmchvvRxdgUXwqNYIQ12g==
X-Received: by 2002:ad4:5b81:: with SMTP id 1mr21374587qvp.48.1635345486439;
        Wed, 27 Oct 2021 07:38:06 -0700 (PDT)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com. [209.85.219.46])
        by smtp.gmail.com with ESMTPSA id bq30sm137481qkb.6.2021.10.27.07.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 07:38:05 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id gh1so1875555qvb.8;
        Wed, 27 Oct 2021 07:38:05 -0700 (PDT)
X-Received: by 2002:a0c:fe8c:: with SMTP id d12mr25332323qvs.19.1635345485575;
 Wed, 27 Oct 2021 07:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211027080849.3276289-1-geert@linux-m68k.org>
In-Reply-To: <20211027080849.3276289-1-geert@linux-m68k.org>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 27 Oct 2021 09:37:54 -0500
X-Gmail-Original-Message-ID: <CADRPPNQwcTTS-0MkonizSA_XbLBbTS8di4F3NWOMADACp4gD_w@mail.gmail.com>
Message-ID: <CADRPPNQwcTTS-0MkonizSA_XbLBbTS8di4F3NWOMADACp4gD_w@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: Mark USB_FSL_QE broken on 64-bit
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 5:25 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On 64-bit:
>
>     drivers/usb/gadget/udc/fsl_qe_udc.c: In function ‘qe_ep0_rx’:
>     drivers/usb/gadget/udc/fsl_qe_udc.c:842:13: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>       842 |     vaddr = (u32)phys_to_virt(in_be32(&bd->buf));
>           |             ^
>     In file included from drivers/usb/gadget/udc/fsl_qe_udc.c:41:
>     drivers/usb/gadget/udc/fsl_qe_udc.c:843:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>       843 |     frame_set_data(pframe, (u8 *)vaddr);
>           |                            ^
>
> The driver assumes physical and virtual addresses are 32-bit, hence it
> cannot work on 64-bit platforms.

The device is truly only used in legacy 32-bit PowerPC chips and never
tested with 64-bit.  Thanks.

>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
> One more casualty of CONFIG_WERROR=y.
> http://kisskb.ellerman.id.au/kisskb/buildresult/14652936/
> ---
>  drivers/usb/gadget/udc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
> index 8c614bb86c665c77..69394dc1cdfb6436 100644
> --- a/drivers/usb/gadget/udc/Kconfig
> +++ b/drivers/usb/gadget/udc/Kconfig
> @@ -330,6 +330,7 @@ config USB_AMD5536UDC
>  config USB_FSL_QE
>         tristate "Freescale QE/CPM USB Device Controller"
>         depends on FSL_SOC && (QUICC_ENGINE || CPM)
> +       depends on !64BIT || BROKEN
>         help
>            Some of Freescale PowerPC processors have a Full Speed
>            QE/CPM2 USB controller, which support device mode with 4
> --
> 2.25.1
>
