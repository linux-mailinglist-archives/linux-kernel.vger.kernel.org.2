Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD05459C92
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 08:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhKWHJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 02:09:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:58572 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhKWHJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 02:09:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="235201962"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="235201962"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 23:06:15 -0800
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="456954692"
Received: from rli9-dbox.sh.intel.com (HELO rli9-dbox) ([10.239.159.142])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 23:06:12 -0800
Date:   Tue, 23 Nov 2021 15:07:14 +0800
From:   Philip Li <philip.li@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [kbuild-all] Re: [axboe-block:for-5.17/block 3/11] htmldocs:
 Error: Cannot open file block/blk-exec.c
Message-ID: <YZyTIigqYZZhs9vC@rli9-dbox>
References: <202111221827.02uE91s3-lkp@intel.com>
 <20211123065822.GA14390@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123065822.GA14390@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 07:58:22AM +0100, Christoph Hellwig wrote:
> I can't really find any remaining reference to blk-exec in the
> for-5.17/block tree, any idea where this error comes from?
sorry kindly ignore the report, which is a false report with
wrong info. We will resolve this in earliest time.

> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
