Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC77B36B1C6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 12:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhDZKnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 06:43:00 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:3162 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232194AbhDZKm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:42:57 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AyA29FKGjWNd2RwvOpLqECceALOonbusQ8zAX?=
 =?us-ascii?q?/mp2TgFYddHdqtC2kJ0gpHvJoRsYRX1Io7u9EYaaR3e0z/RIyKkXeYyvRQz3/F?=
 =?us-ascii?q?avRbsC0aLH4xnNXxLz7fRc06AISdkaNPTVAUJhhcj3pCmUeuxB/PC9/KqlhfjT?=
 =?us-ascii?q?wh5WJGlXQppt4AtjBgGQHlcefngkObMCCJGe6sBbzgDPRV0raK2AakUtY/LOvJ?=
 =?us-ascii?q?nimp7gfHc9dnwawTjLvHeT5Ln2HwPw5HojejlEqI1MzVT4?=
X-IronPort-AV: E=Sophos;i="5.82,252,1613430000"; 
   d="scan'208";a="379682631"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 12:42:14 +0200
Date:   Mon, 26 Apr 2021 12:42:14 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        David Kershner <david.kershner@unisys.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Outreachy kernel] [RFC PATCH] staging: unisys: visorhba: Convert
 module from IDR to XArray
In-Reply-To: <70412520.S8q5jszebs@linux.local>
Message-ID: <alpine.DEB.2.22.394.2104261241000.7906@hadrien>
References: <20210426095015.18556-1-fmdefrancesco@gmail.com> <YIaORY3B6+6vMvFj@kroah.com> <70412520.S8q5jszebs@linux.local>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Apr 2021, Fabio M. De Francesco wrote:

> On Monday, April 26, 2021 11:56:21 AM CEST Greg Kroah-Hartman wrote:
> > On Mon, Apr 26, 2021 at 11:50:15AM +0200, Fabio M. De Francesco wrote:
> > > Converted visorhba from IDR to XArray. The abstract data type XArray is
> > > more memory-efficient, parallelisable and cache friendly. It takes
> > > advantage of RCU to perform lookups without locking.
> > >
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > >
> > >  .../staging/unisys/visorhba/visorhba_main.c   | 107 +++++++-----------
> > >  1 file changed, 44 insertions(+), 63 deletions(-)
> > >
> > > diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c
> > > b/drivers/staging/unisys/visorhba/visorhba_main.c index
> 4455d26f7c96..851e60ab0c46
> > > 100644
> > > --- a/drivers/staging/unisys/visorhba/visorhba_main.c
> > > +++ b/drivers/staging/unisys/visorhba/visorhba_main.c
> > > @@ -6,10 +6,10 @@
> > >
> > >  #include <linux/debugfs.h>
> > >  #include <linux/kthread.h>
> > >
> > > -#include <linux/idr.h>
> > >
> > >  #include <linux/module.h>
> > >  #include <linux/seq_file.h>
> > >  #include <linux/visorbus.h>
> > >
> > > +#include <linux/xarray.h>
> > >
> > >  #include <scsi/scsi.h>
> > >  #include <scsi/scsi_host.h>
> > >  #include <scsi/scsi_cmnd.h>
> > >
> > > @@ -23,6 +23,8 @@
> > >
> > >  #define MAX_PENDING_REQUESTS (MIN_NUMSIGNALS * 2)
> > >  #define VISORHBA_ERROR_COUNT 30
> > >
> > > +static DEFINE_XARRAY_ALLOC(xa_dtstr);
> > > +
> > >
> > >  static struct dentry *visorhba_debugfs_dir;
> > >
> > >  /* GUIDS for HBA channel type supported by this driver */
> > >
> > > @@ -78,12 +80,6 @@ struct visorhba_devdata {
> > >
> > >  	unsigned int max_buff_len;
> > >  	int devnum;
> > >  	struct uiscmdrsp *cmdrsp;
> > >
> > > -	/*
> > > -	 * allows us to pass int handles back-and-forth between us and
> > > -	 * iovm, instead of raw pointers
> > > -	 */
> > > -	struct idr idr;
> > > -
> > >
> > >  	struct dentry *debugfs_dir;
> > >  	struct dentry *debugfs_info;
> > >
> > >  };
> > >
> > > @@ -183,32 +179,16 @@ static struct uiscmdrsp
> *get_scsipending_cmdrsp(struct
> > > visorhba_devdata *ddata,>
> > >  }
> > >
> > >  /*
> > >
> > > - * simple_idr_get - Associate a provided pointer with an int value
> > > - *		    1 <= value <= INT_MAX, and return this int value;
> > > - *		    the pointer value can be obtained later by passing
> > > - *		    this int value to idr_find()
> > > - * @idrtable: The data object maintaining the pointer<-->int mappings
> > > - * @p:	      The pointer value to be remembered
> > > - * @lock:     A spinlock used when exclusive access to idrtable is needed
> > > - *
> > > - * Return: The id number mapped to pointer 'p', 0 on failure
> > > + * simple_xa_dtstr_get - Store a pointer to xa_dtstr xarray
> > > + * @id: Pointer to ID
> > > + * @entry: New entry
> > >
> > >   */
> > >
> > > -static unsigned int simple_idr_get(struct idr *idrtable, void *p,
> > > -				   spinlock_t *lock)
> > > +static int simple_xa_dtstr_get(u32 *id, void *entry)
> >
> > What are you trying to really "get" here?  We shouldn't name the
> > function based on the data type being used.  All we want is some sort of
> > "token" or hash or something else?  It's hard to tell...
> >
> Sorry, I am so lazy that I just substituted the _idr_ in the old name with
> _xa_dtstr_. Perhaps simple_entry_get() would be better. it deserves a v2.
> >
> > >  {
> > >
> > > -	int id;
> > > -	unsigned long flags;
> > > +	int ret = xa_alloc_irq(&xa_dtstr, id, entry, xa_limit_32b,
> GFP_NOWAIT);
> > > +	/* TODO: check for and manage errors */
> >
> > That's a nice TODO, which means we really should not be considering this
> > patch to be merged, right?
> >
> Right, lazy again :)
>
> The fact is that I was just interested in conversion from IDR to XArray
> because this would be the main subject of the project I applied for the DRM
> subsystem. Therefore, where I didn't find proper error checking and management
> in the old code, I simply wrote some TODO.
>
> I suppose that some more knowledge of both Linux device drivers programming
> and of that specific driver is needed to do proper management of errors in
> order to unwind what is already done by the code and leave everything in a
> consistent state. I'd left that work to Unisys developers, if you don't mind.
> I'd prefer to simply remove those TODO from where I placed them. I hope that
> you agree with me.

I don't know the details of this code, but normally the code is written so
that it is only what is done in the current function that has to be
unwound.  Perhaps it is possible to find what to do by looking at similar
code in other drivers.  It is better to do the whole thing than to leave
the code partly done.

julia
