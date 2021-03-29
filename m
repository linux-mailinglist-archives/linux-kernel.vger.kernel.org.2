Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84EB34D29D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhC2OmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhC2OmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:42:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7B4C061574;
        Mon, 29 Mar 2021 07:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vm5zEBeCPjD/iTb+A5QL77YLz7/wSFqZ0VuA9U9AgEM=; b=kT2Fd56bQGmbq/1CmBtaGTGHVG
        e2KkNwqoWY0Y/4v5WBRDuuO6zozf1tbLLntGEsGcgeKVozhxzToJX2mVndhVSa0a58LeYqtbPWtN0
        DdpHSXCo8Jea3ZRN9GEX+xTWg/7xCmvioG9rldxACMgP5V1Erxiddj6WCOggYR+adw6koqOLYbqyc
        3qQ6f5+jiU2njHRjZkAT6L+rUhKiAHqgVwB3m9uJmkWPPMSH6HovlmoHHvnKmS8CPamLxa+BTDxE5
        v3e0xmwKJugkN7UiiLfMqsKTkBhMtI7Zg0d/WiODJJk2HrapVdktQC7riVD8xax+ZLVjMe9hF5y16
        v4OMmQYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lQt5g-001hhO-K7; Mon, 29 Mar 2021 14:42:09 +0000
Date:   Mon, 29 Mar 2021 15:42:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: better handle '::' sequences
Message-ID: <20210329144204.GF351017@casper.infradead.org>
References: <20210325184615.08526aed@coco.lan>
 <2cf44cf1fa42588632735d4fbc8e84304bdc235f.1616696051.git.mchehab+huawei@kernel.org>
 <87tuozyslu.fsf@meer.lwn.net>
 <20210325191435.GZ1719932@casper.infradead.org>
 <87a6qrx7wf.fsf@meer.lwn.net>
 <20210325221437.GA1719932@casper.infradead.org>
 <87wntux3w7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wntux3w7.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 04:30:32PM -0600, Jonathan Corbet wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > The rust code is alredy coming though ...
> >
> > rust/kernel/buffer.rs:/// A pre-allocated buffer that implements [`core::fmt::Write`].
> >
> > so now we have three formats.  Markdown and RST are _very_ similar, but
> > not identical [1].  Oh, and even better we now have three distinct tools --
> > kerneldoc, rustdoc and sphinx.  Have the rust people reached out to you
> > about integrating the various docs?
> 
> I have talked with them a bit, yes, but without any clear conclusions at
> this point.  The Rust world has its own way of doing things with regard
> to documentation, and I don't want to tell them they can't use it in the
> kernel context.  So I think there's going to be a certain amount of
> groping around for the best solution.
> 
> We did come to the mutual agreement that teaching kernel-doc to parse
> Rust code as well was not an ideal solution.  Probably there will be
> some sort of tool to translate between rustdoc and our sphinx setup.
> Beyond that, we'll see how it goes.

In the spirit of groping around for the best solution, I did some looking
around at various options, including using rustdoc for .c files (that
uses Markdown, which appears to be strictly worse than rST for our
purposes).

So here's my "modest proposal":

 - Similar to our ".. kernel-doc::" invocation in .rst files, handle
   ".. rustdoc::" (insert weeks of hacking here)
 - Now add ".. rst-doc::" which parses .c files like [1] kernel-doc
   does, but interprets a different style of comment and actually does
   most of the repetitive boring bits for you.

For example, xa_load:

/**
 * xa_load() - Load an entry from an XArray.
 * @xa: XArray.
 * @index: index into array.
 *
 * Context: Any context.  Takes and releases the RCU lock.
 * Return: The entry at @index in @xa.
 */
void *xa_load(struct xarray *xa, unsigned long index)

//rST
// Load an entry from an XArray.
//
// :Context: Any context.  Takes and releases the RCU lock.
// :Return: The entry in `xa` at `index`.
void *xa_load(struct xarray *xa, unsigned long index)

(more complex example below [2])

Things I considered:

 - Explicitly document that this is rST markup instead of Markdown or
   whatever.
 - Don't repeat the name of the function.  The tool can figure it out.
 - Don't force documenting each parameter.  Often they are obvious
   and there's really nothing interesting to say about the parameter.
   Witness the number of '@foo: The foo' (of type struct foo) that we
   have scattered throughout the tree.  It's not that the documenter is
   lazy, it's that there's genuinely nothing to say here.
 - Use `interpreted text` to refer to parameters instead of *emphasis* or
   **strong emphasis**.  The tool can turn that into whatever markup
   is appropriate.
 - Use field lists for Context and Return instead of sections.  The markup
   is simpler to use, and I think the rendered output is better.

[1] by which i mean "in a completely different way from, but similar in
    concept"

[2] More complex example:

/**
 * xa_store() - Store this entry in the XArray.
 * @xa: XArray.
 * @index: Index into array.
 * @entry: New entry.
 * @gfp: Memory allocation flags.
 *
 * After this function returns, loads from this index will return @entry.
 * Storing into an existing multi-index entry updates the entry of every index.
 * The marks associated with @index are unaffected unless @entry is %NULL.
 *
 * Context: Any context.  Takes and releases the xa_lock.
 * May sleep if the @gfp flags permit.
 * Return: The old entry at this index on success, xa_err(-EINVAL) if @entry
 * cannot be stored in an XArray, or xa_err(-ENOMEM) if memory allocation
 * failed.
 */
void *xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)

//rST
// Store an entry in the XArray.
//
// After this function returns, loads from `index` will return `entry`.
// Storing into an existing multi-index entry updates the entry of every index.
// The marks associated with `index` are unaffected unless `entry` is ``NULL``.
//
// :Context: Any context.  Takes and releases the xa_lock.
//    May sleep if the `gfp` flags permit.
// :Return: The old entry at this index on success, xa_err(-EINVAL) if `entry`
//    cannot be stored in an XArray, or xa_err(-ENOMEM) if memory allocation
//    failed.
void *xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)

