Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C617C396DCB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhFAHPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 03:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229984AbhFAHPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:15:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D254610A8;
        Tue,  1 Jun 2021 07:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622531610;
        bh=dkkqEZ46ygeb8R6c460uRo7VIXi3q12IgWL/Sj2VTsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jA2lpEdAC+eZixkGMXlCI7EmbgwV0TP5dmW1+yNGHrOM/shogRyaTLKBztC5OCyQz
         Vo0gtCVB5S0n5sOy9ioc2PCl8ZYCgyUVuYSkdtNEPbyvebR0ZO4epjYyQNabBmQZL8
         OUSVqJCqi/4X2sMe4CmaWtJecQGlXiLhPviO/Y6s=
Date:   Tue, 1 Jun 2021 09:13:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "tiantao (H)" <tiantao6@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] topology: use bin_attribute to avoid buff overflow
Message-ID: <YLXeF8oxHgIxl2iF@kroah.com>
References: <1622516210-10886-1-git-send-email-tiantao6@hisilicon.com>
 <1622516210-10886-2-git-send-email-tiantao6@hisilicon.com>
 <YLW+hZwoImx2wjwS@kroah.com>
 <cb90096ab76d4a55a59d0682fa786ba5@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb90096ab76d4a55a59d0682fa786ba5@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 07:04:33AM +0000, Song Bao Hua (Barry Song) wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Tuesday, June 1, 2021 4:59 PM
> > To: tiantao (H) <tiantao6@hisilicon.com>
> > Cc: linux-kernel@vger.kernel.org; akpm@linux-foundation.org; Song Bao Hua
> > (Barry Song) <song.bao.hua@hisilicon.com>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; Rafael J. Wysocki <rafael@kernel.org>
> > Subject: Re: [PATCH 1/2] topology: use bin_attribute to avoid buff overflow
> > 
> > On Tue, Jun 01, 2021 at 10:56:49AM +0800, Tian Tao wrote:
> > > Reading sys/devices/system/cpu/cpuX/topology/ returns cpu topology.
> > > However, the size of this file is limited to PAGE_SIZE because of the
> > > limitation for sysfs attribute. so we use bin_attribute instead of
> > > attribute to avoid NR_CPUS too big to cause buff overflow.
> > >
> > > This patch is based on the following discussion.
> > > https://www.spinics.net/lists/linux-doc/msg95921.html
> > 
> > Please use lore.kernel.org for links as we have no control over other
> > sites to ensure that they will work in the future.  Use the message id
> > in the link as well, so that if something were to happen to lore, we can
> > figure it out.
> > 
> > Also, you are modifying a bunch of different files here, do you mean to
> > do it for all of them?
> 
> The plan is providing a common wrapper similar with cpumap_print_to_pagebuf
> so that all modules which have bitmap and list topology ABI can move to use
> it.

Ok, then create the new function and then convert to use it, do not
bundle it together in the same patch.

thanks,

greg k-h
