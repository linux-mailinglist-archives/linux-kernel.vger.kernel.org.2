Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D897D36C9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbhD0Q5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbhD0Q5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:57:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A00EC06175F;
        Tue, 27 Apr 2021 09:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XVHaeqgZB+erEa9UOd2e5xkHagKcSoWRwUEctU/iNSY=; b=Fyy4Y8nUeQf9/Up8osMcyno9T0
        gy+JjV3A3VgWENh1hriXrkZMyJImCsYjwgFpvz27dbnY5Wq3OfKCVKW20dpxpbOmuhHPFHdm8Ud8R
        lDdoC48qQDaH11BU5OFZpoL5c+fq24n8DAPQeAhMktAgQJCU2mGuiHNq2EkiotGRCqM7dmlDNa1oM
        FLCDxwEqgoR8sWkiNNwzE1w+VhIN9YkJR8NsZmJLK7AYX+nNCAYPG8zX/kHhKbjCj/f0iOt761QMc
        B7kGsCJxObMQv978OeWW3iGpwbd7r48iWF5arC//g6e5ugk9Q7/WCHS3RhyJ7n+paLn3LqzOwiyjQ
        D5XDygTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lbR0j-007ALN-Hd; Tue, 27 Apr 2021 16:56:40 +0000
Date:   Tue, 27 Apr 2021 17:56:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Aditya Srivastava <yashsri421@gmail.com>, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2] scripts: kernel-doc: reduce repeated regex expressions
 into variables
Message-ID: <20210427165633.GA235567@casper.infradead.org>
References: <6f76ddcb-7076-4c91-9c4c-995002c4cb91@gmail.com>
 <20210424124731.29905-1-yashsri421@gmail.com>
 <87wnsnd8nc.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnsnd8nc.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 09:55:35AM -0600, Jonathan Corbet wrote:
> The use of the variables here doesn't really make those expressions more
> readable.  
> 
> >  	$members =~ s/\s*CRYPTO_MINALIGN_ATTR/ /gos;
> > -	$members =~ s/\s*____cacheline_aligned_in_smp/ /gos;
> > -	$members =~ s/\s*____cacheline_aligned/ /gos;
> > +	$members =~ s/\s*$cacheline_aligned_in_smp/ /gos;
> > +	$members =~ s/\s*$cacheline_aligned/ /gos;
> >  
> > +	my $args = qr{([^,)]+)};
> >  	# replace DECLARE_BITMAP
> >  	$members =~ s/__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)/DECLARE_BITMAP($1, __ETHTOOL_LINK_MODE_MASK_NBITS)/gos;
> > -	$members =~ s/DECLARE_BITMAP\s*\(([^,)]+),\s*([^,)]+)\)/unsigned long $1\[BITS_TO_LONGS($2)\]/gos;
> > +	$members =~ s/DECLARE_BITMAP\s*\($args,\s*$args\)/unsigned long $1\[BITS_TO_LONGS($2)\]/gos;
> 
> Here too ... this is the kind of stuff that makes me glad that Colorado
> is a legal-weed state, and the new version, while better, doesn't change
> that basic fact.

I'm going to have to disagree with you on this one (I agree with you on all
the others).  I find this much easier to read ...

"DECLARE_BITMAP followed by any amount of whitespace, literal open bracket,
an argument, literal comma, whitespace, another argument, literal close bracket"

Before, I get to "DECLARE_BITMAP followed by any amount of whitespace,
then some line noise".

Obviously I'm less experienced at reading regexes than you are, but this
simplification really does help me.

> I think I'll stop here; hopefully I've gotten my point across.  I really
> like where this work is heading; focusing just a bit more on pulling the
> regexes together and making the whole thing more readable would be
> wonderful.

Amen.
