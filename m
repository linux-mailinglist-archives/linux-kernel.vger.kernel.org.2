Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81ABF403FD0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350363AbhIHT3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230323AbhIHT3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:29:40 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38BE361104;
        Wed,  8 Sep 2021 19:28:32 +0000 (UTC)
Date:   Wed, 8 Sep 2021 15:28:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julio Faracco <jcfaracco@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-next][PATCH 08/12] bootconfig: Fix missing return check of
 xbc_node_compose_key function
Message-ID: <20210908152825.1a07d8b2@oasis.local.home>
In-Reply-To: <20210908191954.608550008@goodmis.org>
References: <20210908191851.381347939@goodmis.org>
        <20210908191954.608550008@goodmis.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Sep 2021 15:18:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Julio Faracco <jcfaracco@gmail.com>
> 
> The function `xbc_show_list should` handle the keys during the
> composition. Even the errors returned by the compose function. Instead
> of removing the `ret` variable, it should save the value and show the
> exact error. This missing variable is causing a compilation issue also.
> 
> Link: https://lkml.kernel.org/r/163077087861.222577.12884543474750968146.stgit@devnote2
> 
> Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
> Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> Cc: stable@vgar.kernel.org

Oops, a typo. That should be: stable@vger.kernel.org or
stable@kernel.org. There is no "vgar" ;-)

I'll fix this up.

-- Steve


> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
