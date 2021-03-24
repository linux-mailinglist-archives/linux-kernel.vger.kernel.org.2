Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F3934821E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbhCXToM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbhCXTnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:43:52 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6CDC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:43:51 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u20so86843lja.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZsxM/2Ykxu5IttmOH8Blmg3qxt7HyUyyxyppNU8QMfk=;
        b=ihxR+uuzlP8ImCNG5ItmyIu3OCF9ZqN+bhsDpuiXtnlULfrpsGDJ6o0uDVE6K55vfB
         tyeM6kuAnyaPydWXKw8UAUZ1gX4Fk75FT/KcAWmRqaD28DG6q4y947NKu3KOHIQVt4gF
         iqLGiIm5nT2/YS4MVpKtzgdHFoJU7S96XEN6asm6tss9c4ljJ66SpOqOx8BanzkzjT0e
         1BU3ICeVSotxvziA/gerpRD2Pqv3TSnZeKaXLwohHksUuAIybX7KN1rO4BrkmTAZBOOY
         bj0JKJ55mhC6Xj772qk9NX1ULSwyRivGUW2zGJQT8FvHY6vizgFp6OVT05KYfNbL3uIm
         RScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZsxM/2Ykxu5IttmOH8Blmg3qxt7HyUyyxyppNU8QMfk=;
        b=AKjrECBYx4JaZwPENMH8xQJjIgRyQwH5Tgonpl7kOYh+Aw5b6o39c/mzaWTh48HRac
         2dww4nShHpDw7C9x8+BjwAUSbSq+U/cAJmZPA70g5TV33XGV2DeBgUpmM7bkMKK21fFX
         m53hL3zM+KIqMqqo4CfOCIc67BmYK7F2MLmneneU12jnz+270cGs5dOsfBFkpahcrYgj
         isPAnD9HuEZ2IDzD5JOLxVJ2hRlURaAc5Z71b/jv5AB1h1ind8EyeTm5Mwc0Q3Xiqsen
         jys4lyogDY97Fg+fr5Lyq+Utd6ejy/FXwZF0m1pJZhMSku/1ARLISzsPWeRVBosagFxH
         5vLw==
X-Gm-Message-State: AOAM532fjuuFjeDrssb0b/XSahjcU6Q6obz+lVKBNPGzT6eGUzUoBPW1
        Xq75tqXZGhptQ0ddEjCeNargryQtfho=
X-Google-Smtp-Source: ABdhPJy0XoQsm08/P+H2D3PRFBIwy3RkMDUTgI0q5lcOl/QqmGK6ktXvEobzb8/NWdIkAbHt3rYz3Q==
X-Received: by 2002:a2e:a481:: with SMTP id h1mr3052315lji.143.1616615030303;
        Wed, 24 Mar 2021 12:43:50 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru. [109.252.193.60])
        by smtp.googlemail.com with ESMTPSA id f4sm408695lja.69.2021.03.24.12.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 12:43:49 -0700 (PDT)
Subject: Re: [PATCH] mm: cma: fix corruption cma_sysfs_alloc_pages_count
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        jhubbard@nvidia.com, willy@infradead.org
References: <20210324192044.1505747-1-minchan@kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <18ee5c3e-fba2-0d8d-bd93-5fb8d0dd7a01@gmail.com>
Date:   Wed, 24 Mar 2021 22:43:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324192044.1505747-1-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.03.2021 22:20, Minchan Kim пишет:
>  static int __init cma_sysfs_init(void)
>  {
> -	int i = 0;
> +	struct kobject *cma_kobj_root;
> +	struct cma_kobject *cma_kobj;
>  	struct cma *cma;
> +	unsigned int i;

>  	while (--i >= 0) {

Do you realize that this doesn't work anymore?

>  		cma = &cma_areas[i];
> -		kobject_put(&cma->stat->kobj);
> -	}
>  
> -	kfree(cma_stats);
> -	kobject_put(cma_kobj);
> +		kobject_put(&cma->cma_kobj->kobj);
> +		kfree(cma->cma_kobj);

Freeing a null pointer?

> +		cma->cma_kobj = NULL;
> +	}
> +	kobject_put(cma_kobj_root);

