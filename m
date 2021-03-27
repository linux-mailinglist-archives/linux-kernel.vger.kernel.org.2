Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB85734B814
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 17:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhC0P7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 11:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhC0P7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 11:59:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A9AC0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=xkC4ArgTk906pKWcdErzH1Fktc/TORlko372c6NRiwc=; b=Milx6OIoEQRQxRPtj+/MvTuevl
        jWOy5CyRhJvycLzJ+bF0HFRHY1xIoffBez57/Sbxk21Ljrzz0L9KZVSIDAOjaEgqFH/zal/al5Vce
        FZEwnDspGtND33u37lsbU2z4A51LFsA53KctbhPtN/RO+1J6GmKjQZNhlbfzz7XPStuIiOss40Aiv
        VoFD4Jnd71ErX9jwStvBU402YFqMAlOoD0HFs7S6FR+OcxNRslJTCvaDzc+4I6WBmuiVKoLR5AWBd
        zKMXokcy3UESOVTfA2UWvMdNCAo8QTc/ovPKyCSLf3ixVPDrhwMjMe61oD6wx4G4fua1cRfwwrLVs
        FGZM2mkA==;
Received: from [2601:1c0:6280:3f0::4557]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQBKw-00GXWx-HY; Sat, 27 Mar 2021 15:58:56 +0000
Subject: Re: [PATCH] kconfig: nconf: stop endless search-up loops
To:     Mihai Moldovan <ionic@ionic.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20210327120155.500-1-ionic@ionic.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1ca3a90f-799e-d917-370e-1475e33cdb14@infradead.org>
Date:   Sat, 27 Mar 2021 08:58:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210327120155.500-1-ionic@ionic.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/21 5:01 AM, Mihai Moldovan wrote:
> If the user selects the very first entry in a page and performs a
> search-up operation (e.g., via [/][a][Up Arrow]), nconf will never
> terminate searching the page.
> 
> The reason is that in this case, the starting point will be set to -1,
> which is then translated into (n - 1) (i.e., the last entry of the
> page) and finally the search begins. This continues to work fine until
> the index reaches 0, at which point it will be decremented to -1, but
> not checked against the starting point right away. Instead, it's
> wrapped around to the bottom again, after which the starting point
> check occurs... and naturally fails.
> 
> We can easily avoid it by checking against the starting point directly
> if the current index is -1 (which should be safe, since it's the only
> magic value that can occur) and terminate the matching function.
> 
> Amazingly, nobody seems to have been hit by this for 11 years - or at
> the very least nobody bothered to debug and fix this.
> 
> Signed-off-by: Mihai Moldovan <ionic@ionic.de>

Nice catch.

> ---
>  scripts/kconfig/nconf.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
> index e0f965529166..92a5403d8afa 100644
> --- a/scripts/kconfig/nconf.c
> +++ b/scripts/kconfig/nconf.c
> @@ -515,6 +515,15 @@ static int get_mext_match(const char *match_str, match_f flag)
>  			--index;
>  		else
>  			++index;
> +		/*
> +		 * It's fine for index to become negative - think of an
> +		 * initial value for match_start of 0 with a match direction
> +		 * of up, eventually making it -1.
> +		 *
> +		 * Handle this as a special case.
> +		 */
> +		if ((-1 == index) && (index == match_start))

checkpatch doesn't complain about this (and I wonder how it's missed), but
kernel style is (mostly) "constant goes on right hand side of comparison",
so
		if ((index == -1) &&

Otherwise LGTM.
Thanks.

> +			return -1;
>  		index = (index + items_num) % items_num;
>  		if (index == match_start)
>  			return -1;
> 


-- 
~Randy

