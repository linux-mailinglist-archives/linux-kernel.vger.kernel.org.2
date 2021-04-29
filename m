Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B420E36EC80
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbhD2OkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232820AbhD2OkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:40:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60DC661446;
        Thu, 29 Apr 2021 14:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619707167;
        bh=Mh8dyfMC3818Shu7XLjNLUJFKWBWMg2lbNf10K7e91M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lhyr1yQJKkahTplcGu4TKSOknhpsBnXMOCTdoAEjefWCcqASnjPDlj9j0aPTjwca8
         raFqCc/PBknzybSC6eQyNFzj3Mo+iGFuyfIIMP9rTKKDBLXYdy/V/ZaP+NDcnAj9uW
         avoPyQIjNlKGc8HTaXyc6a4Quz1cjVOKSNSR5Ysq57Cf1Xb+IScc7Wj49UsKXnRhrk
         h7KudqlzMnChwEx0iZ121mU96j14t60A1rYyzQp7nA5yKclj9NOZlhSQWwKQlYyhgJ
         ZxIJibu6ON0bWh5IaAurwTQ2xiu7I49pueQn8XMIea6B2s244UB8xGEV+IjdKzR+FW
         mUAmxRn2mDIzQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9AC804034C; Thu, 29 Apr 2021 11:39:23 -0300 (-03)
Date:   Thu, 29 Apr 2021 11:39:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] perf intel-pt: Add a tree for VMCS information
Message-ID: <YIrFGzo819FMXnKL@kernel.org>
References: <20210429125854.13905-1-adrian.hunter@intel.com>
 <20210429125854.13905-9-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429125854.13905-9-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 29, 2021 at 03:58:50PM +0300, Adrian Hunter escreveu:
> Even when VMX TSC Offset is not changing (during perf record), different
> virtual machines can have different TSC Offsets. There is a Virtual Machine
> Control Structure (VMCS) for each virtual CPU, the address of which is
> reported to Intel PT in the VMCS packet. We do not know which VMCS belongs
> to which virtual machine, so use a tree to keep track of VMCS information.
> Then the decoder will be able to use the current VMCS value to look up the
> current TSC Offset.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  .../util/intel-pt-decoder/intel-pt-decoder.c  |  2 +
>  .../util/intel-pt-decoder/intel-pt-decoder.h  | 11 ++++
>  tools/perf/util/intel-pt.c                    | 66 +++++++++++++++++++
>  3 files changed, 79 insertions(+)
> 
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> index 8f916f90205e..8cbcb419c0d1 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> @@ -107,6 +107,7 @@ struct intel_pt_decoder {
>  			 uint64_t max_insn_cnt, void *data);
>  	bool (*pgd_ip)(uint64_t ip, void *data);
>  	int (*lookahead)(void *data, intel_pt_lookahead_cb_t cb, void *cb_data);
> +	struct intel_pt_vmcs_info *(*lookup_vmcs_info)(void *data, uint64_t vmcs);
>  	void *data;
>  	struct intel_pt_state state;
>  	const unsigned char *buf;
> @@ -258,6 +259,7 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
>  	decoder->walk_insn          = params->walk_insn;
>  	decoder->pgd_ip             = params->pgd_ip;
>  	decoder->lookahead          = params->lookahead;
> +	decoder->lookup_vmcs_info   = params->lookup_vmcs_info;
>  	decoder->data               = params->data;
>  	decoder->return_compression = params->return_compression;
>  	decoder->branch_enable      = params->branch_enable;
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
> index bebdb7d37b39..634dd4ac174a 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
> @@ -11,6 +11,8 @@
>  #include <stddef.h>
>  #include <stdbool.h>
>  
> +#include <linux/rbtree.h>
> +
>  #include "intel-pt-insn-decoder.h"
>  
>  #define INTEL_PT_IN_TX		(1 << 0)
> @@ -199,6 +201,14 @@ struct intel_pt_blk_items {
>  	bool is_32_bit;
>  };
>  
> +struct intel_pt_vmcs_info {
> +	struct rb_node rb_node;
> +	uint64_t vmcs;
> +	uint64_t tsc_offset;
> +	bool reliable;
> +	bool error_printed;
> +};
> +
>  struct intel_pt_state {
>  	enum intel_pt_sample_type type;
>  	bool from_nr;
> @@ -244,6 +254,7 @@ struct intel_pt_params {
>  			 uint64_t max_insn_cnt, void *data);
>  	bool (*pgd_ip)(uint64_t ip, void *data);
>  	int (*lookahead)(void *data, intel_pt_lookahead_cb_t cb, void *cb_data);
> +	struct intel_pt_vmcs_info *(*lookup_vmcs_info)(void *data, uint64_t vmcs);
>  	void *data;
>  	bool return_compression;
>  	bool branch_enable;
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index a494d47aa1ad..71e29a82a7cf 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -133,6 +133,9 @@ struct intel_pt {
>  
>  	struct ip_callchain *chain;
>  	struct branch_stack *br_stack;
> +
> +	u64 dflt_tsc_offset;
> +	struct rb_root vmcs_info;
>  };
>  
>  enum switch_state {
> @@ -271,6 +274,65 @@ static bool intel_pt_log_events(struct intel_pt *pt, u64 tm)
>  	return !n || !perf_time__ranges_skip_sample(range, n, tm);
>  }
>  
> +static struct intel_pt_vmcs_info *intel_pt_lookup_vmcs(struct rb_root *rb_root,
> +						       u64 vmcs,
> +						       u64 dflt_tsc_offset)
> +{

Elsewhere in tools/perf/ we use the __findnew() jargon for such "find
and if not present, create the new entry and add it", can we please use
it here as well?

> +	struct rb_node **p = &rb_root->rb_node;
> +	struct rb_node *parent = NULL;
> +	struct intel_pt_vmcs_info *v;
> +
> +	while (*p) {
> +		parent = *p;
> +		v = rb_entry(parent, struct intel_pt_vmcs_info, rb_node);
> +
> +		if (v->vmcs == vmcs)
> +			return v;
> +
> +		if (vmcs < v->vmcs)
> +			p = &(*p)->rb_left;
> +		else
> +			p = &(*p)->rb_right;
> +	}
> +
> +	v = zalloc(sizeof(*v));
> +	if (v) {
> +		v->vmcs = vmcs;
> +		v->tsc_offset = dflt_tsc_offset;
> +		v->reliable = dflt_tsc_offset;
> +
> +		rb_link_node(&v->rb_node, parent, p);
> +		rb_insert_color(&v->rb_node, rb_root);
> +	}
> +
> +	return v;
> +}

> +static struct intel_pt_vmcs_info *intel_pt_lookup_vmcs_info(void *data, uint64_t vmcs)
> +{
> +	struct intel_pt_queue *ptq = data;
> +	struct intel_pt *pt = ptq->pt;
> +
> +	if (!vmcs && !pt->dflt_tsc_offset)
> +		return NULL;
> +
> +	return intel_pt_lookup_vmcs(&pt->vmcs_info, vmcs, pt->dflt_tsc_offset);
> +}
> +
> +static void intel_pt_free_vmcs_info(struct intel_pt *pt)
> +{
> +	struct intel_pt_vmcs_info *v;
> +	struct rb_node *n;
> +
> +	n = rb_first(&pt->vmcs_info);
> +	while (n) {
> +		v = rb_entry(n, struct intel_pt_vmcs_info, rb_node);
> +		n = rb_next(n);
> +		rb_erase(&v->rb_node, &pt->vmcs_info);
> +		free(v);
> +	}
> +}
> +
>  static int intel_pt_do_fix_overlap(struct intel_pt *pt, struct auxtrace_buffer *a,
>  				   struct auxtrace_buffer *b)
>  {
> @@ -1109,6 +1171,7 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
>  	params.get_trace = intel_pt_get_trace;
>  	params.walk_insn = intel_pt_walk_next_insn;
>  	params.lookahead = intel_pt_lookahead;
> +	params.lookup_vmcs_info = intel_pt_lookup_vmcs_info;
>  	params.data = ptq;
>  	params.return_compression = intel_pt_return_compression(pt);
>  	params.branch_enable = intel_pt_branch_enable(pt);
> @@ -2970,6 +3033,7 @@ static void intel_pt_free(struct perf_session *session)
>  	auxtrace_heap__free(&pt->heap);
>  	intel_pt_free_events(session);
>  	session->auxtrace = NULL;
> +	intel_pt_free_vmcs_info(pt);
>  	thread__put(pt->unknown_thread);
>  	addr_filters__exit(&pt->filts);
>  	zfree(&pt->chain);
> @@ -3475,6 +3539,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>  	if (!pt)
>  		return -ENOMEM;
>  
> +	pt->vmcs_info = RB_ROOT;
> +
>  	addr_filters__init(&pt->filts);
>  
>  	err = perf_config(intel_pt_perf_config, pt);
> -- 
> 2.17.1
> 

-- 

- Arnaldo
