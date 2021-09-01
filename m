Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CA53FE312
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 21:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344678AbhIATcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 15:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244842AbhIATcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 15:32:53 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7819CC061760;
        Wed,  1 Sep 2021 12:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=aHeB5tLgbX1mWI1LAUsWRTzA7m8n3phXSwvcMOX63Oo=; b=LH72Tn5h9o3IkQs7klgTVV8YDm
        rJOrYgTpWSRflJu/ID3D+cnWc4lOmMG6wbChjN6CjmoXtxC+6DAmZkdqEb67vMB61GNXOKraDDo7t
        oGgAaV6U4LNM9FKDWj8vE9UpojoJH6+lljbAq2OPQYh5IZ7O9rRWxi5PDPKx2ytNmGkTqiL58sUN8
        CtX9EkfBfEvznKpZnyw2thXEtAVWlBEJ54dXOzBNwEdFT+nmejaBThedIefO/B1aew6WO0ru5h7S6
        7dZNKtdbMmfqsflZ1lBmK4+kt2jLT5Rsu6CCH0z439exJ74FD07IvYIE3UawwQE0qeP45rQEy+8Vm
        FY0BeKjw==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.153])
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLVxj-00761J-Df; Wed, 01 Sep 2021 19:31:55 +0000
Subject: Re: [PATCH v3 1/1] ishtp: Add support for Intel ishtp eclite driver
To:     sumesh.k.naduvalath@intel.com, hdegoede@redhat.com,
        mgross@linux.intel.com, srinivas.pandruvada@linux.intel.com
Cc:     srinivas.pandruvada@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, ganapathi.chinnu@intel.com,
        nachiketa.kumar@intel.com
References: <20210901124307.16886-1-sumesh.k.naduvalath@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2e82bbb6-59c1-e713-f153-57ddd1e68163@infradead.org>
Date:   Wed, 1 Sep 2021 12:31:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210901124307.16886-1-sumesh.k.naduvalath@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/21 5:43 AM, sumesh.k.naduvalath@intel.com wrote:
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index d12db6c316ea..8a0945ed1182 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1176,6 +1176,22 @@ config INTEL_CHTDC_TI_PWRBTN
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called intel_chtdc_ti_pwrbtn.
>   
> +config INTEL_ISHTP_ECLITE
> +	tristate "Intel ISHTP eclite controller"
> +	depends on INTEL_ISH_HID
> +	depends on ACPI
> +	help
> +	  This driver is for accessing the PSE (Programmable Service Engine),
> +	  an Embedded Controller like IP, using ISHTP (Integrated Sensor Hub

Which "IP" is that?  "an Embedded Controller like IP" doesn't make sense IMO.


> +	  Transport Protocol) to get battery, thermal and UCSI (USB Type-C
> +          Connector System Software Interface) related data from the platform.

Indent above line with tab + 2 spaces instead of many spaces.

> +	  Users who don't want to use discrete Embedded Controller on Intel's
> +	  Elkhartlake platform, can leverage this integrated solution of

	Drop this comma       ^

> +	  ECLite which is part of PSE subsystem.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called intel_ishtp_eclite

End the last sentence with a period ('.').


thanks.
-- 
~Randy

