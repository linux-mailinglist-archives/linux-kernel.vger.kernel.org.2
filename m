Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809F842672D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbhJHJx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhJHJxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:53:23 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BBFC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 02:51:28 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id n8so35053615lfk.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=We0TlgUShJQM6EjIHFWMHy/wENnjZ0TPxRk0At+mWjg=;
        b=s6ZV9WAhjM639Ryc3nDZkNN5ECnbRF6Z6+x/1eIos4fbPJRyA7Nq57+D0OWssmAlTw
         +lnhayBzlRQs5+om/hU3GanBO2ZxTMrDQdkUDY4E5BSRZsT2isQXTt3oK2SknBOtfjR6
         oW77wZmkPD0zzw9IVMKGF8no3GyLYkmbAkgnKdCh6QSoafnY1Ep7ht0zzZJClmk421L7
         KBOIhOLvniAohvsJXx8PGiSxIN3ygjfeVT/QXalOypwrMH3kTYj1mp7nE+o+p9wA82ZC
         jO0x25dJi01DF0KEb4ERNwiUVKQ+VY+YH0XSe52o5ShTAJOkNWCRzlBCBoUyiPf0ZT51
         GFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=We0TlgUShJQM6EjIHFWMHy/wENnjZ0TPxRk0At+mWjg=;
        b=WP8NJgj5iCipqsVQcc/SdLZeT5K7j4sLNc+EkXCAw2XaiNDPTo675IkM2gowOcFw6f
         jNswOZfQXS9o3n9Shwb+Zc/NaXUdo2jh5P789qR3DdDr1ng77l0IB6JgPzrEkd4aJmbm
         YgFb3FD8DsSTCnA9gDaWkcWxI/yFUIgph/EERjZFyruOC7pWgpTkfJtmFR1Po+WX75+c
         tooBM0DXvG0pN5514/PGRY/UX9l09dQYxP15KPW7AafCfmPIk9P+Y19QHbgXaKWm5A+9
         cx7UfkvOzTfinWTG/DWjtfn3pUuQTZICLPgVmxcp7FrvOU/vUkloCkv+AO4aY8rt/F/C
         1IxQ==
X-Gm-Message-State: AOAM531+AhnIF87LcW0se3vLACNmuYanVk3DUX+wlAXDUXubsoogjIkM
        WHK8Q0+AQx0sCsfH8QB4YUbidg==
X-Google-Smtp-Source: ABdhPJwHd1mtH8H/TmsRUQMg7Qp41jHspbh9+6ZioBBxaKUYR6g6L1g1+8V72I+Q7k0I34P0OSetdA==
X-Received: by 2002:a2e:2e07:: with SMTP id u7mr2386984lju.418.1633686684423;
        Fri, 08 Oct 2021 02:51:24 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u3sm199461lfi.265.2021.10.08.02.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 02:51:23 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 487491030F5; Fri,  8 Oct 2021 12:51:23 +0300 (+03)
Date:   Fri, 8 Oct 2021 12:51:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/huge_memory.c: disable THP with large THP size on
 small present memory
Message-ID: <20211008095123.73b4bubwrpdj6tuz@box.shutemov.name>
References: <CAPm50aLPxJCiVTqqwiz00oMNiqHggB84sXB3x=tv_HUAd5UktQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPm50aLPxJCiVTqqwiz00oMNiqHggB84sXB3x=tv_HUAd5UktQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 09:22:00AM +0800, Hao Peng wrote:
> From: Peng Hao <flyingpeng@tencent.com>
> 
> After setting the page size to 64k on ARM64, the supported huge page
> size is 512M and 1TB. Therefore, if the thp is enabled, the size
> of the thp is 512M. But if THP is enabled, min_free_kbytes will
> be recalculated. At this time, min_free_kbytes is calculated based
> on the size of THP.
> 
> On an arm64 server with 64G memory, the page size is 64k, with thp
> enabled.
> cat /proc/sys/vm/min_free_kbytes
> 3335104
> 
> Therefore, when judging whether to enable THP by default, consider
> the size of thp.
> 
> V2: title suggested by David Hildenbrand
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 5e9ef0fc261e..03c7f571b3ae 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -437,7 +437,7 @@ static int __init hugepage_init(void)
>          * where the extra memory used could hurt more than TLB overhead
>          * is likely to save.  The admin can still enable it through /sys.
>          */
> -       if (totalram_pages() < (512 << (20 - PAGE_SHIFT))) {
> +       if (totalram_pages() < (512 << (HPAGE_PMD_SHIFT - PAGE_SHIFT))) {

On x86-64 HPAGE_PMD_SHIFT is 21, so you double the amount of memory
required to enabled THP by default. It doesn't seem to be the intent of
the patch.

What about something like

	if (totalram_pages() < 256 * HPAGE_PMD_NR)

?

>                 transparent_hugepage_flags = 0;
>                 return 0;
>         }
> --
> 2.27.0
> 

-- 
 Kirill A. Shutemov
