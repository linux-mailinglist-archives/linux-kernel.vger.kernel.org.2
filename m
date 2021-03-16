Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED1D33D342
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbhCPLkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237392AbhCPLkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:40:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB539C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 04:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bTUJcGrn5E33KbHSPMj/OesZXrhNWuuNMWDtShWHOq0=; b=AsViUXDZomWYLu/b4MasjjMAqb
        WWoGG0O4nHmMkUO1KopwyDvvWul35LrrJJ+4SriJFA9Jz3rtLPLF2au2Hd9Db4AdTfVPMHNRljGVL
        YfB56Q4AT5K+4d55gB+aue2D19qyw6Sf9/HpYiKEhfByG5wYc8/vwTgiwfNV5QlvfOCGSaVtnb0Vx
        dkTp6pNBjgs4rwLeqm2GdLd5sGqkVsqeeUgwpQdq47px/zKMFw1yhcVF+CcZeql2tKsmFW379MUyt
        ashPXXz5dF3XdbPpRDliANYZZeSW2zXolVSAiXhY1+NUH+ge1//B6gr8iy6PCmg1Ao21F4MdYeEGB
        Op9mhXHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lM83R-000bNM-7n; Tue, 16 Mar 2021 11:40:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D4C14304D58;
        Tue, 16 Mar 2021 12:40:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BBF9820435CE8; Tue, 16 Mar 2021 12:40:01 +0100 (CET)
Date:   Tue, 16 Mar 2021 12:40:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 1/5] perf/x86/intel/uncore: Parse uncore discovery tables
Message-ID: <YFCZEesJdSJsaxQh@hirez.programming.kicks-ass.net>
References: <1615566878-70244-1-git-send-email-kan.liang@linux.intel.com>
 <1615566878-70244-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615566878-70244-2-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 08:34:34AM -0800, kan.liang@linux.intel.com wrote:
> +static struct intel_uncore_discovery_type *
> +search_uncore_discovery_type(u16 type_id)
> +{
> +	struct rb_node *node = discovery_tables.rb_node;
> +	struct intel_uncore_discovery_type *type;
> +
> +	while (node) {
> +		type = rb_entry(node, struct intel_uncore_discovery_type, node);
> +
> +		if (type->type > type_id)
> +			node = node->rb_left;
> +		else if (type->type < type_id)
> +			node = node->rb_right;
> +		else
> +			return type;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct intel_uncore_discovery_type *
> +add_uncore_discovery_type(struct uncore_unit_discovery *unit)
> +{
> +	struct intel_uncore_discovery_type *type, *cur;
> +	struct rb_node **node = &discovery_tables.rb_node;
> +	struct rb_node *parent = *node;
> +
> +	if (unit->access_type >= UNCORE_ACCESS_MAX) {
> +		pr_warn("Unsupported access type %d\n", unit->access_type);
> +		return NULL;
> +	}
> +
> +	type = kzalloc(sizeof(struct intel_uncore_discovery_type), GFP_KERNEL);
> +	if (!type)
> +		return NULL;
> +
> +	type->box_ctrl_die = kcalloc(__uncore_max_dies, sizeof(u64), GFP_KERNEL);
> +	if (!type->box_ctrl_die)
> +		goto free_type;
> +
> +	type->access_type = unit->access_type;
> +	num_discovered_types[type->access_type]++;
> +	type->type = unit->box_type;
> +
> +	while (*node) {
> +		parent = *node;
> +		cur = rb_entry(parent, struct intel_uncore_discovery_type, node);
> +
> +		if (cur->type > type->type)
> +			node = &parent->rb_left;
> +		else
> +			node = &parent->rb_right;
> +	}
> +
> +	rb_link_node(&type->node, parent, node);
> +	rb_insert_color(&type->node, &discovery_tables);
> +
> +	return type;
> +
> +free_type:
> +	kfree(type);
> +
> +	return NULL;
> +
> +}

I'm thinking this can use some of this:

  2d24dd5798d0 ("rbtree: Add generic add and find helpers")
