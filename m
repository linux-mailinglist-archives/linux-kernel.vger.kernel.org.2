Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0669B32542E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhBYQ7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:59:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35573 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233906AbhBYQ7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:59:03 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1BF464E83;
        Thu, 25 Feb 2021 16:58:21 +0000 (UTC)
Date:   Thu, 25 Feb 2021 11:58:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Cc:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] Fix for the latency-collector
Message-ID: <20210225115820.7a0ec44d@gandalf.local.home>
In-Reply-To: <20210225165248.22050-1-Viktor.Rosendahl@bmw.de>
References: <20210225165248.22050-1-Viktor.Rosendahl@bmw.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021 17:52:47 +0100
Viktor Rosendahl <Viktor.Rosendahl@bmw.de> wrote:

> Hi Steve,
> 
> I am not sure what is the correct approach to handle this latency-collector
> fix. Can you take it into your queue?

Yes I can take it. I was going to just pull this in for the next merge
window as it's not as critical. But because the change is not likely to
cause any issues with other parts of the kernel, I'll queue it up for my
next push to Linus (as I have some other fixes to send him).

-- Steve


> 
> best regards,
> 
> Viktor
> 
> Colin Ian King (1):
>   tracing/tools: fix a couple of spelling mistakes
> 
>  tools/tracing/latency/latency-collector.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
