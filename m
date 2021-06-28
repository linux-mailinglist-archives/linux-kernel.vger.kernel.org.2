Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4F73B5D33
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 13:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhF1Lhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 07:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbhF1Lhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 07:37:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499C0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 04:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JMsHJSSbXaQYgBW3BFBIwAUGgAX3mrsrM7nhL0T/Drg=; b=Cxr7JzzN1bLRFrP8HzaMDHwHT5
        HgpNmCokRl2yfvhZok0m+XpK81eq8Zc/fzPjAizJR12BLobVBHAmX7FqWfnSbOSlpkg+jOPtK6NC3
        rpDAldsauwolMU7Wze2Bb9MYyZ3Tdd63eqCQPBm6RsNX4edXbzYMbszXlkThLhUVaaBPMUL+A/bU9
        gjcf0+BTmqr0vnzlO0udZQeOp55UufQoUlgS6avj00OzQxMYG+sgUTwHS+Gh/be1DnUNKGu5LvX6a
        LBVYaPCm4HUrk9w58p6Tf9V3qBlI+WJM9lYwk1gcJm9smS4PBnx6WraNPvmfdKmY8ruBdC10axHpn
        VYqvPehQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxpXX-00CXuz-3M; Mon, 28 Jun 2021 11:34:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9266030022B;
        Mon, 28 Jun 2021 13:34:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7947D203AAC61; Mon, 28 Jun 2021 13:34:58 +0200 (CEST)
Date:   Mon, 28 Jun 2021 13:34:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, mhiramat@kernel.org,
        davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kprobe/static_call: Restore missing
 static_call_text_reserved()
Message-ID: <YNmz4nvH84jzX1aB@hirez.programming.kicks-ass.net>
References: <20210628112409.233121975@infradead.org>
 <20210628113045.167127609@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628113045.167127609@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 01:24:12PM +0200, Peter Zijlstra wrote:
> Restore two hunks from commit 6333e8f73b83 ("static_call: Avoid
> kprobes on inline static_call()s") that went walkabout.
> 
> Fixes: 76d4acf22b48 ("Merge tag 'perf-kprobes-2020-12-14' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

FWIW, it was a royal pain in the arse to find that commit...
