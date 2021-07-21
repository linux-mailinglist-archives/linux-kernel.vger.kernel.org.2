Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98483D0BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 12:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbhGUI7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 04:59:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237276AbhGUIwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 04:52:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94CFD61181;
        Wed, 21 Jul 2021 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626859987;
        bh=Ugfx0SLzjHVJOXOYrQ6di8BvRX/xV7sv48IdSOw9ZyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dRBpow7Zp5CnRW8JDVuBsfZ/qRKkDPziZDOOFaq+2VQzvemV+PiuxGEyFbSVnwT7H
         UYPymfrdxJzK/rPY0jkVVYp0BRTKy/yOXARUiOLH7jEBOAne59Wrg49pvo369+L2Y5
         0fAj94XKe1pY5nok/O0HfPiozcVoTwVblgrZZMn0=
Date:   Wed, 21 Jul 2021 11:33:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jorgen Hansen <jhansen@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH] MAINTAINERS: Update for VMCI driver
Message-ID: <YPfp0Ff6KuyPlyrc@kroah.com>
References: <1626776941-9163-1-git-send-email-jhansen@vmware.com>
 <YPan14jucU9/u6JL@kroah.com>
 <0C3493F7-AF29-417B-94EA-26871283E65A@vmware.com>
 <YPfiNuKonyTIKcDL@kroah.com>
 <6344A6B0-F7B7-450C-9BDF-AF9056D211F3@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6344A6B0-F7B7-450C-9BDF-AF9056D211F3@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 09:26:15AM +0000, Jorgen Hansen wrote:
> 
> 
> > On 21 Jul 2021, at 11:00, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Wed, Jul 21, 2021 at 08:46:15AM +0000, Jorgen Hansen wrote:
> >> 
> >> 
> >>> On 20 Jul 2021, at 12:39, Greg KH <gregkh@linuxfoundation.org> wrote:
> >>> 
> >>> On Tue, Jul 20, 2021 at 03:29:01AM -0700, Jorgen Hansen wrote:
> >>>> Add maintainer info for the VMware VMCI driver.
> >>>> 
> >>>> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> >>>> ---
> >>>> MAINTAINERS | 8 ++++++++
> >>>> 1 file changed, 8 insertions(+)
> >>>> 
> >>>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>>> index a61f4f3..7e7c6fa 100644
> >>>> --- a/MAINTAINERS
> >>>> +++ b/MAINTAINERS
> >>>> @@ -19792,6 +19792,14 @@ L:	netdev@vger.kernel.org
> >>>> S:	Supported
> >>>> F:	drivers/ptp/ptp_vmw.c
> >>>> 
> >>>> +VMWARE VMCI DRIVER
> >>>> +M:	Jorgen Hansen <jhansen@vmware.com>
> >>>> +M:	Vishnu Dasa <vdasa@vmware.com>
> >>>> +M:	"VMware, Inc." <pv-drivers@vmware.com>
> >>> 
> >>> Please do not use generic aliases as they provide no personal
> >>> responsibility.  Just stick with real people.
> >> 
> >> That makes sense. However, the pv-drivers list is used for keeping managers
> >> and people helping with testing in the loop. So would adding pv-drivers as a
> >> second L: entry be OK?
> > 
> > Is it really a list?  If not, then that would not make much sense.
> 
> It is - with VMware subscribers only but anyone can post to it. If the intent of the
> L: entries is to allow folks to subscribe to relevant information, then it isn’t
> appropriate.

Then mark it as a private list.

> All existing vmw driver maintainer entries have pv-drivers as an M: entry,
> so has there been a change in policy regarding this? The approach has
> been quite useful for us.

It's a hit-or-miss policy, some of us notice it, others do not.  nothing
official at all, just those of us with more experience know that aliases
like this usually atrophy and become useless.  There are many such
examples of useless ones in the MAINTAINERS file right now :(

thanks,

greg k-h
