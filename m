Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED813A944C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhFPHpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:45:20 -0400
Received: from verein.lst.de ([213.95.11.211]:53049 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231628AbhFPHpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:45:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 454156736F; Wed, 16 Jun 2021 09:43:11 +0200 (CEST)
Date:   Wed, 16 Jun 2021 09:43:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, slp@redhat.com,
        sgarzare@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] virtio_blk: blk-mq io_poll support
Message-ID: <20210616074310.GA2910@lst.de>
References: <20210520141305.355961-1-stefanha@redhat.com> <YLj1kUiTTlLm5HwU@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLj1kUiTTlLm5HwU@stefanha-x1.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 04:30:25PM +0100, Stefan Hajnoczi wrote:
> Christoph and Jens: Any more thoughts on this irq toggling approach?

I think it would eventually come back and byte us and would much prefer
explicit poll queues.
