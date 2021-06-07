Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BD339D8D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhFGJdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230426AbhFGJdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:33:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28E8C610A1;
        Mon,  7 Jun 2021 09:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623058306;
        bh=WdVzm/FJG0NfLk07dFMDkGqLo03YPB29B8+bdyAfT0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OQHewZ19gjB42HQZErW1gFHA6wwnusEB6PQLhdkzotV3gvbjuriJ/fZpAagf2xV3O
         SjPY/CTmf7eAkwSwP7n80G7L+wVtgsbfAm5uqjUJc0CUuJoAL2VdbreFkyE4mTw/N9
         gFYYLEQR32zXn9El6jD8Pep1rEbceDpX5NAIw3fc=
Date:   Mon, 7 Jun 2021 11:31:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 4/5] nvmem: eeprom: at25: export FRAM serial num
Message-ID: <YL3ngDRPFJWgNSvJ@kroah.com>
References: <20210607082638.52409-1-jiri.prchal@aksignal.cz>
 <20210607082638.52409-5-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607082638.52409-5-jiri.prchal@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 10:26:37AM +0200, Jiri Prchal wrote:
> This exports serial number of FRAM in sysfs file named "sernum".
> Formatted in hex, each byte separated by space.
> Example:
> $ cat /sys/class/spi_master/spi0/spi0.0/sernum
> 0000a43644f2ae6c
> 
> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
> v2: no change here
> v3: resend and added more recipients
> v4: resend
> v5: reworked up on Greg comments: no spaces in string, sysfs done correctly
> v6: no change here
> ---
>  drivers/misc/eeprom/at25.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index 45a486994828..4e4fa8d3ba5d 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -39,6 +39,7 @@ struct at25_data {
>  	struct nvmem_config	nvmem_config;
>  	struct nvmem_device	*nvmem;
>  	int has_sernum;
> +	char *sernum;

If this really is only 8 bytes long, just make it an 8 byte array of u8
please.

thanks,

greg k-h
