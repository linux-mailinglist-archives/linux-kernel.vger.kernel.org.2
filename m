Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCD131A691
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBLVKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:10:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229796AbhBLVKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:10:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03AC2601FF;
        Fri, 12 Feb 2021 21:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613164175;
        bh=N7rA3qpnhmgAC9fBXPMGsTbgAXD+uXqgcADbmEmU+fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X9TCwDkmT1MOrBScgC8MjYopMkdsdvRZ8MlKH6FOphxn3fLA0gK/4nMeEbll+VE2V
         kIdooVHtYQQ+K+WKVb1bU8Ek7e3QjQH/m/kg0a4bfFnCxhKo+6W93WhE7BSgX/GweI
         hCRKk1iZXrLDEBvSO/bYdIP1Ehgs3cFHicqbp69QRN3H5aRLBUgoKvkljVdloURUHy
         TBoARgrNRtQQxgOcaQCyjQyMPAkvnReTX+9gyR2ezwrLr+1D+otTnRnezVBCPs5dxF
         sf3Iak7D8+D5nNvFwZnl8IuNGxcvK9dG6f1ACO3Sqqudq1BXIPPdNBsZ0scqdwImqd
         q1qZrcKf68Qow==
Date:   Sat, 13 Feb 2021 06:09:29 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
Message-ID: <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
References: <20210212181738.79274-1-dwagner@suse.de>
 <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 12:58:27PM -0800, Sagi Grimberg wrote:
> > blk_mq_tag_to_rq() will always return a request if the command_id is
> > in the valid range. Check if the request has been started. If we
> > blindly process the request we might double complete a request which
> > can be fatal.
> 
> How did you get to this one? did the controller send a completion for
> a completed/bogus request?

If that is the case, then that must mean it's possible the driver could
have started the command id just before the bogus completion check. Data
iorruption, right?
