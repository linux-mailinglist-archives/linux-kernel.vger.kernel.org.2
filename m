Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAC33ABCD3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbhFQTfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhFQTfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:35:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878F3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MwRWhtxF23aeMiI4qPp+QqfLbIRWW43NooDmTPhXArg=; b=n/5FgNghKyjRWo6t6NaYB/qmZ9
        LgDrJHPlHqdHK3+mD+/cmV2VVofL4Qw0lu8Bg09J+p+DLIQm4I6oZwk0WOxT5Tg2Whsop12F6PcNr
        OItOsPGcGpH2rx+l3vdR6z+wWLvuG1nEfQnwxwBka8Ltq5MiG+Qet8f15J4XwQfx2XgvcztUVk8BL
        WKMdF/iuYowhLfFFtZysSLdwYG7bvtMsQIjLWUdr9oM2kQ7cAB+Ki1iWxrnUvGesez1Zt3IlvSDUA
        Cgv5MyQQ9z7TWFU0Ub7Pa+9Plr3GGl+yAUf0PcyOx+WwuVTBsZt38oOvv+kodFf6GLZzLafF9c1cD
        6ZZtge/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltxkv-008v2P-Mv; Thu, 17 Jun 2021 19:32:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C3DC33001DB;
        Thu, 17 Jun 2021 21:32:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9A0620244CE2; Thu, 17 Jun 2021 21:32:55 +0200 (CEST)
Date:   Thu, 17 Jun 2021 21:32:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@redhat.com
Subject: Re: [PATCH 0/4] perf: Fix the ctx->pmu for a hybrid system
Message-ID: <YMujZ7a/8ToWXzo+@hirez.programming.kicks-ass.net>
References: <1623869734-133974-1-git-send-email-kan.liang@linux.intel.com>
 <YMsiiuUsjsrh8ZAC@hirez.programming.kicks-ass.net>
 <YMsy7BuGT8nBTspT@hirez.programming.kicks-ass.net>
 <3d4b9377-30b0-a945-7b11-b412dcc4c51a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d4b9377-30b0-a945-7b11-b412dcc4c51a@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 10:10:37AM -0400, Liang, Kan wrote:
> I think all the perf_sw_context PMUs share the same pmu_cpu_context. so the
> cpuctx->ctx.pmu should be always the first registered perf_sw_context PMU
> which is perf_swevent. The ctx->pmu could be another software PMU.

Is there actually anything that relies on that? IIRC the sw pmus only
use event->pmu->foo() methods (exactly because the ctx->pmu is
unreliable for them).

> In theory, the perf_sw_context PMUs should have a similar issue. If the
> events are from different perf_sw_context PMUs, we should perf_pmu_disable()
> all of the PMUs before schedule them, but the ctx->pmu only tracks the first
> one.
> 
> I don't have a good way to fix the perf_sw_context PMUs. I think we have to
> go through the event list and find all PMUs. But I don't think it's worth
> doing.

Yeah, the software PMUs are misserable, they're one of the things I wish
I'd done differently. Cleaning that up is *somewhere* on the TODO list.

So I *think* it should work as is and we can avoid the extra check, but
let me know what actual testing does.
