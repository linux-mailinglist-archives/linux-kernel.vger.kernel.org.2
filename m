Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FCB33A614
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 17:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhCNQ1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 12:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbhCNQ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 12:26:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF93C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 09:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=X3zz9Nh6ODGrE4SzkyQqvV2ob57MmMUZRVJJwFQka/M=; b=oBnrjNZNInQuaVi+BKsh/9ao5E
        JF+62URv84PLDpA5jGS2tnRwTUzIdYLEcG5v3BvttkJydFoCTvfPKvwvcPqysbh7O8z+xwn6ebW59
        JYOOxhrhFseNgYWfmfx54p1On5RWh1Tv6Eu0L34SVqH5lSvGKnT/NCrsWGLf7ca/LQ7CiYpkRZW7W
        ZKYJCR63N6ok7P6yLIDlvou4u8LsPs4KRZ8m2g6cqZ303Gq+2sL2hGscHO4w6wASTpByeuPYCl6hg
        orTqMNreBlf2WD9dJ9RKMZLruYbewqd85fDCGAdmK+mfnjg6ITGhI+azA5MbY4/ChweqgIu2OMvr0
        JJZaJd8w==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLTZn-001DR4-Tx; Sun, 14 Mar 2021 16:26:48 +0000
Subject: Re: [PATCH V2] tty: vt: Mundane typo fix in the file vt.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, nico@fluxnic.net,
        linux-kernel@vger.kernel.org
References: <20210314062716.28539-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <51741000-c404-58a5-889c-960ec3638bd5@infradead.org>
Date:   Sun, 14 Mar 2021 09:26:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210314062716.28539-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/21 10:27 PM, Bhaskar Chowdhury wrote:
> 
> s/spurrious/spurious/
> s/worse/worst/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Changes from V1:
>   Incorporated Randy's suggestion.
> 
>  drivers/tty/vt/vt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 284b07224c55..d9366da51e06 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -4448,7 +4448,7 @@ void poke_blanked_console(void)
>  	might_sleep();
> 
>  	/* This isn't perfectly race free, but a race here would be mostly harmless,
> -	 * at worse, we'll do a spurrious blank and it's unlikely
> +	 * at worst, we'll do a spurious blank and it's unlikely
>  	 */
>  	del_timer(&console_timer);
>  	blank_timer_expired = 0;
> --


-- 
~Randy

