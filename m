Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0D73973DF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhFANMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233064AbhFANMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:12:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0C8161090;
        Tue,  1 Jun 2021 13:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622553026;
        bh=lE3CSgPX33jsmcTIcv0+X8suVzuMTUCG2GCoG071wGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AD6aXOY5XSV0Sd3jePiq5wu9ot549JpP33alOWdxVeW7JxH3ZdDHMa+C6u4XmsuPo
         M7w9arxJs/BZ4ShY4f+ep19SvWHsLL01gb+bLKdKv85adY8Wl9kvW+/FeTUIgjVCcm
         MojMmqRgjSR1MHR38kNN1GNcsWrsnG4FgcJy2O/jiCHmgi8GJ+llWap5Mdf/tpX9gG
         co5Vebyg5KOBG4GXKlO0lZwGkxYDGWP/uGd8d/g44hMhb1fygSPTsvNO2Gxd17BYbY
         8nnP4Avr/NvbNPMc1YJ1pZwsLhcipJWzbGVKEoOHCs6JJUbBjrto2n4CQv9oPYD7ei
         CFGbxSsacYEsw==
Date:   Tue, 1 Jun 2021 14:10:21 +0100
From:   Will Deacon <will@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v2 1/9] perf: Add EVENT_ATTR_ID to simplify event
 attributes
Message-ID: <20210601131020.GD28025@willie-the-truck>
References: <1621417919-6632-1-git-send-email-liuqi115@huawei.com>
 <1621417919-6632-2-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621417919-6632-2-git-send-email-liuqi115@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 05:51:51PM +0800, Qi Liu wrote:
> Similar EVENT_ATTR macros are defined in many PMU drivers,
> like HiSilicon PMU driver, Arm PMU driver, Arm SMMU PMU
> driver. So Add a generic macro to simplify code.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>  include/linux/perf_event.h | 6 ++++++
>  kernel/events/core.c       | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index f5a6a2f..d0aa74e 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1576,6 +1576,12 @@ static struct perf_pmu_events_attr _var = {				    \
>  	.event_str	= _str,						    \
>  };
>  
> +#define PMU_EVENT_ATTR_ID(_name, _id)					     \
> +	(&((struct perf_pmu_events_attr[]) {				     \
> +		{ .attr = __ATTR(_name, 0444, perf_event_sysfs_show, NULL),  \
> +		  .id = _id, }						     \
> +	})[0].attr.attr)
> +
>  #define PMU_FORMAT_ATTR(_name, _format)					\
>  static ssize_t								\
>  _name##_show(struct device *dev,					\
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 0ac818b..330d9cc 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13295,6 +13295,8 @@ ssize_t perf_event_sysfs_show(struct device *dev, struct device_attribute *attr,
>  
>  	if (pmu_attr->event_str)
>  		return sprintf(page, "%s\n", pmu_attr->event_str);
> +	else
> +		return sprintf(page, "config=%#llx\n", pmu_attr->id);

I think it's a really bad idea to hardcode this here. For example, I think
this patch series breaks user ABI for the SMMU PMU which used to print:

	"event=0x%02llx\n"

and by the looks of it many of the other conversions are unsound too.

I'm all for a common macro, but the string needs to be determined by the
driver.

Will
