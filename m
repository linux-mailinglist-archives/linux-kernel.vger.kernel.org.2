Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADD732700B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 03:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhB1CIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 21:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhB1CIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 21:08:10 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5E3C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 18:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=Phr3R3uzQnU4nbKKAa+GvqFF6KqkcN5yY4GFlyFqEtw=; b=Wr5eC0d1VyPFG4N3HtbQZ1GfLf
        rJWMwJ8z/tb1DaXLaKYcBIoVtafi3Q9BIRY2njIJ5i1jjyYaHtLf780hfgV1vKL718aTmm+e4uj1T
        tvW/Wu4eVO28Be2OfYdKysLCcBEWvfDsJBVj5WnMtvG1ggs1xYwzznnTxbK1Op7YNGhDM2hEgYdnF
        kvd+1bGWwCpTyFG7ifZEhRN3NLydLWQcRmR78nDDqDYbzpkyw0BSUwBMRT5s+0CzM7wF/C5u0xpcS
        mLHT6+xMrEu9tCsIonsVoBHTuQHiVk5Uq7CkL/Z/lbRTOZ5Sm/IQZ9QVwruq3114iwuf05Hga50J+
        OnyXbM1Q==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lGBUU-000170-UB; Sun, 28 Feb 2021 02:07:27 +0000
Subject: Re: [PATCH V2] fs: dlm: Spellings fixed throughout the file lock.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, ccaulfie@redhat.com,
        teigland@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210228010205.28697-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d5205f03-9080-0b46-e9eb-044f7bc42748@infradead.org>
Date:   Sat, 27 Feb 2021 18:07:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210228010205.28697-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/21 5:02 PM, Bhaskar Chowdhury wrote:
> 
> Few spelling fixes throughout the file.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Changes from V1:
>  Fixed the subject line typo.
>  Measured unwanted blank lines insertion.
> 
>  fs/dlm/lock.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
> index 002123efc6b0..b00001c36ed5 100644
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
> --


-- 
~Randy

