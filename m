Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D32344553
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhCVNQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:16:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233325AbhCVNIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:08:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91778601FF;
        Mon, 22 Mar 2021 13:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616418479;
        bh=qGVCe84YjHOqo7ar1lMMOlU6GzzioCkF4hOoYU0sLJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M6C9/3IYNPUizTchFvw+auywfWq30w+2b+iZfTJyR9dspjkGDLbTDIwxP6pUhsKNA
         yRz0Gp+ppLnYEwZyWO47oORcC63v7MvANSu++m+F7NGFa/tDizRhKiU2iDuG+a2oSu
         eUF5USMxUNU9+5nYqafMsUsM9IbMPJT8vTVJoFKqE7k8BcCRujHtYZv6CAu3aC8ety
         S5Pna6dRpcH2QhuoaVjDnDCgU85KeWX6LC4QGBCEO+1C1/Pg5JzOiwGIfxkD1C1DKn
         ZK4gBfS5gw1Cu0kfKwWru9dw/64/AF5E8/bG7H41zTf0jhLGIcWgmio/JBYbYkwqZK
         /ARbaB9stpEYA==
Date:   Mon, 22 Mar 2021 14:07:54 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        jbaron@akamai.com, ardb@kernel.org, linux-kernel@vger.kernel.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org
Subject: Re: [PATCH 3/3] static_call: Fix static_call_update() sanity check
Message-ID: <YFiWqvEsswDHBDPX@gunter>
References: <20210318113156.407406787@infradead.org>
 <20210318113610.739542434@infradead.org>
 <20210318161308.vu3dhezp2lczch6f@treble>
 <YFOGvmWiJUDOHy7D@hirez.programming.kicks-ass.net>
 <YFSfwimq/VLmo1Lw@hirez.programming.kicks-ass.net>
 <20210319140005.7ececb11@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210319140005.7ececb11@gandalf.local.home>
X-OS:   Linux gunter 5.11.2-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Steven Rostedt [19/03/21 14:00 -0400]:
>On Fri, 19 Mar 2021 13:57:38 +0100
>Peter Zijlstra <peterz@infradead.org> wrote:
>
>> Jessica, can you explain how !MODULE_UNLOAD is supposed to work?
>> Alternatives, jump_labels and static_call all can have relocations into
>> __exit code. Not loading it at all would be BAD.
>
>According to the description:
>
>" Without this option you will not be able to unload any
>  modules (note that some modules may not be unloadable anyway), which
>  makes your kernel smaller, faster and simpler.
>  If unsure, say Y."
>
>Seems there's no reason to load the "exit" portion, as that's what makes it
>"smaller".

Exactly. If you disable MODULE_UNLOAD, then you don't intend to ever
unload any modules, and so you'll never end up calling the module's
cleanup/exit function. That code would basically be never used, so
that's why it's not loaded in the first place.
