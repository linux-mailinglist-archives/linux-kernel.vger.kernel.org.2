Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93573404DF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhCRLnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhCRLmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:42:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2003BC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XMl5tyzL3PqSIQHKGXY+NHohD9Yw2kJOC+D+1or4eto=; b=PlixEdAi+QREJcHN8mEPclgVNy
        NP97hxzYi12WqQFJ1W+bGBKYAg6Evo7BE1C2pNn5nwnj+2ioELwIGNytYD7GKGbeD5a6p1EDJ9mOJ
        SUhmiQkcgHYnxFCt9LlwsV4+r9FuJZXY31iBJAKXSIj3QDPByZBjY4TAhZKGu++gPVregJlA7et92
        jvUe0dfh/Vt4gctxCodTvYaIrE04kTAyWTjKzwWQt0C5ZJewu3f+ZqFKHlXirA3xJ2QSSmWZROsvj
        sHmvKRpNZdlqy7jTnkzhPlx0r4pg3qLGc39mB/OGJccJiuUVlI/l4DEqAdujdJS8KP+9e4sMAqy3S
        ZByYGi9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMr2o-0057l4-IS; Thu, 18 Mar 2021 11:42:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0C5B83006E0;
        Thu, 18 Mar 2021 12:42:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F20BA201960CD; Thu, 18 Mar 2021 12:42:25 +0100 (CET)
Date:   Thu, 18 Mar 2021 12:42:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, sumit.garg@linaro.org,
        oliver.sang@intel.com, jarkko@kernel.org
Subject: Re: [PATCH 3/3] static_call: Fix static_call_update() sanity check
Message-ID: <YFM8oZ5PJz8Mfl3k@hirez.programming.kicks-ass.net>
References: <20210318113156.407406787@infradead.org>
 <20210318113610.739542434@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318113610.739542434@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 12:31:59PM +0100, Peter Zijlstra wrote:
> Sites that match init_section_contains() get marked as INIT. For
> built-in code init_sections contains both __init and __exit text. OTOH
> kernel_text_address() only explicitly includes __init text (and there
> are no __exit text markers).
> 
> Match what jump_label already does and ignore the warning for INIT
> sites. Also see the excellent changelog for commit: 8f35eaa5f2de
> ("jump_label: Don't warn on __exit jump entries")

Note that I initially had a different fix and thought jump_label was
broken for not patching, but then found the above commit.

