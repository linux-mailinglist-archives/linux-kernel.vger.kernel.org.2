Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088B644A822
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 09:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243922AbhKIIJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 03:09:23 -0500
Received: from verein.lst.de ([213.95.11.211]:48976 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243915AbhKIIJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:09:22 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6199A67373; Tue,  9 Nov 2021 09:06:34 +0100 (CET)
Date:   Tue, 9 Nov 2021 09:06:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] nvme: add NO APST quirk for Kioxia device
Message-ID: <20211109080634.GA28581@lst.de>
References: <20211106020858.18625-1-ematsumiya@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106020858.18625-1-ematsumiya@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 11:08:57PM -0300, Enzo Matsumiya wrote:
> +	},
> +	{
> +		/*
> +		 * This Kioxia device times out and aborts I/O during any load,
> +		 * but more easily reproducible with discards (fstrim).
> +		 *
> +		 * Device is left in a state that is also not possible to use "nvme set-feature"
> +		 * to disable APST, but booting with nvme_core.default_ps_max_latency=0 works.
> +		 */

Overly long lines here, but I can fix that up.  Do you have a product
name for this device or is just a nameless OEM controller?
