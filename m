Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7B73D0AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbhGUHvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236377AbhGUHmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:42:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2051860725;
        Wed, 21 Jul 2021 08:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626855773;
        bh=3PWNZrY7Out6Ln+JN77opOhAxUWkjAGCCcV/67Adxew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qI5dNiRdcZW41C4zH5DsiCCa1bfUyApXrNylhYbUKKn/hU05I1/GzHSh/PkFHMnQs
         zE7ISA/7UOy3NL4lQepk+1yOzqqo6RULs2L2s9KJgOaMG1lg7Yfe+r9fXFM6g/fuIL
         /wLGIK4EGDHh7xkBqrT3af/QIND4/0bsNbqNtuqg=
Date:   Wed, 21 Jul 2021 10:22:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ojaswin Mujoo <ojaswin98@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>, nsaenz@kernel.org,
        arnd@arndb.de, dan.carpenter@oracle.com, phil@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] staging: vchiq: Combine vchiq platform code into
 single file
Message-ID: <YPfZW0k563kuuHnx@kroah.com>
References: <cover.1625401927.git.ojaswin98@gmail.com>
 <b2e9eaee3e6d8f278a3277aaa284c5ca8b76d756.1625401928.git.ojaswin98@gmail.com>
 <b1b867c1-476c-8a5d-721b-ac19854efcbc@i2se.com>
 <20210711112821.GA5049@ojas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210711112821.GA5049@ojas>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2021 at 04:58:21PM +0530, Ojaswin Mujoo wrote:
> On Sun, Jul 11, 2021 at 12:49:35PM +0200, Stefan Wahren wrote:
> > Am 04.07.21 um 17:59 schrieb Ojaswin Mujoo:
> > > Combine the vchiq platform initialization code into a single file by
> > > merging vchiq_2835_arm.c into vchiq_arm.c
> > >
> > > Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
> > > ---
> > >  drivers/staging/vc04_services/Makefile        |   1 -
> > >  .../interface/vchiq_arm/vchiq_2835_arm.c      | 564 ------------------
> > >  .../interface/vchiq_arm/vchiq_arm.c           | 549 +++++++++++++++++
> > >  3 files changed, 549 insertions(+), 565 deletions(-)
> > >  delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> > >
> > > diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
> > > index 0a04338fc962..1fd191e2e2a5 100644
> > > --- a/drivers/staging/vc04_services/Makefile
> > > +++ b/drivers/staging/vc04_services/Makefile
> > > @@ -4,7 +4,6 @@ obj-$(CONFIG_BCM2835_VCHIQ)	+= vchiq.o
> > >  vchiq-objs := \
> > >     interface/vchiq_arm/vchiq_core.o  \
> > >     interface/vchiq_arm/vchiq_arm.o \
> > > -   interface/vchiq_arm/vchiq_2835_arm.o \
> > >     interface/vchiq_arm/vchiq_debugfs.o \
> > >     interface/vchiq_arm/vchiq_connected.o \
> > >  
> > ...
> > > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > > index 0f2de571eba7..9057d01ffd48 100644
> > > --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > > @@ -25,15 +25,32 @@
> > >  #include <linux/rcupdate.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/io.h>
> > > +#include <linux/uaccess.h>
> > >  #include <soc/bcm2835/raspberrypi-firmware.h>
> > >  
> > >  #include "vchiq_core.h"
> > >  #include "vchiq_ioctl.h"
> > >  #include "vchiq_arm.h"
> > >  #include "vchiq_debugfs.h"
> > > +#include "vchiq_connected.h"
> > > +#include "vchiq_pagelist.h"
> > >  
> > >  #define DEVICE_NAME "vchiq"
> > >  
> > > +#define TOTAL_SLOTS (VCHIQ_SLOT_ZERO_SLOTS + 2 * 32)
> > > +
> > > +#define MAX_FRAGMENTS (VCHIQ_NUM_CURRENT_BULKS * 2)
> > > +
> > > +#define VCHIQ_PLATFORM_FRAGMENTS_OFFSET_IDX 0
> > > +#define VCHIQ_PLATFORM_FRAGMENTS_COUNT_IDX  1
> > > +
> > > +#define BELL0	0x00
> > > +#define BELL2	0x08
> > > +
> > > +#define ARM_DS_ACTIVE	BIT(2)
> > > +
> > >  /* Override the default prefix, which would be vchiq_arm (from the filename) */
> > >  #undef MODULE_PARAM_PREFIX
> > >  #define MODULE_PARAM_PREFIX DEVICE_NAME "."
> > > @@ -59,10 +76,542 @@ static struct vchiq_drvdata bcm2836_drvdata = {
> > >  	.cache_line_size = 64,
> > >  };
> > >  
> > > +struct vchiq_2835_state {
> > > +	int inited;
> > > +	struct vchiq_arm_state arm_state;
> > > +};
> > > +
> > > +struct vchiq_pagelist_info {
> > > +	struct pagelist *pagelist;
> > > +	size_t pagelist_buffer_size;
> > > +	dma_addr_t dma_addr;
> > > +	enum dma_data_direction dma_dir;
> > > +	unsigned int num_pages;
> > > +	unsigned int pages_need_release;
> > > +	struct page **pages;
> > > +	struct scatterlist *scatterlist;
> > > +	unsigned int scatterlist_mapped;
> > > +};
> > > +
> > > +static void __iomem *g_regs;
> > > +/* This value is the size of the L2 cache lines as understood by the
> > > + * VPU firmware, which determines the required alignment of the
> > > + * offsets/sizes in pagelists.
> > > + *
> > > + * Modern VPU firmware looks for a DT "cache-line-size" property in
> > > + * the VCHIQ node and will overwrite it with the actual L2 cache size,
> > > + * which the kernel must then respect.  That property was rejected
> > > + * upstream, so we have to use the VPU firmware's compatibility value
> > > + * of 32.
> > > + */
> > > +static unsigned int g_cache_line_size = 32;
> > > +static unsigned int g_fragments_size;
> > > +static char *g_fragments_base;
> > > +static char *g_free_fragments;
> > > +static struct semaphore g_free_fragments_sema;
> > > +static struct device *g_dev;
> > > +
> > > +static DEFINE_SEMAPHORE(g_free_fragments_mutex);
> > > +
> > > +static irqreturn_t
> > > +vchiq_doorbell_irq(int irq, void *dev_id);
> > > +
> > > +static struct vchiq_pagelist_info *
> > > +create_pagelist(char *buf, char __user *ubuf, size_t count, unsigned short type);
> > > +
> > > +static void
> > > +free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
> > > +	      int actual);
> > 
> > please no forward declarations of these 3 functions. Put them into the
> > right order instead ...
> > 
> > Since this patch is independent from the other ones from the series,
> > maybe Greg can merg the rest of the series.
> > 
> > 
> > 
> 
> Hello Stefan,
> 
> Thanks for the review. As for the forward declerations, sure I can fix
> these 3 functions and send an independent patch for this.

Please fix up and resend the whole series properly so that I can apply
them that way.

thanks,

greg k-h
