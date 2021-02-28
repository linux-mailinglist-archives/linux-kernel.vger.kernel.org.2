Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6AD326FB6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 01:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhB1AQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 19:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhB1AQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 19:16:06 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333F5C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 16:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=v+H6rhGenduWmlc2ViLo+jOPPHTi6eMUVkUPJ4uCqjg=; b=W+00LOKW4QEgXitrzv7Up6IrTn
        bQprLr0ffyP5NJZ/x5mVvKNQ64yi9y6hg91Ce/NGETHOweiGxUjw4txM1efnKUVJUxY4m1MoVZ5kr
        wHh0oq3oRWzregTOCdz52nqHbMmXGom8neJLjhC9YWjfFHapGGG0erotqb2nwtFXUsLcSfUbcFDOy
        wIVgwWFZ1JQLKhFmvGMaeKy4FwmE/VYlyXSIiSmbtdi5dqBgHtHWTRRabXH+dDBUijpT/N9H3B4rl
        N8XsBpRqrJ6HPjMhhQglrDD7xPHIytD+HxXZuIWlGEPJwJ2ilPIPpyuUIWdET5J0j/92s+kdDtzfN
        cP7Xxx5g==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lG9k3-00066Y-9b; Sun, 28 Feb 2021 00:15:23 +0000
Subject: Re: [PATCH] fs: dlm: Spellings fixed throughout the fle lock.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, ccaulfie@redhat.com,
        teigland@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210227233336.6290-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <51c331a2-59e0-c485-f3b0-d582963c87da@infradead.org>
Date:   Sat, 27 Feb 2021 16:15:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210227233336.6290-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/21 3:33 PM, Bhaskar Chowdhury wrote:
> 
> Few spelling fixes throughout the file.
> 

in Subject: s/fle/file/

> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  fs/dlm/lock.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
> index 002123efc6b0..efcd84faca14 100644
> --- a/fs/dlm/lock.c
> +++ b/fs/dlm/lock.c
> @@ -91,7 +91,7 @@ static void del_timeout(struct dlm_lkb *lkb);
>  static void toss_rsb(struct kref *kref);
> 
>  /*
> - * Lock compatibilty matrix - thanks Steve
> + * Lock compatibility matrix - thanks Steve
>   * UN = Unlocked state. Not really a state, used as a flag
>   * PD = Padding. Used to make the matrix a nice power of two in size
>   * Other states are the same as the VMS DLM.
> @@ -594,7 +594,7 @@ static int find_rsb_dir(struct dlm_ls *ls, char *name, int len,
>  	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].keep, name, len, &r);
>  	if (error)
>  		goto do_toss;
> -
> +

stray change?

>  	/*
>  	 * rsb is active, so we can't check master_nodeid without lock_rsb.
>  	 */
> @@ -2357,14 +2357,14 @@ static int _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
>  	 * 6-5: But the default algorithm for deciding whether to grant or
>  	 * queue conversion requests does not by itself guarantee that such
>  	 * requests are serviced on a "first come first serve" basis.  This, in
> -	 * turn, can lead to a phenomenon known as "indefinate postponement".
> +	 * turn, can lead to a phenomenon known as "indefinite postponement".
>  	 *
>  	 * 6-7: This issue is dealt with by using the optional QUECVT flag with
>  	 * the system service employed to request a lock conversion.  This flag
>  	 * forces certain conversion requests to be queued, even if they are
>  	 * compatible with the granted modes of other locks on the same
>  	 * resource.  Thus, the use of this flag results in conversion requests
> -	 * being ordered on a "first come first servce" basis.
> +	 * being ordered on a "first come first serve" basis.
>  	 *
>  	 * DCT: This condition is all about new conversions being able to occur
>  	 * "in place" while the lock remains on the granted queue (assuming
> @@ -5745,7 +5745,7 @@ int dlm_recover_process_copy(struct dlm_ls *ls, struct dlm_rcom *rc)
> 
>  		log_debug(ls, "dlm_recover_process_copy %x remote %d %x %d",
>  			  lkid, rc->rc_header.h_nodeid, remid, result);
> -
> +

stray change?

>  		dlm_send_rcom_lock(r, lkb);
>  		goto out;
>  	case -EEXIST:
> --


-- 
~Randy

