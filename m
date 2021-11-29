Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04358460F19
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 07:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhK2HA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:00:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40426 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbhK2G6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 01:58:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4E61611BB
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 06:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8562EC004E1;
        Mon, 29 Nov 2021 06:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638168907;
        bh=Mu0VOgT1a1DX99oi2rPtkkxbxded1sLdQmrt9ST5pdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0E5eaB63q/YE/eCNc0TMrTvyLR7Ytx64PC2DIX9pUb1I9SLbSixz7dQUhoi3B6oja
         S5s286kyC16hdLn8NEZUfgEgmBb/AV+Lf7AcWSeTuC6m4Ms4p/b4+uMnVsTjLQZT/h
         bfoSx1ZzwKpV0kozoHaJ6cDV82pbIKpl66mj2NJY=
Date:   Mon, 29 Nov 2021 07:55:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <len.brown@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 3/3] topology/sysfs: rework book and drawer topology
 ifdefery
Message-ID: <YaR5SPEYnz4sHtq9@kroah.com>
References: <20211128212221.1069726-1-hca@linux.ibm.com>
 <20211128212221.1069726-4-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128212221.1069726-4-hca@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 10:22:21PM +0100, Heiko Carstens wrote:
> Provide default defines for the topology_book_[id|cpumask] and
> topology_drawer_[id|cpumask] macros just like for each other topology
> level.
> This way all topology levels are handled in a similar way. Still the
> the book and drawer levels are only used on s390, and also the sysfs
> attributes are only created on s390. However other architectures may
> opt in if wanted.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  Documentation/admin-guide/cputopology.rst | 36 ++++++++++-------------
>  drivers/base/topology.c                   | 12 ++++----
>  include/linux/topology.h                  | 16 ++++++++++
>  3 files changed, 37 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-guide/cputopology.rst
> index ad2238b41439..677ba1c2c820 100644
> --- a/Documentation/admin-guide/cputopology.rst
> +++ b/Documentation/admin-guide/cputopology.rst
> @@ -8,14 +8,9 @@ to /proc/cpuinfo output of some architectures. They reside in
>  Documentation/ABI/stable/sysfs-devices-system-cpu.
>  
>  Architecture-neutral, drivers/base/topology.c, exports these attributes.
> -However, the book and drawer related sysfs files will only be created if
> -CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are selected, respectively.
> -
> -The die and cluster hierarchy related sysfs files will only be created if an
> -architecture provides the related macros as described below.
> -
> -CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are currently only used on s390,
> -where they reflect the cpu and cache hierarchy.
> +However the die, cluster, book, and drawer hierarchy related sysfs files will
> +only be created if an architecture provides the related macros as described
> +below.
>  
>  For an architecture to support this feature, it must define some of
>  these macros in include/asm-XXX/topology.h::
> @@ -42,19 +37,18 @@ To be consistent on all architectures, include/linux/topology.h
>  provides default definitions for any of the above macros that are
>  not defined by include/asm-XXX/topology.h:
>  
> -1) topology_physical_package_id: -1
> -2) topology_die_id: -1
> -3) topology_cluster_id: -1
> -4) topology_core_id: 0
> -5) topology_sibling_cpumask: just the given CPU
> -6) topology_core_cpumask: just the given CPU
> -7) topology_cluster_cpumask: just the given CPU
> -8) topology_die_cpumask: just the given CPU
> -
> -For architectures that don't support books (CONFIG_SCHED_BOOK) there are no
> -default definitions for topology_book_id() and topology_book_cpumask().
> -For architectures that don't support drawers (CONFIG_SCHED_DRAWER) there are
> -no default definitions for topology_drawer_id() and topology_drawer_cpumask().
> + 1) topology_physical_package_id: -1
> + 2) topology_die_id: -1
> + 3) topology_cluster_id: -1
> + 4) topology_core_id: 0
> + 5) topology_book_id: -1
> + 6) topology_drawer_id: -1
> + 7) topology_sibling_cpumask: just the given CPU
> + 8) topology_core_cpumask: just the given CPU
> + 9) topology_cluster_cpumask: just the given CPU
> +10) topology_die_cpumask: just the given CPU
> +11) topology_book_cpumask:  just the given CPU
> +12) topology_drawer_cpumask: just the given CPU
>  
>  Additionally, CPU topology information is provided under
>  /sys/devices/system/cpu and includes these files.  The internal
> diff --git a/drivers/base/topology.c b/drivers/base/topology.c
> index 1a288eac2c44..a942fadd3c5b 100644
> --- a/drivers/base/topology.c
> +++ b/drivers/base/topology.c
> @@ -86,7 +86,7 @@ define_siblings_read_func(package_cpus, core_cpumask);
>  static BIN_ATTR_RO(package_cpus, 0);
>  static BIN_ATTR_RO(package_cpus_list, 0);
>  
> -#ifdef CONFIG_SCHED_BOOK
> +#ifndef topology_book_no_sysfs
>  define_id_show_func(book_id);
>  static DEVICE_ATTR_RO(book_id);
>  define_siblings_read_func(book_siblings, book_cpumask);
> @@ -94,7 +94,7 @@ static BIN_ATTR_RO(book_siblings, 0);
>  static BIN_ATTR_RO(book_siblings_list, 0);
>  #endif
>  
> -#ifdef CONFIG_SCHED_DRAWER
> +#ifndef topology_drawer_no_sysfs
>  define_id_show_func(drawer_id);
>  static DEVICE_ATTR_RO(drawer_id);
>  define_siblings_read_func(drawer_siblings, drawer_cpumask);
> @@ -119,11 +119,11 @@ static struct bin_attribute *bin_attrs[] = {
>  #endif
>  	&bin_attr_package_cpus,
>  	&bin_attr_package_cpus_list,
> -#ifdef CONFIG_SCHED_BOOK
> +#ifndef topology_book_no_sysfs

Again, flip around:
	TOPOLOGY_BOOK_SYSFS

thanks,

greg k-h
