Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558C03D0B50
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 11:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbhGUI1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 04:27:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235407AbhGUIUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 04:20:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9266C61175;
        Wed, 21 Jul 2021 09:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626858041;
        bh=Nm8mnH9tGqYOqV3B8p39LD6S+9Q29MorENuKk20x+4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hn49yPndJpyJ+dUwfi+oo3LtPjWG5+/Bgou2JXhxVOPy7EHluSi16SeLnbp63ZQc9
         hWTxUquFme+uMe80OKPet9oLg0HJLP6/3LbrMehm2C22kkmFACe08WbGrXse4pHTOk
         9T4BwhS1yXEOkjhGKpo5tN0HuUMQ/hVcFqGqUdiE=
Date:   Wed, 21 Jul 2021 11:00:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jorgen Hansen <jhansen@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH] MAINTAINERS: Update for VMCI driver
Message-ID: <YPfiNuKonyTIKcDL@kroah.com>
References: <1626776941-9163-1-git-send-email-jhansen@vmware.com>
 <YPan14jucU9/u6JL@kroah.com>
 <0C3493F7-AF29-417B-94EA-26871283E65A@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0C3493F7-AF29-417B-94EA-26871283E65A@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 08:46:15AM +0000, Jorgen Hansen wrote:
> 
> 
> > On 20 Jul 2021, at 12:39, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Tue, Jul 20, 2021 at 03:29:01AM -0700, Jorgen Hansen wrote:
> >> Add maintainer info for the VMware VMCI driver.
> >> 
> >> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> >> ---
> >> MAINTAINERS | 8 ++++++++
> >> 1 file changed, 8 insertions(+)
> >> 
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index a61f4f3..7e7c6fa 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -19792,6 +19792,14 @@ L:	netdev@vger.kernel.org
> >> S:	Supported
> >> F:	drivers/ptp/ptp_vmw.c
> >> 
> >> +VMWARE VMCI DRIVER
> >> +M:	Jorgen Hansen <jhansen@vmware.com>
> >> +M:	Vishnu Dasa <vdasa@vmware.com>
> >> +M:	"VMware, Inc." <pv-drivers@vmware.com>
> > 
> > Please do not use generic aliases as they provide no personal
> > responsibility.  Just stick with real people.
> 
> That makes sense. However, the pv-drivers list is used for keeping managers
> and people helping with testing in the loop. So would adding pv-drivers as a
> second L: entry be OK?

Is it really a list?  If not, then that would not make much sense.
