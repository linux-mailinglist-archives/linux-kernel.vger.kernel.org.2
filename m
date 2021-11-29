Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9ED460F07
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 07:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbhK2G7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 01:59:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37414 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbhK2G5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 01:57:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9092B80AD7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 06:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CECC004E1;
        Mon, 29 Nov 2021 06:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638168866;
        bh=RYQ5TL3Q4scjHyOKenA0PR6N4gn+hsgYDnRoNOVu0FQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m2ZGqYc96w6X2cahe+qCHtAnUqCkrUiHiZQR73q5KP0Qis+XV+n8LtKOKU6jAv57M
         er3Vcqh1rHs1W7UcMK6FPTtKwssUDvWliXoqm9XknsdbLAx/c05R5JKvf/WycMybDm
         2TPo+Lbn2WbwBC/6NTV5i3xrDxx/9hhSYspy5i2w=
Date:   Mon, 29 Nov 2021 07:54:24 +0100
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
Subject: Re: [PATCH 2/3] topology/sysfs: export cluster attributes only if an
 architectures has support
Message-ID: <YaR5IMK3+TAhWfet@kroah.com>
References: <20211128212221.1069726-1-hca@linux.ibm.com>
 <20211128212221.1069726-3-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128212221.1069726-3-hca@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 10:22:20PM +0100, Heiko Carstens wrote:
> The cluster_id and cluster_cpus topology sysfs attributes have been
> added with c5e22feffdd7 ("topology: Represent clusters of CPUs within
> a die").
> 
> They are currently only used for x86, arm64, and riscv (via generic
> arch topology), however they are still present with bogus default
> values for all other architectures. Instead of enforcing such new
> sysfs attributes to all architectures, make them only optional visible
> if an architecture opts in by defining both the topology_cluster_id
> and topology_cluster_cpumask attributes.
> 
> This is similar to what was done when the book and drawer topology
> levels were introduced: avoid useless and therefore confusing sysfs
> attributes for architectures which cannot make use of them.
> 
> This should not break any existing applications, since this is a
> new interface introduced with the v5.16 merge window.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  Documentation/admin-guide/cputopology.rst | 4 ++--
>  drivers/base/topology.c                   | 8 ++++++++
>  include/linux/topology.h                  | 2 ++
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-guide/cputopology.rst
> index c68d07533c45..ad2238b41439 100644
> --- a/Documentation/admin-guide/cputopology.rst
> +++ b/Documentation/admin-guide/cputopology.rst
> @@ -11,8 +11,8 @@ Architecture-neutral, drivers/base/topology.c, exports these attributes.
>  However, the book and drawer related sysfs files will only be created if
>  CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are selected, respectively.
>  
> -The die hierarchy related sysfs files will only be created if an architecture
> -provides the related macros as described below.
> +The die and cluster hierarchy related sysfs files will only be created if an
> +architecture provides the related macros as described below.
>  
>  CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are currently only used on s390,
>  where they reflect the cpu and cache hierarchy.
> diff --git a/drivers/base/topology.c b/drivers/base/topology.c
> index 7fa5a7fbef25..1a288eac2c44 100644
> --- a/drivers/base/topology.c
> +++ b/drivers/base/topology.c
> @@ -50,8 +50,10 @@ define_id_show_func(die_id);
>  static DEVICE_ATTR_RO(die_id);
>  #endif
>  
> +#ifndef topology_cluster_no_sysfs

Same comment here, do not enable an option that disables something :)

thanks,

greg k-h
