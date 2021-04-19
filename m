Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70168364D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 00:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhDSWAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 18:00:33 -0400
Received: from smtprelay0203.hostedemail.com ([216.40.44.203]:34804 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229558AbhDSWAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 18:00:32 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id BE8CB100E7B45;
        Mon, 19 Apr 2021 22:00:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 49D5A315D7B;
        Mon, 19 Apr 2021 22:00:00 +0000 (UTC)
Message-ID: <84e443d76c4c450770ade83aa48cc631c101d383.camel@perches.com>
Subject: Re: [PATCH v2] iommu/amd: Fix extended features logging
From:   Joe Perches <joe@perches.com>
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org
Date:   Mon, 19 Apr 2021 14:59:59 -0700
In-Reply-To: <alpine.LNX.2.20.13.2104192207130.19608@monopod.intra.ispras.ru>
References: <20210411211330.2252-1-amonakov@ispras.ru>
         <0362ad3912473d24e5927c0b54ed8fd3648c68a9.camel@perches.com>
         <alpine.LNX.2.20.13.2104192207130.19608@monopod.intra.ispras.ru>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.10
X-Rspamd-Server: rspamout02
X-Stat-Signature: rr8wy3tt7e6ewhrtb5agpwuwwj5up86q
X-Rspamd-Queue-Id: 49D5A315D7B
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18mE84hj7FKvZFlpJsPAFtqDoE9xBfErBo=
X-HE-Tag: 1618869600-770237
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-04-19 at 22:23 +0300, Alexander Monakov wrote:
> On Sun, 11 Apr 2021, Joe Perches wrote:
> 
> > > v2: avoid pr_info(""), change pci_info() to pr_info() for a nicer
> > > solution
> > > 
> > >  drivers/iommu/amd/init.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> > > index 596d0c413473..62913f82a21f 100644
> > > --- a/drivers/iommu/amd/init.c
> > > +++ b/drivers/iommu/amd/init.c
> > > @@ -1929,8 +1929,8 @@ static void print_iommu_info(void)
> > >  		pci_info(pdev, "Found IOMMU cap 0x%hx\n", iommu->cap_ptr);
> > >  
> > > 
> > >  		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
> > > -			pci_info(pdev, "Extended features (%#llx):",
> > > -				 iommu->features);
> > > +			pr_info("Extended features (%#llx):", iommu->features);
> > > +
> > >  			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
> > >  				if (iommu_feature(iommu, (1ULL << i)))
> > >  					pr_cont(" %s", feat_str[i]);
> > 
> > How about avoiding all of this by using a temporary buffer
> > and a single pci_info.
> 
> I think it is mostly up to the maintainers, but from my perspective, it's not
> good to conflate such a simple bugfix with the substantial rewrite you are
> proposing (which also increases code complexity).

You and I have _significant_ differences in the definition of substantial.

Buffering the output is the preferred code style in preference to
pr_cont.

Do remember pr_cont should _only_ be used when absolutely necessary
as interleaving of other messages from other processes/threads can
and does occur.



