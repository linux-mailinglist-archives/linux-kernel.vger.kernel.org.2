Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85AE381B22
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 23:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbhEOVEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 17:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhEOVEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 17:04:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAEEC061573;
        Sat, 15 May 2021 14:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hyyxptrN6opDfMyDe82jUzcLX0UK5gBJjKQrYKblEk0=; b=EQfXeu58xeH/wF2c62hm+Hpm+D
        llBIBgZ4UtGnuztEh0gmSWjIv1tcLsdI5waiS+I6gSU6yAaUzD1XUM3FuaBj/C9Sl8u9yeaqcYgP6
        J0dS3fJPx+9H9r+6n63o8YiSNP/CwbTYB4U2fzBgYYICn3+WZLDl/e35s+shaUWpEQTTkR1AE8she
        Hp5FLL88GPsErt9Ut85nULimIJCc6raoa0KrbLYzOjMABU4wDVWZ2kammutEnvTiqke6EL3TF249o
        EDz6njNYUOtIMxraQ1hVDi6uYV8KfBX4JkJihG6if7PhAtZbxmyTV4V7J5/dWVQjdiV1TQnF3pE2+
        85x6T6Lw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1li1Qn-00Azjf-5i; Sat, 15 May 2021 21:02:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63E5E98659E; Sat, 15 May 2021 23:02:38 +0200 (CEST)
Date:   Sat, 15 May 2021 23:02:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Khaled ROMDHANI <khaledromdhani216@gmail.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH-next] sched: Fix Null pointer derefrence
Message-ID: <20210515210238.GG5618@worktop.programming.kicks-ass.net>
References: <20210515164645.22849-1-khaledromdhani216@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515164645.22849-1-khaledromdhani216@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 05:46:45PM +0100, Khaled ROMDHANI wrote:
> The 'curr' variable could be NULL and derefrenced by
> pick_next_entity. Fix this by adding a check that prevent
> the invocation of pick_next_entity with a NULL passed argument.

And why exactly is that a problem?

