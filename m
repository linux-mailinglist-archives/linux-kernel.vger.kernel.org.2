Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E89540573A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353700AbhIINc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357679AbhIINPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:15:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D331611B0;
        Thu,  9 Sep 2021 13:11:25 +0000 (UTC)
Date:   Thu, 9 Sep 2021 09:11:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] tracing/boot: bootconfig: Fixes and API name change
Message-ID: <20210909091123.29f17a6f@gandalf.local.home>
In-Reply-To: <163119172318.151131.7138254940364392100.stgit@devnote2>
References: <163119172318.151131.7138254940364392100.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Sep 2021 21:48:43 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is a series of patches to fix some issues on boot-time tracing
> and bootconfig. Yesterday I sent a bugfix(*), and today I found some
> other issues.
> 
> (*) https://lore.kernel.org/all/163112988361.74896.2267026262061819145.stgit@devnote2/T/#u
> 
> This includes following patches.
> 
> [1/3] tracing/boot: Fix trace_boot_hist_add_array() to check array is value
> 
> [2/3] tracing/boot: Fix to check the histogram control param is a leaf node
> 
> [3/3] bootconfig: Rename xbc_node_find_child() to xbc_node_find_subkey()
>  - Rename xbc_node_find_child() to xbc_node_find_subkey() to avoid
>    confusing "child" and "subkey" words.
> 

Masami,

Did this go out correctly?

I only received this email, and this email is not showing up on LKML.

 (https://lore.kernel.org/r/163119172318.151131.7138254940364392100.stgit%40devnote2
 gives "Not found")

-- Steve


> 
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (3):
>       tracing/boot: Fix trace_boot_hist_add_array() to check array is value
>       tracing/boot: Fix to check the histogram control param is a leaf node
>       bootconfig: Rename xbc_node_find_child() to xbc_node_find_subkey()
> 
> 
>  include/linux/bootconfig.h |    4 ++--
>  kernel/trace/trace_boot.c  |   35 +++++++++++++++++------------------
>  lib/bootconfig.c           |    8 ++++----
>  3 files changed, 23 insertions(+), 24 deletions(-)
> 

