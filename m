Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8EC45750F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 18:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhKSROC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:14:02 -0500
Received: from verein.lst.de ([213.95.11.211]:51884 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhKSROB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:14:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 51E7268AFE; Fri, 19 Nov 2021 18:10:56 +0100 (CET)
Date:   Fri, 19 Nov 2021 18:10:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Klaus Jensen <its@irrelevant.dk>
Cc:     linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v2] nvme: fix write zeroes pi
Message-ID: <20211119171056.GA15601@lst.de>
References: <20211110091906.20958-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110091906.20958-1-its@irrelevant.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.16.
