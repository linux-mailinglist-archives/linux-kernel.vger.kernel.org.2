Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D0D3B79C6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 23:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhF2VOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 17:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbhF2VOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 17:14:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C0EC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 14:12:15 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h1so265700plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 14:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5CQKl2nOiLj7iB7PvW8apbqcaJ0I34gpqE979p9aCvc=;
        b=M1fjCNOzM/QykgJpMvFHfw112G8WsR7CeMml1KfwiD6w+DZpyQksoQ3ZYMtjO32xi7
         DUpUKLomfwLKwsJrKrFhw9nj/KsH78gMFUoBKSk6D1BfT1EvIXePHLuzqb9599QWWU+F
         oO/O7sbpBC9QWRMnPz4GvD2xBdGHStCNOCO/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5CQKl2nOiLj7iB7PvW8apbqcaJ0I34gpqE979p9aCvc=;
        b=ORmKdMIP80cqWSkvbzYTeAv+3LemDyHaceWIas52ym8X/YvxifcoOQlgjnK3zK/KvW
         ijO+xaly4F+dKHRTgdKDRnIk3GVL3/OpsPumOuahxqZnN80bIbZBUNaR8/0mpwG8HMQQ
         1eeN13ONOfcBk4iSeEpl2NgXHvxJTqQ+jTV14qqDEtAwOAORzmTKKkK5Yo6/WTv7KeCL
         R2wXRDRPVPGE1Ip+yOFm58HGHbtYT9BVzXgzUE0Ali8ex6se32zNmf5PNdBAvLj3v0TB
         xeKMt9L0GsJKIXlzwxL7lBnPp6csHKAiRTzQhiWEbGSRMML3Uv6BwU1ByIHdfFjlNVe6
         AjxQ==
X-Gm-Message-State: AOAM530/HiDzKuDpit1Qzt0+hAogOoFnesuLBjCQtTZQbr6BSAixd71i
        K44SbZeDPmFk7V/lrSv7gjKPjw==
X-Google-Smtp-Source: ABdhPJxVmi2ybJK/eYeSgSnMfCwVnWUf3x4mh4OdUfZ8pjZtmFNs+L10Mk4dNKXxR9EP1jVv23t/IQ==
X-Received: by 2002:a17:902:da89:b029:123:39a1:2a76 with SMTP id j9-20020a170902da89b029012339a12a76mr29337305plx.68.1625001135207;
        Tue, 29 Jun 2021 14:12:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u7sm20546383pjd.55.2021.06.29.14.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 14:12:14 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/blk: Use "%lu" to format unsigned long
Date:   Tue, 29 Jun 2021 14:12:05 -0700
Message-Id: <162500112137.438178.14586324457676666976.b4-ty@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210629103700.1935012-1-geert@linux-m68k.org>
References: <20210629103700.1935012-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2021 12:37:00 +0200, Geert Uytterhoeven wrote:
> On 32-bit:
> 
>     fs/pstore/blk.c: In function ‘__best_effort_init’:
>     include/linux/kern_levels.h:5:18: warning: format ‘%zu’ expects argument of type ‘size_t’, but argument 3 has type ‘long unsigned int’ [-Wformat=]
> 	5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
> 	  |                  ^~~~~~
>     include/linux/kern_levels.h:14:19: note: in expansion of macro ‘KERN_SOH’
>        14 | #define KERN_INFO KERN_SOH "6" /* informational */
> 	  |                   ^~~~~~~~
>     include/linux/printk.h:373:9: note: in expansion of macro ‘KERN_INFO’
>       373 |  printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> 	  |         ^~~~~~~~~
>     fs/pstore/blk.c:314:3: note: in expansion of macro ‘pr_info’
>       314 |   pr_info("attached %s (%zu) (no dedicated panic_write!)\n",
> 	  |   ^~~~~~~

Applied to for-next/pstore, thanks!

[1/1] pstore/blk: Use "%lu" to format unsigned long
      https://git.kernel.org/kees/c/c5d4fb2539ca

-- 
Kees Cook

