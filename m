Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC824549A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhKQPQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:16:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229737AbhKQPQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:16:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 233D661163;
        Wed, 17 Nov 2021 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637161988;
        bh=DvXatyZHrb0FYnhjvsCH/8WiGYvI6m1CcesplqQ2oyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ARbq7GtW/CorK3i4D4T+9BcFpeElxv2tkIJRDHx+qEQMYqXWEOD/1HR/5E5LlLpUR
         U2HJNWhBg496rNlhuS+XG03wIFOrgZAioKVwOeNzTJWfkxmc4OBLdVD17YVyNLALLG
         vpbt8wOAq1dqpL4C9dVP3sD++grmoZlRIUT5RAfc=
Date:   Wed, 17 Nov 2021 16:13:05 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Abhyuday Godhasara <agodhasa@xilinx.com>
Cc:     Michal Simek <michals@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        Manish Narani <MNARANI@xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 0/6] Add Xilinx Event Management Driver
Message-ID: <YZUcAch7lVZ32/+t@kroah.com>
References: <20211025082350.10881-1-abhyuday.godhasara@xilinx.com>
 <20211026042525.26612-1-abhyuday.godhasara@xilinx.com>
 <SA1PR02MB8592C7C312EA93D3B9467872A1999@SA1PR02MB8592.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR02MB8592C7C312EA93D3B9467872A1999@SA1PR02MB8592.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 04:43:51AM +0000, Abhyuday Godhasara wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> > Sent: Tuesday, October 26, 2021 9:55 AM
> > To: gregkh@linuxfoundation.org
> > Cc: Michal Simek <michals@xilinx.com>; Abhyuday Godhasara
> > <agodhasa@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; Manish Narani
> > <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna Potthuri
> > <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>; Jiaying Liang
> > <jliang@xilinx.com>; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org
> > Subject: [PATCH v7 0/6] Add Xilinx Event Management Driver
> > 
> > This Linux driver provides support to subscribe error/event notification and
> > receive notification from firmware for error/event and forward event
> > notification to subscribed driver via registered callback.
> > 
> > All types of events like power and error will be handled from single place as
> > part of event management driver.
> > 
> > Changes in v7:
> > - Update the cover letter and version history.
> > 
> > Changes in v6:
> > - Fix compilation issue that come due to force merge during rebase.
> > 
> > Changes in v5:
> > - None.
> > 
> > Changes in v4:
> > - Rebase on latest tree.
> > 
> > Changes in v3:
> > - Update the commit message.
> > 
> > Changes in v2:
> > - Removed updated copyright year from unchanged files.
> > - make sgi_num as module parameter for event management driver.
> > - Use same object for error detection and printing.
> > 
> > Acked-by: Michal Simek <michal.simek@xilinx.com>
> [Abhyuday] Michal suggested to merge this via your tree, Please can you merge it.

Patch 4 of this series fails to apply to 5.16-rc1, so I have taken the
first 3.  Can you rebase and resend the remaining 2?

thanks,

greg k-h
