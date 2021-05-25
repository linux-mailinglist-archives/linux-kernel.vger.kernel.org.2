Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4808038FB91
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhEYHYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:24:11 -0400
Received: from verein.lst.de ([213.95.11.211]:57903 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhEYHYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:24:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 50A2467357; Tue, 25 May 2021 09:22:35 +0200 (CEST)
Date:   Tue, 25 May 2021 09:22:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme: Use NN for max_namespaces if MNAN is zero
Message-ID: <20210525072234.GA13966@lst.de>
References: <20210521144734.90044-1-dwagner@suse.de> <20210521145306.ld7jc6alchimyzny@beryllium.lan> <20210521152702.GB29013@redsun51.ssa.fujisawa.hgst.com> <f89bf79e-937c-96ba-4622-4a29fce00b0e@grimberg.me> <20210524073703.GA24372@lst.de> <20210525071259.j5g7koxqad7hwpkp@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525071259.j5g7koxqad7hwpkp@beryllium.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 09:12:59AM +0200, Daniel Wagner wrote:
> On Mon, May 24, 2021 at 09:37:03AM +0200, Christoph Hellwig wrote:
> > I think we should add a sanity check for that and reject the broken
> > controller if that is not the case rather than working around it.
> 
> Alright. I understood from the spec, that in the non ANA case the NN
> field should still be case though?

For non-ANA MNAN doesn't have to be set indeed.  But we also don't use
the value at all either.
