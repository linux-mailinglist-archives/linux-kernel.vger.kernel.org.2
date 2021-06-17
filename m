Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158723AB56D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhFQOJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:09:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45172 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbhFQOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:09:13 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C22B21AFB;
        Thu, 17 Jun 2021 14:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623938824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIhLvjDftgod4c0u6W47gER2zg+qEiqn1dXi4g9yFqE=;
        b=acOXYIgnbUsZLXPbDRDbiRoFRrQRIgeTr5KgNRwjVrd/7F74P5NpN/SfqM6ptNczewB95d
        I4B8TTdd9xbaB2vLDNQYbImEQmMeYuP81ZeVa6zkXVfqhjdXYcYKBSzoeEzk1sMDB9/q+A
        2TbCvdisOqABpqA2v4hTIuOrGoNfkGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623938824;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIhLvjDftgod4c0u6W47gER2zg+qEiqn1dXi4g9yFqE=;
        b=q3lOSr54GnLC0HEoKn/ekUZr+KnPISlV8RNNaqBYtbomuwCmgTWdRR4a+pGI6G0NiEIzAx
        klD91zGc9MFBoCAQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 236E0118DD;
        Thu, 17 Jun 2021 14:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623938824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIhLvjDftgod4c0u6W47gER2zg+qEiqn1dXi4g9yFqE=;
        b=acOXYIgnbUsZLXPbDRDbiRoFRrQRIgeTr5KgNRwjVrd/7F74P5NpN/SfqM6ptNczewB95d
        I4B8TTdd9xbaB2vLDNQYbImEQmMeYuP81ZeVa6zkXVfqhjdXYcYKBSzoeEzk1sMDB9/q+A
        2TbCvdisOqABpqA2v4hTIuOrGoNfkGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623938824;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIhLvjDftgod4c0u6W47gER2zg+qEiqn1dXi4g9yFqE=;
        b=q3lOSr54GnLC0HEoKn/ekUZr+KnPISlV8RNNaqBYtbomuwCmgTWdRR4a+pGI6G0NiEIzAx
        klD91zGc9MFBoCAQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id /n4qCAhXy2B5WQAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Thu, 17 Jun 2021 14:07:04 +0000
Subject: Re: [PATCH] mm/slub: Add taint after the errors are printed
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>,
        akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, djakov@kernel.org
References: <1623860738-146761-1-git-send-email-quic_c_gdjako@quicinc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bf6eb872-99ef-5fbb-5b76-ce4eedc713ee@suse.cz>
Date:   Thu, 17 Jun 2021 16:07:03 +0200
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

Acked-by: Vlastimil Babka <vbabka@suse.cz>

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

