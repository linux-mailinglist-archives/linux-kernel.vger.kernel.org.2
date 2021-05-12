Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835B637BCC7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhELMsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhELMsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:48:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11E4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T4bAEotqJfoHCyEYSaR1Cs+HUJlUPMJDbP9RAYWZNnI=; b=bNFiWA38FWuU5BGFK2i0zAMYS5
        F6Gh2Ks5+93vk0MTJcc1AYJ77Yi3haCbPV1kEzKDn4l6O6cREFvZFxTkJ5WCUc/kOqiXT/ZfuVUTN
        IkC5YVkr5UZbtpaMoZZD61N2exvoH9oCyIFRByDrkL8VAMsNL7tMgwikB2BdGbl5raSQuXkdTtw15
        cr7bQTmBAMJMdXSMDiai+7rB2NkP/cKvnhKEi+U6Da1Q8mLyP74nUuIjUcvWzc8fr/4iFYxwG9UXG
        LI5OBg46di/hLMjoiC4EzBoCRbjvEKxT+vj4bP972KCtXmnjSEQnEHBqr2gciQHhQp2y/wN746vjE
        PMZnQB9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgoFM-008GoO-0W; Wed, 12 May 2021 12:46:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD71D300242;
        Wed, 12 May 2021 14:45:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 93E11286DDD3F; Wed, 12 May 2021 14:45:50 +0200 (CEST)
Date:   Wed, 12 May 2021 14:45:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     alexander.antonov@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
        ak@linux.intel.com, steve.wahl@hpe.com, kyle.meyer@hpe.com,
        alexey.v.bayduraev@linux.intel.com
Subject: Re: [PATCH 0/3] perf/x86/intel/uncore: Enable I/O stacks to IIO PMON
 mapping on SNR and ICX
Message-ID: <YJvN/ucSDFPII3ol@hirez.programming.kicks-ass.net>
References: <20210426131614.16205-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426131614.16205-1-alexander.antonov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 04:16:11PM +0300, alexander.antonov@linux.intel.com wrote:
> Alexander Antonov (3):
>   perf/x86/intel/uncore: Generalize I/O stacks to PMON mapping procedure
>   perf/x86/intel/uncore: Enable I/O stacks to IIO PMON mapping on SNR
>   perf/x86/intel/uncore: Enable I/O stacks to IIO PMON mapping on ICX
> 
>  arch/x86/events/intel/uncore.h       |   1 +
>  arch/x86/events/intel/uncore_snbep.c | 173 ++++++++++++++++++++++++++-
>  2 files changed, 168 insertions(+), 6 deletions(-)

Thanks!
