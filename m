Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A991E433312
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 12:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbhJSKFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 06:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234794AbhJSKFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 06:05:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52DF661052;
        Tue, 19 Oct 2021 10:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634637819;
        bh=6Y/Vzvlx9TgrQ9ag2k8mlYUT3QDwmIYd0+Q1ilrvvGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=iQBK42sSN93TduNEqIVoeyBv/C4SwJjMCr2+WdmsbvoABfgykRVf1PNtGH0lv3QU3
         CsPne0wd1CDTK5qsOtixU/b7/z+3fiozjL8oPOP2gxKwdt/N3NvnzZsTz24rew9Smp
         QXRzbk5/bXKp5Zik784DTFITl174F/88AKEoqCcUO7+qqAXWbY60Eog7QlVS9K8OER
         dOKfmeCUziBVwIVHOS8pckLoVELef4QdWgHAszSt7ZsXvvs/NimTkse2reCUJX0swJ
         4T5waW9jXbRhJbmpmesoGOzvBeC+F3pACVQEK67m/nSEhoSNtoASf8B9GCOlrC2jUK
         lfuMN0La16oZA==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/core: Optimize kdamod.%d thread creation code
Date:   Tue, 19 Oct 2021 10:03:36 +0000
Message-Id: <20211019100336.5861-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211016165914.96049-1-xhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xin,

On Sun, 17 Oct 2021 00:59:14 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> When the ctx->adaptive_targets list is empty,
> i did some test on monitor_on interface like this.
> 
> echo on > /sys/kernel/debug/damon/monitor_on
> [  851.988307] damon: kdamond (5390) starts
> 
> Though the ctx->adaptive_targets list is empty, but the
> kthread_run still be called, and the kdamond.x thread still
> be created, this is meaningless.

Good finding, thank you!

> 
> So there adds a judgment. only if the ctx->adaptive_targets
> list is not empty, and ctx->kdamond pointer is NULL, then call
> the __damon_start function.

I think we cannot believe user-space users, but kernel-space API users.  How
about adding the check in 'dbgfs_monitor_on_write()' rather than
'__damon_start()'?

Also, apparently this patch is based on latest 'damon/next' branch of my tree.
Could you please rebase this on latest -mm tree?


Thanks,
SJ

[...]
