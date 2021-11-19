Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9371456C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 10:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhKSJ3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 04:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbhKSJ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 04:29:03 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB94C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 01:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V6V5lGfCPOd68nz+VKS5XbKmgxvfftjeznJyuXXVPps=; b=NMYnunh6Dqrg8Ie5ghxSl/Tequ
        P2P1j4gmBXB/fhcmrjdIVkkFkgk96WwAmvDcH3GX4pf8z1/46vLV2GyaGEek6DFx0X8faYQFJnqiu
        VkNrVeWZnigxs7RZ/3pQVM2GeSlF2FiwVU/FLYhJx6hfDU0ZEiGOqM5ZjrrtWM2LFSBZpl4TM4133
        KApt9Kh/Mw3IW3rbxHChRsfKHclXqv2t+CIp5PETRh+EE9CqLGztwaTTKl9Du8oNqZ6L6Ggd6yk7b
        ixP0v6ysqWtkO5Kp2vpF72WOFM1zuijYDkPnrHrr0Vi70mH1DQNw7V4JJVtmLvwsc7VLSEmZU6xv4
        JMj+by/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mo08p-00GrnM-Ie; Fri, 19 Nov 2021 09:25:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A13E300129;
        Fri, 19 Nov 2021 10:25:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7104265BA04B; Fri, 19 Nov 2021 10:25:05 +0100 (CET)
Date:   Fri, 19 Nov 2021 10:25:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peng Wang <rocking@linux.alibaba.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add busy loop polling for idle SMT
Message-ID: <YZdtceRRxJQRt8cZ@hirez.programming.kicks-ass.net>
References: <cover.1637062971.git.rocking@linux.alibaba.com>
 <YZTgVzAFvZzXBrzy@hirez.programming.kicks-ass.net>
 <e31e9b58-591b-c538-ccd1-5864e586ad02@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e31e9b58-591b-c538-ccd1-5864e586ad02@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 11:19:03AM +0800, Peng Wang wrote:
> 
> Yes, idle SMT busy loop polling can only provide approximately pipeline
> interference for normal instructions.
> 
> When it comes to AVX works, we notice an idea modifing CPU time
> accounting[1], do you think the combination can lead to a feasible
> solution, or any other better ideas?

I'm not at all interested in solving this business model induced brain
trauma.
