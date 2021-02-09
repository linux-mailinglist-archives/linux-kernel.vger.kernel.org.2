Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E0F314E96
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhBIMBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhBIMAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:00:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7690EC061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 03:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bAPpZ9LVjTvDaTon1gB7Ci/LyNhGLNT597dGHfv9hpU=; b=JHik3t0Wjt4Bc2BLPrZO3kFH5+
        hBk8NTqO6ptMHdqt79M2RaBvEDpmH1lQaY52ZO4uWzCOaErMO7wmoFOoT85OdWfI2BF4HH1NYy+IG
        SBmxT7IQf2OCyhdiowCPimDmMrHL48VQNUlicUdf3MCaQ0U5gQyRKblOMcJrcHcvTx21IofOGdxeL
        UylldITFCYHJ6qcYR82APlEgJ+S6EzvYYmkqwCVH3qH22P1t+4jvlUXic0mo5TouzGFw5xzjokKpc
        Nh3F4MYC85Zm+J8SlLEQVLWu8IB5+gcwqxB2L1naNaUIjn6smseccm54zUThAwDZuq+y9tNGK2t07
        W4m7758w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l9Rfy-007Ooa-5t; Tue, 09 Feb 2021 11:59:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3AD01300446;
        Tue,  9 Feb 2021 12:59:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E61162C70E09A; Tue,  9 Feb 2021 12:59:24 +0100 (CET)
Date:   Tue, 9 Feb 2021 12:59:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 0/2 v3] tracepoints: Stop punishing non-static call users
Message-ID: <YCJ5HEUP1DKUG45r@hirez.programming.kicks-ass.net>
References: <20210208200922.215867530@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208200922.215867530@goodmis.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 03:09:22PM -0500, Steven Rostedt wrote:
> Steven Rostedt (VMware) (2):
>       tracepoints: Remove unnecessary "data_args" macro parameter
>       tracepoints: Do not punish non static call users

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
