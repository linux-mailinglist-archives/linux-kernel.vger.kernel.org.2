Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365E8346349
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhCWPuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232934AbhCWPuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:50:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E61A661963;
        Tue, 23 Mar 2021 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616514607;
        bh=QIAvIxn4BwZxI9azvLmjepIZnQ5GT0qWqdBJES0E7Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G9ZC+JrNw8dKHtQJbfpoeXX0+qi+n2VG+7pREUBOaSi7x+JkB95K0jsT9t6ecbDr9
         BkzcFxTf6cPXLgH5w7ip6pUg83I9t2zBtOX5ctdPdEruETy6jOZyI3ZAlcc2YEb042
         tBFkYdjVdo+wqqlU5a4Ea1iuYsh/PHXgD2iKO3XY=
Date:   Tue, 23 Mar 2021 16:50:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org
Subject: Re: [PATCH v7 1/3] misc/pvpanic: split-up generic and platform
 dependent code
Message-ID: <YFoOLON5W2hiOY4T@kroah.com>
References: <1616507978-15661-1-git-send-email-mihai.carabas@oracle.com>
 <1616507978-15661-2-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1616507978-15661-2-git-send-email-mihai.carabas@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 03:59:36PM +0200, Mihai Carabas wrote:
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
>  drivers/misc/pvpanic.c              | 161 ------------------------------------
>  drivers/misc/pvpanic/Kconfig        |  19 +++++
>  drivers/misc/pvpanic/Makefile       |   7 ++
>  drivers/misc/pvpanic/pvpanic-mmio.c | 135 ++++++++++++++++++++++++++++++
>  drivers/misc/pvpanic/pvpanic.c      |  77 +++++++++++++++++
>  drivers/misc/pvpanic/pvpanic.h      |  15 ++++
>  8 files changed, 255 insertions(+), 170 deletions(-)
>  delete mode 100644 drivers/misc/pvpanic.c
>  create mode 100644 drivers/misc/pvpanic/Kconfig
>  create mode 100644 drivers/misc/pvpanic/Makefile
>  create mode 100644 drivers/misc/pvpanic/pvpanic-mmio.c
>  create mode 100644 drivers/misc/pvpanic/pvpanic.c
>  create mode 100644 drivers/misc/pvpanic/pvpanic.h

With just this commit applied, I get the following build warnings:

drivers/misc/pvpanic/pvpanic-mmio.c:26:22: warning: ‘base’ defined but not used [-Wunused-variable]
   26 | static void __iomem *base;
      |                      ^~~~


ERROR: modpost: missing MODULE_LICENSE() in drivers/misc/pvpanic/pvpanic.o


Remember, each patch needs to work properly and not cause any build
failures or warnings to be added to the tree.

I suggest getting someone else at Oracle to review and test your
patchset before submitting it again so as I don't have to be the ones
finding these types of errors :)

thanks,

greg k-h
