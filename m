Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EE731C791
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 09:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBPIrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 03:47:06 -0500
Received: from verein.lst.de ([213.95.11.211]:40362 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhBPIpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 03:45:12 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E238C6736F; Tue, 16 Feb 2021 09:44:30 +0100 (CET)
Date:   Tue, 16 Feb 2021 09:44:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH 0/2] block: avoid to drop & re-add partitions if
 partitions aren't changed
Message-ID: <20210216084430.GA23694@lst.de>
References: <20210205021708.1498711-1-ming.lei@redhat.com> <20210215040341.GA257964@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215040341.GA257964@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 12:03:41PM +0800, Ming Lei wrote:
> Hello,

I think this is a fundamentally bad idea.  We should not keep the
parsed partition state around forever just to work around some buggy
user space software.
