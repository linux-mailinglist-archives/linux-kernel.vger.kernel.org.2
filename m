Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E18444AA60
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 10:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbhKIJRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 04:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241947AbhKIJRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 04:17:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516B2C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 01:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3v6bJmP3+qBqplcN7AAaA8ZY9KeunR8vcRhii4EOX2I=; b=V65g+fdb+/AbEE7CzQKrwmZIr5
        2Y/HafzeonMRNDXpa8VkWmw+BgrlvgVYrqCVkNWgow3/sIbAvAc6gf1vmNzf47WpbV9Xa1Yx83f0T
        H5WoauZOCMujl5JEC1L6cahGR80JYN6bWbOCnL1Htntl/8G2ehBcfS9hH+zLWgQyb0bqilPAZlUgZ
        2YxzhHd5TOn9GqU/LucAbe88qdhdIdiYRvw5KBfMYBIpiZenWOMw/QbvUdwSU1j/HqkyS5XGt04kX
        lpfueG58W2ppY5Ll0TU90LN/yJzkVq/BBmzADbY8W/XqFUopb2rEAcC/nF2ECnIYMQCUygCFmYmhx
        3N/wUtIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkNDT-000uEm-BD; Tue, 09 Nov 2021 09:14:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A3013001C7;
        Tue,  9 Nov 2021 10:14:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3330C2C277AC1; Tue,  9 Nov 2021 10:14:54 +0100 (CET)
Date:   Tue, 9 Nov 2021 10:14:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Liu Xinpeng <liuxp11@chinatelecom.cn>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, zhouchengming@bytedance.com
Subject: Re: [PATCH 1/2] psi: Remove repeated verbose comment
Message-ID: <YYo8DsWX///Qgnqu@hirez.programming.kicks-ass.net>
References: <1635133586-84611-1-git-send-email-liuxp11@chinatelecom.cn>
 <YYQPL4exZUP2eruI@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYQPL4exZUP2eruI@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 12:49:51PM -0400, Johannes Weiner wrote:
> On Mon, Oct 25, 2021 at 11:46:25AM +0800, Liu Xinpeng wrote:
> > Comment in function psi_task_switch,there are two same lines.
> > ...
> > * runtime state, the cgroup that contains both tasks
> > * runtime state, the cgroup that contains both tasks
> > ...
> > 
> > Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Peter, could you please take this through -tip?

Sure, lemme figure out the b4 incantation to grab these patches since
the originals didn't make it to my inbox. They should show up in
tip/sched/core after -rc1 or so if I get the incantation right :-)
