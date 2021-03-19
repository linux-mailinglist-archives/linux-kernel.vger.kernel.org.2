Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5702934273F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 21:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCSU6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 16:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhCSU5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:57:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 945CA61919;
        Fri, 19 Mar 2021 20:57:51 +0000 (UTC)
Date:   Fri, 19 Mar 2021 16:57:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        jbaron@akamai.com, ardb@kernel.org, linux-kernel@vger.kernel.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org,
        jeyu@kernel.org
Subject: Re: [PATCH 3/3] static_call: Fix static_call_update() sanity check
Message-ID: <20210319165749.0f3c8281@gandalf.local.home>
In-Reply-To: <YFT8wDrWvfpQoIWw@hirez.programming.kicks-ass.net>
References: <20210318113156.407406787@infradead.org>
        <20210318113610.739542434@infradead.org>
        <20210318161308.vu3dhezp2lczch6f@treble>
        <YFOGvmWiJUDOHy7D@hirez.programming.kicks-ass.net>
        <YFSfwimq/VLmo1Lw@hirez.programming.kicks-ass.net>
        <20210319140005.7ececb11@gandalf.local.home>
        <YFT8wDrWvfpQoIWw@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 20:34:24 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Mar 19, 2021 at 02:00:05PM -0400, Steven Rostedt wrote:
> > Would making __exit code the same as init code work? That is, load it just
> > like module init code is loaded, and free it when the init code is freed  
> 
> As stated, yes. But it must then also identify as init through
> within_module_init().

I think that's doable. Since the usecases for that appear to be mostly
about "think code may no longer exist after it is used". Thus, having exit
code act just like init code when UNLOAD is not set, appears appropriate.

Jessica, please correct me if I'm wrong.

Thanks,

-- Steve
