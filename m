Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F9633D348
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbhCPLni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237392AbhCPLnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:43:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F4FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 04:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hwLsizL7XJFqnGMjmpylTC6CiVb1w0cJP3VBTDn/L3Q=; b=Q2e4J9kztINb6/RaS8BAGTPZ0h
        688wNGv1dqyj/XZxuBhb6izILoCSqyjpBf9JKoZGE8YdS1JDnIY2sEo7AAzPhLdYVw62Ja4//VtLe
        El9wobTscRYWjrr6Ql6xMMUyAqseSX9Dyo77na904OND06pc6yOjLzgjJmFAkvWW4vqT8faRq+QHB
        +pxfh34R4gtFSgwdABs/Ltnb49QcOBNzLsTA+BDSzlUVeuMu1wBcNJjfuW7iukIE8S4PIdA/JGUfV
        WFSgGG08cEKIl8SDqv2x9mvLwasdIyqgsO2dPUCv0+8egQDl8vxHbcpScQ5IIVL0+PDs3G/qgwQt+
        rQ//Zf4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lM86N-000bl2-B0; Tue, 16 Mar 2021 11:43:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 215E3301324;
        Tue, 16 Mar 2021 12:43:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C48820435D00; Tue, 16 Mar 2021 12:43:06 +0100 (CET)
Date:   Tue, 16 Mar 2021 12:43:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 1/5] perf/x86/intel/uncore: Parse uncore discovery tables
Message-ID: <YFCZyqz+56bB8n2k@hirez.programming.kicks-ass.net>
References: <1615566878-70244-1-git-send-email-kan.liang@linux.intel.com>
 <1615566878-70244-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615566878-70244-2-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 08:34:34AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> A self-describing mechanism for the uncore PerfMon hardware has been
> introduced with the latest Intel platforms. By reading through an MMIO
> page worth of information, perf can 'discover' all the standard uncore
> PerfMon registers in a machine.
> 
> The discovery mechanism relies on BIOS's support. With a proper BIOS,
> a PCI device with the unique capability ID 0x23 can be found on each
> die. Perf can retrieve the information of all available uncore PerfMons
> from the device via MMIO. The information is composed of one global
> discovery table and several unit discovery tables.

> If a BIOS doesn't support the 'discovery' mechanism, there is nothing
> changed.

What if the BIOS got it wrong? Will the driver still get it correct if
it is a known platform?

Do we need a chicken flag to kill the discovery? uncore_no_discover?
