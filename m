Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021D342D1BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 06:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJNEzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 00:55:17 -0400
Received: from ms-fb01.so-net.ne.jp ([202.238.84.155]:63820 "EHLO
        ms-fb01.so-net.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhJNEzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 00:55:14 -0400
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Oct 2021 00:55:14 EDT
Received: from ms-mxout03.so-net.ne.jp (ms-mxout03.plus.so-net.ne.jp [10.240.82.19])
        by ms-fb01.so-net.ne.jp  with ESMTP id 19E3XrVZ013339
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 13:43:27 +0900
Received: from [192.168.11.5] ([106.167.171.201])
        by ms-mxout03.so-net.ne.jp with ESMTPA
        id asaSmIgYC6exMasaTm5OpS; Thu, 14 Oct 2021 13:43:25 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qa2.so-net.ne.jp;
        s=sn2018; t=1634186605;
        bh=W2MEUvnU1cJEN7axWdZPm78FTL94TY16/3Ym2mmDjyc=;
        h=To:Cc:References:Subject:From:Date:In-Reply-To;
        b=LpdEl6Sr/UZ7iCIQsyWEw2bLdZZTktEaogpf0tLx70ttOgJOLJ8zo3me0M7Ooagvs
         /wWxnVBw7HS/EgDdwZMONnaXNQenRUgWeF7yo1JEY5JbgA4vFuGu5xI3yRGXG0+Yqf
         ec5aGEs8QynbVA/3Fr4UL5rYq0dKU+NWM0lmmagQegaiZKZpS6BQ/hAfcbSOSFD61x
         IqeLa1OrluP+FupzE14fihG6fd3akJsxmk2L3yqu/0Vptbv9raPNWBl64ydEVfZZAD
         caIK1p68VszdRy5WjpILNX25+Xz5VxpvFS1qRzpTWRLIAx6NNz+dLZxbxX03+9P/Jp
         JHviXirPXg1+g==
To:     mst@redhat.com
Cc:     linux-kernel@vger.kernel.org, paulmck@linux.ibm.com,
        Akira Yokosawa <akiyks@gmail.com>
References: <20211011064233-mutt-send-email-mst@kernel.org>
Subject: Re: data dependency naming inconsistency
From:   Akira Yokosawa <akys@qa2.so-net.ne.jp>
Message-ID: <6c362de5-1d79-512c-37d0-81aaf5d335d1@qa2.so-net.ne.jp>
Date:   Thu, 14 Oct 2021 13:43:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011064233-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 07:07:08 -0400, Michael S. Tsirkin wrote:
> Hello Paul, all!

Hello Michael,

I thought Paul would respond soon, but looks like he has not
done so.
So, I'm trying to give some hint to your findings.

> I've been reading with interest Paul's posts about Rust interactions with LKMM
> https://paulmck.livejournal.com/63316.html
> and in particular it states:
> 		A data dependency involves a load whose return value directly or
> 	indirectly determine the value stored by a later store, which results in
> 	the load being ordered before the store.
> 
> This matches the perf book:
> 	A data dependency occurs when the value returned by
> 	a load instruction is used to compute the data stored by
> 	a later store instruction.

You might likely be aware, but these concern "data dependency",
not a _barrier_.

> 
> however, memory-barriers.txt states:
> 
>      A data dependency barrier is a partial ordering on interdependent loads
>      only; it is not required to have any effect on stores, independent loads
>      or overlapping loads.
> 
> It also says:
> 	A data-dependency barrier is not required to order dependent writes
> 	because the CPUs that the Linux kernel supports don't do writes
> 	until they are certain (1) that the write will actually happen, (2)
> 	of the location of the write, and (3) of the value to be written.

These concern the historic "data-dependency barrier", or
[smp_]read_barrier_depends(), which existed until Linux kernel v4.14.

> 
> so the result it the same: writes are ordered without a barrier,
> reads are ordered by a barrier.
> 
> However, it would seem that a bit more consistency in naming won't
> hurt.

So, I don't think the historic term of "data-dependency barrier"
can be changed.

I guess the right approach would be to further de-emphasize
"data-dependency barrier"/"data dependency barrier" in
memory-barriers.txt.

Rewrite by commit 8ca924aeb4f2 ("Documentation/barriers: Remove
references to [smp_]read_barrier_depends()") did some of such
changes, but it failed to update the introductory section of
"VARIETIES OF MEMORY BARRIER".
The part Michael quoted above belongs to it.
I don't think it has any merit keeping it around.

Also, there remain a couple of ascii-art diagrams concerning
<data dependency barrier> in the first part of "EXAMPLES OF MEMORY
BARRIER SEQUENCES" section, which, I think, can be removed as well.

Hope this helps clarify the circumstances.

Paul, what is your take on the naming of "data dependency"/
"data dependency barrier"?

        Thanks, Akira

> 
> Thanks,
> 
> -- 
> MST
