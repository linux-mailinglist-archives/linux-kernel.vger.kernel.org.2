Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000B539DC9D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhFGMjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhFGMjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:39:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D93F4611C0;
        Mon,  7 Jun 2021 12:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623069436;
        bh=bYkjqVxKxw5u/jOfcmy8bIRNCz7tkqC4um4/DGazckU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nrHH89pGQ8diIt2VDaoa4sE5fVt5VUEk9cX448CIWtWALsI/7jjNsLC6+uERskwSi
         4GdAeyWGdnPhWdN2TW/ncys710LrAOAWdxqxsO6VjL9m9i65LRha+y238OcZA5YeK6
         M6SF0peRzBkdciMxesKeQcizlO+KzXV4Nptimcg8=
Date:   Mon, 7 Jun 2021 14:37:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 5/5] nvmem: eeprom: add documentation of sysfs sernum
 file
Message-ID: <YL4S+XwRZpaqkv9j@kroah.com>
References: <20210607122640.143582-1-jiri.prchal@aksignal.cz>
 <20210607122640.143582-6-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607122640.143582-6-jiri.prchal@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 02:26:40PM +0200, Jiri Prchal wrote:
> Added sysfs sernum file documentation.
> 
> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
> v5: new
> v6: no change here
> v7: no change here
> ---
>  Documentation/ABI/testing/sysfs-class-spi-eeprom | 6 ++++++
>  1 file changed, 6 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-spi-eeprom
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-spi-eeprom b/Documentation/ABI/testing/sysfs-class-spi-eeprom
> new file mode 100644
> index 000000000000..4f063a97b735
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-spi-eeprom
> @@ -0,0 +1,6 @@
> +What:		/sys/class/spi_master/spi<bus>/spi<bus>.<dev>/sernum
> +Date:		May 2021
> +KernelVersion:	5.12.1

Odd kernel version number, I do not think it is correct :)

thanks,

greg k-h
