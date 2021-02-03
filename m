Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDE430DD2E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhBCOsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbhBCOsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:48:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D5FC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yXNf+0RKaDSH+SxTfPcL4g60l+zjyKbIEJCEGw1b2J0=; b=e0+hXuKbfnWnpF2sMvSccsm0GW
        ijMnHKlMmEIdbJsKo+zmUANm5qU8tf54Zb+prlE7EE0r/3jn7JmYiEIeAycNPiESx5LYxGC709GdK
        kuaUXLUlc0Wl364pNmD+grrR8LYT4NZgaEhBIt9Qoit4sgGY7OFG2CccBK49OVRy1CeZvtTPmrYYi
        ayd1Lg0o3+Canhv524V9bmVDBLTF2peMXaFpRwx+2bLTW8e3huBHB0au/1QMBztF4CP+5q4aTwLoz
        rCMCW/vFjAkK6NJJJB0Sf0kaZfNOVHZapPOjQvVMOtPVVPkGLm+8iTU+uenjlHyyHf6fTH1+5b137
        dWr6wifg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l7JR7-00H2lZ-6W; Wed, 03 Feb 2021 14:47:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4ADFC30066E;
        Wed,  3 Feb 2021 15:47:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1521120C633CB; Wed,  3 Feb 2021 15:47:14 +0100 (CET)
Date:   Wed, 3 Feb 2021 15:47:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>
Subject: Re: [PATCH 3/3] perf/x86/rapl: Fix psys-energy event on Intel SPR
 platform
Message-ID: <YBq3csfKeH7PaK39@hirez.programming.kicks-ass.net>
References: <20210115092208.20866-1-rui.zhang@intel.com>
 <20210115092208.20866-3-rui.zhang@intel.com>
 <YALhAmTgMHxEgeG4@hirez.programming.kicks-ass.net>
 <70b71922e7f84234be70c7104969331f@intel.com>
 <03e5815f89d749a18b47bdf986181f1f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e5815f89d749a18b47bdf986181f1f@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


FWIW, your email is malformed, please wrap at 78 chars.

On Mon, Jan 25, 2021 at 06:11:14AM +0000, Zhang, Rui wrote:
> In short, the current code does not allow RAPL energy counter to
> return 0. And all the work I do is to allow Psys energy counter to
> return 0.

Ok.

> In this way, the Psys event is "valid" on all CPUs, so we don't need
> to handle the master thing.

So RAPL is mapped to DIEs, and IIRC we can have multiple DIEs per
Package. But the master thing is a Package.

Is this all moot because SPR has one DIE per Package? Because if it
would have more, there's be more interesting problems I suppose.
