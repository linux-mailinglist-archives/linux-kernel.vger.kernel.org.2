Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A4F42FF52
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 02:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbhJPADa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 20:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235896AbhJPAD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 20:03:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18BA3611C3;
        Sat, 16 Oct 2021 00:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634342482;
        bh=zERYufNJ1MZk5CclnMi+gL/h2WeGYYoy9Om0aXiHGLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lAd5BhR7dX0bhUFdgALWUXGCQ+v5W0tvJIwfUWbRKvGKqR2h6V0I6ukKcRF5Dj+Nw
         0dFWCYUmBg7S2Rodk9yCf0H1+kehM9Vr5MyDW3E957s4BJA3cyS4uAhz4e17bCP29s
         II0rzTuzcoBkDSvXr4ZGRWsUKw8yktjg7TyZT5pwSjCguTcC1658+kFky8M1STBicA
         7fLq43tAQkTcs+sDRgIw1Gv5v7j5U3hjGyPw8mDDVxsn00Q51dQWLT/IESbUsSNm65
         nxOHSWjB0mZ+Ve03BmVAuGYwTgnYAMB4qLl+33yxh5AlIshuEdLL26zAeBOF+sdd/j
         wOOh/LnbCmJTQ==
Date:   Fri, 15 Oct 2021 18:01:18 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, geoff@infradead.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, jim@jtan.com,
        minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, hch@lst.de,
        sagi@grimberg.me, linux-block@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
        nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] nvme-multipath: add error handling support for
 add_disk()
Message-ID: <20211016000118.GA50317@C02WT3WMHTD6>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
 <20211015235219.2191207-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015235219.2191207-3-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 04:52:08PM -0700, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> Since we now can tell for sure when a disk was added, move
> setting the bit NVME_NSHEAD_DISK_LIVE only when we did
> add the disk successfully.
> 
> Nothing to do here as the cleanup is done elsewhere. We take
> care and use test_and_set_bit() because it is protects against
> two nvme paths simultaneously calling device_add_disk() on the
> same namespace head.

Looks good, thank you.

Reviewed-by: Keith Busch <kbusch@kernel.org>
