Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5E630D1F6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 04:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhBCDG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 22:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbhBCDGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 22:06:06 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2E0C061793
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 19:05:44 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id j11so11044985plt.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 19:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ZMWBq3ACFJJAx15ObrNGTwgdYr+KZMK5JwRK+RWgkj4=;
        b=UZ4hGLaf9PMkrkN83mYnxJXlf++H0dMxr/g9Y9bTLNpi0TBE2iTtTeNtV3Xb8wna5J
         4itg59xQJS97+0zFCzOedMXSau4kmkEtJ9oFLTjn3YiT2gqSVBEopZBVP04xkHc46hKy
         0WY+BorERSVJVGmmkD0ZLeGpapb657WKCn39plFzKSd6IQt1ivzztc8fHNXeXtvSt0Cq
         0Q/yXBlE0WIHhTrcNXwvidyCWtKl4lLPu0J7iY/nqtnCBuwmUCSkk7NU5NB8qreOXims
         AMg4fkZojCg/uyAcQuu0jmY9AozZ1c9E0PRZVlc1hRx4tRI2+1fCs0IkY+6NhSNzVxga
         TozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ZMWBq3ACFJJAx15ObrNGTwgdYr+KZMK5JwRK+RWgkj4=;
        b=ekcCpGQ5K1cBXWXo2zf7TsrRrbZrX9tgJum0FWmnAh5gaIb7OMYug02MXtrJmFpm73
         ARcXzA9hFR1gemQoTo1gUjKOr1Wz2T6M4TJnWgrXahIn4sazQCBpzTgmVeu+Wf9aif5t
         Ho4qZpWoJpQpuwc6VPIj09Ew2LHAdJzIHdrR22gIzWtz0Qz8MwLVzxN194xdT9pf5MHU
         ZsiVpeG3Iyfm3IL2HmQMD+rC4EntgRZXLUO+phaeW0wq61O1kRtQQ5yVnIl2yDsj2sF4
         2ywSKd4c7Ik7+aDqKaThbGj0PkxQ9ZBuCXeiL0rN4SoFAl1n4a0ZPgRGCrb4xYHTdEuF
         6lDg==
X-Gm-Message-State: AOAM532NXnu1OEJOKU1EEmzIgFSJnSc1F3VlFxLu/fAbKKVfskcq1LtV
        gy7lF7mDzgpIfsgqqi0JOa18BQ==
X-Google-Smtp-Source: ABdhPJzgKeAv3HDKvjGTFSaVzyDdJXRgRIHq2ify9sDpRJUoN3Yie4IWt1vmIbnRLWqV+R9QPytFYA==
X-Received: by 2002:a17:902:241:b029:de:17d3:423e with SMTP id 59-20020a1709020241b02900de17d3423emr1138151plc.44.1612321543577;
        Tue, 02 Feb 2021 19:05:43 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n73sm329565pfd.109.2021.02.02.19.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:05:42 -0800 (PST)
Date:   Tue, 02 Feb 2021 19:05:42 -0800 (PST)
X-Google-Original-Date: Tue, 02 Feb 2021 19:05:31 PST (-0800)
Subject:     Re: [PATCH] riscv: kasan: remove unneeded semicolon
In-Reply-To: <1612245119-116845-1-git-send-email-yang.lee@linux.alibaba.com>
CC:     aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, kasan-dev@googlegroups.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        yang.lee@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     yang.lee@linux.alibaba.com
Message-ID: <mhng-1a6dd811-fd09-409c-a664-7bbd9f9d8315@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Feb 2021 21:51:59 PST (-0800), yang.lee@linux.alibaba.com wrote:
> Eliminate the following coccicheck warning:
> ./arch/riscv/mm/kasan_init.c:103:2-3: Unneeded semicolon
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/riscv/mm/kasan_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index a8a2ffd..fac437a 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -100,7 +100,7 @@ void __init kasan_init(void)
>  			break;
>
>  		populate(kasan_mem_to_shadow(start), kasan_mem_to_shadow(end));
> -	};
> +	}
>
>  	for (i = 0; i < PTRS_PER_PTE; i++)
>  		set_pte(&kasan_early_shadow_pte[i],

Thanks, this is on fixes.
