Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8A2341D95
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhCSM64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhCSM6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:58:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BF7C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 05:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uKLSFVK4/FVoE33LX9TEzOYj6GuTaONNt/jzVlHJ8zQ=; b=rnEBj6oIHWoBHTxeDus3fJueSL
        6LaBATWqTjP8FVl5w83nTFsAtg8JkHDvR0pdRSmhyv4qycjZ8BUa51CcUaV1Tf38HFfGv+JF9ojob
        C9yATU1BZZW8Qqhwuc3eIWUvPD2ftIhXUKnYNU2+i8B40liaZ6I2UhU+RNjK1k/2xsgQQJ4K7UvZM
        BOaHZ4qcGxY4LeeCe3eWmg2Vn07RBU3sQ0ptw07w93gqnTUsPCD9oCczHeKAbWphCgghyP0/EbXPR
        YLpfpH9bftPwZAEszP76STYY+UBH9dBwnTbW6E+a8vVoClQRPCzx5DGL9CaXtp+BQ7Sethy7VP1Dy
        Vpi21zMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNEhA-004QG5-6D; Fri, 19 Mar 2021 12:57:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 216D83006E0;
        Fri, 19 Mar 2021 13:57:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F416721244620; Fri, 19 Mar 2021 13:57:38 +0100 (CET)
Date:   Fri, 19 Mar 2021 13:57:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org,
        jeyu@kernel.org
Subject: Re: [PATCH 3/3] static_call: Fix static_call_update() sanity check
Message-ID: <YFSfwimq/VLmo1Lw@hirez.programming.kicks-ass.net>
References: <20210318113156.407406787@infradead.org>
 <20210318113610.739542434@infradead.org>
 <20210318161308.vu3dhezp2lczch6f@treble>
 <YFOGvmWiJUDOHy7D@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFOGvmWiJUDOHy7D@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 05:58:38PM +0100, Peter Zijlstra wrote:

> > For CONFIG_MODULE_UNLOAD, the code ends up in the normal text area, so
> > static_call_is_init() is false and kernel_text_address() is true.
> > 
> > For !CONFIG_MODULE_UNLOAD, the code gets discarded during module load,
> > so static_call_is_init() and kernel_text_address() are both false.  I
> > guess that will trigger a warning?
> 
> Oh gawd, more variants.
> 
> Afaict MODULE_UNLOAD, by virtue of that #ifdef in

!MODULE_UNLOAD (obv)

> rewrite_section_headers() won't even load the .exit sections. Afaict
> that will break: alterative, jump_label and static_call patching all in
> one go.

Jessica, can you explain how !MODULE_UNLOAD is supposed to work?
Alternatives, jump_labels and static_call all can have relocations into
__exit code. Not loading it at all would be BAD.

For alternatives all we really need it to discard it after init, for
jump_label and static_call we additinoally need to the code to identify
as init (ie, within_module_init() must return true for it).
