Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C15A40A8FA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhINIPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhINIPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:15:51 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A19C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:14:34 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id di6so1062367qvb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=UkRITEGXX6CzWObn2Pss3N17QNxFhOacW/rBM6plBko=;
        b=MMtZoSeZPocFS1s4AR+1LL8xRFfHnFS+4Wq3a4MmLjZxkB2IXZT/iOZcQMyEOdrHbn
         QzlZiqls0kGome6fCgqhcZgoxrpmDHE6SsO0rinz4o3/gSguY3YsK58rKtRNqotHIYPi
         HMFL6Z62BRIdAxvZMC2jxGp/8tEe2cEI9ErjH8s7iqg4ZHQWofed0leTm7yWh3S0BT3k
         bwBHwq5YnDj8X5lJKcKYSmVw6RGp//IOaW1sCKkQGG8t7fl6gkkyukdse7oEYuTJDoVf
         99sB7TGzSsGzozzhJUH+VypdR9YDiRe+YC2Xavv8KgN0ZGQgtKC9Y3q5iw1ujrI+dL8C
         5ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=UkRITEGXX6CzWObn2Pss3N17QNxFhOacW/rBM6plBko=;
        b=wGHfkdmv+JeT5I1MM73j53SrHy8Aiab66TeTzjLHa3SOUoHYvGktj9NAmAYvzWdO1M
         Jf2lhAlK4v7tNm84Wb3N7t3d/SJg/whXpfYPblBVdLMZaMf5ROv8DkyJTMhQBcgW/Uel
         kebHIJ9zjaQLEtrqmQcHcq+1e+B7qtLxeJEvLMl3YPjW9Q9OkRBJ4hOysHry76r0L5mI
         ykGUwRQR6Fo3iDq01r7RyBHanWtfEohmCnTHm1q5ivJoYjqerX/47kq0TsgAxCbS8Kh8
         v8tG04fG5e2IILaJpepo6k02ZVrQrpcjtebD6q9a6jyWRiomfbq8Wb4JYdthISh05/bI
         zYWg==
X-Gm-Message-State: AOAM531Gfd2fDSYP7Bs6t8xWGtlto7NLW4lEwdCEOKj77JUONXac45ci
        YMowUmNX0AxsCOD9NOxBsWrj4wjWiboHMQ==
X-Google-Smtp-Source: ABdhPJywrDCkPNv5Y8r1ovCy4W59cnTuIItmjYmAjBy0zVzaMmsw0aT6O0jKvOxYEluOt8hQlY+HWg==
X-Received: by 2002:a05:6214:527:: with SMTP id x7mr3884341qvw.55.1631607273733;
        Tue, 14 Sep 2021 01:14:33 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id a9sm7217438qko.27.2021.09.14.01.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 01:14:33 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     SeongJae Park <sjpark@amazon.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Kosina <trivial@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH trivial] mm/damon: Grammar s/works/work/
Date:   Tue, 14 Sep 2021 08:14:27 +0000
Message-Id: <20210914081427.18965-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210914073451.3883834-1-geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Hi Geert,


Thank you for this patch!

On Tue, 14 Sep 2021 09:34:51 +0200	[thread overview] Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Correct a singular versus plural grammar mistake in the help text for
> the DAMON_VADDR config symbol.
> 
> Fixes: 3f49584b262cf8f4 ("mm/damon: implement primitives for the virtual memory address spaces")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: SeongJae Park <sjpark@amazon.de>


Thanks,
SJ

> ---
>  mm/damon/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> index 37024798a97caf0b..ba8898c7eb8eb35e 100644
> --- a/mm/damon/Kconfig
> +++ b/mm/damon/Kconfig
> @@ -30,7 +30,7 @@ config DAMON_VADDR
>  	select PAGE_IDLE_FLAG
>  	help
>  	  This builds the default data access monitoring primitives for DAMON
> -	  that works for virtual address spaces.
> +	  that work for virtual address spaces.
>  
>  config DAMON_VADDR_KUNIT_TEST
>  	bool "Test for DAMON primitives" if !KUNIT_ALL_TESTS
> -- 
> 2.25.1
> 
