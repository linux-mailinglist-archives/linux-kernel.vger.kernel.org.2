Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA3D34D850
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhC2TeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhC2TeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:34:15 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A686EC061574;
        Mon, 29 Mar 2021 12:34:15 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5598E5CC;
        Mon, 29 Mar 2021 19:34:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5598E5CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1617046455; bh=uzFXcG0h/iYERcvHtbYCNxggA1K+2rAr3AVX/yFCPd8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hdTGzRUX36cS3AH7waEjn9eMbrPj1cCWz1qv0+eWGCZqcpX9jXF3tjIiIMy9cWoPm
         WuZiviyQ/iwy48hj0CId1CbERQjHPsg4GUs25pFajjfk9I+H0JUhaAetWmgSMRHT/L
         ulms3pTcjQgJPkMaYlIqmFMbNXJVIV+KrPFPNx4H3DdqiE2bdUtYsxhNWqlR3ZZO++
         dtMQ9EnQ9/5PebdGSqa7slpq8A/cqhgXSGM45sWOXLh+OStH7JHyrX847A+6BD97yh
         5ky61eqcz97I97sB3aQ0TmvBUf+ZcV+vC/b4mUzBw+vBLMWtR0TqJbhOsjnLPKcXLi
         vFs+p08/7DGCg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: kerneldoc and rust (was [PATCH] kernel-doc: better handle '::'
 sequences)
In-Reply-To: <20210329144204.GF351017@casper.infradead.org>
References: <20210325184615.08526aed@coco.lan>
 <2cf44cf1fa42588632735d4fbc8e84304bdc235f.1616696051.git.mchehab+huawei@kernel.org>
 <87tuozyslu.fsf@meer.lwn.net>
 <20210325191435.GZ1719932@casper.infradead.org>
 <87a6qrx7wf.fsf@meer.lwn.net>
 <20210325221437.GA1719932@casper.infradead.org>
 <87wntux3w7.fsf@meer.lwn.net>
 <20210329144204.GF351017@casper.infradead.org>
Date:   Mon, 29 Mar 2021 13:34:14 -0600
Message-ID: <87czvhrbyh.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

If we're going to talk about incorporating Rust into the doc system, we
should probably include some Rust folks - thus, I'm adding Miguel.

> On Thu, Mar 25, 2021 at 04:30:32PM -0600, Jonathan Corbet wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> 
>> We did come to the mutual agreement that teaching kernel-doc to parse
>> Rust code as well was not an ideal solution.  Probably there will be
>> some sort of tool to translate between rustdoc and our sphinx setup.
>> Beyond that, we'll see how it goes.
>
> In the spirit of groping around for the best solution, I did some looking
> around at various options, including using rustdoc for .c files (that
> uses Markdown, which appears to be strictly worse than rST for our
> purposes).
>
> So here's my "modest proposal":
>
>  - Similar to our ".. kernel-doc::" invocation in .rst files, handle
>    ".. rustdoc::" (insert weeks of hacking here)
>  - Now add ".. rst-doc::" which parses .c files like [1] kernel-doc
>    does, but interprets a different style of comment and actually does
>    most of the repetitive boring bits for you.
>
> For example, xa_load:
>
> /**
>  * xa_load() - Load an entry from an XArray.
>  * @xa: XArray.
>  * @index: index into array.
>  *
>  * Context: Any context.  Takes and releases the RCU lock.
>  * Return: The entry at @index in @xa.
>  */
> void *xa_load(struct xarray *xa, unsigned long index)
>
> //rST
> // Load an entry from an XArray.
> //
> // :Context: Any context.  Takes and releases the RCU lock.
> // :Return: The entry in `xa` at `index`.
> void *xa_load(struct xarray *xa, unsigned long index)
>
> (more complex example below [2])
>
> Things I considered:
>
>  - Explicitly document that this is rST markup instead of Markdown or
>    whatever.
>  - Don't repeat the name of the function.  The tool can figure it out.

That worries me a wee bit just because a common source of problems is
kerneldoc comments becoming separated from the functions they describe
over time.  We finally have tooling to notice that; this seems like a
step in the other direction.

>  - Don't force documenting each parameter.  Often they are obvious
>    and there's really nothing interesting to say about the parameter.
>    Witness the number of '@foo: The foo' (of type struct foo) that we
>    have scattered throughout the tree.  It's not that the documenter is
>    lazy, it's that there's genuinely nothing to say here.

...another failure mode is developers adding parameters and not
documenting them; this would mask that problem too.

>  - Use `interpreted text` to refer to parameters instead of *emphasis* or
>    **strong emphasis**.  The tool can turn that into whatever markup
>    is appropriate.
>  - Use field lists for Context and Return instead of sections.  The markup
>    is simpler to use, and I think the rendered output is better.
>
> [1] by which i mean "in a completely different way from, but similar in
>     concept"
>
> [2] More complex example:
>
> /**
>  * xa_store() - Store this entry in the XArray.
>  * @xa: XArray.
>  * @index: Index into array.
>  * @entry: New entry.
>  * @gfp: Memory allocation flags.
>  *
>  * After this function returns, loads from this index will return @entry.
>  * Storing into an existing multi-index entry updates the entry of every index.
>  * The marks associated with @index are unaffected unless @entry is %NULL.
>  *
>  * Context: Any context.  Takes and releases the xa_lock.
>  * May sleep if the @gfp flags permit.
>  * Return: The old entry at this index on success, xa_err(-EINVAL) if @entry
>  * cannot be stored in an XArray, or xa_err(-ENOMEM) if memory allocation
>  * failed.
>  */
> void *xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
>
> //rST
> // Store an entry in the XArray.
> //
> // After this function returns, loads from `index` will return `entry`.
> // Storing into an existing multi-index entry updates the entry of every index.
> // The marks associated with `index` are unaffected unless `entry` is ``NULL``.
> //
> // :Context: Any context.  Takes and releases the xa_lock.
> //    May sleep if the `gfp` flags permit.
> // :Return: The old entry at this index on success, xa_err(-EINVAL) if `entry`
> //    cannot be stored in an XArray, or xa_err(-ENOMEM) if memory allocation
> //    failed.
> void *xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)

Thanks,

jon
