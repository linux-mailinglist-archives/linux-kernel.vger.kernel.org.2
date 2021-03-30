Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8966C34E667
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhC3Lgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:36:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:49629 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229801AbhC3LgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:36:05 -0400
IronPort-SDR: BhBM94rhTZeXZgwX2b+lk1cMtAzvtzVK3hrlvSsqndWZb6KeQJbSAJfMEdtTcUgSZvkZrdoyLp
 aNaE/b/9eP0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="255738511"
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="255738511"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 04:36:02 -0700
IronPort-SDR: Qn/n0r1XTS6bViYTWeiG2zJwPkO507jha4/bTE/H7oRc42hKUx2kg8iW3rMwfbPgsgS8xyEJAT
 cCKf1t6qSVEg==
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="411566797"
Received: from ograu-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.175])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 04:36:00 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: better handle '::' sequences
In-Reply-To: <20210329185843.GK351017@casper.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210325184615.08526aed@coco.lan> <2cf44cf1fa42588632735d4fbc8e84304bdc235f.1616696051.git.mchehab+huawei@kernel.org> <87tuozyslu.fsf@meer.lwn.net> <20210325191435.GZ1719932@casper.infradead.org> <87a6qrx7wf.fsf@meer.lwn.net> <20210325221437.GA1719932@casper.infradead.org> <87wntux3w7.fsf@meer.lwn.net> <20210329144204.GF351017@casper.infradead.org> <874kgtq079.fsf@intel.com> <20210329185843.GK351017@casper.infradead.org>
Date:   Tue, 30 Mar 2021 14:35:57 +0300
Message-ID: <87tuosoov6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021, Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Mar 29, 2021 at 09:33:30PM +0300, Jani Nikula wrote:
>> On Mon, 29 Mar 2021, Matthew Wilcox <willy@infradead.org> wrote:
>> > So here's my "modest proposal":
>> >
>> >  - Similar to our ".. kernel-doc::" invocation in .rst files, handle
>> >    ".. rustdoc::" (insert weeks of hacking here)
>> >  - Now add ".. rst-doc::" which parses .c files like [1] kernel-doc
>> >    does, but interprets a different style of comment and actually does
>> >    most of the repetitive boring bits for you.
>> 
>> As a hobby, I've written a Sphinx extension to use Clang to parse the
>> code and extract pure reStructuredText documentation comments with
>> minimal conversions [1]. No additional syntax. Just use reStructuredText
>> for everything instead of inventing your own.
>> 
>> I'm not proposing to use that in kernel, at all. It was more like a
>> diversion from the kernel documentation.
>
> Actually, that looks like my proposal, except that it uses the same /**
> as kernel-doc, so you can't tell whether a comment is intended to be
> interpreted by kernel-doc or hawkmoth.
>
> https://github.com/jnikula/hawkmoth/blob/master/test/example-70-function.c
>
> If the introduction were "/*rST" instead of "/**", would we have
> consensus?  It gives us a path to let people intermix kernel-doc and
> hawkmoth comments in the same file, which would be amazing.

If you want to allow two syntaxes for documentation comments (current
kernel-doc and pure reStructuredText with just the comment markers and
indentation removed) I think the natural first step would be to modify
kernel-doc the perl script to support that. It would probably even be
trivial.

Hawkmoth uses Clang for parsing, with none of the kernel specific stuff
that kernel-doc has, such as EXPORT_SYMBOL(). It makes sense for a pet
project with a clean break. I don't know if anyone has the bandwidth or
desire to re-implement the kernel specific stuff on top of Clang. (I
know I don't, I started the project because I wanted that clean break to
begin with!)

The real question is, is it a good idea to support multiple formats at
all? (N.b. I'm not a fan of extending the kernel-doc syntax either.)

BR,
Jani.


>
>> But based on my experience with the old and new kernel documentation
>> systems and the hobby one, the one takeaway is to not create new
>> syntaxes, grammars, parsers, or preprocessors to be maintained by the
>> kernel community. Just don't. Take what's working and supported by other
>> projects, and add the minimal glue using Sphinx extensions to put it
>> together, and no more.
>> 
>> Of course, we couldn't ditch kernel-doc the script, but we managed to
>> trim it down quite a bit. OTOH, there have been a number of additions
>> outside of Sphinx in Makefiles and custom tools in various languages
>> that I'm really not happy about. It's all too reminiscient of the old
>> DocBook toolchain, while Sphinx was supposed to be the one tool to tie
>> it all together, partially chosen because of the extension support.
>> 
>> 
>> BR,
>> Jani.
>> 
>> 
>> [1] https://github.com/jnikula/hawkmoth
>> 
>> 
>> >
>> > For example, xa_load:
>> >
>> > /**
>> >  * xa_load() - Load an entry from an XArray.
>> >  * @xa: XArray.
>> >  * @index: index into array.
>> >  *
>> >  * Context: Any context.  Takes and releases the RCU lock.
>> >  * Return: The entry at @index in @xa.
>> >  */
>> > void *xa_load(struct xarray *xa, unsigned long index)
>> >
>> > //rST
>> > // Load an entry from an XArray.
>> > //
>> > // :Context: Any context.  Takes and releases the RCU lock.
>> > // :Return: The entry in `xa` at `index`.
>> > void *xa_load(struct xarray *xa, unsigned long index)
>> >
>> > (more complex example below [2])
>> >
>> > Things I considered:
>> >
>> >  - Explicitly document that this is rST markup instead of Markdown or
>> >    whatever.
>> >  - Don't repeat the name of the function.  The tool can figure it out.
>> >  - Don't force documenting each parameter.  Often they are obvious
>> >    and there's really nothing interesting to say about the parameter.
>> >    Witness the number of '@foo: The foo' (of type struct foo) that we
>> >    have scattered throughout the tree.  It's not that the documenter is
>> >    lazy, it's that there's genuinely nothing to say here.
>> >  - Use `interpreted text` to refer to parameters instead of *emphasis* or
>> >    **strong emphasis**.  The tool can turn that into whatever markup
>> >    is appropriate.
>> >  - Use field lists for Context and Return instead of sections.  The markup
>> >    is simpler to use, and I think the rendered output is better.
>> >
>> > [1] by which i mean "in a completely different way from, but similar in
>> >     concept"
>> >
>> > [2] More complex example:
>> >
>> > /**
>> >  * xa_store() - Store this entry in the XArray.
>> >  * @xa: XArray.
>> >  * @index: Index into array.
>> >  * @entry: New entry.
>> >  * @gfp: Memory allocation flags.
>> >  *
>> >  * After this function returns, loads from this index will return @entry.
>> >  * Storing into an existing multi-index entry updates the entry of every index.
>> >  * The marks associated with @index are unaffected unless @entry is %NULL.
>> >  *
>> >  * Context: Any context.  Takes and releases the xa_lock.
>> >  * May sleep if the @gfp flags permit.
>> >  * Return: The old entry at this index on success, xa_err(-EINVAL) if @entry
>> >  * cannot be stored in an XArray, or xa_err(-ENOMEM) if memory allocation
>> >  * failed.
>> >  */
>> > void *xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
>> >
>> > //rST
>> > // Store an entry in the XArray.
>> > //
>> > // After this function returns, loads from `index` will return `entry`.
>> > // Storing into an existing multi-index entry updates the entry of every index.
>> > // The marks associated with `index` are unaffected unless `entry` is ``NULL``.
>> > //
>> > // :Context: Any context.  Takes and releases the xa_lock.
>> > //    May sleep if the `gfp` flags permit.
>> > // :Return: The old entry at this index on success, xa_err(-EINVAL) if `entry`
>> > //    cannot be stored in an XArray, or xa_err(-ENOMEM) if memory allocation
>> > //    failed.
>> > void *xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
>> >
>> 
>> -- 
>> Jani Nikula, Intel Open Source Graphics Center

-- 
Jani Nikula, Intel Open Source Graphics Center
