Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A7438C996
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhEUO6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232049AbhEUO6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:58:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D72E61132;
        Fri, 21 May 2021 14:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621609032;
        bh=MP1ZWuiaGoZ6dn6NU3Rv291MI0WIXC7H9aXQHHf6/j0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MMbiAUaYAMvpZvTIGYWnNNvtge5HeGr2VS1AIckz/r7vvrkPHJT/mIHkFfOKtLng3
         0tKYmv6xlIphR5s6X8FefMi5mZWW7k4n8qBcSIM0fZIFhglaXLlLsXR+kk2twcK70M
         //2PYihECgWvKpRvm4QsAtyWO+CZBX+GC1WL4oXWfUg6drQ7bKXg2S/nNZfhPU5mKm
         fPWYDAnQIzc2UT8BmWpGX56v04h4bdBka1edtXN3qu3l64vEWotOAtgUNdhAzLxywF
         PIAmb55bt0nZFqVz1FzggqLOykpojhKOH8/Z98iLJvTt5FCcQhVSqQPVHBTl+Tpt1Y
         6FA7Uet+LqBVw==
Date:   Fri, 21 May 2021 23:57:05 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>
Subject: Re: [BISECTED] nvme probe failure with v5.13-rc1
Message-ID: <20210521145705.GA29013@redsun51.ssa.fujisawa.hgst.com>
References: <40071b11108987556d0473f9d968fe7dcd3f304a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40071b11108987556d0473f9d968fe7dcd3f304a.camel@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 05:00:29AM +0000, Verma, Vishal L wrote:
> Hi,
> 
> I ran into this failure to probe an nvme device in an emulator
> (simics). It looks like there is a ~60 second wait followed by a
> timeout and a failure to boot (the root device is an nvme disk) with
> these messages in the log:
> 
>    [   67.174010] nvme nvme0: I/O 5 QID 0 timeout, disable controller
>    [   67.175793] nvme nvme0: Removing after probe failure status: -4
> 
> I bisected this to:
>    5befc7c26e5a ("nvme: implement non-mdts command limits") 
> 
> It's not immediately obvious to me what's causing the problem.
> Reverting the above commit fixes it. It is easily reproducible - I'd be
> happy to provide more info about the emulated device or test out
> patches or theories.
> 
> It is of course possible that the emulated device is behaving in some
> non spec-compliant way, in which case I'd appreciate any help figuring
> out what that is.

Hi Vishal,

The patch you bisected to sends only a single Identify command, so it
sounds like that must be the command that times out. The controller is
not required to support this specific identify (CNS 0x6), but it is
required to produce a response. If the identify is unsupported, the
controller should respond with an appropriate error (Invalid Field In
Command), but it looks like the controller didn't respond at all.

So based on your observation, it sounds like the simics implementation
has an identify bug. The spec doesn't provide a way for the driver to
know ahead of time whether or not this identification is supported, so
the driver just has to try it and react to the status code. If the
implmenetation can't be fixed, then we'll need to quirk your device.

If you want to confirm for certain that the new identify is the source
of your timeout, you could try the following patch and the timeout
should go away:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a73eed61eee..b16d31d82606 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2711,7 +2711,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	else
 		ctrl->max_zeroes_sectors = 0;

-	if (nvme_ctrl_limited_cns(ctrl))
+	if (true || nvme_ctrl_limited_cns(ctrl))
 		return 0;

 	id = kzalloc(sizeof(*id), GFP_KERNEL);
--
