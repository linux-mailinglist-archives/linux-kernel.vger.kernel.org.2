Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F94B32FC95
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhCFTMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:12:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231295AbhCFTMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615057968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DU0oO8F2NvO8OsJLQfljJW69vSl+5O5YqDTwYhLOduM=;
        b=edyXzhL/pxZ5jUqGGTaKk5oXjTN1VsZrKkiUp923e/8VeWlwSSl39C967IZ1ZPPb1YMRii
        H2nEe6uSpVQ9lWhxxqssIGkNzS2sEeEnai5sC6Snxy2v1212VrMkNVdUbEkryMU+cgpppO
        sHbhCz+86BQ7+Lf/m3VwTQ7GPenQhkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-OsIlwoOzMCqCBGt8-FOy3w-1; Sat, 06 Mar 2021 14:12:44 -0500
X-MC-Unique: OsIlwoOzMCqCBGt8-FOy3w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B53BA10059C5;
        Sat,  6 Mar 2021 19:12:42 +0000 (UTC)
Received: from krava (unknown [10.40.192.64])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9A9625D9C6;
        Sat,  6 Mar 2021 19:12:40 +0000 (UTC)
Date:   Sat, 6 Mar 2021 20:12:39 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf pmu: Validate raw event with sysfs exported
 format bits
Message-ID: <YEPUJze6AUpNb8nr@krava>
References: <20210305005625.14987-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305005625.14987-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 08:56:25AM +0800, Jin Yao wrote:
> A raw PMU event (eventsel+umask) in the form of rNNN is supported
> by perf but lacks of checking for the validity of raw encoding.
> 
> For example, bit 16 and bit 17 are not valid on KBL but perf doesn't
> report warning when encoding with these bits.
> 
> Before:
> 
>   # ./perf stat -e cpu/r031234/ -a -- sleep 1
> 
>    Performance counter stats for 'system wide':
> 
>                    0      cpu/r031234/
> 
>          1.003798924 seconds time elapsed
> 
> It may silently measure the wrong event!
> 
> The kernel supported bits have been exported through
> /sys/devices/<pmu>/format/. Perf collects the information to
> 'struct perf_pmu_format' and links it to 'pmu->format' list.
> 
> The 'struct perf_pmu_format' has a bitmap which records the
> valid bits for this format. For example,
> 
>   root@kbl-ppc:/sys/devices/cpu/format# cat umask
>   config:8-15
> 
> bit8-bit15 are recorded in bitmap of format 'umask'.
> 
> We collect total valid bits of all formats, save to a local variable
> 'masks' and reverse it. Now '~masks' represents total invalid bits.
> 
> bits = config & ~masks;
> 
> The set bits in 'bits' indicate the invalid bits used in config.
> Finally use strbuf to report the invalid bits.
> 
> Some architectures may not export supported bits through sysfs,
> so if masks is 0, perf_pmu__warn_invalid_config directly returns.
> 
> After:
> 
> Single event without name:
> 
>   # ./perf stat -e cpu/r031234/ -a -- sleep 1
>   WARNING: event not valid (bits 16 17 of config '31234' not supported by kernel)!
> 
>    Performance counter stats for 'system wide':
> 
>                    0      cpu/r031234/
> 
>          1.001414935 seconds time elapsed
> 
> Multiple events with names:
> 
>   # ./perf stat -e cpu/rf01234,name=aaa/,cpu/r031234,name=bbb/ -a -- sleep 1
>   WARNING: event 'aaa' not valid (bits 20 22 of config 'f01234' not supported by kernel)!
>   WARNING: event 'bbb' not valid (bits 16 17 of config '31234' not supported by kernel)!
> 
>    Performance counter stats for 'system wide':
> 
>                    0      aaa
>                   36      bbb
> 
>          1.001565999 seconds time elapsed
> 
> Warning is reported for invalid bits.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/parse-events.c |  3 +++
>  tools/perf/util/pmu.c          | 46 ++++++++++++++++++++++++++++++++++
>  tools/perf/util/pmu.h          |  3 +++
>  3 files changed, 52 insertions(+)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 42c84adeb2fb..c0c0fab22cb8 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -356,6 +356,9 @@ __add_event(struct list_head *list, int *idx,
>  	struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
>  			       cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
>  
> +	if (pmu && attr->type == PERF_TYPE_RAW)
> +		perf_pmu__warn_invalid_config(pmu, attr->config, name);
> +
>  	if (init_attr)
>  		event_attr_init(attr);
>  
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 44ef28302fc7..31e975b75766 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1812,3 +1812,49 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>  
>  	return nr_caps;
>  }
> +
> +void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
> +				   char *name)
> +{
> +	struct perf_pmu_format *format;
> +	__u64 masks = 0, bits;
> +	struct strbuf buf = STRBUF_INIT;
> +	unsigned int i;
> +
> +	list_for_each_entry(format, &pmu->format, list)	{
> +		/*
> +		 * Skip extra configs such as config1/config2.
> +		 */
> +		if (format->value > 0)
> +			continue;
> +
> +		for_each_set_bit(i, format->bits, PERF_PMU_FORMAT_BITS)
> +			masks |= 1ULL << i;
> +	}
> +
> +	/*
> +	 * Kernel doesn't export any valid format bits.
> +	 */
> +	if (masks == 0)
> +		goto out;
> +
> +	bits = config & ~masks;
> +	if (bits == 0)
> +		goto out;
> +
> +	for_each_set_bit(i, (unsigned long *)&bits, sizeof(bits) * 8)
> +		strbuf_addf(&buf, " %d", i);
> +
> +	if (name) {
> +		pr_warning("WARNING: event '%s' not valid (bits%s of config "
> +			   "'%llx' not supported by kernel)!\n",
> +			   name, buf.buf, config);
> +	} else {
> +		pr_warning("WARNING: event not valid (bits%s of config "
> +			   "'%llx' not supported by kernel)!\n",
> +			   buf.buf, config);
> +	}
> +
> +out:
> +	strbuf_release(&buf);
> +}

actualy we do have bitmap_scnprintf, which is already doing the
printing in a nice way.. we could use it like below, only compile
tested

jirka


---
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 31e975b75766..37ca5eee2667 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1818,7 +1818,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 {
 	struct perf_pmu_format *format;
 	__u64 masks = 0, bits;
-	struct strbuf buf = STRBUF_INIT;
+	char buf[50];
 	unsigned int i;
 
 	list_for_each_entry(format, &pmu->format, list)	{
@@ -1836,25 +1836,15 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 	 * Kernel doesn't export any valid format bits.
 	 */
 	if (masks == 0)
-		goto out;
+		return;
 
 	bits = config & ~masks;
 	if (bits == 0)
-		goto out;
-
-	for_each_set_bit(i, (unsigned long *)&bits, sizeof(bits) * 8)
-		strbuf_addf(&buf, " %d", i);
+		return;
 
-	if (name) {
-		pr_warning("WARNING: event '%s' not valid (bits%s of config "
-			   "'%llx' not supported by kernel)!\n",
-			   name, buf.buf, config);
-	} else {
-		pr_warning("WARNING: event not valid (bits%s of config "
-			   "'%llx' not supported by kernel)!\n",
-			   buf.buf, config);
-	}
+	bitmap_scnprintf((unsigned long *)&bits, sizeof(bits) * 8, buf, sizeof(buf));
 
-out:
-	strbuf_release(&buf);
+	pr_warning("WARNING: event '%s' not valid (bits%s of config "
+		   "'%llx' not supported by kernel)!\n",
+		   name ?: "N/A", buf, config);
 }

