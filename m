Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E66334D7AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhC2S7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhC2S67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:58:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FA6C061574;
        Mon, 29 Mar 2021 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/t3sDjCOg+looCPLpwW0cPQdgu0ulEgPF9JDnwqY/qQ=; b=GZum5RC4zLbbb8tyX5Q37B5iIc
        HavRXjXAIA1cZvk0ueXUNNhouTlihRVJKstbRg6PcDzSrcY8t8zmyiQEoB17MjunLRuzFHl6lCpzH
        CftTnOn3rWXLdJawCo8zo3iqxkeca7IvLz2EhIDAzNHWzQ5FWHFO7hXAsv4Se5T3ZFBGsI4G6KQfk
        14DKxZ7lwseCTsQQb52WXkUBu/w4j9fEY63XGc1M0xpceLcwlsVAwb/Lnp5Zls99vSkr2wJK2h7PY
        /nILANETM3uifLRUV7VOHvS7MmGfKexV2aIB1bjml9FUoreRV3YSVtFUrIKCCl0TIWiV5g3GBrt8Y
        u6ofRIdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lQx63-001yry-Oi; Mon, 29 Mar 2021 18:58:45 +0000
Date:   Mon, 29 Mar 2021 19:58:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: better handle '::' sequences
Message-ID: <20210329185843.GK351017@casper.infradead.org>
References: <20210325184615.08526aed@coco.lan>
 <2cf44cf1fa42588632735d4fbc8e84304bdc235f.1616696051.git.mchehab+huawei@kernel.org>
 <87tuozyslu.fsf@meer.lwn.net>
 <20210325191435.GZ1719932@casper.infradead.org>
 <87a6qrx7wf.fsf@meer.lwn.net>
 <20210325221437.GA1719932@casper.infradead.org>
 <87wntux3w7.fsf@meer.lwn.net>
 <20210329144204.GF351017@casper.infradead.org>
 <874kgtq079.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kgtq079.fsf@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 09:33:30PM +0300, Jani Nikula wrote:
> On Mon, 29 Mar 2021, Matthew Wilcox <willy@infradead.org> wrote:
> > So here's my "modest proposal":
> >
> >  - Similar to our ".. kernel-doc::" invocation in .rst files, handle
> >    ".. rustdoc::" (insert weeks of hacking here)
> >  - Now add ".. rst-doc::" which parses .c files like [1] kernel-doc
> >    does, but interprets a different style of comment and actually does
> >    most of the repetitive boring bits for you.
> 
> As a hobby, I've written a Sphinx extension to use Clang to parse the
> code and extract pure reStructuredText documentation comments with
> minimal conversions [1]. No additional syntax. Just use reStructuredText
> for everything instead of inventing your own.
> 
> I'm not proposing to use that in kernel, at all. It was more like a
> diversion from the kernel documentation.

Actually, that looks like my proposal, except that it uses the same /**
as kernel-doc, so you can't tell whether a comment is intended to be
interpreted by kernel-doc or hawkmoth.

https://github.com/jnikula/hawkmoth/blob/master/test/example-70-function.c

If the introduction were "/*rST" instead of "/**", would we have
consensus?  It gives us a path to let people intermix kernel-doc and
hawkmoth comments in the same file, which would be amazing.

> But based on my experience with the old and new kernel documentation
> systems and the hobby one, the one takeaway is to not create new
> syntaxes, grammars, parsers, or preprocessors to be maintained by the
> kernel community. Just don't. Take what's working and supported by other
> projects, and add the minimal glue using Sphinx extensions to put it
> together, and no more.
> 
> Of course, we couldn't ditch kernel-doc the script, but we managed to
> trim it down quite a bit. OTOH, there have been a number of additions
> outside of Sphinx in Makefiles and custom tools in various languages
> that I'm really not happy about. It's all too reminiscient of the old
> DocBook toolchain, while Sphinx was supposed to be the one tool to tie
> it all together, partially chosen because of the extension support.
> 
> 
> BR,
> Jani.
> 
> 
> [1] https://github.com/jnikula/hawkmoth
> 
> 
> >
> > For example, xa_load:
> >
> > /**
> >  * xa_load() - Load an entry from an XArray.
> >  * @xa: XArray.
> >  * @index: index into array.
> >  *
> >  * Context: Any context.  Takes and releases the RCU lock.
> >  * Return: The entry at @index in @xa.
> >  */
> > void *xa_load(struct xarray *xa, unsigned long index)
> >
> > //rST
> > // Load an entry from an XArray.
> > //
> > // :Context: Any context.  Takes and releases the RCU lock.
> > // :Return: The entry in `xa` at `index`.
> > void *xa_load(struct xarray *xa, unsigned long index)
> >
> > (more complex example below [2])
> >
> > Things I considered:
> >
> >  - Explicitly document that this is rST markup instead of Markdown or
> >    whatever.
> >  - Don't repeat the name of the function.  The tool can figure it out.
> >  - Don't force documenting each parameter.  Often they are obvious
> >    and there's really nothing interesting to say about the parameter.
> >    Witness the number of '@foo: The foo' (of type struct foo) that we
> >    have scattered throughout the tree.  It's not that the documenter is
> >    lazy, it's that there's genuinely nothing to say here.
> >  - Use `interpreted text` to refer to parameters instead of *emphasis* or
> >    **strong emphasis**.  The tool can turn that into whatever markup
> >    is appropriate.
> >  - Use field lists for Context and Return instead of sections.  The markup
> >    is simpler to use, and I think the rendered output is better.
> >
> > [1] by which i mean "in a completely different way from, but similar in
> >     concept"
> >
> > [2] More complex example:
> >
> > /**
> >  * xa_store() - Store this entry in the XArray.
> >  * @xa: XArray.
> >  * @index: Index into array.
> >  * @entry: New entry.
> >  * @gfp: Memory allocation flags.
> >  *
> >  * After this function returns, loads from this index will return @entry.
> >  * Storing into an existing multi-index entry updates the entry of every index.
> >  * The marks associated with @index are unaffected unless @entry is %NULL.
> >  *
> >  * Context: Any context.  Takes and releases the xa_lock.
> >  * May sleep if the @gfp flags permit.
> >  * Return: The old entry at this index on success, xa_err(-EINVAL) if @entry
> >  * cannot be stored in an XArray, or xa_err(-ENOMEM) if memory allocation
> >  * failed.
> >  */
> > void *xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
> >
> > //rST
> > // Store an entry in the XArray.
> > //
> > // After this function returns, loads from `index` will return `entry`.
> > // Storing into an existing multi-index entry updates the entry of every index.
> > // The marks associated with `index` are unaffected unless `entry` is ``NULL``.
> > //
> > // :Context: Any context.  Takes and releases the xa_lock.
> > //    May sleep if the `gfp` flags permit.
> > // :Return: The old entry at this index on success, xa_err(-EINVAL) if `entry`
> > //    cannot be stored in an XArray, or xa_err(-ENOMEM) if memory allocation
> > //    failed.
> > void *xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
> >
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center
