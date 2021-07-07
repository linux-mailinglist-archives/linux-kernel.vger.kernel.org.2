Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763433BE634
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 12:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhGGKPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 06:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhGGKPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 06:15:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77675C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 03:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UgjsPSucTzTH0A+UmBwxWmqQFqZt+Rk91IrthgYtDSE=; b=m00D8DO4GNRBLgrjKK2YKQYfF0
        O13wofFYkmdrOkLKIaA/w7Gg2nNfhEQQxqetMe0ZDWoOQozfSB/ZVM8kKd2Fgvriqou/vv2vbDF6K
        ZwnHWxV6cJ+ZLg+ex0er7kPmscUwRivnYWQOtHokufAIiY9LzFkd9M1jBUyHCE2IJSghaw7V+Wtm6
        0e9UiD0UF+AsxNIzOS01/5A7gZE33q/YJJ+32t0SA/tSLSjTEKsWz203PR32tnbQmHqkVzk9EXJQf
        1638Zchwbqv6mXnGHrgOMeGj/zbWPp+O7j666VwUoDn70b6dZc2u3+FOhSkCKx1HqzOOK2eFBFH0a
        WuPCrmfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m14Xx-00FK5o-1e; Wed, 07 Jul 2021 10:12:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E5267300233;
        Wed,  7 Jul 2021 12:12:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF6C22018A6F5; Wed,  7 Jul 2021 12:12:47 +0200 (CEST)
Date:   Wed, 7 Jul 2021 12:12:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     alexander.antonov@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kan.liang@linux.intel.com, ak@linux.intel.com,
        alexey.v.bayduraev@linux.intel.com
Subject: Re: [RESEND PATCH] perf/x86/intel/uncore: Fix IIO cleanup mapping
 procedure for SNR/ICX
Message-ID: <YOV+H56LLiLQWmi5@hirez.programming.kicks-ass.net>
References: <20210707065455.10271-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707065455.10271-1-alexander.antonov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 09:54:55AM +0300, alexander.antonov@linux.intel.com wrote:
> From: Alexander Antonov <alexander.antonov@linux.intel.com>
> 
> Cleanup mapping procedure for IIO PMU is needed to free memory which was
> allocated for topology data and for attributes in IIO mapping
> attribute_group.
> Current implementation of this procedure for Snowridge and Icelake Server
> platforms doesn't free allocated memory that can be a reason for memory
> leak issue.
> Fix the issue with IIO cleanup mapping procedure for these platforms
> to release allocated memory.
> 
> Fixes: 10337e95e04c ("perf/x86/intel/uncore: Enable I/O stacks to IIO PMON mapping on ICX")
> 

This whitespace is wrong.

> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>

Why am I getting a resend of this? Kan replied only yesterday.. folding
tags isn't a reason to resend, we have scripts for that. At the very
least you could've tried making the Changelog readable /
