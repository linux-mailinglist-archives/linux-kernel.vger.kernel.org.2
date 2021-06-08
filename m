Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD54039F1A6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhFHJG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229724AbhFHJG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:06:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49E776124B;
        Tue,  8 Jun 2021 09:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623143103;
        bh=Lk0dpZ3JnJrK/MuRM0J1KS/R98dqCBu105n2TZOlKD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RqZUBCTZ5WKmarg2bEJ50CKRXDZr/JG4u5uVdEnjRbVnv6zURHUX8UvW31Djxalsc
         IBbPI+z6EljJJTCJLphXWU0c1sR4qIQynxpBzX35qX5Y16ERLc6sERQrhi9mvqK9ye
         5m7kLYcJYtxiZ4+LClEF4tsvzR+frRupr7Ax6xbg=
Date:   Tue, 8 Jun 2021 11:05:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 5/5] nvmem: eeprom: add documentation of sysfs fram
 and sernum file
Message-ID: <YL8yveuSWTC9iEEz@kroah.com>
References: <20210607161201.223697-1-jiri.prchal@aksignal.cz>
 <20210607161201.223697-6-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607161201.223697-6-jiri.prchal@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 06:12:01PM +0200, Jiri Prchal wrote:
> Added sysfs fram and sernum file documentation.
> 
> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
> v5: new
> v6: no change here
> v7: no change here
> v8: added fram file doc
> ---
>  Documentation/ABI/testing/sysfs-class-spi-eeprom | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-spi-eeprom
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-spi-eeprom b/Documentation/ABI/testing/sysfs-class-spi-eeprom
> new file mode 100644
> index 000000000000..b41420fe1329
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-spi-eeprom
> @@ -0,0 +1,13 @@
> +What:		/sys/class/spi_master/spi<bus>/spi<bus>.<dev>/sernum
> +Date:		May 2021
> +KernelVersion:	5.13
> +Contact:	Jiri Prchal <jiri.prchal@aksignal.cz>
> +Description:
> +		(RO) Exports serial number of Cypress FRAM (FM25VN). 8 bytes as is in chip in hex string.

Please properly wrap your lines.

What is "(RO)" here?

And the grammer is a bit odd, what is the second sentence supposed to
mean?

> +
> +What:		/sys/class/spi_master/spi<bus>/spi<bus>.<dev>/fram
> +Date:		June 2021
> +KernelVersion:	5.13

Obviously it can not make 5.13, right?

> +Contact:	Jiri Prchal <jiri.prchal@aksignal.cz>
> +Description:
> +		(RW) FRAM data.

I have no idea what that is, do you?

Please provide real documentation for these entries.

thannks,

greg k-h
