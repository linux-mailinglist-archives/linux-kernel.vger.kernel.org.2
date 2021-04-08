Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9B0358A6B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhDHRB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhDHRB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:01:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF75C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wd8921wFrgD6hVwNv+IXa152B3WodbiJoLO9VaviUIY=; b=ZaxUsJwpuQAvW/5cs0lVLMeLsk
        7w11tth6JRz0O9ZDFtrjMAcqcVQILIyjRLGYQj90BeyQbZ6HvDrpHUIKY9LKXvUw8ns2yA7/vjSGc
        mUGjeiO/Eo4nMt98UH5/PaE5pTRAJku+ME4TL0BiEDWaYereV9pdHYwfCo4Y/n1qjFkvVSaP/VCsw
        4ebLgvLlRmdSn+vYUTi6sfjbWiXX0dLiWrAy4G9DGX1SIx3m11pREp99yHc2jhXGmtVTx6/XSNStP
        5EZVGVlGC4rqGKrbahv50I1Q4vNIj6LZoPjY6YWu0Cp4Atkl+hZqVXeJRKj9I5YMItqui+/yFJ2ft
        4B9mOfCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUY1C-00GYtn-Av; Thu, 08 Apr 2021 17:00:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DEBAA3000CC;
        Thu,  8 Apr 2021 19:00:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C29842BD0DAEF; Thu,  8 Apr 2021 19:00:33 +0200 (CEST)
Date:   Thu, 8 Apr 2021 19:00:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        ricardo.neri-calderon@linux.intel.com
Subject: Re: [PATCH V5 04/25] perf/x86/intel: Hybrid PMU support for perf
 capabilities
Message-ID: <YG82scZuZAsxj2js@hirez.programming.kicks-ass.net>
References: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
 <1617635467-181510-5-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617635467-181510-5-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 08:10:46AM -0700, kan.liang@linux.intel.com wrote:
> +#define is_hybrid()			(!!x86_pmu.num_hybrid_pmus)

Given this is sprinkled all over the place, can you make this a
static_key_false + static_branch_unlikely() such that the hybrid case is
out-of-line?
