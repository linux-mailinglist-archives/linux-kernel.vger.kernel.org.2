Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A18033D3DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhCPMaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:30:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:7989 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231656AbhCPM3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:29:48 -0400
IronPort-SDR: Kbm6jhEhgk6yzAK1bvJMiPim7XslRPZJOSskL24KuzbS+o0TXoF03DoW/K8e6mhb0ZI0dyRKWI
 loS/5Vg73mYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="169164947"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="169164947"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 05:29:46 -0700
IronPort-SDR: ONTErTsvWDqLrhoV1VLP4aaLcGy1bIARRUEUIsr7XGm8Am9Ar0FArzgWn8wlJx16g6b2gdaDgM
 3dQQpzOp17Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="601812044"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2021 05:29:46 -0700
Received: from [10.254.95.225] (kliang2-MOBL.ccr.corp.intel.com [10.254.95.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 939FF5807EA;
        Tue, 16 Mar 2021 05:29:45 -0700 (PDT)
Subject: Re: [PATCH 1/5] perf/x86/intel/uncore: Parse uncore discovery tables
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com
References: <1615566878-70244-1-git-send-email-kan.liang@linux.intel.com>
 <1615566878-70244-2-git-send-email-kan.liang@linux.intel.com>
 <YFCZEesJdSJsaxQh@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <23df70de-e63c-e64d-bc6e-2b4608911c29@linux.intel.com>
Date:   Tue, 16 Mar 2021 08:29:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFCZEesJdSJsaxQh@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2021 7:40 AM, Peter Zijlstra wrote:
> On Fri, Mar 12, 2021 at 08:34:34AM -0800, kan.liang@linux.intel.com wrote:
>> +static struct intel_uncore_discovery_type *
>> +search_uncore_discovery_type(u16 type_id)
>> +{
>> +	struct rb_node *node = discovery_tables.rb_node;
>> +	struct intel_uncore_discovery_type *type;
>> +
>> +	while (node) {
>> +		type = rb_entry(node, struct intel_uncore_discovery_type, node);
>> +
>> +		if (type->type > type_id)
>> +			node = node->rb_left;
>> +		else if (type->type < type_id)
>> +			node = node->rb_right;
>> +		else
>> +			return type;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static struct intel_uncore_discovery_type *
>> +add_uncore_discovery_type(struct uncore_unit_discovery *unit)
>> +{
>> +	struct intel_uncore_discovery_type *type, *cur;
>> +	struct rb_node **node = &discovery_tables.rb_node;
>> +	struct rb_node *parent = *node;
>> +
>> +	if (unit->access_type >= UNCORE_ACCESS_MAX) {
>> +		pr_warn("Unsupported access type %d\n", unit->access_type);
>> +		return NULL;
>> +	}
>> +
>> +	type = kzalloc(sizeof(struct intel_uncore_discovery_type), GFP_KERNEL);
>> +	if (!type)
>> +		return NULL;
>> +
>> +	type->box_ctrl_die = kcalloc(__uncore_max_dies, sizeof(u64), GFP_KERNEL);
>> +	if (!type->box_ctrl_die)
>> +		goto free_type;
>> +
>> +	type->access_type = unit->access_type;
>> +	num_discovered_types[type->access_type]++;
>> +	type->type = unit->box_type;
>> +
>> +	while (*node) {
>> +		parent = *node;
>> +		cur = rb_entry(parent, struct intel_uncore_discovery_type, node);
>> +
>> +		if (cur->type > type->type)
>> +			node = &parent->rb_left;
>> +		else
>> +			node = &parent->rb_right;
>> +	}
>> +
>> +	rb_link_node(&type->node, parent, node);
>> +	rb_insert_color(&type->node, &discovery_tables);
>> +
>> +	return type;
>> +
>> +free_type:
>> +	kfree(type);
>> +
>> +	return NULL;
>> +
>> +}
> 
> I'm thinking this can use some of this:
> 
>    2d24dd5798d0 ("rbtree: Add generic add and find helpers")
> 

Sure, I will use the generic rbtree framework in V2.

Thanks,
Kan
