Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB8036F56E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 07:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhD3Fnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 01:43:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhD3Fnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 01:43:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3C1E613E1;
        Fri, 30 Apr 2021 05:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619761374;
        bh=SNhPLoJUDYxXdeRDmWHuWy2hHqI1fkkBlG5cFr4P/Ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0B9ExcJ2PmIAm+vNSlMeJOwQ1lSD5E/tpgUusqptmtVHOUm5pHFF4YipfwHYTjyux
         kBxVKVuDn8ug1p/FcTXorcsNSSRfwpy8tIX4dCZDEnqgqgrG80ANPblrNQGTdgS1H8
         UUS1PJNjYVZT25paVaOxPTugVQLwvrlrAvP64p9Y=
Date:   Fri, 30 Apr 2021 07:42:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Baron <jbaron@akamai.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Shuo Chen <giantchen@gmail.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        linux-kernel@vger.kernel.org, Shuo Chen <shuochen@google.com>
Subject: Re: [PATCH] dyndbg: fix parsing file query without a line-range
 suffix
Message-ID: <YIuY3GtRa1mO9/BG@kroah.com>
References: <20210414212400.2927281-1-giantchen@gmail.com>
 <a053afb1-bd3c-78f2-6414-e43014692a56@gmail.com>
 <a98d420c-500d-2790-0ee9-71f4690c24d7@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a98d420c-500d-2790-0ee9-71f4690c24d7@akamai.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 05:08:28PM -0400, Jason Baron wrote:
> 
> 
> On 4/26/21 12:38 PM, Eric Dumazet wrote:
> > 
> > 
> > On 4/14/21 11:24 PM, Shuo Chen wrote:
> >> From: Shuo Chen <shuochen@google.com>
> >>
> >> Query like 'file tcp_input.c line 1234 +p' was broken by
> >> commit aaebe329bff0 ("dyndbg: accept 'file foo.c:func1' and 'file
> >> foo.c:10-100'") because a file name without a ':' now makes the loop in
> >> ddebug_parse_query() exits early before parsing the 'line 1234' part.
> >> As a result, all pr_debug() in tcp_input.c will be enabled, instead of only
> >> the one on line 1234.  Changing 'break' to 'continue' fixes this.
> >>
> >> Fixes: aaebe329bff0 ("dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'")
> >> Signed-off-by: Shuo Chen <shuochen@google.com>
> >> ---
> >>  lib/dynamic_debug.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> >> index c70d6347afa2..921d0a654243 100644
> >> --- a/lib/dynamic_debug.c
> >> +++ b/lib/dynamic_debug.c
> >> @@ -396,7 +396,7 @@ static int ddebug_parse_query(char *words[], int nwords,
> >>  			/* tail :$info is function or line-range */
> >>  			fline = strchr(query->filename, ':');
> >>  			if (!fline)
> >> -				break;
> >> +				continue;
> >>  			*fline++ = '\0';
> >>  			if (isalpha(*fline) || *fline == '*' || *fline == '?') {
> >>  				/* take as function name */
> >>
> > 
> > SGTM, thanks !
> > 
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > 
> 
> Hi Greg,
> 
> I acked this previously and is an important fix.
> Can you please pick it up if you haven't done so?

Will do, sorry for the delay.

greg k-h
