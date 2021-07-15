Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CA03CA37B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhGORDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:03:12 -0400
Received: from verein.lst.de ([213.95.11.211]:39282 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhGORDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:03:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D5DD667373; Thu, 15 Jul 2021 19:00:11 +0200 (CEST)
Date:   Thu, 15 Jul 2021 19:00:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Roman Skakun <rm.skakun@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Roman Skakun <roman_skakun@epam.com>,
        Andrii Anisov <andrii_anisov@epam.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] dma-mapping: use vmalloc_to_page for vmalloc
 addresses
Message-ID: <20210715170011.GA17324@lst.de>
References: <20210616154436.GA7619@lst.de> <20210622133414.132754-1-rm.skakun@gmail.com> <YO4si0to/XYximwM@fedora> <CADu_u-OMx6Pj4DQDoOsdh6aNAzYys-+R=o+OzHYtLm=nECgkyQ@mail.gmail.com> <fb262a14-a69c-030b-1f39-d924553ddbd2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb262a14-a69c-030b-1f39-d924553ddbd2@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 12:58:53PM -0400, Boris Ostrovsky wrote:
> 
> On 7/15/21 3:39 AM, Roman Skakun wrote:
> >> This looks like it wasn't picked up? Should it go in rc1?
> > Hi, Konrad!
> >
> > This looks like an unambiguous bug, and should be in rc1.
> 
> 
> Looks like you didn't copy Christoph which could be part of the problem. Adding him.

Can someone just send a clean patch that I can review and hopefully
apply?
