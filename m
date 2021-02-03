Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE930DE80
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbhBCPnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:43:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234606AbhBCPmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:42:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 729A864E41;
        Wed,  3 Feb 2021 15:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612366882;
        bh=pdKIqf8nvxkcgr1K6PBj4wBjfRw0jyR1RW3Hp9JQVhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNETbrN8uiUEsHEydik8tTIPDv5AUm9RBqNWecuKaglNRTGq8QDZZEgi+GuOawcju
         x+chWH11H7l2NZmLn5WNPB6W6al28vbj7dtMOi2HoWajl1oTBRyFaHYtS1ducge7dr
         knyn+hg+qjzbLvueGisQFnmNBnPkJ+6M9sFZA8sA=
Date:   Wed, 3 Feb 2021 16:41:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        andriy.shevchenko@linux.intel.com, bobo.shaobowang@huawei.com
Subject: Re: [PATCH 2/2] misc/pvpanic: add pci driver
Message-ID: <YBrEHyvGFAezcH7S@kroah.com>
References: <1612363439-26656-1-git-send-email-mihai.carabas@oracle.com>
 <1612363439-26656-3-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612363439-26656-3-git-send-email-mihai.carabas@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 04:43:59PM +0200, Mihai Carabas wrote:
> Add pvpanic pci device driver support.

What does that mean?  Please provide more changelog text here.

> 
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
> ---
>  drivers/misc/pvpanic/Kconfig       | 16 ++++++++++-
>  drivers/misc/pvpanic/Makefile      |  7 +++++
>  drivers/misc/pvpanic/pvpanic-pci.c | 54 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c
> 
> diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
> index 12bb017..4a96e8d 100644
> --- a/drivers/misc/pvpanic/Kconfig
> +++ b/drivers/misc/pvpanic/Kconfig
> @@ -1,6 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# pvpanic device
> +#

While nice, why add this now?

> +
>  config PVPANIC
>  	bool "pvpanic device support"
> -	depends on PVPANIC_MMIO
> +	depends on (PVPANIC_MMIO || PVPANIC_PCI)
>  	help
>  	  This option enable generic code for pvpanic device driver logic.
>  
> @@ -12,3 +17,12 @@ config PVPANIC_MMIO
>  	  This driver provides support for the pvpanic device.  pvpanic is
>  	  a paravirtualized device provided by QEMU; it lets a virtual machine
>  	  (guest) communicate panic events to the host.
> +
> +config PVPANIC_PCI
> +	tristate "pvpanic pci device support"
> +	depends on PCI
> +	select PVPANIC
> +	help
> +	  This driver provides support for the pvpanic device.  pvpanic is
> +	  a paravirtualized device provided by QEMU; it lets a virtual machine
> +	  (guest) communicate panic events to the host.
> diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
> index d08379b..fe57d1f 100644
> --- a/drivers/misc/pvpanic/Makefile
> +++ b/drivers/misc/pvpanic/Makefile
> @@ -1,2 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for pvpanic device.
> +#

Again, nice, but nothing to do with this change.  Please only do "one
thing" per patch.

thanks,

greg k-h
