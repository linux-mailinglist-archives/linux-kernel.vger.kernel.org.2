Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11B241D30B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 08:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348222AbhI3GI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 02:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348054AbhI3GI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 02:08:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D0E5611C0;
        Thu, 30 Sep 2021 06:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632982006;
        bh=6v0o2oaBHUuXJtHcvE1qZ8zginS+Wa7xhhbrurvMJ0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jaYaemiFIxsztxYfk821mtLeBOfbjuomDLVkKc3HPGk0xyz38n91M2bb48tUpENUR
         /bGmKw7DvUTtS2AClOOlg/QAKhPOM1nml4mHgGs8IoJkcvNtSDCSSpg/452fvwKfmr
         pKuHm0dgEMMHH14Gcx8qPeSOg06zkrVkTyyN1NPU=
Date:   Thu, 30 Sep 2021 08:06:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dyndbg: recode for stronger precondition
Message-ID: <YVVT8su0iYNXz5fn@kroah.com>
References: <20210929183735.6630-1-jim.cromie@gmail.com>
 <20210929183735.6630-2-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929183735.6630-2-jim.cromie@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 12:37:30PM -0600, Jim Cromie wrote:
> The table of struct _ddebugs, due to its construction by the linker,
> has an important property; namely that its "equal" fields have actual
> ptr-equality, not just strcmp-equality.  Lets recognize that truth in
> dynamic_debug_init(), while slicing the builtin table into a
> per-module list.
> ---
>  lib/dynamic_debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index cb5abb42c16a..817a87e9c37f 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -1101,7 +1101,7 @@ static int __init dynamic_debug_init(void)
>  	iter_start = iter;
>  	for (; iter < __stop___dyndbg; iter++) {
>  		entries++;
> -		if (strcmp(modname, iter->modname)) {
> +		if (modname != iter->modname) {
>  			modct++;
>  			ret = ddebug_add_module(iter_start, n, modname);
>  			if (ret)
> -- 
> 2.31.1
> 

Always run checkpatch on a patch so you do not get a grumpy kernel
developer telling you to run checkpatch on your patch :(

I can't take this for the obvious reasons here...

thanks,

greg k-h
