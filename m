Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CD843CCB5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbhJ0Ovk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230406AbhJ0Ovh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:51:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAE4C60F21;
        Wed, 27 Oct 2021 14:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635346152;
        bh=UF6GSrTtdrrXl1kLp4baAEEP98hFcXRtXOtb27Vet0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dMAlncbOPkWK7AcpZamUUnGoIpai07nkUaD+Ie8JTvsxUJmOYpY4+EuLqMFNsKm9H
         nM9WyAm08Ys5xNtG3SPQXSu8Qg8066xUcomHaK3naANDfMSE+jgU1707CvOjIgruaS
         re6CxBbOQj/JuJP+diE2VclBLDdE2NKYhmgn1pO5mKOfu3JJx5bXR353tVvuY+YIuo
         tX5hFzGYI1rnfFcEuEi4tD2tEMVyckMfB+j9dy4DLbSwHJatGUzcl6qRhL/7/Rhe5F
         PbLYA2gRfVgqdNFtyeVTeenQWMdBEOrbQXVpGAfLv9TqSsDZRTtf5xl4MHH06bJ54c
         F5Z90wrQOypWg==
Date:   Wed, 27 Oct 2021 23:49:08 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] bootconfig: Initialize ret in xbc_parse_tree()
Message-Id: <20211027234908.ea6b045947c0bd99f64d56af@kernel.org>
In-Reply-To: <20211027095512.3da02311@gandalf.local.home>
References: <20211027095512.3da02311@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 09:55:12 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The do while loop continues while ret is zero, but ret is never
> initialized. The check for ret in the loop at the while should always be
> initialized, but if an empty string were to be passed in, q would be NULL
> and p would be '\0', and it would break out of the loop without ever
> setting ret.
> 
> Set ret to zero, and then xbc_verify_tree() would be called and catch that
> it is an empty tree and report the proper error.

Thanks for fixing!
Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>


> 
> Cc: stable@vger.kernel.org
> Fixes: 76db5a27a827c ("bootconfig: Add Extra Boot Config support")

Please update the Fixes tag (and remove Cc: stable, because below one
is still on the -next tree)

Fixes: bdac5c2b243f ("bootconfig: Allocate xbc_data inside xbc_init()")

Thank you,

> Reported-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  lib/bootconfig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index a10ab25f6fcc..70e0d52ffd24 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -836,7 +836,7 @@ static int __init xbc_verify_tree(void)
>  static int __init xbc_parse_tree(void)
>  {
>  	char *p, *q;
> -	int ret, c;
> +	int ret = 0, c;
>  
>  	last_parent = NULL;
>  	p = xbc_data;
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
