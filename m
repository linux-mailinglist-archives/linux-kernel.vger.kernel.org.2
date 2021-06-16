Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B001E3AA680
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhFPWNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:13:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233011AbhFPWNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623881472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mCmaf7kl/6J7xNoXGC5mXBNbsEPDwL0kiQ5HpKTcfoc=;
        b=FCKaEHGInajfBtyh1HHZpputWyN6i+aikcejCLgrzR72uMYCDL/AdpMR6Ij8dGqiOQ0bNP
        /pl8XZCSRkaBozADGPZp66CSoeSQoebrE9iEdgQhwbArvJZ2U3EROMfWUcS/lqgsIvgXDH
        G4zFYngkCPTX9eyzYq0hOsMavvU/VAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-ZBJ8Z5sxOzeu110_WyzcJA-1; Wed, 16 Jun 2021 18:11:08 -0400
X-MC-Unique: ZBJ8Z5sxOzeu110_WyzcJA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CF57100C610;
        Wed, 16 Jun 2021 22:11:06 +0000 (UTC)
Received: from optiplex-fbsd (unknown [10.3.128.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D8ABC5D6BA;
        Wed, 16 Jun 2021 22:11:03 +0000 (UTC)
Date:   Wed, 16 Jun 2021 18:11:01 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     vbabka@suse.cz, akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, djakov@kernel.org
Subject: Re: [PATCH] mm/slub: Add taint after the errors are printed
Message-ID: <YMp29eCm55pqz1lq@optiplex-fbsd>
References: <1623860738-146761-1-git-send-email-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623860738-146761-1-git-send-email-quic_c_gdjako@quicinc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 09:25:38AM -0700, Georgi Djakov wrote:
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
Acked-by: Rafael Aquini <aquini@redhat.com>

