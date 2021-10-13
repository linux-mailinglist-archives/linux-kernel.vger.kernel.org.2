Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C796642C275
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhJMOM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235564AbhJMOM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:12:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD755610A2;
        Wed, 13 Oct 2021 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634134254;
        bh=MCbUSpXLvBAnZfn8uK00pPLksVK7sxri5OuKDIq3xbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Io/RxVIRW+Um06HQJcY1eWk+WuM4gWpZ4+NCBWfidvCtVHSQP7shRXxRjN8CtzcLL
         u+Uzp8zgYQFKlPfdwZQQbIlVhT9XDkEH53bhB5iX10zQXg/dj5Pp9OQiEDvrbEZtnt
         VCTo5ebkguj78HU3+O+EVT/ZEBA3DFa/nk7/GMTM=
Date:   Wed, 13 Oct 2021 16:10:51 +0200
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
Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
Message-ID: <YWbo660XPKlwDZH0@kroah.com>
References: <438b398c-a901-7568-11e0-cd9bf302343f@xilinx.com>
 <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
 <SA1PR02MB8592838B99062EFA6EAAE73DA1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbYKQXf8g8s55kG@kroah.com>
 <YWbZoPHDzc4e5Nme@kroah.com>
 <SA1PR02MB8592E68D021E12DCA45B70A2A1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR02MB8592E68D021E12DCA45B70A2A1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 01:57:59PM +0000, Abhyuday Godhasara wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > Sent: Wednesday, October 13, 2021 6:36 PM
> > To: Abhyuday Godhasara <agodhasa@xilinx.com>
> > Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>;
> > Manish Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
> > Potthuri <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
> > 
> > On Wed, Oct 13, 2021 at 02:59:21PM +0200, gregkh@linuxfoundation.org
> > wrote:
> > > On Wed, Oct 13, 2021 at 12:27:58PM +0000, Abhyuday Godhasara wrote:
> > > > Hi Greg,
> > > >
> > > > > -----Original Message-----
> > > > > From: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> > > > > Sent: Wednesday, September 15, 2021 6:46 PM
> > > > > To: gregkh@linuxfoundation.org
> > > > > Cc: Michal Simek <michals@xilinx.com>; Abhyuday Godhasara
> > > > > <agodhasa@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; Manish
> > > > > Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
> > > > > Potthuri <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>;
> > > > > Jiaying Liang <jliang@xilinx.com>; linux-kernel@vger.kernel.org;
> > > > > linux-arm- kernel@lists.infradead.org
> > > > > Subject: [PATCH v4 0/6] Add Xilinx Event Management Driver
> > > > >
> > > > > This Linux driver provides support to subscribe error/event
> > > > > notification and receive notification from firmware for
> > > > > error/event and forward event notification to subscribed driver via
> > registered callback.
> > > > >
> > > > > All types of events like power and error will be handled from
> > > > > single place as part of event management driver.
> > > > >
> > > > > Changes in v4:
> > > > > - Rebase on latest tree
> > > > >
> > > > > Changes in v3:
> > > > > - Update the commit message.
> > > > >
> > > > > Changes in v2:
> > > > > - Removed updated copyright year from unchanged files.
> > > > > - make sgi_num as module parameter for event management driver.
> > > > > - Use same object for error detection and printing.
> > > > >
> > > > > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > > > [Abhyuday] Michal suggested to merge this via your tree. Please have a
> > look.
> > > > Please let me know if there is anything required from my side.
> > >
> > > Ok, I'll pick it up, thanks.
> > 
> > Nope, I can not as for some reason it all did not show up on lore.kernel.org.
> > 
> > Please resend this, with Michal's ack and I will be glad to pick it up.
> [Abhyuday] Sent v5 with Michal's ack.

Sent where?  Do you have a lore.kernel.org link?  Did you cc: me?

thanks,

greg k-h
