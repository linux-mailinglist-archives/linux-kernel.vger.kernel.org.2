Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF162345E52
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhCWMil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230359AbhCWMiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:38:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3D40619A5;
        Tue, 23 Mar 2021 12:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616503101;
        bh=zN11fVU0Z030qlDrGEzPsWfYkZ1EdchzwyXI5aqwaG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3dl/67/RwkIgaUig79a+MWfmlM0fSAvPrzE0gvYr29ApnHS1EM+mkFeEmtRpaHuP
         6laW/WHRsj7BVE1ep8Jw8pJm4QNajpXCqwQSMDKBT2RPf/QnHzSoPKf7k9IhqqAxT3
         wdA3KJ8EDTYX7Sd3HEWnq2cHDlup6dekS4TB4FHE=
Date:   Tue, 23 Mar 2021 13:38:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org
Subject: Re: [PATCH v6 1/3] misc/pvpanic: split-up generic and platform
 dependent code
Message-ID: <YFnhOnRmaE7iVsDy@kroah.com>
References: <1616431467-14173-1-git-send-email-mihai.carabas@oracle.com>
 <1616431467-14173-2-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616431467-14173-2-git-send-email-mihai.carabas@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 06:44:25PM +0200, Mihai Carabas wrote:
> Split-up generic and platform dependent code in order to be able to re-use
> generic event handling code in pvpanic PCI device driver in the next patches.
> 
> The code from pvpanic.c was split in two new files:
> - pvpanic.c: generic code that handles pvpanic events
> - pvpanic-mmio.c: platform/bus dependent code
> 
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
> ---
>  drivers/misc/Kconfig                |   9 +-
>  drivers/misc/Makefile               |   2 +-
>  drivers/misc/pvpanic.c              | 160 ------------------------------------
>  drivers/misc/pvpanic/Kconfig        |  19 +++++
>  drivers/misc/pvpanic/Makefile       |   7 ++
>  drivers/misc/pvpanic/pvpanic-mmio.c | 134 ++++++++++++++++++++++++++++++
>  drivers/misc/pvpanic/pvpanic.c      |  77 +++++++++++++++++
>  drivers/misc/pvpanic/pvpanic.h      |  15 ++++
>  8 files changed, 254 insertions(+), 169 deletions(-)
>  delete mode 100644 drivers/misc/pvpanic.c
>  create mode 100644 drivers/misc/pvpanic/Kconfig
>  create mode 100644 drivers/misc/pvpanic/Makefile
>  create mode 100644 drivers/misc/pvpanic/pvpanic-mmio.c
>  create mode 100644 drivers/misc/pvpanic/pvpanic.c
>  create mode 100644 drivers/misc/pvpanic/pvpanic.h

This patch does not apply to my char-misc-next branch of char-misc.git
on git.kernel.org.  What did you make it against?

Please reabase it against the above branch and resend.

thanks,

greg k-h
