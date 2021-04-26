Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF4E36B81C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbhDZRcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbhDZRb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:31:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAD0C061574;
        Mon, 26 Apr 2021 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sEsgnbR9Bd5/MELEwxLgHOD1YuAgY9Prs8WjOgXrw04=; b=jWxiyEf1/h7v6v/zUTVDudlE8c
        Sl5uCsPzX/1NTkE16ziM651qe8yFaVQbZrI7f6eKKvLoVA3E556OPEbCuCbWdfJUXvhgU4DPxol62
        +QvztcslRjRM5965YaU5y8SojB5Kz0t9KJQyRBrxhd+MB40G+o60vRg9gxtSz96g/CcFItiMfVsF4
        G24MGWDozUhuBA37bsu9p2b8z077z5JdnZuYMtyK4w6/E7/rpeRSsnl0V9mYhXZhkRE67D42a3dfW
        +n0p2DySZx5Zmwncc8eu72X0T4FXF+sNZbl4i3zmT3HkBCl05qku4X7MtJvjIEcbUqemvsCfdg/U5
        iCukrDtg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lb54Y-005uHt-Bm; Mon, 26 Apr 2021 17:31:04 +0000
Date:   Mon, 26 Apr 2021 18:31:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     corbet@lwn.net, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] scripts: kernel-doc: reduce repeated regex expressions
 into variables
Message-ID: <20210426173102.GO235567@casper.infradead.org>
References: <20210422191839.6119-1-yashsri421@gmail.com>
 <20210423132117.GB235567@casper.infradead.org>
 <6f76ddcb-7076-4c91-9c4c-995002c4cb91@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f76ddcb-7076-4c91-9c4c-995002c4cb91@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2021 at 05:27:34PM +0530, Aditya Srivastava wrote:
> On 23/4/21 6:51 pm, Matthew Wilcox wrote:
> > On Fri, Apr 23, 2021 at 12:48:39AM +0530, Aditya Srivastava wrote:
> >> +my $pointer_function = qr{([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)};
> > 
> > Is that a pointer-to-function?  Or as people who write C usually call it,
> > a function pointer?  Wouldn't it be better to call it $function_pointer?
> > 
> Will do it.
> 
> >> @@ -1210,8 +1211,14 @@ sub dump_struct($$) {
> >>      my $decl_type;
> >>      my $members;
> >>      my $type = qr{struct|union};
> >> +    my $packed = qr{__packed};
> >> +    my $aligned = qr{__aligned};
> >> +    my $cacheline_aligned_in_smp = qr{____cacheline_aligned_in_smp};
> >> +    my $cacheline_aligned = qr{____cacheline_aligned};
> > 
> > I don't think those four definitions actually simplify anything.
> > 
> >> +    my $attribute = qr{__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)}i;
> > 
> > ... whereas this one definitely does.
> > 
> >> -	$members =~ s/\s*__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)/ /gi;
> >> -	$members =~ s/\s*__aligned\s*\([^;]*\)/ /gos;
> >> -	$members =~ s/\s*__packed\s*/ /gos;
> >> +	$members =~ s/\s*$attribute/ /gi;
> >> +	$members =~ s/\s*$aligned\s*\([^;]*\)/ /gos;
> > 
> > Maybe put the \s*\([^;]*\) into $aligned?  Then it becomes a useful
> > abstraction.
> 
> Actually, I had made these variables as they were repeated here and at
> -    my $definition_body =
> qr{\{(.*)\}(?:\s*(?:__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*};
> +    my $definition_body =
> qr{\{(.*)\}(?:\s*(?:$packed|$aligned|$cacheline_aligned_in_smp|$cacheline_aligned|$attribute))*};
> 
> So, defining them at a place might help.
> 
> What do you think?

I don't think that seeing $packed is any easier to read than __packed.
Indeed, I think it's harder, because now I have to look up what $packed
is defined as.

Defining a variable, say

	$decorations = qr{__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\))}
	(i didn't count brackets to be sure i got that right)

would be helpful because then we could say:

	my $definition_body = qr{\{(.*)\}...$decorations...

and have a fighting chance of understanding what it means.

Now, this other place we use it, we do the =~ operation a number of times.
Is there a way to use the $decorations variable to do the same thing
with a single operation?

