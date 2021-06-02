Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCD4398F41
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhFBPwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:52:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:63042 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232294AbhFBPwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:52:19 -0400
IronPort-SDR: lkcplOfVo969KZkDKXhbCSEc0otnNXeX6keT8PMN3rYlNGk5TtnJNNK2+xUSqtJ8fAALGwii1I
 c4B67YljkyQQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="201961714"
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="201961714"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 08:50:30 -0700
IronPort-SDR: Kkd7mOWhPSX4fG894Dp0r1PpTOmhWjZEFY5rCDv30mbj0WX4Cn+1Afzrs8WrR7Dj0RoPAiNwUb
 +00z0sN5nq/w==
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="438453038"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 08:50:27 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1loT8S-00Gk80-Q1; Wed, 02 Jun 2021 18:50:24 +0300
Date:   Wed, 2 Jun 2021 18:50:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, jonathan.cameron@huawei.com,
        song.bao.hua@hisilicon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drivers/base/node.c: use bin_attribute to avoid
 buff overflow
Message-ID: <YLeowAzQPfJK3oap@smile.fi.intel.com>
References: <1622641734-22538-1-git-send-email-tiantao6@hisilicon.com>
 <1622641734-22538-4-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622641734-22538-4-git-send-email-tiantao6@hisilicon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 09:48:54PM +0800, Tian Tao wrote:
> Reading sys/devices/system/cpu/cpuX/nodeX/ returns cpumap and cpulist.
> However, the size of this file is limited to PAGE_SIZE because of the
> limitation for sysfs attribute. so we use bin_attribute instead of
> attribute to avoid NR_CPUS too big to cause buff overflow.

...

> -static ssize_t node_read_cpumap(struct device *dev, bool list, char *buf)
> +static ssize_t node_read_cpumap(struct device *dev, bool list,
> +				char *buf, loff_t off, size_t count)

Why you moved char *buf to the next line? Replacing ) by , doesn't change
character count. Perhaps you need to reconfigure your editor.

...

> +static struct bin_attribute *node_dev_bin_attrs[] = {
> +	&bin_attr_cpumap,
> +	&bin_attr_cpulist,

> +	NULL,

No comma.

> +};

...

> +static const struct attribute_group *node_dev_groups[] = {
> +	&node_dev_group,
> +	NULL,

Ditto.

> +};

-- 
With Best Regards,
Andy Shevchenko


