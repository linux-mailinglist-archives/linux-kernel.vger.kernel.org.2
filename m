Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F9A3AB14D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhFQKZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhFQKZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB9AC061280
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 03:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sm7PZgjQz5zYbS6T2zkMlFmy5MlgXNyPsFshR7FkJog=; b=h6Qot+wKmU6avy4U655Lgf11Nt
        t7zMgpixnX1ZJy/BN59+D8giSYrvhJONKgJTMEzdiPFEkSAx1wbunr1xR6Z1+8X06BqR8+wCal6VJ
        j0kdWiLv6K4fN8cPbcfDBhtgcAz0CeeUnPBQzqOAaoNQy0b9V5lXqNLSn+qpRBVJkodHpz2GKB02v
        hHAAh2pyZfmj0OrMhI9L2cUIsYMwrNAO+W+3PAXXeFptxosgsqKd2JNF3jzjeK2rS+JobEOcwwals
        r5gCFjt9b8ud3xaAtemcbqm1UKwW69jYOXO3MUZEY9L4TlAKylAxy710mY5TEJxvwEOFS6wtKg4AV
        4kADCdyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltpAt-008bTD-5c; Thu, 17 Jun 2021 10:23:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC4A93001DB;
        Thu, 17 Jun 2021 12:23:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0C3E2CC18C69; Thu, 17 Jun 2021 12:23:06 +0200 (CEST)
Date:   Thu, 17 Jun 2021 12:23:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@redhat.com
Subject: Re: [PATCH 0/4] perf: Fix the ctx->pmu for a hybrid system
Message-ID: <YMsiiuUsjsrh8ZAC@hirez.programming.kicks-ass.net>
References: <1623869734-133974-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623869734-133974-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:55:30AM -0700, kan.liang@linux.intel.com wrote:

> To fix the issue, the generic perf codes have to understand the
> supported CPU mask of a specific hybrid PMU. So it can update the
> ctx->pmu accordingly, when a task is scheduled on a CPU which has
> a different type of PMU from the previous CPU. The supported_cpus
> has to be moved to the struct pmu.

Urghh.. I so hate this :-/

I *did* point you to:

  https://lore.kernel.org/lkml/20181010104559.GO5728@hirez.programming.kicks-ass.net/

when you started this whole hybrid crud, and I think that's still the
correct thing to do.

Still, let me consider if there's a workable short-term cludge I hate
less.
