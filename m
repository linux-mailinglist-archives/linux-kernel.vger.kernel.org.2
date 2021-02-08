Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1948631326D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhBHMdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbhBHMX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:23:26 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0AFC061756
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 04:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U+vMpCPQFxIpg2pHEBr6zm/a1C2DWoRbgxdsY3onAo8=; b=SwFa8CMNNKl/dQaTN6gaHsmCju
        gIwkRLTy3hPInfYDdcp0sE5TTRcKEw+4D82lp2TEe2QYCyidrDJqeYFNwsHY+qaFaDzDYw2kVTSVE
        I12PSQBC0P24uGyj0XA2VNLrtbkr5XkyR4486F5wbkLO2ksCAC2j4wfneFpmTEVewo9nREoY1EtHZ
        cqBlbYSVABNLNqLhwkWeSSy6p56UwlsJkEO/Who9rGc4RRglF8BHPEfCnbhyh+QaFvYEitr8nm4DR
        0E3OFdrRLlzrNJzV3v06bksF+oQc1PGy3wsGpmozg7UW1YCYLKJq4PucFunSFg65ZJzj/QXKO25VL
        7ML6RyLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l95Yk-0008O8-HF; Mon, 08 Feb 2021 12:22:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD01B306099;
        Mon,  8 Feb 2021 13:22:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B7C5E2BF9690E; Mon,  8 Feb 2021 13:22:28 +0100 (CET)
Date:   Mon, 8 Feb 2021 13:22:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bristot@redhat.com, bsegall@google.com,
        mgorman@suse.de, lgoncalv@redhat.com, williams@redhat.com
Subject: Re: [PATCH 0/2] HRTICK reprogramming and optimization
Message-ID: <YCEtBOXYuBGIk/c7@hirez.programming.kicks-ass.net>
References: <20210208073554.14629-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208073554.14629-1-juri.lelli@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 08:35:52AM +0100, Juri Lelli wrote:
> Juri Lelli (2):
>   sched/features: Fix hrtick reprogramming
>   sched/features: Distinguish between NORMAL and DEADLINE hrtick

Thanks!
