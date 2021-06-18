Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C86D3ACD5F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhFROUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:20:31 -0400
Received: from verein.lst.de ([213.95.11.211]:35116 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232052AbhFROU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:20:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 92AA668D08; Fri, 18 Jun 2021 16:18:17 +0200 (CEST)
Date:   Fri, 18 Jun 2021 16:18:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     zhouchuangao <zhouchuangao@vivo.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/nvme/host: Use kobj_to_dev() API
Message-ID: <20210618141817.GA18781@lst.de>
References: <1624025458-56465-1-git-send-email-zhouchuangao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624025458-56465-1-git-send-email-zhouchuangao@vivo.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 07:10:58AM -0700, zhouchuangao wrote:
> Use kobj_to_dev() API instead of container_of().

Why?  That just makes the code harder to read.
