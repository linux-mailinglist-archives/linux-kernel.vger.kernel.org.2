Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DB234D74D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhC2SeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:34:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:15369 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhC2Sdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:33:36 -0400
IronPort-SDR: LSxqw8Yved18eHCFeiCt9yXtnhIq3gYgvIWvg3Vg8eel9KT1TyDjI/8nu2dgOCNquA+xK56CDY
 bqr9qGn0GGXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="276770688"
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="276770688"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 11:33:36 -0700
IronPort-SDR: b6dMCHmsN/szLMRFtlDYijrVu5YTBH2pJDqufuaQmqjltYgrY1AFsxfDObNd2XGb5xzdgX6L0s
 8yrIibqi5onA==
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="417793139"
Received: from auchter-mobl.ger.corp.intel.com (HELO localhost) ([10.252.56.199])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 11:33:33 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: better handle '::' sequences
In-Reply-To: <20210329144204.GF351017@casper.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210325184615.08526aed@coco.lan> <2cf44cf1fa42588632735d4fbc8e84304bdc235f.1616696051.git.mchehab+huawei@kernel.org> <87tuozyslu.fsf@meer.lwn.net> <20210325191435.GZ1719932@casper.infradead.org> <87a6qrx7wf.fsf@meer.lwn.net> <20210325221437.GA1719932@casper.infradead.org> <87wntux3w7.fsf@meer.lwn.net> <20210329144204.GF351017@casper.infradead.org>
Date:   Mon, 29 Mar 2021 21:33:30 +0300
Message-ID: <874kgtq079.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021, Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Mar 25, 2021 at 04:30:32PM -0600, Jonathan Corbet wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> 
>> > The rust code is alredy coming though ...
>> >
>> > rust/kernel/buffer.rs:/// A pre-allocated buffer that implements [`core::fmt::Write`].
>> >
>> > so now we have three formats.  Markdown and RST are _very_ similar, but
>> > not identical [1].  Oh, and even better we now have three distinct tools --
>> > kerneldoc, rustdoc and sphinx.  Have the rust people reached out to you
>> > about integrating the various docs?
>> 
>> I have talked with them a bit, yes, but without any clear conclusions at
>> this point.  The Rust world has its own way of doing things with regard
>> to documentation, and I don't want to tell them they can't use it in the
>> kernel context.  So I think there's going to be a certain amount of
>> groping around for the best solution.
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

As a hobby, I've written a Sphinx extension to use Clang to parse the
code and extract pure reStructuredText documentation comments with
minimal conversions [1]. No additional syntax. Just use reStructuredText
for everything instead of inventing your own.

I'm not proposing to use that in kernel, at all. It was more like a
diversion from the kernel documentation.

But based on my experience with the old and new kernel documentation
systems and the hobby one, the one takeaway is to not create new
syntaxes, grammars, parsers, or preprocessors to be maintained by the
kernel community. Just don't. Take what's working and supported by other
projects, and add the minimal glue using Sphinx extensions to put it
together, and no more.

Of course, we couldn't ditch kernel-doc the script, but we managed to
trim it down quite a bit. OTOH, there have been a number of additions
outside of Sphinx in Makefiles and custom tools in various languages
that I'm really not happy about. It's all too reminiscient of the old
DocBook toolchain, while Sphinx was supposed to be the one tool to tie
it all together, partially chosen because of the extension support.


BR,
Jani.


[1] https://github.com/jnikula/hawkmoth


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
>  - Don't force documenting each parameter.  Often they are obvious
>    and there's really nothing interesting to say about the parameter.
>    Witness the number of '@foo: The foo' (of type struct foo) that we
>    have scattered throughout the tree.  It's not that the documenter is
>    lazy, it's that there's genuinely nothing to say here.
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
>

-- 
Jani Nikula, Intel Open Source Graphics Center
