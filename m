Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17F33626A9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241055AbhDPRX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhDPRX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:23:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E363FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dVTBdLjO5X2LZBlF6uMCzwGYwSm8D1So/RddF8X/oVc=; b=kfhDF+5U40GbyECy/be+y++Ba1
        Gs8lAQrOr2NW1adAiITsQimNhmAa8aTyrwPLg4PEudtT+cxMIgpYQRDmNm95w2CVCh/YF8vxGFuUs
        /Sb4beXlqB8JGjaMfsiK6Njk89HY5H/JieX+irThlh2uLwPlHnUTS3fvFB/8m+LbZqzV3u90bOXhQ
        pf658QKednz+cELOZPf0E0AzYd3w9++HRh8bJIsBXRUVpaJ+R7tpm0eWWEVfqg/fk5j1E0rQyOxzg
        +NiNOPyvqPXKLZaWTcxH+t97GA5o73xSwH/+/j8v5HxoOJ894JcSnBUvGUVyBynZlCHWiGW6LRe2u
        OyA4/MYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXSB8-002w8G-If; Fri, 16 Apr 2021 17:22:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91E72300209;
        Fri, 16 Apr 2021 19:22:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51E88286E9FD4; Fri, 16 Apr 2021 19:22:49 +0200 (CEST)
Date:   Fri, 16 Apr 2021 19:22:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Charan Teja Reddy <charante@codeaurora.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] sched,psi: fix the 'int' underflow for psi
Message-ID: <YHnH6R2c7VW05jc0@hirez.programming.kicks-ass.net>
References: <1618585336-37219-1-git-send-email-charante@codeaurora.org>
 <YHmpCOz339T67yTt@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHmpCOz339T67yTt@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 11:11:04AM -0400, Johannes Weiner wrote:
> On Fri, Apr 16, 2021 at 08:32:16PM +0530, Charan Teja Reddy wrote:
> > psi_group_cpu->tasks, represented by the unsigned int, stores the number
> > of tasks that could be stalled on a psi resource(io/mem/cpu).
> > Decrementing these counters at zero leads to wrapping which further
> > leads to the psi_group_cpu->state_mask is being set with the respective
> > pressure state. This could result into the unnecessary time sampling for
> > the pressure state thus cause the spurious psi events. This can further
> > lead to wrong actions being taken at the user land based on these psi
> > events.
> > Though psi_bug is set under these conditions but that just for debug
> > purpose. Fix it by decrementing the ->tasks count only when it is
> > non-zero.
> > 
> > Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
> 
> The subject should be
> 
>   psi: handle potential task count underflow bugs more gracefully

Done.

> since it's not fixing a known bug at this point. Otherwise,
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!


