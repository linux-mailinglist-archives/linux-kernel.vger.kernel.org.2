Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52132315066
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhBINiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:38:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhBINhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:37:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D03C64ECC;
        Tue,  9 Feb 2021 13:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612877799;
        bh=aCMDFgriYUqM7ObWJ2eF1msupqikQ0hVEHs5rlbVExE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7I6F/qVo+KtBHio0909wvtJWvsN7C4SBlErYV8Om+uaN0DHuCsNb2hWwHwPrmpSO
         xcw6CMPsFsVlyOn8d9wS8cQfrdTXdJZ+5CGAcueIKsoYOon4MKnl3Nsy9xTJu+5FtP
         0bf08C9ZvSMibh+qcIFX+BEsIo62PYOPxUOyJ9ok=
Date:   Tue, 9 Feb 2021 14:36:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Ximing Chen <mike.ximing.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: Re: [PATCH v10 01/20] dlb: add skeleton for DLB driver
Message-ID: <YCKP5ZUL1/wMzmf4@kroah.com>
References: <20210127225641.1342-1-mike.ximing.chen@intel.com>
 <20210127225641.1342-2-mike.ximing.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127225641.1342-2-mike.ximing.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 04:56:22PM -0600, Mike Ximing Chen wrote:
> Add basic driver functionality (load, unload, probe, and remove callbacks)
> for the DLB driver.
> 
> Add documentation which describes in detail the hardware, the user
> interface, device interrupts, and the driver's power-management strategy.
> For more details about the driver see the documentation in the patch.
> 
> Add a DLB entry to the MAINTAINERS file.
> 
> Signed-off-by: Gage Eads <gage.eads@intel.com>
> Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
> Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/misc-devices/dlb.rst   | 259 +++++++++++++++++++++++++++
>  Documentation/misc-devices/index.rst |   1 +
>  MAINTAINERS                          |   8 +
>  drivers/misc/Kconfig                 |   1 +
>  drivers/misc/Makefile                |   1 +
>  drivers/misc/dlb/Kconfig             |  18 ++
>  drivers/misc/dlb/Makefile            |   9 +
>  drivers/misc/dlb/dlb_hw_types.h      |  32 ++++
>  drivers/misc/dlb/dlb_main.c          | 156 ++++++++++++++++
>  drivers/misc/dlb/dlb_main.h          |  37 ++++
>  10 files changed, 522 insertions(+)
>  create mode 100644 Documentation/misc-devices/dlb.rst
>  create mode 100644 drivers/misc/dlb/Kconfig
>  create mode 100644 drivers/misc/dlb/Makefile
>  create mode 100644 drivers/misc/dlb/dlb_hw_types.h
>  create mode 100644 drivers/misc/dlb/dlb_main.c
>  create mode 100644 drivers/misc/dlb/dlb_main.h
> 
> diff --git a/Documentation/misc-devices/dlb.rst b/Documentation/misc-devices/dlb.rst
> new file mode 100644
> index 000000000000..aa79be07ee49
> --- /dev/null
> +++ b/Documentation/misc-devices/dlb.rst
> @@ -0,0 +1,259 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +===========================================
> +Intel(R) Dynamic Load Balancer Overview
> +===========================================
> +
> +:Authors: Gage Eads and Mike Ximing Chen
> +
> +Contents
> +========
> +
> +- Introduction
> +- Scheduling
> +- Queue Entry
> +- Port
> +- Queue
> +- Credits
> +- Scheduling Domain
> +- Interrupts
> +- Power Management
> +- User Interface
> +- Reset
> +
> +Introduction
> +============
> +
> +The Intel(r) Dynamic Load Balancer (Intel(r) DLB) is a PCIe device that
> +provides load-balanced, prioritized scheduling of core-to-core communication.
> +
> +Intel DLB is an accelerator for the event-driven programming model of
> +DPDK's Event Device Library[2]. The library is used in packet processing
> +pipelines that arrange for multi-core scalability, dynamic load-balancing, and
> +variety of packet distribution and synchronization schemes.

As this is a networking related thing, I would like you to get the
proper reviews/acks from the networking maintainers before I can take
this.

Or, if they think it has nothing to do with networking, that's fine too,
but please do not try to route around them.

thanks,

greg k-h
