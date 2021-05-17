Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED04F383967
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242882AbhEQQPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:15:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240287AbhEQPvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:51:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCA2060FF3;
        Mon, 17 May 2021 15:24:35 +0000 (UTC)
Date:   Mon, 17 May 2021 11:24:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Devin Moore <devinmoore@google.com>
Subject: Re: [PATCH 1/4] bootconfig: Change array value to use child node
Message-ID: <20210517112434.570fd87b@gandalf.local.home>
In-Reply-To: <162117693103.9011.18172892676114426345.stgit@devnote2>
References: <162117692155.9011.16682190750100804269.stgit@devnote2>
        <162117693103.9011.18172892676114426345.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 May 2021 23:55:31 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Change array value to use child node of the xbc_node tree
> instead of next node.

Hi Masami,

This says what you did, not why you did it. Can you add a comment about
what the purpose of this change was?

Thanks!

-- Steve


> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/bootconfig/main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
