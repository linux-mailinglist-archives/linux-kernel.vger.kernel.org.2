Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FA93D3978
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhGWKsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 06:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231703AbhGWKsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 06:48:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10F93608FE;
        Fri, 23 Jul 2021 11:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627039719;
        bh=o+tyEe6E2yY0cCqULkCIT3sxBdyYAIFVQGoL8ZDwEM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yJCxL3/FRkZsMKSMEwAU73noA9LdiUKH0tz1gENQJwM6z2Yhk5T4uprW5uify8Xcc
         LbdJkU7lw8sEomDOmSjq8yjt4fUbeT4ATnrflWDyGJlgzj3gfyrBbBvQBb0kzdnBRZ
         VcEwU3bEctWN6pD51vtPv6fIMFlNnusM0qJTucmI=
Date:   Fri, 23 Jul 2021 13:28:37 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH 1/2] CPU, NUMA topology ABIs: clarify the overflow issue
 of sysfs pagebuf
Message-ID: <YPqn5SDi6bzLHsOY@kroah.com>
References: <1619679819-45256-1-git-send-email-tiantao6@hisilicon.com>
 <1619679819-45256-2-git-send-email-tiantao6@hisilicon.com>
 <146e051b-603c-a6d3-43d8-d083cf2c8119@intel.com>
 <602918a1e2214ea7bd0890a751975566@hisilicon.com>
 <7c663f7e-07e0-6d95-3012-6e31a1b78f7e@intel.com>
 <4bf6870f7f3942398e4d1fdaa42184c7@hisilicon.com>
 <fd78ac30-dd3b-a7d7-eae8-193b09a7d49a@intel.com>
 <e9610060a8d046e783ab9a229f35410c@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9610060a8d046e783ab9a229f35410c@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 11:20:19AM +0000, Song Bao Hua (Barry Song) wrote:
> 
> 
> > -----Original Message-----
> > From: Dave Hansen [mailto:dave.hansen@intel.com]
> > Sent: Friday, April 30, 2021 10:39 AM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; tiantao (H)
> > <tiantao6@hisilicon.com>; corbet@lwn.net; gregkh@linuxfoundation.org
> > Cc: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; Rafael J.
> > Wysocki <rafael@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Valentin
> > Schneider <valentin.schneider@arm.com>; Dave Hansen
> > <dave.hansen@linux.intel.com>; Daniel Bristot de Oliveira <bristot@redhat.com>
> > Subject: Re: [PATCH 1/2] CPU, NUMA topology ABIs: clarify the overflow issue
> > of sysfs pagebuf
> > 
> > On 4/29/21 3:32 PM, Song Bao Hua (Barry Song) wrote:
> > > $ strace numactl --hardware  2>&1 | grep cpu
> > > openat(AT_FDCWD, "/sys/devices/system/cpu",
> > > O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
> > > openat(AT_FDCWD, "/sys/devices/system/node/node0/cpumap", O_RDONLY) = 3
> > > openat(AT_FDCWD, "/sys/devices/system/node/node1/cpumap", O_RDONLY) = 3
> > > openat(AT_FDCWD, "/sys/devices/system/node/node2/cpumap", O_RDONLY) = 3
> > > openat(AT_FDCWD, "/sys/devices/system/node/node3/cpumap", O_RDONLY) = 3
> > >
> > > If we move to binary, it means we have to change those applications.
> > 
> > I thought Greg was saying to using a sysfs binary attribute using
> > something like like sysfs_create_bin_file().  Those don't have the
> > PAGE_SIZE limitation.  But, there's also nothing to keep us from spewing
> > nice human-readable text via the "binary" file.
> > 
> > We don't need to change the file format, just the internal kernel API
> > that we produce the files with.
> 
> Sorry for waking-up the old thread.
> 
> I am not sure how common a regular device_attribute will be larger than
> 4KB and have to work around by bin_attribute. But I wrote a prototype
> which can initially support large regular sysfs entry and be able to
> fill the entire buffer by only one show() entry. The other words to say,
> we don't need to call read() of bin_attribute multiple times for a large
> regular file. Right now, only read-only attribute is supported.
> 
> Subject: [RFC PATCH] sysfs: support regular device attr which can be larger than
>  PAGE_SIZE
> 
> A regular sysfs ABI could be more than 4KB, right now, we are using
> bin_attribute to workaround and break this limit. A better solution
> would be supporting long device attribute. In this case, we will
> still be able to enjoy the advantages of buffering and seeking of
> seq file and only need to fill the entire buffer of sysfs entry
> once.

No, please no.  I WANT people to run into this problem and realize that
it went totally wrong because they should not be having more than one
"value" in a sysfs file like this.

Let's not make it easy on people please, moving to a bin attribute is a
big deal, let's keep it that way.

thanks,

greg k-h
