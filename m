Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D90140B93A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbhINUZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:25:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58630 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbhINUZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:25:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7520B21F7C;
        Tue, 14 Sep 2021 20:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631651033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p8d/4cda7fwDsEp3jVs6b5CMPrG1WucWvYK1SQctGM4=;
        b=oUYzO8OaGgr8yYbSxVIflJLnK4MYmE+9BpBsueGdKZzgoEbdcepGXTzq5P4eW5cLUxACLD
        f/R/ZkDzVBWo1QTVu1CiC7mvvP8e2OluWeTyxSBDrZcXiczEooTLEt64bgb0AHrsK8reyW
        BKBZ08igYLW6wwYi5cZtoZlyKVkdCM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631651033;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p8d/4cda7fwDsEp3jVs6b5CMPrG1WucWvYK1SQctGM4=;
        b=72sfuX7hQ2wWIr6OOhyaEPyH/hg3AKVRSt4buuNQtTJkDLf1Os6bklpXrAM7bzm2foo7qx
        0ULoBYP+MAT4NnCQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 038DAA3B8F;
        Tue, 14 Sep 2021 20:23:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DD2DD1E0BF7; Tue, 14 Sep 2021 22:23:49 +0200 (CEST)
Date:   Tue, 14 Sep 2021 22:23:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     cgel.zte@gmail.com
Cc:     hare@suse.de, axboe@kernel.dk, jack@suse.cz, tj@kernel.org,
        viro@zeniv.linux.org.uk, xu.xin16@zte.com.cn,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>,
        zhang yunkai <zhang.yunkai@zte.com.cn>,
        Christoph Hellwig <hch@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH linux-next] init/do_mounts: fix potential memory out of
 bounds access
Message-ID: <20210914202349.GB9406@quack2.suse.cz>
References: <20210913114336.83684-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913114336.83684-1-xu.xin16@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 13-09-21 11:43:36, cgel.zte@gmail.com wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> Initially the pointer "p" points to the start of "pages".
> In the loop "while(*p++) {...}", it ends when "*p" equals
> to zero. Just after that, the pointer "p" moves forward
> with "p++", so "p" may points ouf of "pages".
> 
> furthermore, it is no use to set *p = '\0', so we remove it.

Hum, I agree it is somewhat unclear that the assignment cannot go beyond
the end of the page although I suspect it cannot happen in practice as that
would mean parameter PAGE_SIZE long and I suspect parameter parsing code
would refuse that earlier (but don't really know kernel cmdline parsing
details).

But what I'm quite sure about is that the assignment is not useless. If you
look at the loop below this assignment, you'll notice it terminates on
0-length string and the assignment creates exactly this string at the end
of the split parameter. So your patch certainly breaks things.

								Honza

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Acked-by: zhang yunkai<zhang.yunkai@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>  init/do_mounts.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 2ed30ff6c906..ee1172599249 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -348,7 +348,6 @@ static int __init split_fs_names(char *page, char *names)
>  		if (p[-1] == ',')
>  			p[-1] = '\0';
>  	}
> -	*p = '\0';
>  
>  	for (p = page; *p; p += strlen(p)+1)
>  		count++;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
