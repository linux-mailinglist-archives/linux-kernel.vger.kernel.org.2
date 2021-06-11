Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5B03A3E58
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhFKIzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229598AbhFKIzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:55:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AF5C611CD;
        Fri, 11 Jun 2021 08:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623401603;
        bh=smTzRx2zx9EfIZmrcrU3+rjPyo/xH3+WrI1TijPFAfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GEYn2q0edweutaShIlS4C2ma1EfL/x6cCf89p459q4/qkSKWqWUaVoex7OuA7sDZK
         imKQra24IJB3bYLqaiieP/fLX4zugNxh1AkF9ekRbiWqZt0UcazrgKgWY2Z+mp19H2
         2DfHVDaLLjFBfmMBlI8fT6hCDl47yP3d1HZUMMIc=
Date:   Fri, 11 Jun 2021 10:53:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 5/5] nvmem: eeprom: add documentation of sysfs fram
 and sernum file
Message-ID: <YMMkgfRBKpwCo3PE@kroah.com>
References: <20210611052652.7894-1-jiri.prchal@aksignal.cz>
 <20210611052652.7894-6-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611052652.7894-6-jiri.prchal@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 07:26:52AM +0200, Jiri Prchal wrote:
> Added sysfs fram and sernum file documentation.
> 
> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
> v5: new
> v6: no change here
> v7: no change here
> v8: added fram file doc
> v9: rewritten description
> ---
>  .../ABI/testing/sysfs-class-spi-eeprom        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-spi-eeprom
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-spi-eeprom b/Documentation/ABI/testing/sysfs-class-spi-eeprom
> new file mode 100644
> index 000000000000..4e69c78f9f65
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-spi-eeprom
> @@ -0,0 +1,20 @@
> +What:		/sys/class/spi_master/spi<bus>/spi<bus>.<dev>/sernum
> +Date:		May 2021
> +KernelVersion:	5.14
> +Contact:	Jiri Prchal <jiri.prchal@aksignal.cz>
> +Description:
> +	Contains the serial number of the Cypress FRAM (FM25VN) if it is
> +	present.  It will be displayed as a 8 byte hex string, as read
> +	from the device.
> +
> +	This is a read-only attribute.
> +
> +What:		/sys/class/spi_master/spi<bus>/spi<bus>.<dev>/fram
> +Date:		June 2021
> +KernelVersion:	5.14
> +Contact:	Jiri Prchal <jiri.prchal@aksignal.cz>
> +Description:
> +	Contains the FRAM binary data. Same as EEPROM, just another file
> +	name to indicate that it employs ferroelectric process.
> +	It performs write operations at bus speed - no write delays, capable
> +	of 10^14 read/write cycles and 151 years data retention.

Are you sure of these statistics?  Don't promise something here that
might not be true, this is not a marketing document :)

thanks,

greg k-h
