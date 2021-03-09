Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5AB3327F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhCIN7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhCIN7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:59:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF88DC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 05:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ck8EJLkijPyclDuwcCq92S8jY9TLPpWoJZPr64BYRCo=; b=n+YWl6jsPbp7Af8fLgCt3ScwUa
        RC+S0fjwTSl33wWqkkjcrqJu94gsn5KpZcL+PfxYyBTftBKi4f4t9N6snOxcaT9+tw1OxpinMn3JV
        vynhaueV/T9TowJsCU2M+GplgFNUeXthK59HSdxAeYotKLZmgFSgwDfXI2+yXPnOP+Cu9+e5JcmQK
        sfGTXYOGcOi+rMqj+nfiM0XRG7mupP8XMFeJLV08fWnZvKUI1Nd+vNFbnKFVV/o/fJSe8r9lDCII/
        L1a0VTr8/LClHVHtZe60pn/ChXN7etihCGVatQhkVFUeXWjdZpmEL9VTIslDGzPA+OXYOqQ7ZWSiR
        tdoe4H+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJcsj-000f5r-1j; Tue, 09 Mar 2021 13:58:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9DFF03010CF;
        Tue,  9 Mar 2021 14:58:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 647E220C29E87; Tue,  9 Mar 2021 14:58:39 +0100 (CET)
Date:   Tue, 9 Mar 2021 14:58:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [sched]  ef72661e28:
 WARNING:at_arch/x86/kernel/static_call.c:#__static_call_validate
Message-ID: <YEd/D0CRDIQ/eb9F@hirez.programming.kicks-ass.net>
References: <20210309133746.GA17567@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309133746.GA17567@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 09:37:47PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: ef72661e28c64ad610f89acc2832ec67b27ba438 ("sched: Harden PREEMPT_DYNAMIC")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Should be fixed by:

https://lkml.kernel.org/r/161459376868.20312.9858096297457613530.tip-bot2@tip-bot2
