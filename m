Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8579C402827
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243105AbhIGMEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:04:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42432 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbhIGMEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:04:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D210622119;
        Tue,  7 Sep 2021 12:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631016179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j25+LpQod1QI80++OlSQRGUgFsrVKKSgFf0138c8TVQ=;
        b=L6bZSsu2pNXyftKXlI+rdsHuDIyQPIGfBY09AwkHJ8dkrXqH5ssvKC99sB8OGrgfsnryqn
        OOZLx5m/Lhi/y5eH7r47QMsk0qZQecVl3jMSEQbZROIG1vv+I+h9qntEsTt/qGAe8xwLgP
        xnlCawBlaxGhjxtxSCHFqDGwOoeLPcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631016179;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j25+LpQod1QI80++OlSQRGUgFsrVKKSgFf0138c8TVQ=;
        b=QdRf3J/OBaiaXjxKdiy5D+6HSzM4dDlr59ppGPkwZ8KO1fqiFSJcbh+lBuPCt+Ciok5sGr
        V6mUxfeDYIxbPDDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B806013C56;
        Tue,  7 Sep 2021 12:02:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kcRTLPNUN2HdDAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 07 Sep 2021 12:02:59 +0000
Message-ID: <79c08d1d-eef5-bc15-8186-7e3367b4ebe7@suse.cz>
Date:   Tue, 7 Sep 2021 14:02:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] mm : bail out from psi memstall after submit_bio in
 swap_readpage
Content-Language: en-US
To:     Huangzhaoyang <huangzhaoyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
References: <1631015968-9779-1-git-send-email-huangzhaoyang@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1631015968-9779-1-git-send-email-huangzhaoyang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 13:59, Huangzhaoyang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> It doesn't make sense to count IO time into psi memstall. Bail out after
> bio submitted.

Isn't that the point if psi, to observe real stalls, which include IO?
Anyway, CCing Johannes.

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/page_io.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_io.c b/mm/page_io.c
> index c493ce9..1d131fc 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -423,6 +423,7 @@ int swap_readpage(struct page *page, bool synchronous)
>  	count_vm_event(PSWPIN);
>  	bio_get(bio);
>  	qc = submit_bio(bio);
> +	psi_memstall_leave(&pflags);
>  	while (synchronous) {
>  		set_current_state(TASK_UNINTERRUPTIBLE);
>  		if (!READ_ONCE(bio->bi_private))
> @@ -433,7 +434,7 @@ int swap_readpage(struct page *page, bool synchronous)
>  	}
>  	__set_current_state(TASK_RUNNING);
>  	bio_put(bio);
> -
> +	return ret;
>  out:
>  	psi_memstall_leave(&pflags);
>  	return ret;
> 

