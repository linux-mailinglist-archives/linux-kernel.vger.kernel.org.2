Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2C03A8842
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhFOSKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:10:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:8494 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhFOSKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:10:31 -0400
IronPort-SDR: yjCf7fH2UC4hB+N1dv/hx2zE+q4Z+RfDkpqDGvZ8aix0zmUHeWI60EionaCn9Ai8GPCX2uPEJd
 5ADi4QRh/6Dg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="204214731"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="204214731"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:08:17 -0700
IronPort-SDR: ngBHJ8PvHNIQ1V/kAIE99CkLaYLqAG4azbnScU/5Sz/KT77kNJP8uGldDW4JtwmNQcKexAm3m5
 dlBmqpFBrg6w==
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="554528686"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.184.247]) ([10.212.184.247])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:08:16 -0700
Subject: Re: [PATCH v4 05/24] x86/resctrl: Label the resources with their
 configuration type
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com
References: <20210614200941.12383-1-james.morse@arm.com>
 <20210614200941.12383-6-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <bddb1c5a-005b-3ef9-443e-2b603582e927@intel.com>
Date:   Tue, 15 Jun 2021 11:08:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614200941.12383-6-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 6/14/2021 1:09 PM, James Morse wrote:
...

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 425e7913dc8d..81073d0751c9 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -15,6 +15,14 @@ int proc_resctrl_show(struct seq_file *m,
>   
>   #endif
>   
> +enum resctrl_conf_type {
> +	/* No prioritisation, both code and data are controlled or monitored. */
> +	CDP_NONE,
> +
> +	CDP_CODE,
> +	CDP_DATA,
> +};
> +


Please follow style of the rest of this file - please no inline 
documentation, use proper kernel-doc instead.

Reinette
