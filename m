Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218143C6FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 13:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhGMLhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 07:37:24 -0400
Received: from foss.arm.com ([217.140.110.172]:41712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235623AbhGMLhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:37:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1EF21FB;
        Tue, 13 Jul 2021 04:34:32 -0700 (PDT)
Received: from bogus (unknown [10.57.79.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3221B3F7D8;
        Tue, 13 Jul 2021 04:34:31 -0700 (PDT)
Date:   Tue, 13 Jul 2021 12:33:24 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, james.morse@arm.com
Subject: Re: [PATCH] cacheinfo: clear cache_leaves(cpu) in
 free_cache_attributes()
Message-ID: <20210713113315.thsvrvqvqptc7hje@bogus>
References: <1626148058-55230-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626148058-55230-1-git-send-email-wangxiongfeng2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 11:47:38AM +0800, Xiongfeng Wang wrote:
> On ARM64, when PPTT(Processor Properties Topology Table) is not
> implemented in ACPI boot, we will goto 'free_ci' with the following
> print:
>   Unable to detect cache hierarchy for CPU 0
>

The change itself looks good and I am fine with that. However,...

> But some other codes may still use 'num_leaves' to iterate through the

Can you point me exactly where it is used to make sure there are no
other issues associated with that.

> 'info_list', such as get_cpu_cacheinfo_id(). If 'info_list' is NULL , it
> would crash. So clear 'num_leaves' in free_cache_attributes().
>

And can you provide the crash dump please ? If we are not hitting any
issue and you just figured this with code inspection, that is fine. It
helps to determine if this needs to be backport or just good to have
clean up.

> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/base/cacheinfo.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index bfc0959..dad2962 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -297,6 +297,7 @@ static void free_cache_attributes(unsigned int cpu)
>
>  	kfree(per_cpu_cacheinfo(cpu));
>  	per_cpu_cacheinfo(cpu) = NULL;
> +	cache_leaves(cpu) = 0;

I initially thought it might get used and crash in cache_shared_cpu_map_remove
but you are setting it later. So where do you suspect it to be used ? Sorry
if I am missing something obvious, looking at this code after long time.

-- 
Regards,
Sudeep
