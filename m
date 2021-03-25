Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997B6349A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhCYTPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhCYTPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:15:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF18C06174A;
        Thu, 25 Mar 2021 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WUqGPkhwjAbPY0ivEtV7le3YOwKlwVLG87yWTGzEbAY=; b=OtfPuLECwnuLlrDw3rOgxbmE2j
        0KnZ3pkGk5DBrhOhz+hTnTpCKamjUNn+sZo0cNmYgu0Gd3HTYnUeqHBn/YA/OcVxdPAMMmt5x84rg
        mufSHYaur8+6leetRiPrGKVy7kXq0QmPxd1WHZyA6WpfhYnOEjclveReqV1aeFoxRkWOHZNoRdlQb
        JkbAuT056Numa5k59Oo+FbP/zZMZLny6a1qB8oKQ/OLbn/LMHRvmOCl7JVtQ+sQDcnDHYSjvZe4ez
        eBiBaT3OUnOVDJioOAaSy3MrBXrGkMH31yzFOUihwHUMNoy9/FakGyJCbKMXs68OqRM0E7eS0KMtv
        HtqFnm7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lPVRD-00DcBq-8o; Thu, 25 Mar 2021 19:14:45 +0000
Date:   Thu, 25 Mar 2021 19:14:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: better handle '::' sequences
Message-ID: <20210325191435.GZ1719932@casper.infradead.org>
References: <20210325184615.08526aed@coco.lan>
 <2cf44cf1fa42588632735d4fbc8e84304bdc235f.1616696051.git.mchehab+huawei@kernel.org>
 <87tuozyslu.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuozyslu.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 12:51:25PM -0600, Jonathan Corbet wrote:
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Right now, if one of the following headers end with a '::', the
> > kernel-doc script will do the wrong thing:
> >
> > 	description|context|returns?|notes?|examples?
> >
> > The real issue is with examples, as people could try to write
> > something like:
> >
> > 	example::
> >
> > 		/* Some C code */
> >
> > and this won't be properly evaluated. So, improve the regex
> > to not catch '\w+::' regex for the above identifiers.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  scripts/kernel-doc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Ah....wouldn't it be nice if kerneldoc comments had just been RST from
> the beginning?  I don't think we're fixing that at this point, though,
> so this makes sense; applied.

Well ...

If somebody wants to write a new tool (*) that extracts documentation
written in a different format, I think that could be done.  Because the
hard part of writing documentation is getting the person who knows the
code to get everything that's in their brain into words, not really
the formatting.

If somebody did want to write such a tool, I think we'd also want a
tool that turns the existing kernel-doc into the new format, because
maintaining two function-doc formats would be awful.

https://blog.golang.org/godoc would be my preferred format ... the less
information repeated from the actual function, the better.  But if
we're actually going to have rust in the kernel, perhaps rustdoc is
better.  https://doc.rust-lang.org/beta/rust-by-example/meta/doc.html

(*) because nobody actually likes kernel-doc.pl, right?
