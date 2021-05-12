Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026F337C162
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhELO7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:59:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:15118 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232414AbhELO5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:57:02 -0400
IronPort-SDR: uaOZ/puAhYJgVZIEZ+xsJzaQg61kZ6dyiNbcIDzFtK2lvMoCeXKjNY1o2svF3D4bLNHP3jLOCY
 VOaNSWLsLS7w==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187149182"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="187149182"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 07:55:53 -0700
IronPort-SDR: y4XUhU0pegKxNxb89n7z7Bf29Yzf14vRHiMZ4O646DK9SEWCCG4uQ0E3S6PMT8BSmn1rbdAffC
 vt8x+x4qcwZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="400143970"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga007.fm.intel.com with ESMTP; 12 May 2021 07:55:52 -0700
Date:   Wed, 12 May 2021 22:50:41 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: De-duplicate INTEL MAX 10 BMC MFD DRIVER
 entry
Message-ID: <20210512145041.GA906580@yilunxu-OptiPlex-7050>
References: <20210510183056.810753-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210510183056.810753-1-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's good to me.

Hi Lee:

Could you help submit this fix?

Thanks,
Yilun

On Mon, May 10, 2021 at 08:30:56PM +0200, Jonathan Neuschäfer wrote:
> Xu Yilin's patch "MAINTAINERS: Add entry for Intel MAX 10 mfd driver"
> was applied twice, resulting in a duplicate entry. De-duplicate it.
> 
> Fixes: 58d91f1c1701d ("MAINTAINERS: Add entry for Intel MAX 10 mfd driver")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  MAINTAINERS | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd7aff0c120f2..7d6e44b9f4664 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9299,16 +9299,6 @@ F:	drivers/hwmon/intel-m10-bmc-hwmon.c
>  F:	drivers/mfd/intel-m10-bmc.c
>  F:	include/linux/mfd/intel-m10-bmc.h
> 
> -INTEL MAX 10 BMC MFD DRIVER
> -M:	Xu Yilun <yilun.xu@intel.com>
> -R:	Tom Rix <trix@redhat.com>
> -S:	Maintained
> -F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> -F:	Documentation/hwmon/intel-m10-bmc-hwmon.rst
> -F:	drivers/hwmon/intel-m10-bmc-hwmon.c
> -F:	drivers/mfd/intel-m10-bmc.c
> -F:	include/linux/mfd/intel-m10-bmc.h
> -
>  INTEL MENLOW THERMAL DRIVER
>  M:	Sujith Thomas <sujith.thomas@intel.com>
>  L:	platform-driver-x86@vger.kernel.org
> --
> 2.30.2
