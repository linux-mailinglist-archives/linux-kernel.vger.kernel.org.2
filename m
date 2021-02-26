Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013CC325D86
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 07:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBZG0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 01:26:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhBZG0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 01:26:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C65060238;
        Fri, 26 Feb 2021 06:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614320721;
        bh=1sBTNx9ia/yig3QRMYYdGBU3SSrL8Mn1UN+wlEcJgDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TO8evHlqI2UQnRh8rPjWvpOlV4WiJ0XBl00GnrFCONsrkXVm1C8ryibRjVi9WCwE8
         +QyvdP2lNmcPB1FkNNfSDgYMglXadR0nW9p15N3z7iSqCYqC+z6laoLP8sLSskpNkG
         pYPJ0pLN/hbasQZNwhaxIXtIM/I3uqcqYwd4/YWs=
Date:   Fri, 26 Feb 2021 07:25:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shuo A Liu <shuo.a.liu@intel.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Zhi Wang <zhi.a.wang@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: add hotplug_cpu dependency
Message-ID: <YDiUTv5czunFzgEN@kroah.com>
References: <20210225133838.2196965-1-arnd@kernel.org>
 <20210226013807.GA9695@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226013807.GA9695@shuo-intel.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 09:38:07AM +0800, Shuo A Liu wrote:
> Hi Arnd,
> 
> There is already a patchset for this build issue. Please refer to
> https://lore.kernel.org/lkml/20210221134339.57851-1-shuo.a.liu@intel.com/.
> 
> Hi Greg, Would you like accept that patchset in you tree?

I can't take anything new in my tree until 5.12-rc1 is out.  When that
happens I will go through everything submitted to me and merge fixes
like this one and get them sent to Linus in a week or so.

thanks,

greg k-h
