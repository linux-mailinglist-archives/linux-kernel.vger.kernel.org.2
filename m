Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920E53B05B0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhFVNU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhFVNU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:20:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D22C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eZY6GqewjUN9e3eOVBj0Dn/RPI/YL2dXlQWBO6SvtIo=; b=vghLiMwRX9ZqqYTxZeBcgShMRK
        I3RAZaFqKkqPtPQbjXOjQiAeV5GvSDRldCz6UIATh+BfkzHE27saURtxy1XIvpKz05Hd9mJSu3sNM
        oE+Pi/d4DQMZJdBrgtIYyW+W9WoMlO5c3PF7lPfMQKpY4ecSPSLYsQFe9C7chCuw4aNadwrymyQZo
        3qx5dKq5rYRfSxX+fpQjsK3+0sD01883n2N2JqCgfRxAbVmQVeQYzxi2DZxUFEYWO2L+d42D5ZXfM
        HP86CFMcwM1q7KsnX8QiCirsJz4htDblvC/LZSXL52Un85Iu+iK6Ad1hLWfykN0ROHazwf+ONRgjG
        ucdDm4KA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvgGq-00EKTh-6T; Tue, 22 Jun 2021 13:17:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 37860300223;
        Tue, 22 Jun 2021 15:16:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1BCA02C82BAE9; Tue, 22 Jun 2021 15:16:51 +0200 (CEST)
Date:   Tue, 22 Jun 2021 15:16:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix RT/DL utilization during policy change
Message-ID: <YNHiw5CQNO+yifZ9@hirez.programming.kicks-ass.net>
References: <1624271872-211872-1-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624271872-211872-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 11:37:50AM +0100, Vincent Donnefort wrote:
> changelog since V1:
>   * Simplify and merge "if" conditions for RT's switched_to
>   * Collect Reviewed-by
> 
> Vincent Donnefort (2):
>   sched/rt: Fix RT utilization tracking during policy change
>   sched/rt: Fix Deadline utilization tracking during policy change
> 
>  kernel/sched/deadline.c |  2 ++
>  kernel/sched/rt.c       | 17 ++++++++++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)

Thanks!
