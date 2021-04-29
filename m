Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E2836ED92
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbhD2PrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232989AbhD2PrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:47:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FC3161418;
        Thu, 29 Apr 2021 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619711186;
        bh=/VKU8BHFV59c+saQPJazlJKeZ1egZHPlDGpRVTaqF18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oo+Tooz5WEkT5vZmP5cFl0QHgzIRrbjTSH8T8DDJnqg6EJk2ooRGKe86Xp3CVQj0D
         kzwCVojGtFf4hs5GvKrAhXX/oU4ZjmI+TEFqWMDOYO75OkfBpd6uBhmmVMwR5aVbqz
         1XGnYKH4qJHP+y+/Cb22Q3Yyih1kMZFFK3mF/kEg=
Date:   Thu, 29 Apr 2021 17:46:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>, corbet@lwn.net,
        song.bao.hua@hisilicon.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/2] CPU, NUMA topology ABIs: clarify the overflow issue
 of sysfs pagebuf
Message-ID: <YIrU0GMcnk6/5mbP@kroah.com>
References: <1619679819-45256-1-git-send-email-tiantao6@hisilicon.com>
 <1619679819-45256-2-git-send-email-tiantao6@hisilicon.com>
 <146e051b-603c-a6d3-43d8-d083cf2c8119@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146e051b-603c-a6d3-43d8-d083cf2c8119@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 07:21:13AM -0700, Dave Hansen wrote:
> On 4/29/21 12:03 AM, Tian Tao wrote:
> > diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> > index 484fc04..82dfe64 100644
> > --- a/Documentation/ABI/stable/sysfs-devices-node
> > +++ b/Documentation/ABI/stable/sysfs-devices-node
> > @@ -47,7 +47,10 @@ What:		/sys/devices/system/node/nodeX/cpulist
> >  Date:		October 2002
> >  Contact:	Linux Memory Management list <linux-mm@kvack.org>
> >  Description:
> > -		The CPUs associated to the node.
> > +		The CPUs associated to the node. The format is like 0-3,
> > +		8-11, 14,17. maximum size is PAGE_SIZE, so the tail
> > +		of the string will be trimmed while its size is larger
> > +		than PAGE_SIZE.
> 
> I think it's pretty arguable that truncating output on a real system is
> an ABI break.  Doing this would make the interface rather useless.
> 
> Don't we need a real solution rather than throwing up our hands?
> 
> Do we think >PAGE_SIZE data out of a sysfs file is a worse ABI break or
> something?

There is a real way to get > PAGE_SIZE out of a sysfs file.  The LED
developers had to do this when they ran into this same exact problem.
Make it a binary sysfs file and promise to NEVER create such a file
again in the future :)

thanks,

gre gk-h
