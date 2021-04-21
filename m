Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FE136720D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbhDURyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:54:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:48932 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243375AbhDURyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:54:23 -0400
IronPort-SDR: /VL4ZreGaq6NI8kUJ8vgtQrN+cZJ7hf08CRxYeKReBfxL4ZQX9VrcNc7+cVBgzEBV6cjzEfZFS
 w8vol+H6NhQQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="195301534"
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="195301534"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 10:53:50 -0700
IronPort-SDR: RIZb0MRHyztcffxl5iuuncej8/aH9ccGhf462926I1z18DfGJgyipFc05YsTshajOraCiHkp8p
 c8B9HWXwNp7w==
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="427609582"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.153.90]) ([10.249.153.90])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 10:53:49 -0700
Subject: Re: [PATCH 038/190] Revert "cpuidle: Fix three reference count leaks"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-39-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <6fc7a639-f97f-923e-04e7-6402b4e6ef7f@intel.com>
Date:   Wed, 21 Apr 2021 19:53:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-39-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/2021 2:58 PM, Greg Kroah-Hartman wrote:
> This reverts commit c343bf1ba5efcbf2266a1fe3baefec9cc82f867f.
>
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
>
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
>
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>   drivers/cpuidle/sysfs.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index 53ec9585ccd4..23a219cedbdb 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -487,7 +487,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
>   		ret = kobject_init_and_add(&kobj->kobj, &ktype_state_cpuidle,
>   					   &kdev->kobj, "state%d", i);
>   		if (ret) {
> -			kobject_put(&kobj->kobj);
> +			kfree(kobj);
>   			goto error_state;
>   		}
>   		cpuidle_add_s2idle_attr_group(kobj);
> @@ -618,7 +618,7 @@ static int cpuidle_add_driver_sysfs(struct cpuidle_device *dev)
>   	ret = kobject_init_and_add(&kdrv->kobj, &ktype_driver_cpuidle,
>   				   &kdev->kobj, "driver");
>   	if (ret) {
> -		kobject_put(&kdrv->kobj);
> +		kfree(kdrv);
>   		return ret;
>   	}
>   
> @@ -712,7 +712,7 @@ int cpuidle_add_sysfs(struct cpuidle_device *dev)
>   	error = kobject_init_and_add(&kdev->kobj, &ktype_cpuidle, &cpu_dev->kobj,
>   				   "cpuidle");
>   	if (error) {
> -		kobject_put(&kdev->kobj);
> +		kfree(kdev);
>   		return error;
>   	}
>   


