Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7073595C6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhDIGrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233335AbhDIGru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:47:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13105610CF;
        Fri,  9 Apr 2021 06:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617950858;
        bh=rSrNGxxYkNoifYjlH9dOruBnwxN9o3793XnSWs7r/v0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gwdz1GorxTe6LSDaLHoXzr4Q8RxAVqWFutm4Qtc5DCrGCaZgZ0WbF8UCzrwuMbpAW
         nV4+2b9dpoOt/pHpo2ZwCpkhgT9CRnOc+BJtEY2Jd4tOJQSKGWWXpf1UONF7GToI+n
         77iuhvK0wgBr2TjoLg/4uHG56CYmQFKLkpdZtEKc=
Date:   Fri, 9 Apr 2021 08:47:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     liulongfang <liulongfang@huawei.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, mathias.nyman@intel.com,
        liudongdong3@huawei.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kong.kongxinwei@hisilicon.com,
        yisen.zhuang@huawei.com
Subject: Re: [PATCH v2 0/2] USB:ehci:fix the no SRBN register problem
Message-ID: <YG/4iGJVGj/v+I5v@kroah.com>
References: <1617889760-17733-1-git-send-email-liulongfang@huawei.com>
 <20210408145332.GA1296449@rowland.harvard.edu>
 <f5eb92ab-9d28-d4a9-a3a0-6a759656ad37@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5eb92ab-9d28-d4a9-a3a0-6a759656ad37@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 10:42:35AM +0800, liulongfang wrote:
> On 2021/4/8 22:53, Alan Stern wrote:
> > On Thu, Apr 08, 2021 at 09:49:18PM +0800, Longfang Liu wrote:
> >> (1) Add a whitelist for EHCI devices without SBRN registers.
> >> (2) Add Kunpeng920's EHCI device to the whitelist.
> >>
> >> Changes in v2:
> >> 	- Fix some code style issues.
> >> 	- Update function name.
> >>
> >> Longfang Liu (2):
> >>   USB:ehci:Add a whitelist for EHCI controllers
> >>   USB:ehci:fix Kunpeng920 ehci hardware problem
> >>
> >>  drivers/usb/host/ehci-pci.c | 30 ++++++++++++++++++++++++++----
> >>  1 file changed, 26 insertions(+), 4 deletions(-)
> > 
> > I don't think we need a whole list, along with an associated lookup 
> > routine, when there are only two entries.  The total amount of code will 
> > be smaller if you just add a check for the Kunpeng920 controller to
> > the existing check for the STMICRO controller.
> > 
> > Alan Stern
> > .
> > 
> Now there are two EHCI controllers that do not have SBRN registers,
> and there may be more in the future. This list is added for subsequent
> compatibility if there are such controllers, instead of a series of if-else.

Why would more people create new EHCI controllers these days with the
cheapness of USB 3 cores?  Anyway, let us worry about that if this list
gets "too long", a simple if statement is fine for now.

thanks,

greg k-h
