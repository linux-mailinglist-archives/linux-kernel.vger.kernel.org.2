Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E76330641
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 04:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhCHDMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 22:12:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:27506 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233747AbhCHDM3 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 22:12:29 -0500
IronPort-SDR: EsYBUCm/LHNzbZK0V/Eff0Ns3CdwF5NZSkOX66Mjp0/Hg5BhbrBUVHNORyRfJv/qc/9HU90lH5
 /dlp/4we4Bvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="207713935"
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; 
   d="scan'208";a="207713935"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 19:12:29 -0800
IronPort-SDR: AHnCYmQlv7gqcgE4RTlN7wroWPxv1oFeIRQNsaYgT0qYdwqDe5khzB5+iQ8yNHetFhglDNulww
 UGQRXaP/K7kQ==
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; 
   d="scan'208";a="402654636"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 19:12:27 -0800
Subject: Re: [PATCH v2] perf pmu: Validate raw event with sysfs exported
 format bits
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210305005625.14987-1-yao.jin@linux.intel.com>
 <YEPUJze6AUpNb8nr@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <4677dda8-6a3b-1908-775e-3510091abda5@linux.intel.com>
Date:   Mon, 8 Mar 2021 11:12:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEPUJze6AUpNb8nr@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 3/7/2021 3:12 AM, Jiri Olsa wrote:
> actualy we do have bitmap_scnprintf, which is already doing the
> printing in a nice way.. we could use it like below, only compile
> tested
> 
> jirka
> 
> 
> ---
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 31e975b75766..37ca5eee2667 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1818,7 +1818,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
>   {
>   	struct perf_pmu_format *format;
>   	__u64 masks = 0, bits;
> -	struct strbuf buf = STRBUF_INIT;
> +	char buf[50];
>   	unsigned int i;
>   
>   	list_for_each_entry(format, &pmu->format, list)	{
> @@ -1836,25 +1836,15 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
>   	 * Kernel doesn't export any valid format bits.
>   	 */
>   	if (masks == 0)
> -		goto out;
> +		return;
>   
>   	bits = config & ~masks;
>   	if (bits == 0)
> -		goto out;
> -
> -	for_each_set_bit(i, (unsigned long *)&bits, sizeof(bits) * 8)
> -		strbuf_addf(&buf, " %d", i);
> +		return;
>   
> -	if (name) {
> -		pr_warning("WARNING: event '%s' not valid (bits%s of config "
> -			   "'%llx' not supported by kernel)!\n",
> -			   name, buf.buf, config);
> -	} else {
> -		pr_warning("WARNING: event not valid (bits%s of config "
> -			   "'%llx' not supported by kernel)!\n",
> -			   buf.buf, config);
> -	}
> +	bitmap_scnprintf((unsigned long *)&bits, sizeof(bits) * 8, buf, sizeof(buf));
>   
> -out:
> -	strbuf_release(&buf);
> +	pr_warning("WARNING: event '%s' not valid (bits%s of config "
> +		   "'%llx' not supported by kernel)!\n",
> +		   name ?: "N/A", buf, config);
>   }

The bitmap_scnprintf works fine. Yes, it's really better than original 'strbuf' way, thanks!

BTW, I added "Co-developed-by: Jiri Olsa <jolsa@redhat.com>" in v3, but the patch checking shows the 
warning:

WARNING: Co-developed-by and Signed-off-by: name/email do not match
#76:
Co-developed-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

I'm not sure if this warning is important or not, but anyway I add the line to v3. Thanks for your 
help！

Jin Yao
