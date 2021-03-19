Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7700A341E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 14:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhCSN3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 09:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhCSN2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:28:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E99C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B5strBRQyFzpOM3Wfz4RudrNE2GXbdGvk/1wSsxmA+s=; b=b93A2ByPQOVshceyHxloFkx4Fn
        myphYVP9asJ7bPrcHfOj5Pbps1lRjSTIc/VcRbG2Nzh8WpttpFPL+mNs8sfWenyUMuAsm24hiF0II
        wu0RTWRMnhiUcSD5no9ssuEqnGh10YpnJzL4rOFuNhcJ1x4+KS+M1Z90ML4+rSWfCuSimF9o36GqL
        bJ35Bsj9dyUmCz4767pGkgB+wozDy/5MP3ydadngAb/klBVjrB9J6qK8lGwqMVgZzgWZAu66h8qFq
        LMEqa80ZBVG5RLGVDakNar5C4jlRf0xRPqR/GsPeW1hwx57DDJxBlBm0xiZK6EQLlgaaJEXOSeWdw
        0uGoEUeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNFAf-004Rwr-Dr; Fri, 19 Mar 2021 13:28:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF4033003E1;
        Fri, 19 Mar 2021 14:28:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C93E82846DE2D; Fri, 19 Mar 2021 14:28:07 +0100 (CET)
Date:   Fri, 19 Mar 2021 14:28:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/14] objtool: Allow archs to rewrite retpolines
Message-ID: <YFSm55W64AcBki+1@hirez.programming.kicks-ass.net>
References: <20210318171103.577093939@infradead.org>
 <20210318171920.131630843@infradead.org>
 <20210319025440.ah5kr7aztz4jbzer@treble>
 <YFSJH0/wiHLkteLw@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFSJH0/wiHLkteLw@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 12:21:03PM +0100, Peter Zijlstra wrote:
> Let me see if I can come up with something better.

Duh, we can put the instructions on a list and process them later, just
like static_call, can even use the same insn list_head since a retpoline
cannot be a static call.

Lemme go make that happen.
