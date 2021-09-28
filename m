Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C81541A714
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 07:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbhI1F2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 01:28:07 -0400
Received: from verein.lst.de ([213.95.11.211]:50083 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234177AbhI1F2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 01:28:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 500E267373; Tue, 28 Sep 2021 07:26:24 +0200 (CEST)
Date:   Tue, 28 Sep 2021 07:26:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 5/7] genirq/affinity: move group_cpus_evenly() into
 lib/
Message-ID: <20210928052624.GA29020@lst.de>
References: <20210928005558.243352-1-ming.lei@redhat.com> <20210928005558.243352-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928005558.243352-6-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 08:55:56AM +0800, Ming Lei wrote:
> group_cpus_evenly() has become one generic helper which can be used for
> other subsystems, so move it into lib/.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
