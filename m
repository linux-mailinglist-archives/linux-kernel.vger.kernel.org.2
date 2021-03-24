Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F34347DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbhCXQ0u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Mar 2021 12:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235180AbhCXQ0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:26:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BC1961A01;
        Wed, 24 Mar 2021 16:26:47 +0000 (UTC)
Date:   Wed, 24 Mar 2021 12:26:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     akpm@linux-foundation.org, mingo@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Liam Mark <lmark@codeaurora.org>
Subject: Re: [PATCH] mm: cma: add trace events for CMA alloc perf testing
Message-ID: <20210324122645.05152010@gandalf.local.home>
In-Reply-To: <20210324160740.15901-1-georgi.djakov@linaro.org>
References: <20210324160740.15901-1-georgi.djakov@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 18:07:40 +0200
Georgi Djakov <georgi.djakov@linaro.org> wrote:

> From: Liam Mark <lmark@codeaurora.org>
> 
> Add cma and migrate trace events to enable CMA allocation
> performance to be measured via ftrace.
> 
> Signed-off-by: Liam Mark <lmark@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  include/trace/events/cma.h     | 39 +++++++++++++++++++++++++++++++++-
>  include/trace/events/migrate.h | 22 +++++++++++++++++++
>  mm/cma.c                       |  4 ++++
>  mm/migrate.c                   |  2 ++
>  4 files changed, 66 insertions(+), 1 deletion(-)

From a tracing perspective:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
