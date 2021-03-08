Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2C23308A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 08:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhCHHJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 02:09:22 -0500
Received: from verein.lst.de ([213.95.11.211]:54397 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhCHHJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 02:09:18 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D9B6A68B02; Mon,  8 Mar 2021 08:09:15 +0100 (CET)
Date:   Mon, 8 Mar 2021 08:09:15 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "hch@lst.de" <hch@lst.de>, lkp <lkp@intel.com>,
        "hare@suse.de" <hare@suse.de>,
        "olkuroch@cisco.com" <olkuroch@cisco.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [block]  52f019d43c: ndctl.test-libndctl.fail
Message-ID: <20210308070915.GA32695@lst.de>
References: <20210305055900.GC31481@xsang-OptiPlex-9020> <20210305074204.GA17414@lst.de> <6f40b1f53c029788e20fe175618d8772e36d648c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f40b1f53c029788e20fe175618d8772e36d648c.camel@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2021 at 08:33:04PM +0000, Williams, Dan J wrote:
> Yes, it looks like my unit test checks for exactly the behavior you
> changed. It was convenient to test that the device could be switched
> back to rw via BLKROSET, but I don't require that. The new behaviour of
> letting the disk->ro take precedence makes more sense to me, so I'll
> update the test for the new behaviour.
> 
> I.e. I don't think regressing a unit test counts as a userspace
> regression.

Ok, thanks for the confirmation.
