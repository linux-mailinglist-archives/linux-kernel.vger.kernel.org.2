Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3871F40BD4B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhIOBsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhIOBsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:48:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47CD460FBF;
        Wed, 15 Sep 2021 01:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631670441;
        bh=kV/8C4i7eWTDSAKvUKgFEW1M+SrDYbH2T+hdA65Mr3I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JTpzq6AtQD3Skm3KS7nMAWQqaGsTKcd6qsjmygYD8QdafqAXrFrLOOlnBStqDJkqX
         E8cPohR3rz5A9hGtaZWlWklumfK3PaRFoeNQ3cqNcx16OkwiM4rpA0q39FF1cPaBBF
         EY79fEK+YGVcqNEfbwlJqCQ5ni/65E3D8T416WTe7vnyDxbiz94RukoNYS4EPF9Xua
         SvYdLDD4pNVVb0a8MFJI2XDkyzTQvddN8O3e91QhEnxD7RobeiwNULquYNFRmb2T0j
         jaqWYCPZbBdrL7z92K67BNLS1HyJnLqBb4gmf22FAAfFstnrg+iNOsTVBhA6GEXN8O
         VG9p2Dhx+ZBWQ==
Date:   Wed, 15 Sep 2021 10:47:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 5/5] tools/bootconfig: Define memblock_free_ptr() to
 fix build error
Message-Id: <20210915104718.135cb7393fb63bd8140105a2@kernel.org>
In-Reply-To: <CAHk-=whsAk7u0arWz37YbCyQPZgKfKOhrM1oKp+0B9uJk6J9OQ@mail.gmail.com>
References: <163166717752.510331.12843735095061762373.stgit@devnote2>
        <163166721835.510331.4931010992364519157.stgit@devnote2>
        <CAHk-=whsAk7u0arWz37YbCyQPZgKfKOhrM1oKp+0B9uJk6J9OQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 18:21:09 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Sep 14, 2021 at 5:53 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Since commit 77e02cf57b6c ("memblock: introduce saner
> > 'memblock_free_ptr()' interface") introduced memblock_free_ptr()
> > to lib/bootconfig.c, bootconfig tool also has to define
> > memblock_free_ptr() wrapper, and remove unused __pa() and
> > memblock_free().
> 
> Christ.
> 
> I grepped for this, and couldn't find any use of that memblock_free
> function in the tools directory, so I ignored it.
> 
> It seems like the code in lib/bootconfig.c is compiled both into the
> kernel and into that tool. This is a nightmare. We've explicitly tried
> to avoid this for the tooling headers exactly because of issues like
> this.

Hmm, OK. Let me copy lib/bootconfig.c itself into tools/bootconfig
as a user-space code.

Thank you,

> 
>            Linus


-- 
Masami Hiramatsu <mhiramat@kernel.org>
