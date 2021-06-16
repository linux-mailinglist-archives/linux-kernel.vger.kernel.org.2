Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2C53A9EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbhFPPQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhFPPQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:16:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109BCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bbAO4rkZ1twjX62vhI/BbaMEgXyiGmxtV1K6vm723R0=; b=fAvLvaBqO5e0iTW7QoIcsUwQe+
        tBFlUtYrdlEUweiIjcIPNtiMO/eqqu1rgVq04y7FOih+++qO7MUMJE26TnX3PZWE5Z28mH6XrNpBi
        VNSKEA8i+ilH6mnjQN379Z45fzGqwc7CX3VZ61tHjv8U0O42yAF1/+Z4JXFqVR5ZXoi/hg8ZQ7xmB
        Vg1Q/Hbu/ijBASPHbXqYLp1U5MUQTKqD4O4BvkDRSd7+D2XPyn8vpO/JL4zLeO2jDuRxzm4svoNgE
        ckwV2X81YvqcE2ReyW45nzqU+UKTUyy64i+Bc8yL0b7s7ElzkbY/gKNQQubLabZp+sFuQ7vyz/eGy
        Qiep9WFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltXEx-008B0W-2T; Wed, 16 Jun 2021 15:14:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7B6C6300269;
        Wed, 16 Jun 2021 17:14:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 542C12C516D3C; Wed, 16 Jun 2021 17:14:02 +0200 (CEST)
Date:   Wed, 16 Jun 2021 17:14:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCHSET v2 0/3] perf stat: Enable BPF counters with
 --for-each-cgroup
Message-ID: <YMoVOp4+TIUViBb7@hirez.programming.kicks-ass.net>
References: <20210615011724.672612-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615011724.672612-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 06:17:21PM -0700, Namhyung Kim wrote:
> Current limitations are:
>  * it doesn't support cgroup hierarchy

That seems unfortunate; there's no bpf helper to iterate cgroup
hierarchy?

>  * there's no reliable way to trigger running the BPF program

You can't attach to the PERF_COUNT_SW_CGROUP_SWITCHES event?
