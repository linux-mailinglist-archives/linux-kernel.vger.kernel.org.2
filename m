Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9333D71A6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 10:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbhG0I5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 04:57:45 -0400
Received: from verein.lst.de ([213.95.11.211]:48952 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235885AbhG0I5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 04:57:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0DA8B68AFE; Tue, 27 Jul 2021 10:57:43 +0200 (CEST)
Date:   Tue, 27 Jul 2021 10:57:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [ext3:generic_block_fiemap_removal 3/4] file.c:undefined
 reference to `iomap_fiemap'
Message-ID: <20210727085742.GA21354@lst.de>
References: <202107271057.xwwoSXFy-lkp@intel.com> <YP+umZ1/XX969ioH@infradead.org> <20210727085551.GA29619@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727085551.GA29619@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 10:55:51AM +0200, Jan Kara wrote:
> On Tue 27-07-21 07:58:33, Christoph Hellwig wrote:
> > Oops, hpfs now needs to select FS_IOMAP:
> 
> And I assume ext2 as well, right? So far ext2 needed iomap only for DAX
> which selects FS_IOMAP itself. But now ext2 needs iomap also without DAX...

Indeed.
