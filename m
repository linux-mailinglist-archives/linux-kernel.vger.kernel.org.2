Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18BE3BC3F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 00:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhGEWvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 18:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhGEWvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 18:51:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECCBB6186A;
        Mon,  5 Jul 2021 22:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625525349;
        bh=mkfPMjkHVZE0n14BdJf3P80AOd+hrM+UUpZI+nANjwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lw3wt+d7NhPeCSzYclWsItQ6S7mi3EaCuEacBxCewmMfWc7MsoTUbQXJudjA8tVDb
         GtzHGzyFiUgTUq7MqJjYbWYPgL66aDXAtCgQLpX4EdU/JuwghySeMQyG2baEHOPrWz
         ncj7fvfhl5mBd/DDMDdhbbw0K54qHEY+1VbFmojQpnJriIQl8NTBVM4qJqxca+TJg6
         NXTqorK8W6ICOZQdbDjXGiZajpy2XH8jEy5qnF32se9Y9HnlZFJaD0R7ZuTQLctK3y
         55l0Ts5j+/Z5uiobJvrHZ821RCEacu+xBLHRcgnGcoIov8W70hTFy2AKhubt3fDNHV
         FESEO8VY3n09w==
Date:   Tue, 6 Jul 2021 06:48:39 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] erofs: directly traverse pages in
 z_erofs_readahead()
Message-ID: <20210705224822.GA17518@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
References: <20210705183253.14833-1-xiang@kernel.org>
 <20210705183253.14833-2-xiang@kernel.org>
 <YONoXm1ksYgWWi/r@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YONoXm1ksYgWWi/r@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Mon, Jul 05, 2021 at 09:15:26PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 06, 2021 at 02:32:53AM +0800, Gao Xiang wrote:
> > In that way, pages can be accessed directly with xarray.
> 
> I didn't mean "open code readahead_page()".  I meant "Wouldn't it be
> great if z_erofs_do_read_page() used readahead_expand() in order to
> allocate the extra pages in the extents that cover the start and end of
> the requested chunk".  That way the pages would already be in the page
> cache for subsequent reads.

Yes, I understand that idea. readahead_expand() can be used to
cache the whole requested decompressed chunk. Currently, EROFS tends
to cache compressed data for incomplete requested chunks instead in the
managed inode if cache mode is enabled since LZ4 compressed data is
more effective for caching to save I/O than uncompressed data
(considering LZ4 decompression speed, which is somewhat like zcache.)

For now, EROFS LZMA support is also on the way (but recently I
have to work on the DAX support in advance.) LZMA is somewhat slow
algorithm but with much better compression ratio. I think it should
decompress all requested chunks to save the overall decompression
time. So readahead_expand() is quite useful with EROFS LZMA cases,
I will investigate it for LZMA-specific cases...

BTW, from the patch [2/2] itself, it there some chance to extend
readahead_page() or some new API like this? So the original dance
can be avoided.

Some comments for the iteration behavior itself is always useful,
anyway...

Thanks,
Gao Xiang

> 
