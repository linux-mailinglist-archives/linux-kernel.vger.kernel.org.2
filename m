Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF78A30693D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 02:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhA1BBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 20:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhA1A6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 19:58:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03E0E61492;
        Thu, 28 Jan 2021 00:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1611795462;
        bh=GmiQS9jbtp67wxyW//Qr7OOg3keGiSKqCrr+Cvr/THQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jNzKXLmzl9LiQ21rTP0SVfohiEwxUxkWxj0ZvFfUqDClO67LIsQuTyZfG9aiheu5P
         BOcpcXor8txN0iXnkXOwGMmebCn/mlI9XHa+zjel4dFDcr0fXOC/nln9Ln4DA1/DSz
         fdLxLlePGrOYRaRkJW9KT4zgNLnAuly6cAIHXZOo=
Date:   Wed, 27 Jan 2021 16:57:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     vjitta@codeaurora.org
Cc:     minchan@kernel.org, glider@google.com, dan.j.williams@intel.com,
        broonie@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, ylal@codeaurora.org,
        vinmenon@codeaurora.org
Subject: Re: [PATCH v6 2/2] lib: stackdepot: Add support to disable stack
 depot
Message-Id: <20210127165740.d3546f332ed49c5570b06057@linux-foundation.org>
In-Reply-To: <1611749198-24316-2-git-send-email-vjitta@codeaurora.org>
References: <1611749198-24316-1-git-send-email-vjitta@codeaurora.org>
        <1611749198-24316-2-git-send-email-vjitta@codeaurora.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 17:36:38 +0530 vjitta@codeaurora.org wrote:

> Add a kernel parameter stack_depot_disable to disable
> stack depot. So that stack hash table doesn't consume
> any memory when stack depot is disabled.
> 
> The usecase is CONFIG_PAGE_OWNER without page_owner=on.
> Without this patch, stackdepot will consume the memory
> for the hashtable. By default, it's 8M which is never trivial.
> 
> With this option, in CONFIG_PAGE_OWNER configured system,
> page_owner=off, stack_depot_disable in kernel command line,
> we could save the wasted memory for the hashtable.

CONFIG_STACKDEPOT=n:

main.c:(.init.text+0x4c1): undefined reference to `stack_depot_init'


--- a/include/linux/stackdepot.h~lib-stackdepot-add-support-to-disable-stack-depot-fix
+++ a/include/linux/stackdepot.h
@@ -21,5 +21,13 @@ unsigned int stack_depot_fetch(depot_sta
 
 unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_entries);
 
+#ifdef CONFIG_STACKDEPOT
 int stack_depot_init(void);
+#else
+static inline int stack_depot_init(void)
+{
+	return 0;
+}
+#endif	/* CONFIG_STACKDEPOT */
+
 #endif
_

