Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2596371883
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhECPyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:54:43 -0400
Received: from verein.lst.de ([213.95.11.211]:35575 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230501AbhECPym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:54:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9D5AA68BEB; Mon,  3 May 2021 17:53:45 +0200 (CEST)
Date:   Mon, 3 May 2021 17:53:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-multipath: Reset bi_disk to ns head when failover
Message-ID: <20210503155345.GA5342@lst.de>
References: <20210503125741.68117-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503125741.68117-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 02:57:41PM +0200, Daniel Wagner wrote:
> The path can be stale when we failover. If we don't reset the bdev to
> the ns head and the I/O finally completes in end_io() it will triggers
> a crash. By resetting the to ns head disk so that the submit path can
> map the request to an active path.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> The patch is against nvme-5.13.

There is no bi_disk in nvme-5.13, but fortunately that slipped in only
in the subject.

> +	bdev = bdget_disk(ns->head->disk, 0);

Please just use ns->head->disk->part0 directly.  No need for the
reference and bdget_disk is about to go away.
