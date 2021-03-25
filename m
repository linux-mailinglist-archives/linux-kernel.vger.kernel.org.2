Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A033A349C24
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 23:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhCYWPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 18:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhCYWOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 18:14:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E35C06174A;
        Thu, 25 Mar 2021 15:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=NVCefAzy77SIiZ982ecvAabze2914IZvTimkJPzBisY=; b=TfxwZjnFgqGZ5NQ+eKBh0v7KU+
        rqNxyVhfuYmNk7nqg49MuhL7N0divk7vJxDTz+/8ySCo9BnvrcZUXLDmGH7hPLLd/PGY1A6CyMXpf
        lhKRgxZqoK0InTMHIJDdQUPKEBhw3Gz/DjtPFDhH3Jo6aPOmpu6Sj8KVnLQusA457Ordfjt8hMet/
        U+wYfoP3yEltBc4womhWfhS9iaBZHKGP5633Ku+1RtusLbdZM3T/STFT3EH7Rju7wLZLw4pWHQhQA
        IaPWvOW21uGBpAg/tsN3GYuLtg3L7+4rP8ApqxwBdQLG33GBoDCP8pwFxtE4RFsd7jhBKJpAEi7iD
        v6LLnFcw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lPYFR-00DtKj-Au; Thu, 25 Mar 2021 22:14:41 +0000
Date:   Thu, 25 Mar 2021 22:14:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: better handle '::' sequences
Message-ID: <20210325221437.GA1719932@casper.infradead.org>
References: <20210325184615.08526aed@coco.lan>
 <2cf44cf1fa42588632735d4fbc8e84304bdc235f.1616696051.git.mchehab+huawei@kernel.org>
 <87tuozyslu.fsf@meer.lwn.net>
 <20210325191435.GZ1719932@casper.infradead.org>
 <87a6qrx7wf.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6qrx7wf.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 03:04:00PM -0600, Jonathan Corbet wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> > Well ...
> >
> > If somebody wants to write a new tool (*) that extracts documentation
> > written in a different format, I think that could be done.  Because the
> > hard part of writing documentation is getting the person who knows the
> > code to get everything that's in their brain into words, not really
> > the formatting.
> >
> > If somebody did want to write such a tool, I think we'd also want a
> > tool that turns the existing kernel-doc into the new format, because
> > maintaining two function-doc formats would be awful.
> 
> Yeah, the thing is that, as long as we're documenting code with
> something other than RST, we *do* have two formats, and they interact
> with each other in surprising and unwelcome ways.
> 
> I don't really see a fix, though.  Even if we come up with the Perfect
> New Format™, I don't want to be the one trying to push through the
> patches changing tens of thousands of kerneldoc comments over...

I can't argue with either of your points.

The rust code is alredy coming though ...

rust/kernel/buffer.rs:/// A pre-allocated buffer that implements [`core::fmt::Write`].

so now we have three formats.  Markdown and RST are _very_ similar, but
not identical [1].  Oh, and even better we now have three distinct tools --
kerneldoc, rustdoc and sphinx.  Have the rust people reached out to you
about integrating the various docs?

[1] https://en.wikipedia.org/wiki/Lightweight_markup_language#Comparison_of_lightweight_markup_language_syntax
