Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FD53AAF9A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhFQJZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49677 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230162AbhFQJZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623921773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3KysMvllyHPoDyzaTHkhdiOfQlu8vxXEh89IxvBC1IU=;
        b=cXXp7jxpbC8hwyIPaPDDUTBvJ6X3WRGI9xCGhHnaZEysLtzY3JoDwhxcxqTgIQmczhMXy5
        vlN7Hfhjr6xrKpaMLU96kiqZv0nYrlYVk3uVlt0J/9srHx/v0eRx4FIbSWnKk1fgvqsI4O
        hWh7rI/XAh5rKbqHdxo7tE5Cm7QZ6w4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-i3zd8byWPiqGtBVRZY_7zw-1; Thu, 17 Jun 2021 05:22:51 -0400
X-MC-Unique: i3zd8byWPiqGtBVRZY_7zw-1
Received: by mail-wr1-f72.google.com with SMTP id e9-20020a5d6d090000b0290119e91be97dso2672777wrq.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3KysMvllyHPoDyzaTHkhdiOfQlu8vxXEh89IxvBC1IU=;
        b=ZIP5IHI1HxRlL4sME0/3tzREuw+L5mYm8GtFmemvILospkLmymaD5Efh6IBFdWIcRW
         OZCRmaAlCNkMciy54V6uhNDCCzyo9XpzOL3NMUkdcN9+I3OZyHYxKTpgtLM641etgmcP
         rV3B+SiY79Y1bnIIUvWlhoWZtpkjHP9kpI05YwkDnthSzouVfwah6ATZ+o7pW1bA6OHT
         hbvG1rijiebDiVc+v9fJKk0Cqgk7EHgNBDtpdo0kw7mzLJ1gXD+ANs+mFzn6PDaNTMFa
         Tsj94/L8J0lsjp2XWZp+QCfPGUd/2D7siJnqvk0YmtQZG4MpuqAVLZSO+VPJUvDSKy8r
         RVdQ==
X-Gm-Message-State: AOAM531j7geCbnRVNsCr1CKZWsF7IvUuIV9xs9bq4lC5iyWmtVmrEJ1e
        3SovgSQfuh3ZEGFP0WdTHXjTbgeOqQfbmbLD1WeTKq8LZjZ6qKe624LqKzETWEBamQ5V2lEeLt7
        EpuEoFwLwL1KUqq67PBmg/GU=
X-Received: by 2002:a1c:9dd4:: with SMTP id g203mr3940603wme.132.1623921770627;
        Thu, 17 Jun 2021 02:22:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtAXwHrTnFjJ33bdE+rVfG/hzys+v4plGgnWztV9/gYM8Kp47+O94Jytb/YjTPw/AXGcVjPw==
X-Received: by 2002:a1c:9dd4:: with SMTP id g203mr3940576wme.132.1623921770396;
        Thu, 17 Jun 2021 02:22:50 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f14sm4508599wri.16.2021.06.17.02.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 02:22:50 -0700 (PDT)
Date:   Thu, 17 Jun 2021 10:22:49 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     vbabka@suse.cz, akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, djakov@kernel.org
Subject: Re: [PATCH] mm/slub: Add taint after the errors are printed
Message-ID: <20210617092249.5v6kh3q6skawkae6@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <1623860738-146761-1-git-send-email-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1623860738-146761-1-git-send-email-quic_c_gdjako@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-06-16 09:25 -0700, Georgi Djakov wrote:
> When running the kernel with panic_on_taint, the usual slub debug error
> messages are not being printed when object corruption happens. That's
> because we panic in add_taint(), which is called before printing the
> additional information. This is a bit unfortunate as the error messages
> are actually very useful, especially before a panic. Let's fix this by
> moving add_taint() after the errors are printed on the console.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
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

Good catch. Thanks!

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>

-- 
Aaron Tomlin

