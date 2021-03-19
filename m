Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8AA3423E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhCSSAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230255AbhCSSAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:00:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 429986197F;
        Fri, 19 Mar 2021 18:00:07 +0000 (UTC)
Date:   Fri, 19 Mar 2021 14:00:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        jbaron@akamai.com, ardb@kernel.org, linux-kernel@vger.kernel.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org,
        jeyu@kernel.org
Subject: Re: [PATCH 3/3] static_call: Fix static_call_update() sanity check
Message-ID: <20210319140005.7ececb11@gandalf.local.home>
In-Reply-To: <YFSfwimq/VLmo1Lw@hirez.programming.kicks-ass.net>
References: <20210318113156.407406787@infradead.org>
        <20210318113610.739542434@infradead.org>
        <20210318161308.vu3dhezp2lczch6f@treble>
        <YFOGvmWiJUDOHy7D@hirez.programming.kicks-ass.net>
        <YFSfwimq/VLmo1Lw@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 13:57:38 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Jessica, can you explain how !MODULE_UNLOAD is supposed to work?
> Alternatives, jump_labels and static_call all can have relocations into
> __exit code. Not loading it at all would be BAD.

According to the description:

" Without this option you will not be able to unload any
  modules (note that some modules may not be unloadable anyway), which
  makes your kernel smaller, faster and simpler.
  If unsure, say Y."

Seems there's no reason to load the "exit" portion, as that's what makes it
"smaller".

Would making __exit code the same as init code work? That is, load it just
like module init code is loaded, and free it when the init code is freed
(hopefully keeping the kernel still "smaller, faster and simpler").


-- Steve

