Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386D84006CD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 22:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhICUnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 16:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350618AbhICUnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 16:43:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30FC3603E7;
        Fri,  3 Sep 2021 20:42:00 +0000 (UTC)
Date:   Fri, 3 Sep 2021 16:41:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild] [trace:ftrace/core 35/39]
 kernel/trace/trace_boot.c:420 trace_boot_init_histograms() warn: curly
 braces intended?
Message-ID: <20210903164158.55debf55@gandalf.local.home>
In-Reply-To: <20210901110713.fed0ebd23c05033045953642@kernel.org>
References: <202109010207.nUISBZUN-lkp@intel.com>
        <20210901110713.fed0ebd23c05033045953642@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2021 11:07:13 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > The missing curly braces here trigger a ball of static checker warnings.
> > I'm so happy about that.  :)  
> 
> The ftrace/core branch has a wrong version of the patch. ftrae/for-next has
> correct one. I think Steve correct this mismatch after he comes back.

Yeah, I started focusing on my ftrace/for-next branch and stopped pushing
to ftrace/core. "core" is my development branch that can rebase, "for-next"
only rebases for adding tags, but the content should seldom change.

I already sent Linus a pull request, but I'll go and fix ftrace/core now.

Thanks for letting me know.

-- Steve
