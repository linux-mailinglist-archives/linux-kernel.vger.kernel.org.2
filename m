Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533683119B2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhBFDQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:16:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230206AbhBFCdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612578691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TMLLiiXlekZ69dnRkThVGErl0XxjrQAWy5GuWYc9Jr0=;
        b=RjrNQn4u7v+bTUusfcIrpkSwkwAj8CMvRVa3SB0K5jG8bA52v3li2p8CwVBggTCaLsyaBJ
        yi8S9aMeGyEIdfEViV0wLPaiyXUcYdUXrSMngbHCfN+sfWCxGTfzIPeFOEOCGLFbJ+2HVv
        Tzm3hYyQi4HgS5e6CBM1sIQgrXRvCu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-40_f3PNtPfO6pDG2ntpQvg-1; Fri, 05 Feb 2021 21:31:29 -0500
X-MC-Unique: 40_f3PNtPfO6pDG2ntpQvg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D8368030C1;
        Sat,  6 Feb 2021 02:31:27 +0000 (UTC)
Received: from treble (ovpn-112-217.rdu2.redhat.com [10.10.112.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B965110074FC;
        Sat,  6 Feb 2021 02:31:25 +0000 (UTC)
Date:   Fri, 5 Feb 2021 20:31:22 -0600
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
Message-ID: <20210206023122.ijbihwpzrcxzhi52@treble>
References: <YBFODfNZCjA9s0IP@hirez.programming.kicks-ass.net>
 <20210127155914.jfmr4jay47yck5h5@treble>
 <YBGSdtnKIL3kryos@hirez.programming.kicks-ass.net>
 <20210127163308.cgiq7jxx2uziuhcc@treble>
 <YBG0cSoJmu8NnoAT@hirez.programming.kicks-ass.net>
 <20210127190003.64rdwoxyjgnq2rtx@treble>
 <20210127190218.hoztl7eidujqarkt@treble>
 <20210127231837.ifddpn7rhwdaepiu@treble>
 <YBqtZwIbj6kQEiEd@hirez.programming.kicks-ass.net>
 <YB1ksCPhD40f0VQn@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YB1ksCPhD40f0VQn@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 04:30:56PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 03, 2021 at 03:04:23PM +0100, Peter Zijlstra wrote:
> > Fair enough I suppose. I'll slap a changelog and your SoB on it and I
> > suppose I'll got commit the whole lot. Then we can forget about it
> > again.
> 
> FWIW, the whole thing looks like this..
> 
> ---
> Subject: static_call: Allow module use without exposing static_call_key
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Date: Wed, 27 Jan 2021 17:18:37 -0600
> 
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> When exporting static_call_key; with EXPORT_STATIC_CALL*(), the module
> can use static_call_update() to change the function called.  This is
> not desirable in general.

Looks good to me, thanks for fixing that up.  Never said I tested it ;-)

-- 
Josh

