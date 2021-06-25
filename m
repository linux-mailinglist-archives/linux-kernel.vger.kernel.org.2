Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6FE3B3B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 06:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhFYELQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Jun 2021 00:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhFYELQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 00:11:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC3FE613FD;
        Fri, 25 Jun 2021 04:08:55 +0000 (UTC)
Date:   Fri, 25 Jun 2021 00:08:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yun Zhou <yun.zhou@windriver.com>
Cc:     linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        ying.xue@windriver.com, ps-ccm-rr@windriver.com
Subject: Re: [PATCH] seq_buf: let seq_buf_putmem_hex support len larger than
 8
Message-ID: <20210625000854.36ed6f2d@gandalf.local.home>
In-Reply-To: <32276a16-b893-bdbb-e552-7f5ecaaec5f1@windriver.com>
References: <20210624131646.17878-1-yun.zhou@windriver.com>
        <20210624105422.5c8aaf4d@oasis.local.home>
        <32276a16-b893-bdbb-e552-7f5ecaaec5f1@windriver.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 11:41:35 +0800
Yun Zhou <yun.zhou@windriver.com> wrote:

> Hi Steve,
> 
> Thanks very much for your friendly and clear feedback.
> 
> Although in current kernel trace_seq_putmem_hex() is only used for 
> single word,
> 
> I think it should/need support longer data. These are my arguments:
> 
> 1. The design of double loop is used to process more data. If only 
> supports single word,
> 
>      the inner loop is enough, and the outer loop and the following 
> lines are no longer needed.
> 
>          len -= j / 2;
> 
>          hex[j++] = ' ';
> 
> 2. The last line above try to split two words/dwords with space. If only 
> supports single word,
> 
>      this strange behavior is hard to understand.
> 
> 3. If it only supports single word, I think parameter 'len' is redundant.

Not really, we have to differentiate char, short, int and long long.

> 
> 4. The comments of both seq_buf_putmem_hex() and trace_seq_putmem_hex() 
> have not
> 
>      indicated the scope of 'len'.
> 
> 5. If it only supports single word, we need to design a new function to 
> support bigger block of data.
> 
>       I think it is redundant since the current function can perfectly 
> deal with.
> 
> 6. If follow my patch, it can support any length of data, including the 
> single word.
> 
> How do you think?

First, since you found a real bug, we need to just fix that first (single
word as is done currently). Because this needs to go to stable, and what
you are explaining above is an enhancement, and not something that needs to
be backported.

Second, is there a use case? Honestly, I never use the "hex" version of the
output. That was only pulled in because it was implemented in the original
code that was in the rt patch. I wish we could just get rid of it.

Thus, if there's a use case for handling more than one word, then I'm fine
with adding that enhancement. But if it is being done just because it can
be, then I don't think we should bother.

What use case do you have in mind?

Anyway, please send just a fix patch, and then we can discuss the merits of
this update later. I'd like the fix to be in ASAP.

Thanks!

-- Steve
