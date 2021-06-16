Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5787B3A9D74
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhFPOX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:23:58 -0400
Received: from verein.lst.de ([213.95.11.211]:54649 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232694AbhFPOX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:23:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E68C468BEB; Wed, 16 Jun 2021 16:21:48 +0200 (CEST)
Date:   Wed, 16 Jun 2021 16:21:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Roman Skakun <rm.skakun@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Roman Skakun <roman_skakun@epam.com>,
        Andrii Anisov <andrii_anisov@epam.com>
Subject: Re: [PATCH 2/2] swiotlb-xen: override common mmap and get_sgtable
 dma ops
Message-ID: <20210616142148.GA764@lst.de>
References: <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com> <20210616114205.38902-1-roman_skakun@epam.com> <20210616114205.38902-2-roman_skakun@epam.com> <2834cdc0-534c-4f07-1901-e468a7713c1f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2834cdc0-534c-4f07-1901-e468a7713c1f@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 10:12:55AM -0400, Boris Ostrovsky wrote:
> I wonder now whether we could avoid code duplication between here and dma_common_mmap()/dma_common_get_sgtable() and use your helper there.
> 
> 
> Christoph, would that work?  I.e. something like

You should not duplicate the code at all, and just make the common
helpers work with vmalloc addresses.
