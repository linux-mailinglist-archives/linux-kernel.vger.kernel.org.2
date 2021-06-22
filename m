Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0183B05A2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhFVNP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhFVNP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:15:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C68C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KJ+NoEavJnTLT7MKw4RTh05U+sS1+3j1fQ5as46iCZk=; b=oZGSRTO2S6ygxc6YTm9jQoLNJY
        ADkCNB8F9engizrCwW97ZlGKkKv85/gbYvCC/0aP0fS24xbYDmbR7wb6e5gRJwlZeZnfzp9QDkVJb
        YK9XqOGcEuU151UqLNUYbI4peZ6IyiAR2o1RMIx4zzKeRwhP8Gi4l8aVCWMAcpioD/VHWLT62ZeWZ
        5HtlmZSvAYRdwfU90x2OOGESWLVQpHPv/rgZ1tulWQ6sDjX9ESOm3e2yycRHOkE0Cv77osmf9rvza
        PyugYJBGXpocg8C0McrSPYv8xMRXvpb/P+HfBoeVxHHx8l0vzpQWGIe73qJdnFHMXZIv+VbituHwK
        ly/sivQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvgD1-00AbYt-MD; Tue, 22 Jun 2021 13:13:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E21803002C5;
        Tue, 22 Jun 2021 15:13:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2A6C2C82BAE4; Tue, 22 Jun 2021 15:13:00 +0200 (CEST)
Date:   Tue, 22 Jun 2021 15:13:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Tejun Heo <tj@kernel.org>, Quentin Perret <qperret@google.com>,
        Wei Wang <wvw@google.com>, Yun Hsiang <hsiang023167@gmail.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/uclamp: Fix uclamp_tg_restrict()
Message-ID: <YNHh3DeeQF6VbwYX@hirez.programming.kicks-ass.net>
References: <20210617165155.3774110-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617165155.3774110-1-qais.yousef@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 05:51:55PM +0100, Qais Yousef wrote:
> Now cpu.uclamp.min acts as a protection, we need to make sure that the
> uclamp request of the task is within the allowed range of the cgroup,
> that is it is clamp()'ed correctly by tg->uclamp[UCLAMP_MIN] and
> tg->uclamp[UCLAMP_MAX].
> 
> As reported by Xuewen [1] we can have some corner cases where there's
> inversion between uclamp requested by task (p) and the uclamp values of
> the taskgroup it's attached to (tg). Following table demonstrates
> 2 corner cases:
> 
> 	           |  p  |  tg  |  effective
> 	-----------+-----+------+-----------
> 	CASE 1
> 	-----------+-----+------+-----------
> 	uclamp_min | 60% | 0%   |  60%
> 	-----------+-----+------+-----------
> 	uclamp_max | 80% | 50%  |  50%
> 	-----------+-----+------+-----------
> 	CASE 2
> 	-----------+-----+------+-----------
> 	uclamp_min | 0%  | 30%  |  30%
> 	-----------+-----+------+-----------
> 	uclamp_max | 20% | 50%  |  20%
> 	-----------+-----+------+-----------
> 
> With this fix we get:
> 
> 	           |  p  |  tg  |  effective
> 	-----------+-----+------+-----------
> 	CASE 1
> 	-----------+-----+------+-----------
> 	uclamp_min | 60% | 0%   |  50%
> 	-----------+-----+------+-----------
> 	uclamp_max | 80% | 50%  |  50%
> 	-----------+-----+------+-----------
> 	CASE 2
> 	-----------+-----+------+-----------
> 	uclamp_min | 0%  | 30%  |  30%
> 	-----------+-----+------+-----------
> 	uclamp_max | 20% | 50%  |  30%
> 	-----------+-----+------+-----------
> 
> Additionally uclamp_update_active_tasks() must now unconditionally
> update both UCLAMP_MIN/MAX because changing the tg's UCLAMP_MAX for
> instance could have an impact on the effective UCLAMP_MIN of the tasks.
> 
> 	           |  p  |  tg  |  effective
> 	-----------+-----+------+-----------
> 	old
> 	-----------+-----+------+-----------
> 	uclamp_min | 60% | 0%   |  50%
> 	-----------+-----+------+-----------
> 	uclamp_max | 80% | 50%  |  50%
> 	-----------+-----+------+-----------
> 	*new*
> 	-----------+-----+------+-----------
> 	uclamp_min | 60% | 0%   | *60%*
> 	-----------+-----+------+-----------
> 	uclamp_max | 80% |*70%* | *70%*
> 	-----------+-----+------+-----------
> 
> [1] https://lore.kernel.org/lkml/CAB8ipk_a6VFNjiEnHRHkUMBKbA+qzPQvhtNjJ_YNzQhqV_o8Zw@mail.gmail.com/
> 
> Reported-by: Xuewen Yan <xuewen.yan94@gmail.com>
> Fixes: 0c18f2ecfcc2 ("sched/uclamp: Fix wrong implementation of cpu.uclamp.min")
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>

Thanks!
