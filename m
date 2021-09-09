Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AB64059AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbhIIOvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:51:41 -0400
Received: from verein.lst.de ([213.95.11.211]:44669 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232566AbhIIOvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:51:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8523F67373; Thu,  9 Sep 2021 16:50:27 +0200 (CEST)
Date:   Thu, 9 Sep 2021 16:50:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix missing error code in
 nvme_configure_directives()
Message-ID: <20210909145027.GA32109@lst.de>
References: <1631181021-108687-1-git-send-email-jiapeng.chong@linux.alibaba.com> <20210909144739.GA2464330@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909144739.GA2464330@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 07:47:39AM -0700, Keith Busch wrote:
> On Thu, Sep 09, 2021 at 05:50:21PM +0800, Jiapeng Chong wrote:
> > From: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> > 
> > The error code is missing in this code scenario, add the error code
> > '-EINVAL' to the return value 'ret'.
> > 
> > Eliminate the follow smatch warning:
> > 
> > drivers/nvme/host/core.c:786 nvme_configure_directives() warn: missing
> > error code 'ret'.
> 
> Nak, the code is correct as-is. Returning a negative error for this
> harmless condition will result in disabling the controller when we can
> proceed just fine without directives.

Oh, indeed.  We should probably throw a comment in to make this more
clear.
