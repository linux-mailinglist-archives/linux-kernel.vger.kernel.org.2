Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE85B459C78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 07:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhKWHBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 02:01:36 -0500
Received: from verein.lst.de ([213.95.11.211]:60117 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232316AbhKWHBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 02:01:33 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C585368AFE; Tue, 23 Nov 2021 07:58:22 +0100 (CET)
Date:   Tue, 23 Nov 2021 07:58:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [axboe-block:for-5.17/block 3/11] htmldocs: Error: Cannot open
 file block/blk-exec.c
Message-ID: <20211123065822.GA14390@lst.de>
References: <202111221827.02uE91s3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111221827.02uE91s3-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can't really find any remaining reference to blk-exec in the
for-5.17/block tree, any idea where this error comes from?
