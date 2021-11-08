Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867F8449953
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 17:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbhKHQRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 11:17:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:12416 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236038AbhKHQRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 11:17:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="232098289"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="232098289"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 08:14:17 -0800
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="503082774"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 08:14:16 -0800
Date:   Mon, 8 Nov 2021 08:14:16 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvdimm/pmem: Fix an error handling path in
 'pmem_attach_disk()'
Message-ID: <20211108161416.GD3538886@iweiny-DESK2.sc.intel.com>
References: <f1933a01d9cefe24970ee93d741babb8fe9c1b32.1636219557.git.christophe.jaillet@wanadoo.fr>
 <20211107171157.GC3538886@iweiny-DESK2.sc.intel.com>
 <050385c3-7707-76cb-c580-c64d43456462@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <050385c3-7707-76cb-c580-c64d43456462@wanadoo.fr>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2021 at 06:20:14PM +0100, Christophe JAILLET wrote:
> Le 07/11/2021 � 18:11, Ira Weiny a �crit�:
> > On Sat, Nov 06, 2021 at 06:27:11PM +0100, Christophe JAILLET wrote:
> > > If 'devm_init_badblocks()' fails, a previous 'blk_alloc_disk()' call must
> > > be undone.
> > 
> > I think this is a problem...
> > 
> > > 
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > This patch is speculative. Several fixes on error handling paths have been
> > > done recently, but this one has been left as-is. There was maybe a good
> > > reason that I have missed for that. So review with care!
> > > 
> > > I've not been able to identify a Fixes tag that please me :(
> > > ---
> > >   drivers/nvdimm/pmem.c | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > > index fe7ece1534e1..c37a1e6750b3 100644
> > > --- a/drivers/nvdimm/pmem.c
> > > +++ b/drivers/nvdimm/pmem.c
> > > @@ -490,8 +490,9 @@ static int pmem_attach_disk(struct device *dev,
> > >   	nvdimm_namespace_disk_name(ndns, disk->disk_name);
> > >   	set_capacity(disk, (pmem->size - pmem->pfn_pad - pmem->data_offset)
> > >   			/ 512);
> > > -	if (devm_init_badblocks(dev, &pmem->bb))
> > > -		return -ENOMEM;
> > > +	rc = devm_init_badblocks(dev, &pmem->bb);
> > > +	if (rc)
> > > +		goto out;
> > 
> > But I don't see this 'out' label in the function currently?  Was that part of
> > your patch missing?
> 
> Hi,
> the patch is based on the latest linux-next.
> See [1]. The 'out' label exists there and is already used.

Ah I see.  Sorry.

> 
> In fact, I run an own-made coccinelle script which tries to spot mix-up
> between return and goto.
> In this case, we have a 'return -ENOMEM' after a 'goto out' which looks
> spurious.
>

Yes agreed.  I was looking at Linus' kernel not linux-next sorry.

Sorry for the noise,
Ira

> Hence, my patch.
> 
> [1]:https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/nvdimm/pmem.c#n512
> 
> CJ
> 
> > 
> > Ira
> > 
> > >   	nvdimm_badblocks_populate(nd_region, &pmem->bb, &bb_range);
> > >   	disk->bb = &pmem->bb;
> > > -- 
> > > 2.30.2
> > > 
> > 
> 
