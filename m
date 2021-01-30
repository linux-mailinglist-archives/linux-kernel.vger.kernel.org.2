Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038E23097AF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 19:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhA3SyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 13:54:18 -0500
Received: from smtprelay0111.hostedemail.com ([216.40.44.111]:59720 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230045AbhA3SyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 13:54:16 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 0527D1E03;
        Sat, 30 Jan 2021 18:53:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:4321:5007:6119:7652:10004:10400:10848:11026:11232:11658:11914:12043:12297:12438:12555:12740:12895:12986:13069:13311:13357:13439:13894:14181:14659:14721:21080:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: point84_6108006275b3
X-Filterd-Recvd-Size: 2154
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 Jan 2021 18:53:34 +0000 (UTC)
Message-ID: <19fb55171ddc81293e149041c33fa6ce48daed7f.camel@perches.com>
Subject: Re: [PATCH 01/29] coding-style.rst: Avoid comma statements
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Date:   Sat, 30 Jan 2021 10:53:32 -0800
In-Reply-To: <2a97b738bba335434461a5a918053a49c1fb6af4.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
         <2a97b738bba335434461a5a918053a49c1fb6af4.1598331148.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-24 at 21:55 -0700, Joe Perches wrote:
> Commas are not how statements are terminated.
> Always use semicolons and braces if necessary.

ping?

> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  Documentation/process/coding-style.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 98227226c4e5..a1e061149e0d 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -69,9 +69,26 @@ something to hide:
>  	if (condition) do_this;
>  	  do_something_everytime;
>  
> 
> +Don't use commas to avoid using braces:
> +
> +.. code-block:: c
> +
> +	if (condition)
> +		do_this(), do_that();
> +
> +Always uses braces for multiple statements:
> +
> +.. code-block:: c
> +
> +	if (condition) {
> +		do_this();
> +		do_that();
> +	}
> +
>  Don't put multiple assignments on a single line either.  Kernel coding style
>  is super simple.  Avoid tricky expressions.
>  
> 
> +
>  Outside of comments, documentation and except in Kconfig, spaces are never
>  used for indentation, and the above example is deliberately broken.
>  
> 


