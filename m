Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F0E3B9D7F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 10:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhGBI3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 04:29:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54978 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhGBI3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:29:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1376C22961;
        Fri,  2 Jul 2021 08:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625214389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WxJWw2CqLjQ4AZ75S144xJsmeSvAip+8rmh0FMz/5GM=;
        b=lkUj24IiRvJIFfbBu/iB88l1qdMcO1clseyNEaQKefJCuMgGcAjgdMJRWlP12kgCV9/Yhi
        tKyRbORZtjInluugNAS1LcxunK4xUoJoywGyxahtGQ5N81ENdJld/x7bfoqUeoLYg9WEAU
        jPJD63Wi4XgVJsa218wDWmyvbHlfMkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625214389;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WxJWw2CqLjQ4AZ75S144xJsmeSvAip+8rmh0FMz/5GM=;
        b=x8IuBnkDowOrrc2WoDMs/m5k/YVR3o2og0kw/SEkXusC5ZIvp3lzIuKm1dvNCeUv9UsIFd
        HQsALjOFSp+2BsBA==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AAC2BA3B81;
        Fri,  2 Jul 2021 08:26:28 +0000 (UTC)
Date:   Fri, 2 Jul 2021 10:26:28 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     gushengxian <gushengxian507419@gmail.com>
cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, gushengxian <gushengxian@yulong.com>
Subject: Re: [PATCH] objtool: avoid Memory leak: orig_alt_group
In-Reply-To: <20210702031327.559429-1-gushengxian507419@gmail.com>
Message-ID: <alpine.LSU.2.21.2107021021510.29699@pobox.suse.cz>
References: <20210702031327.559429-1-gushengxian507419@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Jul 2021, gushengxian wrote:

> From: gushengxian <gushengxian@yulong.com>
> 
> free(orig_alt_group) should be added in order to avoid memery leak.
> Reported by cppcheck.
> 
> Signed-off-by: gushengxian <gushengxian@yulong.com>

It is not necessary. Objtool would exit immediately in case of this error 
and we do not handle the allocations in such cases. 

> ---
>  tools/objtool/check.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e5947fbb9e7a..deb48b1bc16d 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1097,6 +1097,7 @@ static int handle_group_alt(struct objtool_file *file,
>  				     sizeof(struct cfi_state *));
>  	if (!orig_alt_group->cfi) {
>  		WARN("calloc failed");
> +		free(orig_alt_group);
>  		return -1;
>  	}

There are more sites like this in the code. For example there is one a 
couple of lines later in the same function. It is fine.

Regards
Miroslav
