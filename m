Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D215329152
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 21:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243297AbhCAUXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 15:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbhCARFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:05:32 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22007C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=3uIvgqdfRxEMmwJMDv+53IOaIYDOy6ndY5mh3gou04o=; b=I3iPKq/xYEur6+MWCLjPHqv5AH
        WFOrorPMAd9xe8UcfAWEp5OhBRZ8HJoMe5rAprc6kOy3cx2mDEgUZOM+fgAMl9CUvM/3PvuSknxn2
        OUimlpkQEiaQbB1+L+xru1gaaRFMoKfBTKtErsD9/ajmNdV9CqjmdEvRoHNqIfvUEDBN9FUZVM8ts
        +N9D3NEusEe9EobFWUeit+5vf13CZR+T/w0rsIvUjDJmOTCeF6BMjLwlaGr1GRAQ2h7ud3uBtKSQJ
        IZhkimTWVEaC0tBbDQcS6swUNUi2Gf+IfxEDigXwkOqY39ymTdQqdfA1n8a4eAuXbhhguGkFFYdTI
        gR9bBxEg==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lGlyS-0005zn-2f; Mon, 01 Mar 2021 17:04:48 +0000
Subject: Re: [PATCH] include: linux: Typos fixed in throughout the file
 lru_cache.h
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20210301130258.32077-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ea27072c-e17e-8b55-24ca-7f41db597c3c@infradead.org>
Date:   Mon, 1 Mar 2021 09:04:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210301130258.32077-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 5:02 AM, Bhaskar Chowdhury wrote:
> 
> Few typos fixed throughout the file.
> 
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

but no maintainer Cc:ed to pick it up....

> ---
>  include/linux/lru_cache.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/lru_cache.h b/include/linux/lru_cache.h
> index 429d67d815ce..f65c6734be3c 100644
> --- a/include/linux/lru_cache.h
> +++ b/include/linux/lru_cache.h
> @@ -32,7 +32,7 @@ This header file (and its .c file; kernel-doc of functions see there)
>    Because of this later property, it is called "lru_cache".
>    As it actually Tracks Objects in an Active SeT, we could also call it
>    toast (incidentally that is what may happen to the data on the
> -  backend storage uppon next resync, if we don't get it right).
> +  backend storage upon next resync, if we don't get it right).
> 
>  What for?
> 
> @@ -152,7 +152,7 @@ struct lc_element {
>  	 * for paranoia, and for "lc_element_to_index" */
>  	unsigned lc_index;
>  	/* if we want to track a larger set of objects,
> -	 * it needs to become arch independend u64 */
> +	 * it needs to become arch independent u64 */
>  	unsigned lc_number;
>  	/* special label when on free list */
>  #define LC_FREE (~0U)
> @@ -263,7 +263,7 @@ extern void lc_seq_dump_details(struct seq_file *seq, struct lru_cache *lc, char
>   *
>   * Allows (expects) the set to be "dirty".  Note that the reference counts and
>   * order on the active and lru lists may still change.  Used to serialize
> - * changing transactions.  Returns true if we aquired the lock.
> + * changing transactions.  Returns true if we acquired the lock.
>   */
>  static inline int lc_try_lock_for_transaction(struct lru_cache *lc)
>  {
> @@ -275,7 +275,7 @@ static inline int lc_try_lock_for_transaction(struct lru_cache *lc)
>   * @lc: the lru cache to operate on
>   *
>   * Note that the reference counts and order on the active and lru lists may
> - * still change.  Only works on a "clean" set.  Returns true if we aquired the
> + * still change.  Only works on a "clean" set.  Returns true if we acquired the
>   * lock, which means there are no pending changes, and any further attempt to
>   * change the set will not succeed until the next lc_unlock().
>   */
> --


-- 
~Randy

