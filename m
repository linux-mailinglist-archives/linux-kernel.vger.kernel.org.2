Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738F44031F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 02:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245437AbhIHApO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 20:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhIHApN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 20:45:13 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09A9F610F8;
        Wed,  8 Sep 2021 00:44:05 +0000 (UTC)
Date:   Tue, 7 Sep 2021 20:44:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] tools/bootconfig: Fix a compilation issue with
 missing variable
Message-ID: <20210907204404.3a210307@rorschach.local.home>
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
> 
> Hi Masami,
> 
> I am not sure what went wrong but the patch in the lore link[0]
> doesn't match the end result (bad merge?). You may want to recheck the
> other changes to make sure it all looks sane.
> 
> Regards,
> Punit
> 
> [0] https://lkml.kernel.org/r/162262194685.264090.7738574774030567419.stgit@devnote2

OK, I looked into this deeper, and found it to be a merge conflict bug.

Although I test the bootconfig kernel side, I didn't test the
bootconfig tools side (need to update my tests)

I applied

   https://lkml.kernel.org/r/20210414134647.1870-1-zuoqilin1@163.com

first, and then applied this patch, and made the (incorrect) updates.

I didn't test the tools build (which I need to update), and that's the
cause of the bug.

Thanks for the report.

-- Steve


