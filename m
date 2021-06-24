Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534413B30F7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhFXOKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231811AbhFXOKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:10:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5060B613EC;
        Thu, 24 Jun 2021 14:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624543691;
        bh=uLsCbbWJ3SK3wevhoHiCe4j1US9FnuTG1umOvEiwKkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yMqPeXVCkzDSRybgiF5jY1cCGxN22NjyXUivZ2vSnkFaLZO/FmNymblMk/yBZX5TS
         acdaQToJWVCnN4PRygYjgMJcGxuFZ3KPGj5f9qb/2zO8R/8rLnYlurV8n1swa8W6GX
         H91Lnp/cXRafIJCSJqStJVBu0uu9T12M5DHiw1V8=
Date:   Thu, 24 Jun 2021 16:08:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH RFC 0/1] get_abi.pl: add support for ABI valitation in
 runtime
Message-ID: <YNSRyXPEynLCfCig@kroah.com>
References: <cover.1624014140.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1624014140.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 01:28:36PM +0200, Mauro Carvalho Chehab wrote:
> Hi Greg,
> 
> I was talking today with Jonathan Cameron today about how to ensure that
> the ABI is not missing something.
> 
> While it would be doable to validate the ABI by searching __ATTR and similar
> macros around the driver, this would probably be very complex and would
> take a while to parse.
> 
> Yet, there's one way that should be quick and easier to implement:
> 
> Read the symbols from the current system in runtime, and check if
> everything is declared under Documentation/ABI.

Nice!

> As you know, scripts/get_abi.pl has already a search command, that would
> allow seeking for a symbol inside the ABI. Using a logic similar to that,
> but checking for all symbols under /sys is not hard to implemenent.
> That's what patch 1 does.
> 
> Right now, the results aren't exaustive (I opted this way for the RFC
> version, as otherwise there will be too many symbols that won't match
> the regexes generated from the What:  fields).
> 
> It basically reports results where the sysfs nodename matches one or
> more What, but doesn't match the regex.
> 
> This implementation runs very quick on my desktop: it takes less than
> 2 seconds to run. So, it sounds a good start to help identifying what's
> missing.
> 
> One of the problems with the ABI definitions is how to define wildcards
> there. Different ABI declarations use different notations. For this first
> RFC version, it all the above as wildcards[1]:
> 
> 	<foo>
> 	{foo}
> 	[foo]
> 	/.../
> 	*
> 
> and convert them into:
> 
> 	.*
> 
> [1] perhaps the better would be to just use regex on What:, as this would
>     avoid extra heuristics at get_abi.pl, but this is somewhat OOT from
>     this patch.
> 
> One of the first results is that some /sys symbols that are present
> on *lots* of sysfs nodes, but they aren't properly defined at ABI:
> 
> 	 /sys/.*/(initstate|bind|unbind)
> 
> (there are definitions, but those aren't covering all occurrences)

We should fix that up.

> Another problem it caught is that slab definitions are like:
> 	 /sys/kernel/slab/cache/alloc_calls
> 
> Instead of using a wildcard, like:
> 	/sys/kernel/slab/*/alloc_calls
> or:
> 	/sys/kernel/slab/<cache>/alloc_calls
> 
> So, they don't  match the actual symbols found at the system.

Then we should also fix those up.

> What do you think?

I like this, thanks for doing this.  We should fix up the text files to
match what we have in a format that we can actually test for things.
That will be very helpful to run on some devices so that I can go yell
at driver developers :)

thanks,

greg k-h
