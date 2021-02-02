Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C014930BB5F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhBBJub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:50:31 -0500
Received: from verein.lst.de ([213.95.11.211]:45208 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhBBJu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:50:28 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id ADE7A68C4E; Tue,  2 Feb 2021 10:49:46 +0100 (CET)
Date:   Tue, 2 Feb 2021 10:49:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Claus Stovgaard <claus.stovgaard@gmail.com>
Cc:     linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Mark Phison E16 (Corsair MP600) as
 IGNORE_DEV_SUBNQN
Message-ID: <20210202094945.GC18895@lst.de>
References: <20210201210822.6501-1-claus.stovgaard@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201210822.6501-1-claus.stovgaard@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.11.
