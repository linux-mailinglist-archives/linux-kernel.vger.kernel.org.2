Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA8D3C603C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhGLQRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:17:46 -0400
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:45506 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230019AbhGLQRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:17:45 -0400
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 20EEA181BDB94;
        Mon, 12 Jul 2021 16:14:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id CF5B920A297;
        Mon, 12 Jul 2021 16:14:54 +0000 (UTC)
Message-ID: <6fe3c15d985017ad4e7a266bcf214a711326f151.camel@perches.com>
Subject: Re: [PATCH] dax: replace sprintf() by scnprintf()
From:   Joe Perches <joe@perches.com>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Mon, 12 Jul 2021 09:14:53 -0700
In-Reply-To: <20210712122624.GB777994@pc>
References: <20210710164615.GA690067@pc>
         <10621e048f62018432c42a3fccc1a5fd9a6d71d7.camel@perches.com>
         <20210712122624.GB777994@pc>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: CF5B920A297
X-Spam-Status: No, score=1.53
X-Stat-Signature: dg9frhquxfqc8dkxcqj5z1gnfmbqt4nz
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+nBNFM9f63F3PVtFOORRYpE+8rW4mr8PA=
X-HE-Tag: 1626106494-476059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-07-12 at 13:26 +0100, Salah Triki wrote:
> On Sat, Jul 10, 2021 at 10:04:48AM -0700, Joe Perches wrote:
> > On Sat, 2021-07-10 at 17:46 +0100, Salah Triki wrote:
> > > Replace sprintf() by scnprintf() in order to avoid buffer overflows.
> > 
> > OK but also not strictly necessary.  DAX_NAME_LEN is 30.
> > 
> > Are you finding and changing these manually or with a script?
> > 
> > > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > []
> > > @@ -76,7 +76,7 @@ static ssize_t do_id_store(struct device_driver *drv, const char *buf,
> > >  	fields = sscanf(buf, "dax%d.%d", &region_id, &id);
> > >  	if (fields != 2)
> > >  		return -EINVAL;
> > > -	sprintf(devname, "dax%d.%d", region_id, id);
> > > +	scnprintf(devname, DAX_NAME_LEN, "dax%d.%d", region_id, id);
> > >  	if (!sysfs_streq(buf, devname))
> > >  		return -EINVAL;
> > >  
> > > 
> > 
> > 
> 
> since region_id and id are unsigned long may be devname should be
> char[21].

I think you need to look at the code a bit more carefully.

	unsigned int region_id, id;

Also the output is %d, so the maximum length of each output
int is 10 with a possible leading minus sign.

3 + 10 + 1 + 10 + 1.  So 25 not 21 which is too small.

The %d uses could be changed to %u to make it 23.
But really it hardly matters as 30 is sufficent and the
function call depth here isn't particularly high.

> I'm finding and changing these manually.

coccinelle could help.
https://coccinelle.gitlabpages.inria.fr/website/


