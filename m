Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65BD41A719
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 07:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhI1F3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 01:29:03 -0400
Received: from verein.lst.de ([213.95.11.211]:50089 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235246AbhI1F3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 01:29:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ACBFA67373; Tue, 28 Sep 2021 07:27:21 +0200 (CEST)
Date:   Tue, 28 Sep 2021 07:27:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 6/7] lib/group_cpus: allow to group cpus in case of
 !CONFIG_SMP
Message-ID: <20210928052721.GB29020@lst.de>
References: <20210928005558.243352-1-ming.lei@redhat.com> <20210928005558.243352-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928005558.243352-7-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 08:55:57AM +0800, Ming Lei wrote:
> Allows group_cpus_evenly() to be called in case of !CONFIG_SMP by simply
> assigning all CPUs into the 1st group.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I would hav folded this into the previous patch, but otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>
