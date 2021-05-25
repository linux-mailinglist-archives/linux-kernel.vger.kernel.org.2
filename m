Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D146538FB9E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhEYH03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhEYH02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:26:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F87C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oJ+LyIfFfdlRGrj5vPQjUWBkiQkQZGsj9FLRRkFHVrI=; b=gkvraN8TDleqKMatuxAkAVB5GK
        +WMwIUQ8Q32p3EBV4pMPdMuVbZA7ig/AxqRYCxBF3XgHwmLkp9Wf8Lt+yV/C1o6lHUh+rquMK2dE2
        U89A/q4ngI4J0e/CJNB1By2NSk/wseMKXeM9UbXqFIj+puclfxrM2QD+iDeEV4VFhiZUCLhp1Sijj
        VmjFDIQCewn/8g/6NM02ahDrlgWzqab7iRgTZ9voXI800CHAEVxqKUM8smCpz+Z4ZYdqnA4qL0Q/X
        ag+rqQmHUBPEfbwPPMcf+jLyZeZB3I3pQo2tdK7pBZ+p/u+ML9Ekkwr4PZwtao8FKU5AiKH4eEZ8U
        xCi3usww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llRQS-003EIt-8V; Tue, 25 May 2021 07:24:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE60830022A;
        Tue, 25 May 2021 09:24:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 93C933147B65C; Tue, 25 May 2021 09:24:24 +0200 (CEST)
Date:   Tue, 25 May 2021 09:24:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [BUGFIX PATCH -tip] x86/kprobes: Fix to call previous kprobe's
 fault handler
Message-ID: <YKymKDy0bQi5m7pE@hirez.programming.kicks-ass.net>
References: <162182673618.114649.7393137495689996180.stgit@devnote2>
 <20210524143045.87d7ba5830c9662c2c9862a3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524143045.87d7ba5830c9662c2c9862a3@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 02:30:45PM +0900, Masami Hiramatsu wrote:
> BTW, there is another discussion to remove user fault_handler from
> kprobes. In that case, this patch is not needed anymore.

Thanks for reminding me; I'm indeed still sitting on those patches, let
me post them again, they've been in my tree for months now without a
single robot complaint, I've just been to busy with other things to
pursue them :/

