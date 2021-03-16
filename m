Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970F333CD5D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbhCPFfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbhCPFeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:34:36 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5F1C06174A;
        Mon, 15 Mar 2021 22:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=1Etpvliau/Qdxgd9hIEg+e7aGJ2zYSyXHdu/56RGYjI=; b=rI8hEdof7Kw6DZP5bqLT30Jzrc
        Z7t4PUQrBZXKplLdGrHoKPmfIxiMs7JNuR/8/NLu3kBX+Gb7RRvPrkOCtsWFge6E1gmC47c6mzeul
        qCXX9XWYnAla5XWHntwcsgf5TLMXpQh+2D0BWWNEsVIEMqTqtdi54omq87gac2LAmlZ508JYwsVs+
        LU7TIwvSAIpi7CKWut4MDDq4EpCuGyj185hOHUc5Be1kBslwljjE/3bHBtd2wc3q4UnFVrH76/jqa
        GpPrJDZIf6Ri/WuaQ6kanFtZuGt68/iBnHH+Hs7Cb8CCbPVSy207ttV+pDx+HnGqc7wq6+yEc2hGa
        UWkEy8Tg==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lM2Li-001PXS-5h; Tue, 16 Mar 2021 05:34:34 +0000
Subject: Re: [PATCH] dlm: Mundane typo fixes throughout the file lock.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, ccaulfie@redhat.com,
        teigland@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     trivial@vger.kernel.org
References: <20210316052732.682020-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d5cc74f7-0534-8168-fcfb-dbcf1c940088@infradead.org>
Date:   Mon, 15 Mar 2021 22:34:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316052732.682020-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 10:27 PM, Bhaskar Chowdhury wrote:
> 
> Trivial typo fixes throughout the file.
> 
> cc: trivial@vger.kernel.org
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  fs/dlm/lock.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
> index 002123efc6b0..caadc426c8b4 100644
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
> @@ -1535,7 +1535,7 @@ static int _remove_from_waiters(struct dlm_lkb *lkb, int mstype,
>  		return -1;
>  	}
> 
> -	/* Remove for the convert reply, and premptively remove for the
> +	/* Remove for the convert reply, and preemptively remove for the
>  	   cancel reply.  A convert has been granted while there's still
>  	   an outstanding cancel on it (the cancel is moot and the result
>  	   in the cancel reply should be 0).  We preempt the cancel reply
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

