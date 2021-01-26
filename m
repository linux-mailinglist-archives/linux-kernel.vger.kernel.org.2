Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80D33054D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbhA0HjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 02:39:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S317395AbhAZX7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 18:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611705459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DgYCm5LRv1NPdeJScUNjYJ2RTPp1m9xkwKZ4+YWOHrI=;
        b=GaOv3tPTMN4NzxOeyOFDXKbGApcjnbwtmd+8SmYPXMetuFar2TnDend6+lIKK7cRmIsz38
        6kNkneC4pxPeNWBFNOlZwpE0JrWz4LW9R+0gTbmZw1HO0Q7HQGMecLl6NHL5slDDZ7guWs
        Sr88yEMnuj+GrfTgKQ5neDB+6I4964k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-h7S2Tv7UOzyWBDSxOLSbmg-1; Tue, 26 Jan 2021 18:57:35 -0500
X-MC-Unique: h7S2Tv7UOzyWBDSxOLSbmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FA6C59;
        Tue, 26 Jan 2021 23:57:33 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D65CE1A266;
        Tue, 26 Jan 2021 23:57:31 +0000 (UTC)
Date:   Tue, 26 Jan 2021 17:57:30 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        rostedt@goodmis.org, jbaron@akamai.com, ardb@kernel.org
Subject: Re: [RFC PATCH 6/8] preempt/dynamic: Provide
 preempt_schedule[_notrace]() static calls
Message-ID: <20210126235730.lgfa2uida5se5urn@treble>
References: <20210118141223.123667-1-frederic@kernel.org>
 <20210118141223.123667-7-frederic@kernel.org>
 <20210122165226.GD16371@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210122165226.GD16371@worktop.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 05:52:26PM +0100, Peter Zijlstra wrote:
>  static int static_call_add_module(struct module *mod)
>  {
> -	return __static_call_init(mod, mod->static_call_sites,
> -				  mod->static_call_sites + mod->num_static_call_sites);
> +	struct static_call_site *start = mod->static_call_sites;
> +	struct static_call_site *stop = start + mod->num_static_call_sites;
> +	struct static_call_site *site;
> +
> +	for (site = start; site != stop; site++) {
> +		unsigned long addr = (unsigned long)static_call_key(site);
> +		struct static_call_ass *ass;
> +
> +		/*
> +		 * Gotta fix up the keys that point to the trampoline.
> +		 */
> +		if (!kernel_text_address(addr))
> +			continue;
> +
> +		ass = static_call_find_ass(addr);
> +		if (!ass) {
> +			pr_warn("Failed to fixup __raw_static_call() usage at: %ps\n",
> +				static_call_addr(site));
> +			return -EINVAL;
> +		}
> +		site->key = ((unsigned long)ass->key - (unsigned long)&site->key) |
> +			    (site->key & STATIC_CALL_SITE_FLAGS);

Well, I hate it, but I'm not sure I have any better ideas.  It should be
possible to use kallsyms, instead of the rb-tree/register nonsense.  Not
sure about the performance impact though.  Might be a good reason to
speed up kallsyms!

Also I do have some naming suggestions ;-)

-- 
Josh

