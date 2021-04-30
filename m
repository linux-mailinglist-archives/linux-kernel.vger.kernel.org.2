Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B48E36F590
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 08:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhD3GGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 02:06:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhD3GGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 02:06:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFF5761424;
        Fri, 30 Apr 2021 06:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619762747;
        bh=hqRzyDrn0g03rzVlU0l+LtjC2qwuU1eJezgKOZYtGLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fy98sGODFAY6t0XGklcLMemfXkznN4XNdok3p1cL8YkvWQ7Oaewr8qcf/gbgFZ5j4
         XgNp3kN3BBPHlQ7FC5DFGNzsAYHNce5vQD9CNExU2VwbYf77OZLhGMNJ0JRrpBkFOJ
         wratqWZ/T0qVLvT1k8dbeemExr2TQpSToEv1fP4s=
Date:   Fri, 30 Apr 2021 08:05:45 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/2] CPU, NUMA topology ABIs: clarify the overflow issue
 of sysfs pagebuf
Message-ID: <YIueOR4fOYa1dSAb@kroah.com>
References: <1619679819-45256-1-git-send-email-tiantao6@hisilicon.com>
 <1619679819-45256-2-git-send-email-tiantao6@hisilicon.com>
 <146e051b-603c-a6d3-43d8-d083cf2c8119@intel.com>
 <602918a1e2214ea7bd0890a751975566@hisilicon.com>
 <7c663f7e-07e0-6d95-3012-6e31a1b78f7e@intel.com>
 <4bf6870f7f3942398e4d1fdaa42184c7@hisilicon.com>
 <fd78ac30-dd3b-a7d7-eae8-193b09a7d49a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd78ac30-dd3b-a7d7-eae8-193b09a7d49a@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 03:38:39PM -0700, Dave Hansen wrote:
> On 4/29/21 3:32 PM, Song Bao Hua (Barry Song) wrote:
> > $ strace numactl --hardware  2>&1 | grep cpu
> > openat(AT_FDCWD, "/sys/devices/system/cpu",
> > O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
> > openat(AT_FDCWD, "/sys/devices/system/node/node0/cpumap", O_RDONLY) = 3
> > openat(AT_FDCWD, "/sys/devices/system/node/node1/cpumap", O_RDONLY) = 3
> > openat(AT_FDCWD, "/sys/devices/system/node/node2/cpumap", O_RDONLY) = 3
> > openat(AT_FDCWD, "/sys/devices/system/node/node3/cpumap", O_RDONLY) = 3
> > 
> > If we move to binary, it means we have to change those applications.
> 
> I thought Greg was saying to using a sysfs binary attribute using
> something like like sysfs_create_bin_file().  Those don't have the
> PAGE_SIZE limitation.  But, there's also nothing to keep us from spewing
> nice human-readable text via the "binary" file.

That is correct.

