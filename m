Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E323AA16D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhFPQg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:36:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43884 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhFPQgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:36:49 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4497A1FD47;
        Wed, 16 Jun 2021 16:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623861282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s+fs7aAV8Ixm3MEQCjvdFix1vBA6zB0wLCM+f4oWhXI=;
        b=O7JlAwcUMHH6qOLLwxzHvHN1KhKJwfvxw+caaPS8d4k/r+mLZP21c5z4chMmrOIsQUbtQ6
        Px3vZUkGoE1SR1RRUz51xT8bzADp6Q82OMndyIq/xdATkDXTG5h3h6xlutcMddObu+sWRN
        xpra4PiBOVOGoa3NRvb+Bu+xp04TmHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623861282;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s+fs7aAV8Ixm3MEQCjvdFix1vBA6zB0wLCM+f4oWhXI=;
        b=PmlgTN9QsbUrkCFAZUZBJcIAOGySEfcDPsuGGB3y2cDf4SYOL+lg+ks+a+41eH9UYD2GyX
        NdwSk+EyCAScRJAw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 1F8ED118DD;
        Wed, 16 Jun 2021 16:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623861282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s+fs7aAV8Ixm3MEQCjvdFix1vBA6zB0wLCM+f4oWhXI=;
        b=O7JlAwcUMHH6qOLLwxzHvHN1KhKJwfvxw+caaPS8d4k/r+mLZP21c5z4chMmrOIsQUbtQ6
        Px3vZUkGoE1SR1RRUz51xT8bzADp6Q82OMndyIq/xdATkDXTG5h3h6xlutcMddObu+sWRN
        xpra4PiBOVOGoa3NRvb+Bu+xp04TmHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623861282;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s+fs7aAV8Ixm3MEQCjvdFix1vBA6zB0wLCM+f4oWhXI=;
        b=PmlgTN9QsbUrkCFAZUZBJcIAOGySEfcDPsuGGB3y2cDf4SYOL+lg+ks+a+41eH9UYD2GyX
        NdwSk+EyCAScRJAw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id QvsgByIoymCBIQAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 16 Jun 2021 16:34:42 +0000
Subject: Re: [PATCH] mm/slub: Add taint after the errors are printed
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>,
        akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, djakov@kernel.org
References: <1623860738-146761-1-git-send-email-quic_c_gdjako@quicinc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4b22baf7-582b-f1ae-a525-046a493ec85f@suse.cz>
Date:   Wed, 16 Jun 2021 18:34:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623860738-146761-1-git-send-email-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 6:25 PM, Georgi Djakov wrote:
> When running the kernel with panic_on_taint, the usual slub debug error
> messages are not being printed when object corruption happens. That's
> because we panic in add_taint(), which is called before printing the
> additional information. This is a bit unfortunate as the error messages
> are actually very useful, especially before a panic. Let's fix this by
> moving add_taint() after the errors are printed on the console.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>

Makes sense.

While at it, I wonder if we should use LOCKDEP_STILL_OK instead of
LOCKDEP_NOW_UNRELIABLE. Isn't it too pessimistic to assume that some slab's
memory corruption hit some lock state?

> ---
>  mm/slub.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index a8b0daa1a307..ce7b8e4551b5 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -719,8 +719,6 @@ static void slab_bug(struct kmem_cache *s, char *fmt, ...)
>  	pr_err("=============================================================================\n");
>  	pr_err("BUG %s (%s): %pV\n", s->name, print_tainted(), &vaf);
>  	pr_err("-----------------------------------------------------------------------------\n\n");
> -
> -	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>  	va_end(args);
>  }
>  
> @@ -801,6 +799,7 @@ void object_err(struct kmem_cache *s, struct page *page,
>  
>  	slab_bug(s, "%s", reason);
>  	print_trailer(s, page, object);
> +	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>  }
>  
>  static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
> @@ -818,6 +817,7 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
>  	slab_bug(s, "%s", buf);
>  	print_page_info(page);
>  	dump_stack();
> +	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>  }
>  
>  static void init_object(struct kmem_cache *s, void *object, u8 val)
> @@ -869,6 +869,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
>  					fault, end - 1, fault - addr,
>  					fault[0], value);
>  	print_trailer(s, page, object);
> +	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>  
>  skip_bug_print:
>  	restore_bytes(s, what, value, fault, end);
> 

