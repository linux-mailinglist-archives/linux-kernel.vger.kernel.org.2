Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEFE32CE64
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 09:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbhCDI0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 03:26:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236695AbhCDI0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:26:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BF4764EEC;
        Thu,  4 Mar 2021 08:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614846342;
        bh=cPFi4SVIr+nJ4GP94go8NFRTFtPu+5lJnNcCCcNrlew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KemwzxrOaRUSo4/nR2PUke42b97vIJJaRVxTlHXgOCndtXhMibtfsT307b14CrSZT
         S5sSFDONtKJARRPZOOA/oB7ZzWtZslcbCoNOUmX4rIhmh2xk6avbhrcVRKPtIcM05M
         4ovgQIaUPVuHeiyxgz7nFz+5Orysp1f/wP5hS9Ls=
Date:   Thu, 4 Mar 2021 09:25:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shuo A Liu <shuo.a.liu@intel.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Zhi Wang <zhi.a.wang@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: add hotplug_cpu dependency
Message-ID: <YECZg7h8HNGGhFFM@kroah.com>
References: <20210225133838.2196965-1-arnd@kernel.org>
 <20210226013807.GA9695@shuo-intel.sh.intel.com>
 <YDiUTv5czunFzgEN@kroah.com>
 <20210226063018.GB9695@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226063018.GB9695@shuo-intel.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 02:30:18PM +0800, Shuo A Liu wrote:
> On Fri 26.Feb'21 at  7:25:18 +0100, Greg Kroah-Hartman wrote:
> > On Fri, Feb 26, 2021 at 09:38:07AM +0800, Shuo A Liu wrote:
> > > Hi Arnd,
> > > 
> > > There is already a patchset for this build issue. Please refer to
> > > https://lore.kernel.org/lkml/20210221134339.57851-1-shuo.a.liu@intel.com/.
> > > 
> > > Hi Greg, Would you like accept that patchset in you tree?
> > 
> > I can't take anything new in my tree until 5.12-rc1 is out.  When that
> > happens I will go through everything submitted to me and merge fixes
> > like this one and get them sent to Linus in a week or so.
> 
> OK. Thanks for the information.

Now in my tree and will show up in linux-next tomorrow.

thanks,

greg k-h
