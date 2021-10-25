Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA504391D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhJYJAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbhJYJAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:00:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6765C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=80xr9ygw2WJEE4XFb2EF56NTU+iC2pwy4SKHZowUeqY=; b=liUXSCEMtdJNkd1F6pFhRRiUda
        FgMbrNpElFgab9sDhKUr0SXGPsD2yLDaIUkYE+BUjO7GhdWxIKwiYBG2TBO3HSSx13LT5aDNuefNP
        Hx5pHluuJpL2KCzjpb6rmW5/h8pZtV3uv0Ak3JD+bu/wvlQf7BaGp8lZf7ic5VZ4y5yDszQHAgfbr
        OGg1FrF5JX/TxU/m079qsu9lwRGQcHLczuKjWPH0iA3pW1Xvl93akeDuWhAMKz1fpvcDkz8GTzx+M
        916eI+74HV+CF5SKeGGok2cjrGGwpXkh7T6gDI5AA6a2q0xDzSSJNUy45x/iMD2nQSx+N3OgjN7Zi
        HnOxn1cQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mevnR-00C6pU-9o; Mon, 25 Oct 2021 08:57:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC10D300288;
        Mon, 25 Oct 2021 10:57:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5EDE220C6C14F; Mon, 25 Oct 2021 10:57:31 +0200 (CEST)
Date:   Mon, 25 Oct 2021 10:57:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fix implicit type conversion
Message-ID: <YXZxe/bQS397KX/W@hirez.programming.kicks-ass.net>
References: <1635149847-2426546-1-git-send-email-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635149847-2426546-1-git-send-email-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 08:17:27AM +0000, Jiasheng Jiang wrote:
> The variable 'n' is defined as ULONG. However in the cpumask_next(),
> it is used as INT.
> That is vulnerable and may cause overflow.
> Therefore, it might be better to define 'n' as INT.

-ENOPARSE

