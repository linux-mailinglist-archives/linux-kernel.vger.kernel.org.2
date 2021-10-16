Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F9B430043
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 06:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240586AbhJPEls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 00:41:48 -0400
Received: from verein.lst.de ([213.95.11.211]:56733 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239415AbhJPElr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 00:41:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1695D68BEB; Sat, 16 Oct 2021 06:39:37 +0200 (CEST)
Date:   Sat, 16 Oct 2021 06:39:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, geoff@infradead.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, jim@jtan.com,
        minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
        nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] nvme-multipath: add error handling support for
 add_disk()
Message-ID: <20211016043936.GB27339@lst.de>
References: <20211015235219.2191207-1-mcgrof@kernel.org> <20211015235219.2191207-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015235219.2191207-3-mcgrof@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.16.
