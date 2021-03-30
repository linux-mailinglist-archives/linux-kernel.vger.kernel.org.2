Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4199C34E86B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhC3NGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhC3NG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:06:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A15DC061574;
        Tue, 30 Mar 2021 06:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6og5A0G+M5gHPpagnvWrOM9DTLX0MuKZ8DNDVoTt3ko=; b=P857e9wHnQYj5BnkEFxJtl3xSh
        KzhAvUXq4rBJHfxmzp+1JexDguDBoYlnAFXxTKDX3aGnl5Bmhwkmu76WD4hHzcOEy5d+niLdL9VJK
        1cmMX/1DjYkCXwDdPxT0BFumz2AmFKC4eVFchZYmTpNAsMcgWImBAxlWPUMM3R5k639OQxYb4YkK3
        fkEnMTDhj0axgiibIz6M/rMw+4l3cYDOr2A7NSutDq5psIhWnqRy0/qkY2/mcQHsed7xKnZeGZNFB
        zyIXmVYfxx+Z2xl+DdvCMh2Wi9MINziagBXksUn4cKcAFyb10NSAKh40NRsUfHiWeweQ1XSozvvx3
        EBG45JTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRE4W-0033P7-8e; Tue, 30 Mar 2021 13:06:17 +0000
Date:   Tue, 30 Mar 2021 14:06:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Markus Heiser <markus.heiser@darmarit.de>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: better handle '::' sequences
Message-ID: <20210330130616.GN351017@casper.infradead.org>
References: <87tuozyslu.fsf@meer.lwn.net>
 <20210325191435.GZ1719932@casper.infradead.org>
 <87a6qrx7wf.fsf@meer.lwn.net>
 <20210325221437.GA1719932@casper.infradead.org>
 <87wntux3w7.fsf@meer.lwn.net>
 <20210329144204.GF351017@casper.infradead.org>
 <874kgtq079.fsf@intel.com>
 <20210329185843.GK351017@casper.infradead.org>
 <87tuosoov6.fsf@intel.com>
 <0ad14d9d-5694-432a-6376-b776a4acebfa@darmarit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ad14d9d-5694-432a-6376-b776a4acebfa@darmarit.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 02:43:45PM +0200, Markus Heiser wrote:
> 
> Am 30.03.21 um 13:35 schrieb Jani Nikula:
> > > If the introduction were "/*rST" instead of "/**", would we have
> > > consensus?  It gives us a path to let people intermix kernel-doc and
> > > hawkmoth comments in the same file, which would be amazing.
> 
> > If you want to allow two syntaxes for documentation comments (current
> > kernel-doc and pure reStructuredText with just the comment markers and
> > indentation removed) I think the natural first step would be to modify
> > kernel-doc the perl script to support that. It would probably even be
> > trivial.
> 
> My 2cent: to tag the markup of the documentation, in python they
> use a variable named __docformat__ [PEP-258] / e.g.:
> 
>         __docformat__ = "restructuredtext en"
> 
> [PEP-258] https://www.python.org/dev/peps/pep-0258/#choice-of-docstring-format

I don't think we need to do that.  We can use

.. kernel-doc:: foo.c 

to indicate the comments are in kernel-doc format and

.. hawkmoth:: bar.c

to indicate the comments are in hawkmoth format.  Of course, that means
we have to choose for an entire .c file whether it's in hawkmoth or
kernel-doc format, but that's also true for pep-258.

> > Perhaps the bare minimum is running rustdoc first, and generating the
> > results into Sphinx static pages [1], to make them part of the
> > whole. Even if the HTML style might be different.
> 
> Cross referencing will be problematic, I think.

That would be a second step.  I'd rather see the rst files gain the
ability to have:

.. rustdoc:: quux.rs

to bring the markdown into the sphinx system.
