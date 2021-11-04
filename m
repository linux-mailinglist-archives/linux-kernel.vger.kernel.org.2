Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533A344581B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbhKDRRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhKDRRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:17:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BDBC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9VoUCNEvC7s72t3c4Uy85VU6W4p5k7FpHEk2kB6sWKQ=; b=e8cRG5MmYmv9I0UPZN+Ic29Drr
        cdu2XmwI9BFxaf/ffBvCtcY8EOci8tjRH4WQZbDWs96//bBlRlyrzwELFVtJ3BfqGOBVeYAh8cEb9
        LThFqmUYW2ijLd3Tbl5Ga4C4573A7TA1A3pu/odsSLRuGKsAXoqPG9fyuZ1hLMuyZZQ/zx7AUehli
        FtJXr+cp1cRUgtdtr/nPSeONocCFig/Ep+HgOaHqvT5VYlU2HEXNfj5SfhPEB/l1gvSmPmhf1RcZS
        apewqPm6C5wLbzpVxUqcctdPf0oQgbIcERvIebiHuP7K9Wiwrkx50IZ0f6cm6xa7KdEVUkf7gNeq9
        18+kKrxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1migFh-0060pl-7E; Thu, 04 Nov 2021 17:10:54 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 875CB98632E; Thu,  4 Nov 2021 18:10:12 +0100 (CET)
Date:   Thu, 4 Nov 2021 18:10:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/5] Add hardware prefetch driver for A64FX and
 Intel processors
Message-ID: <20211104171012.GC174703@worktop.programming.kicks-ass.net>
References: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 02:21:17PM +0900, Kohei Tarumizu wrote:
> This patch series add hardware prefetch driver register/unregister
> function. The purpose of this driver is to provide an interface to
> control the hardware prefetch mechanism depending on the application
> characteristics.

Here you talk about applications..

> An earlier RFC[1], we were suggested that we create a hardware
> prefetch directory under /sys/devices/system/cpu/[CPUNUM]/cache.
> Hardware prefetch is a cache-related feature, but it does not require
> cache sysfs feature. Therefore, we decided to isolate the code.
> Specifically, create a directory under cpu/[CPUNUM].

Here you talk about CPUs..

How does that work?
