Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E9F40BD47
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhIOBqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:46:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhIOBqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:46:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52A9160F6C;
        Wed, 15 Sep 2021 01:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631670294;
        bh=AHU95kX8K9H+u3hfWH31TWVQUq+XxncGivmhHM7Hmcw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gxthpra9GO98emsJK8Oxl33MSQDeMbMNlPUs5DkQpY96vcnT/xlD4h3bQvSAfM55A
         tnL5aBW6x/gUBk2AzkmsONYVR1rz62WQ1jAewsbBEEEz0bIOgiFKuVo7uXVhaN1S/Z
         9OhMCnwzd8SWS7xSSzZleqUmvGbo87k32+6F4Q+h1FrnZQXpCwEDcwPrRX7HBIhNAQ
         F4Q9C2ZvewCesEfIjFwgo1jxBskDCNWbfnU5kxAr6PQRxRjl87MnMUC7+k5CZVlyH3
         1cD8gAkld2gvLPbE/tERLZZriywYTV0A7fDawDnJNem+SDVaWmX/J3tT/8TgbLzOlc
         FIUkNG9HRTxwA==
Date:   Wed, 15 Sep 2021 10:44:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 1/5] bootconfig: Fix to check the xbc_node is used
 before free it
Message-Id: <20210915104452.9a3cfd0648a4edeca4583c84@kernel.org>
In-Reply-To: <CAHk-=whJAyOZN16BzB-YS8zYVNfSsRcCnMuvzfz6CMfuknwPDw@mail.gmail.com>
References: <163166717752.510331.12843735095061762373.stgit@devnote2>
        <163166718582.510331.11732633028925882626.stgit@devnote2>
        <CAHk-=whJAyOZN16BzB-YS8zYVNfSsRcCnMuvzfz6CMfuknwPDw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 18:12:28 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Sep 14, 2021 at 5:53 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Fix to check the xbc_node is used before calling memblock_free()
> > because passing NULL to phys_addr() will cause a panic.
> 
> No.
> 
> That's the previous bad situation.
> 
> The whole point of memblock_free_ptr() is that it actually acts the
> way a memory freeing function *should*, and has no problems with NULL
> pointers.

Oops, sorry. Please drop it.

> 
> >    - Rebase on top of Linus tree.
> 
> Please don't do a mindless rebase, take the actual changes into account.

Sorry about that. I missed the change.

Thank you,

> 
>          Linus


-- 
Masami Hiramatsu <mhiramat@kernel.org>
