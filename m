Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C883436505F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 04:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhDTCdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 22:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhDTCdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 22:33:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AA1C06174A;
        Mon, 19 Apr 2021 19:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=Nb17JDdSPfxWSg8o2kNqLlm4TjsZzjUQkLep2Es9IVI=; b=PfAlO9K6XH/+/W8GrufPsUZpl4
        bJvIZ36s15gWQhGtheyi2peoHxy0jpncvmqqPBZvgE5hiWAJFhic1Sv2s4PJAARo7WVF+qwCURMQj
        yLVcztFfdPRZxFzkr2/oUXAqGpNvj3Hs9P+3l8qEHcUT209BeN1LtbOKEbX7CrfaLg0TGxWZ+Q8Kg
        GghxteMSvWflGU71zYH7fznUI3FNTzvBL7JZGz4fo3iX03RF7Ki8+OczAWHdre2cqfNWV2xoe9KBo
        JQDaytpG5fOtCC4Ko/HAlpMvtF394TO+M0zeyWFcePZjgm2ORn6oIxmGQVQmaGwiUUmnowjCrMOZp
        1Y7W1Vcg==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYgBx-00Ec4H-Hn; Tue, 20 Apr 2021 02:32:48 +0000
Subject: Re: [PATCH 2/2] USB: misc: Add driver for the WCH CH341 in I2C/GPIO
 mode
To:     Frank Zago <frank@zago.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jan-Niklas Burfeind <kernel@aiyionpri.me>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-usb@vger.kernel.org
References: <20210420022520.47965-1-frank@zago.net>
 <20210420022520.47965-2-frank@zago.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <aa294927-b5d8-aee9-bfef-7aebfa63ef6e@infradead.org>
Date:   Mon, 19 Apr 2021 19:32:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210420022520.47965-2-frank@zago.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/19/21 7:25 PM, Frank Zago wrote:
> From: frank zago <frank@zago.net>
> 

> 
> Signed-off-by: Frank Zago <frank@zago.net>
> Signed-off-by: frank zago <frank@zago.net>

Don't think you need both of those.

> ---
>  MAINTAINERS                         |   6 +
>  drivers/usb/misc/Kconfig            |  18 ++
>  drivers/usb/misc/Makefile           |   1 +
>  drivers/usb/misc/ch341/Kconfig      |   0
>  drivers/usb/misc/ch341/Makefile     |   3 +
>  drivers/usb/misc/ch341/ch341-core.c |  87 +++++++++
>  drivers/usb/misc/ch341/ch341-gpio.c | 249 ++++++++++++++++++++++++++
>  drivers/usb/misc/ch341/ch341-i2c.c  | 267 ++++++++++++++++++++++++++++
>  drivers/usb/misc/ch341/ch341.h      |  50 ++++++
>  9 files changed, 681 insertions(+)
>  create mode 100644 drivers/usb/misc/ch341/Kconfig
>  create mode 100644 drivers/usb/misc/ch341/Makefile
>  create mode 100644 drivers/usb/misc/ch341/ch341-core.c
>  create mode 100644 drivers/usb/misc/ch341/ch341-gpio.c
>  create mode 100644 drivers/usb/misc/ch341/ch341-i2c.c
>  create mode 100644 drivers/usb/misc/ch341/ch341.h
> 

> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index 8f1144359012..2d4db92f0de4 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -284,3 +284,21 @@ config BRCM_USB_PINMAP
>  	  This option enables support for remapping some USB external
>  	  signals, which are typically on dedicated pins on the chip,
>  	  to any gpio.
> +
> +config USB_CH341_CORE
> +	tristate "USB WinChipHead CH341 in I2C/SPI/GPIO mode"
> +	depends on USB && GPIOLIB && I2C && SPI
> +	help
> +
> +	  If you say yes to this option, support for the CH341 chips,
> +	  running in I2C/SPI/GPIO mode will be included. Some versions
> +	  of the chip do not support all the functionnalities but
> +	  there is no way to differentiate them. For instance the
> +	  CH341A and CH341B support everything while the CH341T can
> +	  only do I2C.
> +
> +	  The serial mode is not supported by this driver. Use the
> +	  CH341 USB serial driver.
> +
> +	  This driver can also be built as a module.  If so, the
> +	  module will be called ch341-buses.

Above should be in drivers/usb/misc/ch341/Kconfig file instead?

> diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
> index 5f4e598573ab..95c0ca15b8c9 100644
> --- a/drivers/usb/misc/Makefile
> +++ b/drivers/usb/misc/Makefile
> @@ -32,3 +32,4 @@ obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
>  obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
>  obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
>  obj-$(CONFIG_BRCM_USB_PINMAP)		+= brcmstb-usb-pinmap.o
> +obj-$(CONFIG_USB_CH341_CORE)		+= ch341/
> diff --git a/drivers/usb/misc/ch341/Kconfig b/drivers/usb/misc/ch341/Kconfig
> new file mode 100644
> index 000000000000..e69de29bb2d1

Is that file (above) empty on purpose?

> diff --git a/drivers/usb/misc/ch341/Makefile b/drivers/usb/misc/ch341/Makefile
> new file mode 100644
> index 000000000000..7c6429e7a46e
> --- /dev/null
> +++ b/drivers/usb/misc/ch341/Makefile
> @@ -0,0 +1,3 @@
> +obj-$(CONFIG_USB_CH341_CORE) := ch341-buses.o
> +
> +ch341-buses-objs := ch341-core.o ch341-i2c.o ch341-gpio.o


-- 
~Randy

