Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CCD33EE26
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhCQKNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:13:40 -0400
Received: from casper.infradead.org ([90.155.50.34]:57108 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhCQKNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ldg8P+ntHqhW13UFSCgwfQWUuj8y81ZkwHhfEwqZwlg=; b=KoqbwD6jrkk+2HGJvS+4wSDpbv
        974mecgUwOBbcvj0ogNZ0lXo6sRy0WTSl7wIMMo2/1q0mnDsjG7hT4vl9S6U7/yBfolgRTVU/BC/v
        Le1BIEjmOcDIikwNREiHbnlv6lNXkNZwrMfCMu9cLcgaM2f2iDKdHyvrTUGxndB2+A9R/yAg3nMQC
        0lqCSjICMctUioZxKQ0lvFOtlTLYP2/tcXE/zfNzYZS+P/0w1SCPDhQn6PxMNLvchgeQPAIiaeGyJ
        XpRqyD9wzyO3zFip+smRmOzVM2Gh4xOxlG1JOiGHkYUIv5pbTp3EknPIPegtfuO3ZgVAuXJROp9Mn
        VKrzn1hA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMTAs-001MYH-9x; Wed, 17 Mar 2021 10:13:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3AE4E3006E0;
        Wed, 17 Mar 2021 11:13:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23AE82C3C233E; Wed, 17 Mar 2021 11:13:09 +0100 (CET)
Date:   Wed, 17 Mar 2021 11:13:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kim Phillips <kim.phillips@amd.com>, Jiri Olsa <jolsa@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stanislav Kozina <skozina@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Pierre Amadio <pamadio@redhat.com>, onatalen@redhat.com,
        darcari@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: unknown NMI on AMD Rome
Message-ID: <YFHWNWBAQ4rsyAMG@hirez.programming.kicks-ass.net>
References: <YFDSSxftYw9tCGC6@krava>
 <YFEMpo6GxxJS9Wvl@hirez.programming.kicks-ass.net>
 <36397980-f897-147f-df55-f37805d869c9@amd.com>
 <20210317084829.GA474581@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317084829.GA474581@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 09:48:29AM +0100, Ingo Molnar wrote:
> > https://developer.amd.com/wp-content/resources/56323-PUB_0.78.pdf
> 
> So:
> 
> 
>   1215 IBS (Instruction Based Sampling) Counter Valid Value
>   May be Incorrect After Exit From Core C6 (CC6) State
> 
>   Description
> 
>   If a core's IBS feature is enabled and configured to generate an interrupt, including NMI (Non-Maskable
>   Interrupt), and the IBS counter overflows during the entry into the Core C6 (CC6) state, the interrupt may be
>   issued, but an invalid value of the valid bit may be restored when the core exits CC6.
>   Potential Effect on System
> 
>   The operating system may receive interrupts due to an IBS counter event, including NMI, and not observe an
>   valid IBS register. Console messages indicating "NMI received for unknown reason" have been observed on
>   Linux systems.
> 
>   Suggested Workaround: None
>   Fix Planned: No fix planned

Should be simple enough to disable CC6 while IBS is in use. Kim, can you
please make that happen?
