Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B97042C046
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbhJMMoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233690AbhJMMoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:44:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA1656023D;
        Wed, 13 Oct 2021 12:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634128926;
        bh=kDr8TMsNHXVKNQ/FqtOohJdE8A+EeYT7qjuR0SyPXhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OoSamRfCgyrl+N8Hc+45pC3+Wk5YENmCvIX+D1AfuKd3iugEfyjeXFqNKwnS68yEE
         SxyXZDk4chxy5yZc6E0INn0Vj+fEHLFqyLI1jDZBzg+lyQqo1J8sDIgJ9DA7Eppqp/
         DOKEWMPviLlVbXZvDIl6bzl9+zXL1sgj8+XfIipQ=
Date:   Wed, 13 Oct 2021 14:42:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dyndbg: use alt-quotes in vpr-infos, not those user
 might use
Message-ID: <YWbUHOSZ8Sh0i5CO@kroah.com>
References: <20211012183310.1016678-1-jim.cromie@gmail.com>
 <20211012183310.1016678-4-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012183310.1016678-4-jim.cromie@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 12:33:08PM -0600, Jim Cromie wrote:
>    echo format $str +p > control
> 
> can be finicky from within a script, `awith respect to quoting

"`awith"?

> of input terms, so lets not complicate things by wrapping that input
> with either quoting char, using <%s> instead.
> 
> This draws a checkpatch warning on pr_cont() altered quoting.
> no functional changes.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  lib/dynamic_debug.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index e645807cb20a..75e702223730 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -132,7 +132,7 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
>  			fmtlen--;
>  	}
>  
> -	v3pr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u\n",
> +	v3pr_info("%s: func=<%s> file=<%s> module=<%s> format=<%.*s> lineno=%u-%u\n",

Wait, no, it now looks like you want '<' and '>' in the input lines
here.

That's confusing, why is this really all needed?

thanks,

greg k-h
