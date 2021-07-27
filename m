Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5113D71A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 10:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbhG0Izy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 04:55:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47924 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbhG0Izx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 04:55:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9337A1FEF6;
        Tue, 27 Jul 2021 08:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627376152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bsJobYnRInJWfI/LeGckiv1Og2fH6SvoRl5XGZ6UtiM=;
        b=p/oaWZXJTCNW+88LZQ64Co5io4AyJ2qgyGdvYjp5rvT/m+IANE7tbumdnld8RIzSqTJ+rN
        BYfX9Vpdgi9m2Ix1ciThyd1xejFWqZJcWS4QKx9f35fPllm3WpBtHnM4+29OOnROYJ0e0A
        f45r1wWdUrZrUE8AXweGuU1SDSREhYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627376152;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bsJobYnRInJWfI/LeGckiv1Og2fH6SvoRl5XGZ6UtiM=;
        b=GWqO33U/NUqtKypIfRwz0q96MwqF6Zu2/Mlbd7E6l9mUs4IQ1ov5jAxKcKZhLEE1quGcDP
        4SnG0i7NI6lz9RAg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 5ED5FA3B88;
        Tue, 27 Jul 2021 08:55:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 763351E0BFA; Tue, 27 Jul 2021 10:55:51 +0200 (CEST)
Date:   Tue, 27 Jul 2021 10:55:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [ext3:generic_block_fiemap_removal 3/4] file.c:undefined
 reference to `iomap_fiemap'
Message-ID: <20210727085551.GA29619@quack2.suse.cz>
References: <202107271057.xwwoSXFy-lkp@intel.com>
 <YP+umZ1/XX969ioH@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP+umZ1/XX969ioH@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-07-21 07:58:33, Christoph Hellwig wrote:
> Oops, hpfs now needs to select FS_IOMAP:

And I assume ext2 as well, right? So far ext2 needed iomap only for DAX
which selects FS_IOMAP itself. But now ext2 needs iomap also without DAX...

								Honza

> diff --git a/fs/hpfs/Kconfig b/fs/hpfs/Kconfig
> index 2b36dc6f0a10..ec975f466877 100644
> --- a/fs/hpfs/Kconfig
> +++ b/fs/hpfs/Kconfig
> @@ -2,6 +2,7 @@
>  config HPFS_FS
>  	tristate "OS/2 HPFS file system support"
>  	depends on BLOCK
> +	select FS_IOMAP
>  	help
>  	  OS/2 is IBM's operating system for PC's, the same as Warp, and HPFS
>  	  is the file system used for organizing files on OS/2 hard disk
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
