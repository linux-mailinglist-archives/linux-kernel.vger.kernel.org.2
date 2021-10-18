Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BBE4327B5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhJRTdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 15:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233182AbhJRTdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:33:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECC3B60E90;
        Mon, 18 Oct 2021 19:31:23 +0000 (UTC)
Date:   Mon, 18 Oct 2021 15:31:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     llvm@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Some potentially uninitialized values in pid_list_refill_irq()
Message-ID: <20211018153122.2f667226@gandalf.local.home>
In-Reply-To: <CAKXUXMyN-9JuK4Cg+5aUPWiL-0wnAJrvD4qZX3O5nCERou_j1w@mail.gmail.com>
References: <CAKXUXMyN-9JuK4Cg+5aUPWiL-0wnAJrvD4qZX3O5nCERou_j1w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 18:14:53 +0200
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Dear Steven,
> 
> Commit 8d6e90983ade ("tracing: Create a sparse bitmask for pid
> filtering") in linux-next adds the new function pid_list_refill_irq().
> For this function, 'make clang-analyzer' reports potentially
> uninitialized values for lower and upper under certain branch
> conditions, see the full report below.
> 
> As far as I understand the analyzer's report and the code at hand:
> 
> if lower_count is zero (and upper_count is not), then lower_next is
> not assigned (because the while lower_count loop is not entered) and
> lower is pointing to an address with an uninitialized value and hence,
> the if (lower) conditional reads this uninitialized value.
> 
> Analogously for upper_count:
> 
> if upper_count is zero (and lower_count is not), then upper_count is
> not assigned (because the while upper_count loop is not entered) and
> upper is pointing to an address with an uninitialized value and hence,
> the if (upper) conditional reads this uninitialized value.
> 
> I think this can be resolved by initializing upper and lower to point
> to an address carrying a zero; but I really fight understanding the
> whole pointer magic, you did :)
> 
> Let me know if clang-analyzer found something buggy here or if the
> tool and I misunderstood the code; we are certainly interested.
> 

No, you are the third (or fourth) person to report this. I just haven't
gotten around to pushing my fixes to linux-next, as my test boxes have been
busy testing stuff for current 5.15-rc. And the fixes are still in the
queue to be tested.

I'll have that fixed in a couple of days at most.

Thanks,

-- Steve
