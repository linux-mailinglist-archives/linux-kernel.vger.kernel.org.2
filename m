Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B953D71B2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 11:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbhG0JHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 05:07:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53246 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbhG0JH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 05:07:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EA62C22122;
        Tue, 27 Jul 2021 09:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627376847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4kqsL/kMeCIBqvFqX/xS0XG6JPdBYVK0X4R2ZoBBdtg=;
        b=HCl2FvwqebD17IhenE+bTNGLM60EYhXC946mn9mDUT+fUoOfJzJ4KJrhG4FS8JqXfW+4f+
        POCb77KlHUooGJ7gMmk0dh91LMRdsklrqGozFPy6dW8O1MXSX6H443zdFVKucZYF8nkoDA
        Oc1KoqHMWbG4xVVYfXszrdXPBshABAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627376847;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4kqsL/kMeCIBqvFqX/xS0XG6JPdBYVK0X4R2ZoBBdtg=;
        b=Lbz981pZmgRdLr2/Ht2oeGPLZaIjcUUj4OmrQQreXgkNv80mh6PbahkY4DwhnhhBbBN7XS
        A7q3MPhTfsusf6BA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id D684AA3B84;
        Tue, 27 Jul 2021 09:07:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EED141E0BFA; Tue, 27 Jul 2021 11:07:27 +0200 (CEST)
Date:   Tue, 27 Jul 2021 11:07:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [ext3:generic_block_fiemap_removal 3/4] file.c:undefined
 reference to `iomap_fiemap'
Message-ID: <20210727090727.GB29619@quack2.suse.cz>
References: <202107271057.xwwoSXFy-lkp@intel.com>
 <YP+umZ1/XX969ioH@infradead.org>
 <20210727085551.GA29619@quack2.suse.cz>
 <20210727085742.GA21354@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727085742.GA21354@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-07-21 10:57:42, Christoph Hellwig wrote:
> On Tue, Jul 27, 2021 at 10:55:51AM +0200, Jan Kara wrote:
> > On Tue 27-07-21 07:58:33, Christoph Hellwig wrote:
> > > Oops, hpfs now needs to select FS_IOMAP:
> > 
> > And I assume ext2 as well, right? So far ext2 needed iomap only for DAX
> > which selects FS_IOMAP itself. But now ext2 needs iomap also without DAX...
> 
> Indeed.

I've ammended the two commits and pushed the result out.
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
