Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551453FD8D7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 13:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243840AbhIALfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 07:35:24 -0400
Received: from verein.lst.de ([213.95.11.211]:47242 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243805AbhIALfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 07:35:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D145F6736F; Wed,  1 Sep 2021 13:34:24 +0200 (CEST)
Date:   Wed, 1 Sep 2021 13:34:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [block]  52b85909f8: ndctl.test-libndctl.fail
Message-ID: <20210901113424.GA6637@lst.de>
References: <20210831145036.GA14661@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831145036.GA14661@xsang-OptiPlex-9020>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 10:50:36PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 52b85909f85d06efa69aaf4210e72467f1f58d2b ("block: fold register_disk into device_add_disk")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Can someone help to decode the output?  I'm a little lost in debug output
from libkmod but can't really find anything substancial that looks wrong.
