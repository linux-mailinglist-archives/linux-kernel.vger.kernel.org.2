Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBE542ECE1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbhJOI4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:56:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235927AbhJOI4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:56:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36E9861053;
        Fri, 15 Oct 2021 08:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634288042;
        bh=dH/fOH5Jp65r1N02JcAZPsDUnPtrNbFHdT7TegvydHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GM5x2OPXJ7RnkYAxwcLjm3P4sSwHjaNa06XYFvzDn0uG2618QRj07StCU16Vy85wa
         7nTR4haV/92NtKz8eEdU6sX9ieghP3IcPxar1flTYX03P3BHdnufXTfpdGAATJi7Sf
         f5fI/zEY52mp8fFPmAhQ80lP6zAWKbW+PL9nroBs=
Date:   Fri, 15 Oct 2021 10:54:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eeprom: 93xx46: fix MODULE_DEVICE_TABLE
Message-ID: <YWlBqLFS7KpBvrg9@kroah.com>
References: <20211014153730.3821376-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014153730.3821376-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 05:37:18PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added SPI device ID table does not work because the
> entry is incorrectly copied from the OF device table.
> 
> During build testing, this shows as a compile failure when building
> it as a loadable module:
> 
> drivers/misc/eeprom/eeprom_93xx46.c:424:1: error: redefinition of '__mod_of__eeprom_93xx46_of_table_device_table'
> MODULE_DEVICE_TABLE(of, eeprom_93xx46_of_table);
> 
> Change the entry to refer to the correct symbol.
> 
> Fixes: 137879f7ff23 ("eeprom: 93xx46: Add SPI device ID table")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/misc/eeprom/eeprom_93xx46.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ah, nice catch, will queue this up now, thanks!

greg k-h
