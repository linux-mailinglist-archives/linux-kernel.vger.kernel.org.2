Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB70325B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 02:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBZBiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 20:38:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:62051 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhBZBiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 20:38:52 -0500
IronPort-SDR: q+H4wR18JTdBlj1xVr31Jbxu57NaY0zcvwu9ZyQLhELdzCw6WlcwKY36MCdLcBsF9Rf9g8JXUn
 gyQb3uAneGdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="185862046"
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; 
   d="scan'208";a="185862046"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 17:38:11 -0800
IronPort-SDR: hCUO2ULXAnczIGQEbRPZd/IawMZg2PrD20vXp+OdVmL2/WTgpqFQt1DUuB491BdlZjsVxh6Ys0
 bnWYBoNVrbNg==
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; 
   d="scan'208";a="404661950"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 17:38:09 -0800
Date:   Fri, 26 Feb 2021 09:38:07 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Zhi Wang <zhi.a.wang@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: add hotplug_cpu dependency
Message-ID: <20210226013807.GA9695@shuo-intel.sh.intel.com>
References: <20210225133838.2196965-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210225133838.2196965-1-arnd@kernel.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

There is already a patchset for this build issue. Please refer to
https://lore.kernel.org/lkml/20210221134339.57851-1-shuo.a.liu@intel.com/.

Hi Greg, 
Would you like accept that patchset in you tree?

Thanks
shuo

On Thu 25.Feb'21 at 14:38:30 +0100, Arnd Bergmann wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>Without CPU hotplug, acrn fails to build:
>
>drivers/virt/acrn/hsm.c:389:3: error: implicit declaration of function 'remove_cpu' [-Werror,-Wimplicit-function-declaration]
>                remove_cpu(cpu);
>                ^
>drivers/virt/acrn/hsm.c:402:2: error: implicit declaration of function 'add_cpu' [-Werror,-Wimplicit-function-declaration]
>        add_cpu(cpu);
>        ^
>
>Enforce the dependency through Kconfig to avoid the build failure.
>
>Fixes: 666834c47d3b ("virt: acrn: Introduce ACRN HSM basic driver")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>---
> drivers/virt/acrn/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/virt/acrn/Kconfig b/drivers/virt/acrn/Kconfig
>index 3e1a61c9d8d8..fbb0e3234aaf 100644
>--- a/drivers/virt/acrn/Kconfig
>+++ b/drivers/virt/acrn/Kconfig
>@@ -2,6 +2,7 @@
> config ACRN_HSM
> 	tristate "ACRN Hypervisor Service Module"
> 	depends on ACRN_GUEST
>+	depends on HOTPLUG_CPU
> 	select EVENTFD
> 	help
> 	  ACRN Hypervisor Service Module (HSM) is a kernel module which
>-- 
>2.29.2
>
