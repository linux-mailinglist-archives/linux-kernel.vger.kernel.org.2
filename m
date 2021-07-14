Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC14C3C7DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 07:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbhGNFbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 01:31:35 -0400
Received: from verein.lst.de ([213.95.11.211]:60959 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237802AbhGNFbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 01:31:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A429C67373; Wed, 14 Jul 2021 07:28:41 +0200 (CEST)
Date:   Wed, 14 Jul 2021 07:28:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Ira Weiny <ira.weiny@intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: call flush_dcache_page in memcpy_to_page and
 memzero_page
Message-ID: <20210714052841.GA6380@lst.de>
References: <20210713055231.137602-1-hch@lst.de> <20210713055231.137602-2-hch@lst.de> <20210713183123.699769a1b0ee95d69606c35d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210713183123.699769a1b0ee95d69606c35d@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 06:31:23PM -0700, Andrew Morton wrote:
> On Tue, 13 Jul 2021 07:52:30 +0200 Christoph Hellwig <hch@lst.de> wrote:
> 
> > memcpy_to_page and memzero_page can write to arbitrary pages, which could
> > be in the page cache or in high memory, so  call flush_kernel_dcache_pages
> > to flush the dcache.
> 
> I assume this presently is not known to cause any problems, but that
> some problems might be discovered in the future?  In which case,
> should we cc:stable?

This is a problem when using these helpers on dcache challeneged
architectures.  Right now there are just a few users, chances
are no one used the PC floppy drіver, the aha1542 driver for an ISA
SCSI HBA, and a few advanced and optional btrfs and ext4 features
on those platforms yet since the conversion.  So yes, stable would be
good.
