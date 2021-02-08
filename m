Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A62313AB4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 18:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhBHRTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 12:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhBHP0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:26:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86589C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 07:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x5UbF+te/cQIVuHKZWDvcWmhKTo4cjeLAYLOlS/MEVQ=; b=dfVGvTyFl76Cmq+Q9dh3depEKl
        S/4Cc2J7DGKaVLtIKhhcXyeNTLtAXroMCtxRpa9fubwgJqRU43FtFV6tcl+BNXBQlIyKRXZthsosy
        x2bpOLGhr3cov1IEaZZgwi2X7Ajsh/9rLoyO2/aHvtii0iUnT/ir4eInGwuIvO49WFnmjlsK95WE/
        JdfOn1yH/bQqe+j8/68Cvl631HLrwVUrNkOs0K+4HvRSPm1ykg9XctIzE6ZGdwEFtNLgfIiy77N7F
        s5IruDgDpN1TgzcL5qRFpAYRcc1QeUrq8tbDR/zxsGEihjj+3y8KcntBx7CF7QHnkErKp3pugX2nW
        Ag/ropvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l98Pw-006903-AF; Mon, 08 Feb 2021 15:25:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 845723056DE;
        Mon,  8 Feb 2021 16:25:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CC9A20D8A033; Mon,  8 Feb 2021 16:25:35 +0100 (CET)
Date:   Mon, 8 Feb 2021 16:25:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] sched: make struct task_struct::state 32-bit
Message-ID: <YCFX7zuwp0haWZFl@hirez.programming.kicks-ass.net>
References: <20210206151832.GA487103@localhost.localdomain>
 <YCETqt8Vqb8R6qmA@hirez.programming.kicks-ass.net>
 <20210208143025.GA10066@localhost.localdomain>
 <20210208145245.GA11701@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208145245.GA11701@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 05:52:45PM +0300, Alexey Dobriyan wrote:
> On Mon, Feb 08, 2021 at 05:30:25PM +0300, Alexey Dobriyan wrote:
> > On Mon, Feb 08, 2021 at 11:34:18AM +0100, Peter Zijlstra wrote:
> > > On Sat, Feb 06, 2021 at 06:18:32PM +0300, Alexey Dobriyan wrote:
> > > 
> > > > Silently delete "extern" from prototypes.
> > > 
> > > NAK, extern is right.
> > 
> > Extern is only necessary for variables.
> 
> Specifically C17, 6.2.2 p5 (linkage of identifiers):
> 
> 	if the declaration of an identifier for a function has no
> 	storage-class specifier, its linkage is determined exactly as if
> 	it were declared with the storage-class specifier "extern".
> 
> This is why nothing happens if "extern" is deleted.

I know, but I still very much like extern on the function declarations
too. It tells me the definition isn't to be found in this TU.
