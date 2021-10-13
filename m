Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995E242C0CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhJMNB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhJMNB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:01:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 332E9610F8;
        Wed, 13 Oct 2021 12:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634129963;
        bh=DSwksxV0xgz7+oM95h/ZvDDJETgO0fB0scyo72wBmac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IC1QJBKiMKcKxGG5xyKfYs1NrvuFsnCluGDk7m3h0W8/Ztuvpyutqe81xVr3CWFD0
         KN7wqjMnUIIb3s8HbkcPRH3aaekXoS1W9ZSxSmK+vbnx1y6EYIT2Kzxry5nTNbD4aD
         iTxoqJlibaTF3TpasgsffGOHSjlTBSzpUO76ApOA=
Date:   Wed, 13 Oct 2021 14:59:21 +0200
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
Message-ID: <YWbYKQXf8g8s55kG@kroah.com>
References: <438b398c-a901-7568-11e0-cd9bf302343f@xilinx.com>
 <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
 <SA1PR02MB8592838B99062EFA6EAAE73DA1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR02MB8592838B99062EFA6EAAE73DA1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 12:27:58PM +0000, Abhyuday Godhasara wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> > Sent: Wednesday, September 15, 2021 6:46 PM
> > To: gregkh@linuxfoundation.org
> > Cc: Michal Simek <michals@xilinx.com>; Abhyuday Godhasara
> > <agodhasa@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; Manish Narani
> > <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna Potthuri
> > <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>; Jiaying Liang
> > <jliang@xilinx.com>; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org
> > Subject: [PATCH v4 0/6] Add Xilinx Event Management Driver
> > 
> > This Linux driver provides support to subscribe error/event notification and
> > receive notification from firmware for error/event and forward event
> > notification to subscribed driver via registered callback.
> > 
> > All types of events like power and error will be handled from single place as
> > part of event management driver.
> > 
> > Changes in v4:
> > - Rebase on latest tree
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
> [Abhyuday] Michal suggested to merge this via your tree. Please have a look.
> Please let me know if there is anything required from my side.

Ok, I'll pick it up, thanks.

greg k-h
