Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108C031F0D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhBRULn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhBRUJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 15:09:38 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0A9C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:08:58 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gb24so2001990pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KBGnsiA79qijtgRc70Ns0sW999VVuZIKysmbTfXA4bw=;
        b=rnpWv4R4S2+W1HON1Mf57A9E6Vvo91WThaSfS3VQoU25Dibev4DY0NdxShlMkXOEFe
         HfonJ+I4EfdM94dhaNUb6OLuJGFbcb6Pl2hwRTdDD0c/qIgxo/sRlbDgjmWva2Bhltgz
         45tnwlUjg4JEyLdWpAihDyMRaHIqYrsXjy+8vo5BPQhZjLxdkKf0LdFwCZhjOzuoJAzv
         AG3V+CjwoAM1F1dDpN9nJ11ulJXrqRs7YHq9rPvEjeCgAYpMAd12sfgShOmYYM8MczPS
         lhGNvgJZP8tLrLEGtbqYP57EJe4beAtW9Cbqn+oti7/wz6XxeP+aUJ5HtVv5jOKFRJg7
         tWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KBGnsiA79qijtgRc70Ns0sW999VVuZIKysmbTfXA4bw=;
        b=pWlyV2eJqcqd+Gqoa+jlIckcnhWRybJlqfa/MTBQdr4KBwMryZh78Q2JrQ3eWDTJ13
         rxWHxeNDUaaHGwVlZQTu7jXpp6QuMPJBr982Z/WRSIzIJ+SI5ChyQq1eSBxDH5SbYmXJ
         JSA2W577v+J3OWgUpQx1uofjj6rixM4w8OUmiHjO70QHfvaKNDSf3ilAoMs23zkQBLXH
         Nc/rPQp2kS3/4UHvHqbF1MHk6gXCHSiDvnWDYfbxAPnnL+4UvRDU1giRiGtGFRkK9Uum
         +noahGePv/Pwp/BgxOUhq6K8xMgmQLMc5G+k2GJ0z/teJBqYQV00pSqT7Jd36/hEswkK
         aVKg==
X-Gm-Message-State: AOAM530IFx2ME0m1uXwQniu6LjptsP7lxPFeX9AB6ULIx54y10DF/vCL
        aETM+ovKkC/S7zV0MfvLFOjbrQ==
X-Google-Smtp-Source: ABdhPJwvyU/Q0J/wNWyVju8KUuYUJXSnY8OZY7IzdxUbwxmBYtPwYgla9gVQu5gLz4fJlwN7PibAQQ==
X-Received: by 2002:a17:90b:1bcf:: with SMTP id oa15mr5511074pjb.78.1613678937452;
        Thu, 18 Feb 2021 12:08:57 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id h5sm6669204pgv.87.2021.02.18.12.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 12:08:56 -0800 (PST)
Date:   Thu, 18 Feb 2021 13:08:54 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     acme@kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, leo.yan@linaro.org,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        john.garry@huawei.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Subject: Re: [PATCH v5] perf: cs-etm: update ETM metadata format
Message-ID: <20210218200854.GA3018315@xps15>
References: <20210202214040.32349-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202214040.32349-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 09:40:40PM +0000, Mike Leach wrote:
> The current fixed metadata version format (version 0), means that adding
> metadata parameter items renders files from a previous version of perf
> unreadable. Per CPU parameters appear in a fixed order, but there is no
> field to indicate the number of ETM parameters per CPU.
> 
> This patch updates the per CPU parameter blocks to include a NR_PARAMs
> value which indicates the number of parameters in the block.
> 
> The header version is incremented to 1. Fixed ordering is retained,
> new ETM parameters are added to the end of the list.
> 
> The reader code is updated to be able to read current version 0 files,
> For version 1, the reader will read the number of parameters in the
> per CPU block. This allows the reader to process older or newer files
> that may have different numbers of parameters than in use at the
> time perf was built.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Tested-by: Leo Yan <leo.yan@linaro.org>
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Please rebase this patch on 5.12-rc1 when it comes out and resend to Arnaldo.

Thanks,
Mathieu
 
> ---
> 
> Changes since v4
> 1. Syntax fixes suggested by Mathieu.
> 
> Changes since v3
> 1. Fixed index bug (Leo)
> 
> Changes since v2
> 1. Add error path print to improve --dump logging
> 2. Replace some hardcoded values with enum consts (Mathieu).
> 
> Changes since v1 (from Review by Leo):
> 1. Split printing routine into sub functions per version
> 2. Renamed NR_PARAMs to NR_TRC_PARAMs to emphasise use as count of trace
> related parameters, not total block parameter.
> 3. Misc other fixes.
> ---
>  tools/perf/arch/arm/util/cs-etm.c |   7 +-
>  tools/perf/util/cs-etm.c          | 235 ++++++++++++++++++++++++------
>  tools/perf/util/cs-etm.h          |  30 +++-
>  3 files changed, 223 insertions(+), 49 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index bd446aba64f7..b0470f2a955a 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -572,7 +572,7 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
>  				struct auxtrace_record *itr,
>  				struct perf_record_auxtrace_info *info)
>  {
> -	u32 increment;
> +	u32 increment, nr_trc_params;
>  	u64 magic;
>  	struct cs_etm_recording *ptr =
>  			container_of(itr, struct cs_etm_recording, itr);
> @@ -607,6 +607,7 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
>  
>  		/* How much space was used */
>  		increment = CS_ETMV4_PRIV_MAX;
> +		nr_trc_params = CS_ETMV4_PRIV_MAX - CS_ETMV4_TRCCONFIGR;
>  	} else {
>  		magic = __perf_cs_etmv3_magic;
>  		/* Get configuration register */
> @@ -624,11 +625,13 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
>  
>  		/* How much space was used */
>  		increment = CS_ETM_PRIV_MAX;
> +		nr_trc_params = CS_ETM_PRIV_MAX - CS_ETM_ETMCR;
>  	}
>  
>  	/* Build generic header portion */
>  	info->priv[*offset + CS_ETM_MAGIC] = magic;
>  	info->priv[*offset + CS_ETM_CPU] = cpu;
> +	info->priv[*offset + CS_ETM_NR_TRC_PARAMS] = nr_trc_params;
>  	/* Where the next CPU entry should start from */
>  	*offset += increment;
>  }
> @@ -674,7 +677,7 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
>  
>  	/* First fill out the session header */
>  	info->type = PERF_AUXTRACE_CS_ETM;
> -	info->priv[CS_HEADER_VERSION_0] = 0;
> +	info->priv[CS_HEADER_VERSION] = CS_HEADER_CURRENT_VERSION;
>  	info->priv[CS_PMU_TYPE_CPUS] = type << 32;
>  	info->priv[CS_PMU_TYPE_CPUS] |= nr_cpu;
>  	info->priv[CS_ETM_SNAPSHOT] = ptr->snapshot_mode;
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index a2a369e2fbb6..ee32d023e9bd 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2435,7 +2435,7 @@ static bool cs_etm__is_timeless_decoding(struct cs_etm_auxtrace *etm)
>  }
>  
>  static const char * const cs_etm_global_header_fmts[] = {
> -	[CS_HEADER_VERSION_0]	= "	Header version		       %llx\n",
> +	[CS_HEADER_VERSION]	= "	Header version		       %llx\n",
>  	[CS_PMU_TYPE_CPUS]	= "	PMU type/num cpus	       %llx\n",
>  	[CS_ETM_SNAPSHOT]	= "	Snapshot		       %llx\n",
>  };
> @@ -2443,6 +2443,7 @@ static const char * const cs_etm_global_header_fmts[] = {
>  static const char * const cs_etm_priv_fmts[] = {
>  	[CS_ETM_MAGIC]		= "	Magic number		       %llx\n",
>  	[CS_ETM_CPU]		= "	CPU			       %lld\n",
> +	[CS_ETM_NR_TRC_PARAMS]	= "	NR_TRC_PARAMS		       %llx\n",
>  	[CS_ETM_ETMCR]		= "	ETMCR			       %llx\n",
>  	[CS_ETM_ETMTRACEIDR]	= "	ETMTRACEIDR		       %llx\n",
>  	[CS_ETM_ETMCCER]	= "	ETMCCER			       %llx\n",
> @@ -2452,6 +2453,7 @@ static const char * const cs_etm_priv_fmts[] = {
>  static const char * const cs_etmv4_priv_fmts[] = {
>  	[CS_ETM_MAGIC]		= "	Magic number		       %llx\n",
>  	[CS_ETM_CPU]		= "	CPU			       %lld\n",
> +	[CS_ETM_NR_TRC_PARAMS]	= "	NR_TRC_PARAMS		       %llx\n",
>  	[CS_ETMV4_TRCCONFIGR]	= "	TRCCONFIGR		       %llx\n",
>  	[CS_ETMV4_TRCTRACEIDR]	= "	TRCTRACEIDR		       %llx\n",
>  	[CS_ETMV4_TRCIDR0]	= "	TRCIDR0			       %llx\n",
> @@ -2461,26 +2463,167 @@ static const char * const cs_etmv4_priv_fmts[] = {
>  	[CS_ETMV4_TRCAUTHSTATUS] = "	TRCAUTHSTATUS		       %llx\n",
>  };
>  
> -static void cs_etm__print_auxtrace_info(__u64 *val, int num)
> +static const char * const param_unk_fmt =
> +	"	Unknown parameter [%d]	       %llx\n";
> +static const char * const magic_unk_fmt =
> +	"	Magic number Unknown	       %llx\n";
> +
> +static int cs_etm__print_cpu_metadata_v0(__u64 *val, int *offset)
>  {
> -	int i, j, cpu = 0;
> +	int i = *offset, j, nr_params = 0, fmt_offset;
> +	__u64 magic;
>  
> -	for (i = 0; i < CS_HEADER_VERSION_0_MAX; i++)
> -		fprintf(stdout, cs_etm_global_header_fmts[i], val[i]);
> +	/* check magic value */
> +	magic = val[i + CS_ETM_MAGIC];
> +	if ((magic != __perf_cs_etmv3_magic) &&
> +	    (magic != __perf_cs_etmv4_magic)) {
> +		/* failure - note bad magic value */
> +		fprintf(stdout, magic_unk_fmt, magic);
> +		return -EINVAL;
> +	}
> +
> +	/* print common header block */
> +	fprintf(stdout, cs_etm_priv_fmts[CS_ETM_MAGIC], val[i++]);
> +	fprintf(stdout, cs_etm_priv_fmts[CS_ETM_CPU], val[i++]);
> +
> +	if (magic == __perf_cs_etmv3_magic) {
> +		nr_params = CS_ETM_NR_TRC_PARAMS_V0;
> +		fmt_offset = CS_ETM_ETMCR;
> +		/* after common block, offset format index past NR_PARAMS */
> +		for (j = fmt_offset; j < nr_params + fmt_offset; j++, i++)
> +			fprintf(stdout, cs_etm_priv_fmts[j], val[i]);
> +	} else if (magic == __perf_cs_etmv4_magic) {
> +		nr_params = CS_ETMV4_NR_TRC_PARAMS_V0;
> +		fmt_offset = CS_ETMV4_TRCCONFIGR;
> +		/* after common block, offset format index past NR_PARAMS */
> +		for (j = fmt_offset; j < nr_params + fmt_offset; j++, i++)
> +			fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
> +	}
> +	*offset = i;
> +	return 0;
> +}
> +
> +static int cs_etm__print_cpu_metadata_v1(__u64 *val, int *offset)
> +{
> +	int i = *offset, j, total_params = 0;
> +	__u64 magic;
> +
> +	magic = val[i + CS_ETM_MAGIC];
> +	/* total params to print is NR_PARAMS + common block size for v1 */
> +	total_params = val[i + CS_ETM_NR_TRC_PARAMS] + CS_ETM_COMMON_BLK_MAX_V1;
>  
> -	for (i = CS_HEADER_VERSION_0_MAX; cpu < num; cpu++) {
> -		if (val[i] == __perf_cs_etmv3_magic)
> -			for (j = 0; j < CS_ETM_PRIV_MAX; j++, i++)
> +	if (magic == __perf_cs_etmv3_magic) {
> +		for (j = 0; j < total_params; j++, i++) {
> +			/* if newer record - could be excess params */
> +			if (j >= CS_ETM_PRIV_MAX)
> +				fprintf(stdout, param_unk_fmt, j, val[i]);
> +			else
>  				fprintf(stdout, cs_etm_priv_fmts[j], val[i]);
> -		else if (val[i] == __perf_cs_etmv4_magic)
> -			for (j = 0; j < CS_ETMV4_PRIV_MAX; j++, i++)
> +		}
> +	} else if (magic == __perf_cs_etmv4_magic) {
> +		for (j = 0; j < total_params; j++, i++) {
> +			/* if newer record - could be excess params */
> +			if (j >= CS_ETMV4_PRIV_MAX)
> +				fprintf(stdout, param_unk_fmt, j, val[i]);
> +			else
>  				fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
> -		else
> -			/* failure.. return */
> +		}
> +	} else {
> +		/* failure - note bad magic value and error out */
> +		fprintf(stdout, magic_unk_fmt, magic);
> +		return -EINVAL;
> +	}
> +	*offset = i;
> +	return 0;
> +}
> +
> +static void cs_etm__print_auxtrace_info(__u64 *val, int num)
> +{
> +	int i, cpu = 0, version, err;
> +
> +	/* bail out early on bad header version */
> +	version = val[0];
> +	if (version > CS_HEADER_CURRENT_VERSION) {
> +		/* failure.. return */
> +		fprintf(stdout, "	Unknown Header Version = %x, ", version);
> +		fprintf(stdout, "Version supported <= %x\n", CS_HEADER_CURRENT_VERSION);
> +		return;
> +	}
> +
> +	for (i = 0; i < CS_HEADER_VERSION_MAX; i++)
> +		fprintf(stdout, cs_etm_global_header_fmts[i], val[i]);
> +
> +	for (i = CS_HEADER_VERSION_MAX; cpu < num; cpu++) {
> +		if (version == 0)
> +			err = cs_etm__print_cpu_metadata_v0(val, &i);
> +		else if (version == 1)
> +			err = cs_etm__print_cpu_metadata_v1(val, &i);
> +		if (err)
>  			return;
>  	}
>  }
>  
> +/*
> + * Read a single cpu parameter block from the auxtrace_info priv block.
> + *
> + * For version 1 there is a per cpu nr_params entry. If we are handling
> + * version 1 file, then there may be less, the same, or more params
> + * indicated by this value than the compile time number we understand.
> + *
> + * For a version 0 info block, there are a fixed number, and we need to
> + * fill out the nr_param value in the metadata we create.
> + */
> +static u64 *cs_etm__create_meta_blk(u64 *buff_in, int *buff_in_offset,
> +				    int out_blk_size, int nr_params_v0)
> +{
> +	u64 *metadata = NULL;
> +	int hdr_version;
> +	int nr_in_params, nr_out_params, nr_cmn_params;
> +	int i, k;
> +
> +	metadata = zalloc(sizeof(*metadata) * out_blk_size);
> +	if (!metadata)
> +		return NULL;
> +
> +	/* read block current index & version */
> +	i = *buff_in_offset;
> +	hdr_version = buff_in[CS_HEADER_VERSION];
> +
> +	if (!hdr_version) {
> +	/* read version 0 info block into a version 1 metadata block  */
> +		nr_in_params = nr_params_v0;
> +		metadata[CS_ETM_MAGIC] = buff_in[i + CS_ETM_MAGIC];
> +		metadata[CS_ETM_CPU] = buff_in[i + CS_ETM_CPU];
> +		metadata[CS_ETM_NR_TRC_PARAMS] = nr_in_params;
> +		/* remaining block params at offset +1 from source */
> +		for (k = CS_ETM_COMMON_BLK_MAX_V1 - 1; k < nr_in_params; k++)
> +			metadata[k + 1] = buff_in[i + k];
> +		/* version 0 has 2 common params */
> +		nr_cmn_params = 2;
> +	} else {
> +	/* read version 1 info block - input and output nr_params may differ */
> +		/* version 1 has 3 common params */
> +		nr_cmn_params = 3;
> +		nr_in_params = buff_in[i + CS_ETM_NR_TRC_PARAMS];
> +
> +		/* if input has more params than output - skip excess */
> +		nr_out_params = nr_in_params + nr_cmn_params;
> +		if (nr_out_params > out_blk_size)
> +			nr_out_params = out_blk_size;
> +
> +		for (k = CS_ETM_MAGIC; k < nr_out_params; k++)
> +			metadata[k] = buff_in[i + k];
> +
> +		/* record the actual nr params we copied */
> +		metadata[CS_ETM_NR_TRC_PARAMS] = nr_out_params - nr_cmn_params;
> +	}
> +
> +	/* adjust in offset by number of in params used */
> +	i += nr_in_params + nr_cmn_params;
> +	*buff_in_offset = i;
> +	return metadata;
> +}
> +
>  int cs_etm__process_auxtrace_info(union perf_event *event,
>  				  struct perf_session *session)
>  {
> @@ -2492,11 +2635,12 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  	int info_header_size;
>  	int total_size = auxtrace_info->header.size;
>  	int priv_size = 0;
> -	int num_cpu;
> -	int err = 0, idx = -1;
> -	int i, j, k;
> +	int num_cpu, trcidr_idx;
> +	int err = 0;
> +	int i, j;
>  	u64 *ptr, *hdr = NULL;
>  	u64 **metadata = NULL;
> +	u64 hdr_version;
>  
>  	/*
>  	 * sizeof(auxtrace_info_event::type) +
> @@ -2512,16 +2656,21 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  	/* First the global part */
>  	ptr = (u64 *) auxtrace_info->priv;
>  
> -	/* Look for version '0' of the header */
> -	if (ptr[0] != 0)
> +	/* Look for version of the header */
> +	hdr_version = ptr[0];
> +	if (hdr_version > CS_HEADER_CURRENT_VERSION) {
> +		/* print routine will print an error on bad version */
> +		if (dump_trace)
> +			cs_etm__print_auxtrace_info(auxtrace_info->priv, 0);
>  		return -EINVAL;
> +	}
>  
> -	hdr = zalloc(sizeof(*hdr) * CS_HEADER_VERSION_0_MAX);
> +	hdr = zalloc(sizeof(*hdr) * CS_HEADER_VERSION_MAX);
>  	if (!hdr)
>  		return -ENOMEM;
>  
>  	/* Extract header information - see cs-etm.h for format */
> -	for (i = 0; i < CS_HEADER_VERSION_0_MAX; i++)
> +	for (i = 0; i < CS_HEADER_VERSION_MAX; i++)
>  		hdr[i] = ptr[i];
>  	num_cpu = hdr[CS_PMU_TYPE_CPUS] & 0xffffffff;
>  	pmu_type = (unsigned int) ((hdr[CS_PMU_TYPE_CPUS] >> 32) &
> @@ -2552,35 +2701,31 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  	 */
>  	for (j = 0; j < num_cpu; j++) {
>  		if (ptr[i] == __perf_cs_etmv3_magic) {
> -			metadata[j] = zalloc(sizeof(*metadata[j]) *
> -					     CS_ETM_PRIV_MAX);
> -			if (!metadata[j]) {
> -				err = -ENOMEM;
> -				goto err_free_metadata;
> -			}
> -			for (k = 0; k < CS_ETM_PRIV_MAX; k++)
> -				metadata[j][k] = ptr[i + k];
> +			metadata[j] =
> +				cs_etm__create_meta_blk(ptr, &i,
> +							CS_ETM_PRIV_MAX,
> +							CS_ETM_NR_TRC_PARAMS_V0);
>  
>  			/* The traceID is our handle */
> -			idx = metadata[j][CS_ETM_ETMTRACEIDR];
> -			i += CS_ETM_PRIV_MAX;
> +			trcidr_idx = CS_ETM_ETMTRACEIDR;
> +
>  		} else if (ptr[i] == __perf_cs_etmv4_magic) {
> -			metadata[j] = zalloc(sizeof(*metadata[j]) *
> -					     CS_ETMV4_PRIV_MAX);
> -			if (!metadata[j]) {
> -				err = -ENOMEM;
> -				goto err_free_metadata;
> -			}
> -			for (k = 0; k < CS_ETMV4_PRIV_MAX; k++)
> -				metadata[j][k] = ptr[i + k];
> +			metadata[j] =
> +				cs_etm__create_meta_blk(ptr, &i,
> +							CS_ETMV4_PRIV_MAX,
> +							CS_ETMV4_NR_TRC_PARAMS_V0);
>  
>  			/* The traceID is our handle */
> -			idx = metadata[j][CS_ETMV4_TRCTRACEIDR];
> -			i += CS_ETMV4_PRIV_MAX;
> +			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
> +		}
> +
> +		if (!metadata[j]) {
> +			err = -ENOMEM;
> +			goto err_free_metadata;
>  		}
>  
>  		/* Get an RB node for this CPU */
> -		inode = intlist__findnew(traceid_list, idx);
> +		inode = intlist__findnew(traceid_list, metadata[j][trcidr_idx]);
>  
>  		/* Something went wrong, no need to continue */
>  		if (!inode) {
> @@ -2601,7 +2746,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  	}
>  
>  	/*
> -	 * Each of CS_HEADER_VERSION_0_MAX, CS_ETM_PRIV_MAX and
> +	 * Each of CS_HEADER_VERSION_MAX, CS_ETM_PRIV_MAX and
>  	 * CS_ETMV4_PRIV_MAX mark how many double words are in the
>  	 * global metadata, and each cpu's metadata respectively.
>  	 * The following tests if the correct number of double words was
> @@ -2703,6 +2848,12 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  	intlist__delete(traceid_list);
>  err_free_hdr:
>  	zfree(&hdr);
> -
> +	/*
> +	 * At this point, as a minimum we have valid header. Dump the rest of
> +	 * the info section - the print routines will error out on structural
> +	 * issues.
> +	 */
> +	if (dump_trace)
> +		cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
>  	return err;
>  }
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index 4ad925d6d799..e153d02df0de 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -17,23 +17,37 @@ struct perf_session;
>   */
>  enum {
>  	/* Starting with 0x0 */
> -	CS_HEADER_VERSION_0,
> +	CS_HEADER_VERSION,
>  	/* PMU->type (32 bit), total # of CPUs (32 bit) */
>  	CS_PMU_TYPE_CPUS,
>  	CS_ETM_SNAPSHOT,
> -	CS_HEADER_VERSION_0_MAX,
> +	CS_HEADER_VERSION_MAX,
>  };
>  
> +/*
> + * Update the version for new format.
> + *
> + * New version 1 format adds a param count to the per cpu metadata.
> + * This allows easy adding of new metadata parameters.
> + * Requires that new params always added after current ones.
> + * Also allows client reader to handle file versions that are different by
> + * checking the number of params in the file vs the number expected.
> + */
> +#define CS_HEADER_CURRENT_VERSION 1
> +
>  /* Beginning of header common to both ETMv3 and V4 */
>  enum {
>  	CS_ETM_MAGIC,
>  	CS_ETM_CPU,
> +	/* Number of trace config params in following ETM specific block */
> +	CS_ETM_NR_TRC_PARAMS,
> +	CS_ETM_COMMON_BLK_MAX_V1,
>  };
>  
>  /* ETMv3/PTM metadata */
>  enum {
>  	/* Dynamic, configurable parameters */
> -	CS_ETM_ETMCR = CS_ETM_CPU + 1,
> +	CS_ETM_ETMCR = CS_ETM_COMMON_BLK_MAX_V1,
>  	CS_ETM_ETMTRACEIDR,
>  	/* RO, taken from sysFS */
>  	CS_ETM_ETMCCER,
> @@ -41,10 +55,13 @@ enum {
>  	CS_ETM_PRIV_MAX,
>  };
>  
> +/* define fixed version 0 length - allow new format reader to read old files. */
> +#define CS_ETM_NR_TRC_PARAMS_V0 (CS_ETM_ETMIDR - CS_ETM_ETMCR + 1)
> +
>  /* ETMv4 metadata */
>  enum {
>  	/* Dynamic, configurable parameters */
> -	CS_ETMV4_TRCCONFIGR = CS_ETM_CPU + 1,
> +	CS_ETMV4_TRCCONFIGR = CS_ETM_COMMON_BLK_MAX_V1,
>  	CS_ETMV4_TRCTRACEIDR,
>  	/* RO, taken from sysFS */
>  	CS_ETMV4_TRCIDR0,
> @@ -55,6 +72,9 @@ enum {
>  	CS_ETMV4_PRIV_MAX,
>  };
>  
> +/* define fixed version 0 length - allow new format reader to read old files. */
> +#define CS_ETMV4_NR_TRC_PARAMS_V0 (CS_ETMV4_TRCAUTHSTATUS - CS_ETMV4_TRCCONFIGR + 1)
> +
>  /*
>   * ETMv3 exception encoding number:
>   * See Embedded Trace Macrocell spcification (ARM IHI 0014Q)
> @@ -162,7 +182,7 @@ struct cs_etm_packet_queue {
>  
>  #define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)
>  
> -#define CS_ETM_HEADER_SIZE (CS_HEADER_VERSION_0_MAX * sizeof(u64))
> +#define CS_ETM_HEADER_SIZE (CS_HEADER_VERSION_MAX * sizeof(u64))
>  
>  #define __perf_cs_etmv3_magic 0x3030303030303030ULL
>  #define __perf_cs_etmv4_magic 0x4040404040404040ULL
> -- 
> 2.17.1
> 
