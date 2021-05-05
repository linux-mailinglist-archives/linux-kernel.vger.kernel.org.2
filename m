Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394C0373AF3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 14:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhEEMSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 08:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbhEEMSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 08:18:02 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3C5C06134B
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 05:16:00 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e2so1538194ilr.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 05:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oqHb4rjlMXWPPEjHYTDBWNoZCPN0FDRJBPayCdf1+gU=;
        b=fC7moJwcexh5klTQU/Qos20CANVJQ0wGYXAyuhaEW/+cMXKHVVnTTnZA1B4VEz51rd
         CrfH126WMYAtoySakuXD+4WU2iaTZNuWIGHXwdV183CJw/dqRPLFvIFgmvOpFzmcfyT+
         FmiDzIYBHig8WTHjxscb43F5miqoZECfetDxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oqHb4rjlMXWPPEjHYTDBWNoZCPN0FDRJBPayCdf1+gU=;
        b=cevGfoBWcw71hepqPBOeAZVfyTuIir4YH3+AiG7i/UWCYacdv3smytpqlI8Z3VDDX+
         Ys8wH3YwjZqKkdDYXIEOikYNGACAG/O9wT9OLW/peaEXSclAlj8UWcDhmmxWVQLc7g9E
         WU8yr9hVgQkgy1O168YB4JObGQMgDM5jYfqJ+lohIqcSlkI/Dz+DLMDbUsw8QOq+FND2
         TwgKK0DyDNC3F/JKz6+wlpUZUZWKteBJnoHauSDJ2B5D+3yGYmihCjU87MvpVSW4+1XY
         pwzhIp2l8BlJ9etiEZRduTYgQ/0uDAQTpBTI+VYRvTljnfgYLdj8to+3moSB0mce6G6M
         QzTg==
X-Gm-Message-State: AOAM533NYcYYPqgiOD3Ko98Tg8BxpJ2KF9q/DfeWsPWK/5a0u6yN0Ifl
        UV626JLAdBGFEYIXiE8AeoToVA==
X-Google-Smtp-Source: ABdhPJzNiPFgzrMBLiHXKIJhn5JVROoYmNooEJpyd7zASOShC5srtlvUOLaoqzdp8ODmKU3x1bXjIw==
X-Received: by 2002:a05:6e02:969:: with SMTP id q9mr14743719ilt.285.1620216960210;
        Wed, 05 May 2021 05:16:00 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id 6sm2446098iog.36.2021.05.05.05.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 05:15:59 -0700 (PDT)
Subject: Re: [PATCH 22/35] tty: make tty_operations::write_room return uint
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Karsten Keil <isdn@linux-pingi.de>,
        Scott Branden <scott.branden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Lin <dtwlin@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20210505091928.22010-1-jslaby@suse.cz>
 <20210505091928.22010-23-jslaby@suse.cz>
From:   Alex Elder <elder@ieee.org>
Message-ID: <608f186f-0c88-1a5d-e612-7f133476f1e3@ieee.org>
Date:   Wed, 5 May 2021 07:15:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210505091928.22010-23-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/21 4:19 AM, Jiri Slaby wrote:
> Line disciplines expect a positive value or zero returned from
> tty->ops->write_room (invoked by tty_write_room). So make this
> assumption explicit by using unsigned int as a return value. Both of
> tty->ops->write_room and tty_write_room.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
> Cc: Jens Taprogge <jens.taprogge@taprogge.org>
> Cc: Karsten Keil <isdn@linux-pingi.de>
> Cc: Scott Branden <scott.branden@broadcom.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: David Lin <dtwlin@gmail.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Oliver Neukum <oneukum@suse.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Mathias Nyman <mathias.nyman@intel.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> ---
>   arch/alpha/kernel/srmcons.c            | 2 +-
>   arch/m68k/emu/nfcon.c                  | 2 +-
>   arch/parisc/kernel/pdc_cons.c          | 2 +-
>   arch/um/drivers/line.c                 | 6 +++---
>   arch/um/drivers/line.h                 | 2 +-
>   arch/xtensa/platforms/iss/console.c    | 2 +-
>   drivers/char/pcmcia/synclink_cs.c      | 2 +-
>   drivers/char/ttyprintk.c               | 2 +-
>   drivers/ipack/devices/ipoctal.c        | 2 +-
>   drivers/isdn/capi/capi.c               | 6 +++---
>   drivers/misc/bcm-vk/bcm_vk_tty.c       | 2 +-
>   drivers/mmc/core/sdio_uart.c           | 2 +-
>   drivers/net/usb/hso.c                  | 4 ++--
>   drivers/s390/char/con3215.c            | 2 +-
>   drivers/s390/char/sclp_tty.c           | 4 ++--
>   drivers/s390/char/sclp_vt220.c         | 4 ++--
>   drivers/s390/char/tty3270.c            | 2 +-
>   drivers/staging/fwserial/fwserial.c    | 6 +++---
>   drivers/staging/gdm724x/gdm_tty.c      | 2 +-
>   drivers/staging/greybus/uart.c         | 2 +-
>   drivers/tty/amiserial.c                | 2 +-
>   drivers/tty/ehv_bytechan.c             | 4 ++--
>   drivers/tty/goldfish.c                 | 2 +-
>   drivers/tty/hvc/hvc_console.c          | 2 +-
>   drivers/tty/hvc/hvcs.c                 | 2 +-
>   drivers/tty/hvc/hvsi.c                 | 4 ++--
>   drivers/tty/ipwireless/tty.c           | 2 +-
>   drivers/tty/mips_ejtag_fdc.c           | 4 ++--
>   drivers/tty/moxa.c                     | 8 ++++----
>   drivers/tty/mxser.c                    | 2 +-
>   drivers/tty/n_gsm.c                    | 2 +-
>   drivers/tty/nozomi.c                   | 4 ++--
>   drivers/tty/pty.c                      | 2 +-
>   drivers/tty/serial/kgdb_nmi.c          | 2 +-
>   drivers/tty/serial/serial_core.c       | 4 ++--
>   drivers/tty/synclink_gt.c              | 6 +++---
>   drivers/tty/tty_ioctl.c                | 2 +-
>   drivers/tty/ttynull.c                  | 2 +-
>   drivers/tty/vcc.c                      | 4 ++--
>   drivers/tty/vt/vt.c                    | 2 +-
>   drivers/usb/class/cdc-acm.c            | 2 +-
>   drivers/usb/gadget/function/u_serial.c | 6 +++---
>   drivers/usb/host/xhci-dbgtty.c         | 4 ++--
>   drivers/usb/serial/usb-serial.c        | 2 +-
>   include/linux/tty.h                    | 2 +-
>   include/linux/tty_driver.h             | 4 ++--
>   net/bluetooth/rfcomm/tty.c             | 2 +-
>   47 files changed, 71 insertions(+), 71 deletions(-)

. . .

Looks good.

Acked-by: Alex Elder <elder@linaro.org.

> diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
> index b1e63f7798b0..529eccb99b6c 100644
> --- a/drivers/staging/greybus/uart.c
> +++ b/drivers/staging/greybus/uart.c
> @@ -440,7 +440,7 @@ static int gb_tty_write(struct tty_struct *tty, const unsigned char *buf,
>   	return count;
>   }
>   
> -static int gb_tty_write_room(struct tty_struct *tty)
> +static unsigned int gb_tty_write_room(struct tty_struct *tty)
>   {
>   	struct gb_tty *gb_tty = tty->driver_data;
>   	unsigned long flags;

. . .

