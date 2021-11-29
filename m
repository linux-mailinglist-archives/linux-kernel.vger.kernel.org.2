Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4621460F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 07:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhK2HCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhK2HAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 02:00:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53B0C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 22:53:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A652B80DD0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 06:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588B7C004E1;
        Mon, 29 Nov 2021 06:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638168836;
        bh=QjhEAPWuUzsFI2aPq5HfQg4bQbfj764zP1RdhnORFkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LozIj9e1YikHnfSGZdW3KmFIlITGMfMCRaUw/x+yvamxEzYLGg2gWV7r36eCtMpRx
         vvN5lMesVWWgf6BpHTgLiEtwC67LuF1JDX1uCnUQZW82Ae7gOJD+dw6M4hI5LyjSy0
         7rFy/LmlL6HmtYzL+6AT/Kpnstfv8pwJTp7U09LA=
Date:   Mon, 29 Nov 2021 07:53:54 +0100
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
Subject: Re: [PATCH 1/3] topology/sysfs: export die attributes only if an
 architectures has support
Message-ID: <YaR5AuPPq2kODFfI@kroah.com>
References: <20211128212221.1069726-1-hca@linux.ibm.com>
 <20211128212221.1069726-2-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128212221.1069726-2-hca@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 10:22:19PM +0100, Heiko Carstens wrote:
> The die_id and die_cpus topology sysfs attributes have been added with
> commit 0e344d8c709f ("cpu/topology: Export die_id") and commit
> 2e4c54dac7b3 ("topology: Create core_cpus and die_cpus sysfs attributes").
> 
> While they are currently only used and useful for x86 they are still
> present with bogus default values for all architectures. Instead of
> enforcing such new sysfs attributes to all architectures, make them
> only optional visible if an architecture opts in by defining both the
> topology_die_id and topology_die_cpumask attributes.
> 
> This is similar to what was done when the book and drawer topology
> levels were introduced: avoid useless and therefore confusing sysfs
> attributes for architectures which cannot make use of them.
> 
> This should not break any existing applications, since this is a
> rather new interface and applications should be able to handle also
> older kernel versions without such attributes - besides that they
> contain only useful information for x86.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  Documentation/admin-guide/cputopology.rst | 3 +++
>  drivers/base/topology.c                   | 8 ++++++++
>  include/linux/topology.h                  | 2 ++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-guide/cputopology.rst
> index 6b62e182baf4..c68d07533c45 100644
> --- a/Documentation/admin-guide/cputopology.rst
> +++ b/Documentation/admin-guide/cputopology.rst
> @@ -11,6 +11,9 @@ Architecture-neutral, drivers/base/topology.c, exports these attributes.
>  However, the book and drawer related sysfs files will only be created if
>  CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are selected, respectively.
>  
> +The die hierarchy related sysfs files will only be created if an architecture
> +provides the related macros as described below.
> +
>  CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are currently only used on s390,
>  where they reflect the cpu and cache hierarchy.
>  
> diff --git a/drivers/base/topology.c b/drivers/base/topology.c
> index 8f2b641d0b8c..7fa5a7fbef25 100644
> --- a/drivers/base/topology.c
> +++ b/drivers/base/topology.c
> @@ -45,8 +45,10 @@ static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
>  define_id_show_func(physical_package_id);
>  static DEVICE_ATTR_RO(physical_package_id);
>  
> +#ifndef topology_die_no_sysfs

Please flip this #define around to be the other way:
	TOPOLOGY_DIE_SYSFS
and enable/disable it.

Makes it much easier to understand than "negative logic"

Also, defines need to be all uppercase.

thanks,

greg k-h
