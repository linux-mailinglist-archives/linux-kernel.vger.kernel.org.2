Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997EF31EE8C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhBRSnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:43:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:45737 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhBRQXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:23:32 -0500
IronPort-SDR: HcNVJ9nowSRk2ollqH8wVaVLMpeC7AkPHKCptHQUlYNO/PJCl4qlyDYVbAn4MmDMHlQiGVC0kS
 /Jp2KoKm1jfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="162692611"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="162692611"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 08:19:55 -0800
IronPort-SDR: Lf+ROC00VWLuqGm1eI8CBjydl88e6ORQORBmIDMtR6XLAVDu6939yYnKt7MKNxfuOdKYpmdR7l
 IWHgF6q2BsAg==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="581326513"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 08:19:55 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 1D1836365;
        Thu, 18 Feb 2021 08:19:55 -0800 (PST)
Date:   Thu, 18 Feb 2021 08:19:55 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: fix typo in Kconfig
Message-ID: <20210218161955.GO154917@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <YCw6zavnfeHRGWgr@arkam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YCw6zavnfeHRGWgr@arkam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 10:36:13PM +0100, Petr Vaněk wrote:
> uses by -> used by
> 
> Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
Reviewed-by: Mark Gross <mgross@linux.intel.com>

Thanks for the clean up!

-mark
> ---
>  drivers/platform/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 91e6176cdfbd..94f2f05bc133 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1372,7 +1372,7 @@ config INTEL_PMT_CLASS
>  	tristate "Intel Platform Monitoring Technology (PMT) Class driver"
>  	help
>  	  The Intel Platform Monitoring Technology (PMT) class driver provides
> -	  the basic sysfs interface and file hierarchy uses by PMT devices.
> +	  the basic sysfs interface and file hierarchy used by PMT devices.
>  
>  	  For more information, see:
>  	  <file:Documentation/ABI/testing/sysfs-class-intel_pmt>
> -- 
> 2.26.2
> 
