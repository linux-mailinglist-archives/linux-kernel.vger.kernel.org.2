Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DF14031D1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 02:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhIHAZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 20:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhIHAZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 20:25:09 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7BD061101;
        Wed,  8 Sep 2021 00:24:01 +0000 (UTC)
Date:   Tue, 7 Sep 2021 20:24:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] tools/bootconfig: Fix a compilation issue with
 missing variable
Message-ID: <20210907202400.330f4ea4@rorschach.local.home>
In-Reply-To: <20210907230710.1189193-1-punitagrawal@gmail.com>
References: <20210907230710.1189193-1-punitagrawal@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Sep 2021 08:07:10 +0900
Punit Agrawal <punitagrawal@gmail.com> wrote:

> While looking to build bootconfig tool in order to debug a kernel boot
> time issue I noticed that tool fails to compile. The broken changes
> were introduced by commit e5efaeb8a8f5 ("bootconfig: Support mixing a
> value and subkeys under a key").
> 
> Fix the compile issue by introducing a "ret" variable to track the
> return value from xbc_node_compose_key().
> 
> Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
> 
> (Apologies for the resend. I fat-fingered the email address for lkml)

And I'm resending my reply to have it recorded as well.

> 
> Hi Masami,
> 
> I am not sure what went wrong but the patch in the lore link[0]
> doesn't match the end result (bad merge?). You may want to recheck the
> other changes to make sure it all looks sane.


Thanks for reporting this. This is strange. Especially since it's all
scripts that are used to import these.

I do remember doing a rebase to fix some issues in another unrelated
patch. I wonder if I accidentally messed this up during that rebase :-/

I'll have to investigate this.

I'll checkout the tree before the affected patch, and reapply the
changes from my scripts to see if it wasn't my script that broke.

Again, thanks for reporting this!

-- Steve


