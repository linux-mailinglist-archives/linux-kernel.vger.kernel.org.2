Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE29833D570
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbhCPOFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbhCPOF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:05:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D6EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 07:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wiisDDeURwIK8ZBtwm3I/POlOBHcEkzJiAHB1DwfLXQ=; b=akx2BTlxxmk+m+pH6eSsqezNZp
        nuGSZlR0oPbYm8lwUrB7uAH0I93vMOz28/qInjUIvxfbgcRlshcPqwb5AZPmgk2sJK6XoGtG9Zpep
        9BlitFteddzWD3qyXYG9UjvfzyDlcEK105vzJZ6iXNUqOd+r0GUmstvufUP8vFIWB81wXTngb9YpN
        0C1o1rqchvxDCRKvoEXUJ9WqafmuaAms4OLnsdaVW6pvieKm/pApj1cbEtyavFBHN/drQAFsO+Ktt
        e1w7RfRm2P7qSig41t+PxXkThTrFGkSPh6tIx0Giv/uoS9+YDWJY1C3AhHKcNGs4hEqRud9HbqFy8
        dLyXCdmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMAJu-000txG-Ia; Tue, 16 Mar 2021 14:05:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9A4C630700B;
        Tue, 16 Mar 2021 15:05:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BC2A23E8EF8C; Tue, 16 Mar 2021 15:05:13 +0100 (CET)
Date:   Tue, 16 Mar 2021 15:05:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 1/5] perf/x86/intel/uncore: Parse uncore discovery tables
Message-ID: <YFC7GeBzL70QX2fS@hirez.programming.kicks-ass.net>
References: <1615566878-70244-1-git-send-email-kan.liang@linux.intel.com>
 <1615566878-70244-2-git-send-email-kan.liang@linux.intel.com>
 <YFCZyqz+56bB8n2k@hirez.programming.kicks-ass.net>
 <f6231c10-60b1-34ec-fb7e-103a6cd2dbcf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6231c10-60b1-34ec-fb7e-103a6cd2dbcf@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 08:42:25AM -0400, Liang, Kan wrote:
> 
> 
> On 3/16/2021 7:43 AM, Peter Zijlstra wrote:
> > On Fri, Mar 12, 2021 at 08:34:34AM -0800, kan.liang@linux.intel.com wrote:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > 
> > > A self-describing mechanism for the uncore PerfMon hardware has been
> > > introduced with the latest Intel platforms. By reading through an MMIO
> > > page worth of information, perf can 'discover' all the standard uncore
> > > PerfMon registers in a machine.
> > > 
> > > The discovery mechanism relies on BIOS's support. With a proper BIOS,
> > > a PCI device with the unique capability ID 0x23 can be found on each
> > > die. Perf can retrieve the information of all available uncore PerfMons
> > > from the device via MMIO. The information is composed of one global
> > > discovery table and several unit discovery tables.
> > 
> > > If a BIOS doesn't support the 'discovery' mechanism, there is nothing
> > > changed.
> > 
> > What if the BIOS got it wrong? Will the driver still get it correct if
> > it is a known platform?
> 
> Yes, I will submit a platform specific patch to fix this case.
> 
> > 
> > Do we need a chicken flag to kill the discovery? uncore_no_discover?
> > 
> 
> Yes, I plan to introduce a .use_discovery_tables flag to indicate whether to
> use the discovery tables for the known platform.
> 
> The below codes is part of the upcoming SPR uncore patches.
> The first SPR uncore patch will still rely on the BIOS discovery tables,
> because some uncore block information hasn't been published yet. We have to
> retrieve the information fro the tables. Once all the information is
> published, we can kill the discovery by removing the ".use_discovery_tables
> = true".

I was thinking of a module parameter, such that we can tell it to skip
discovery on module load time etc.
