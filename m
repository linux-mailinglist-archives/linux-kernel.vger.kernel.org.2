Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5723822A4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 04:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhEQCGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 22:06:33 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:37859 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhEQCG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 22:06:29 -0400
Received: by mail-io1-f50.google.com with SMTP id n40so4333508ioz.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 19:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mtw4anEDg6GM2DlrXl8XXt1BUIjJmxMupUGHcWC3LL4=;
        b=oUq1KC8DvNwhCzOiWEtC4Se8Vx4lnSiEn9LhP9q1G52C9RYX7j0iNuOfEv2uwb7mDi
         3+irKu43YzsE2lOYoO7/BK1V2R78zqDolcgEAmEyK5RnR/KMOB/niiKDP+aAuI/yAzn4
         aiXGCp1GZFStUGnD3did5wU166QKO9z4zzPwg8D8KfLXGnAHHOxIgpO1nlRfnoFIXUje
         +rsm0EECLN+KYG+AUZqawTXeoKfwy2X/xGQfyV6mUQ9SHlDd9sKyNbp3Nhc4Gq13+FZ3
         EBSCXS5lI5XLfnxi+8e1eOnguN8KjbhaSO6Ic7CnEPNNvK8osZUNEuRmUFXgo/dvSRIq
         1w+g==
X-Gm-Message-State: AOAM533KTzjw6WR/zpgdOqyL8e5b6UlufcIGbbA6yS7HDkI9taBC9G5g
        v6kqt7IR3By5Lu5sKxAZ5NU=
X-Google-Smtp-Source: ABdhPJwxx4O1XGk8nVRvQB79e8bKj2o0w7NDmCrHmvZ7DG0IT8W7SFZvAmVUzYudow9l+FyHpBaO3A==
X-Received: by 2002:a05:6638:597:: with SMTP id a23mr3560544jar.27.1621217113710;
        Sun, 16 May 2021 19:05:13 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id m13sm3189371ilq.51.2021.05.16.19.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 19:05:13 -0700 (PDT)
Date:   Mon, 17 May 2021 02:05:11 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     trix@redhat.com
Cc:     tj@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: initialize best_upa variable
Message-ID: <YKHPV4QAXmaWb6jJ@google.com>
References: <20210515180817.1751084-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515180817.1751084-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, May 15, 2021 at 11:08:17AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Static analysis reports this problem
> percpu.c:2945:6: warning: Assigned value is garbage or undefined
>         upa = best_upa;
>             ^ ~~~~~~~~
> best_upa may not be set, so initialize it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  mm/percpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index a257c3efdf18b..6578b706fae81 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2916,6 +2916,7 @@ static struct pcpu_alloc_info * __init __flatten pcpu_build_alloc_info(
>  	 * Related to atom_size, which could be much larger than the unit_size.
>  	 */
>  	last_allocs = INT_MAX;
> +	best_upa = max_upa;
>  	for (upa = max_upa; upa; upa--) {
>  		int allocs = 0, wasted = 0;
>  
> -- 
> 2.26.3
> 

I think the proper fix would be:

best_upa = 0;
for (...) { }
BUG_ON(!best_upa);
upa = best_upa;

If you're fine with this I'll make the changes and apply it to
for-5.13-fixes.

Can you also tell me what static analysis tool produced this? I'm just a
little curious because this code hasn't changed in several years so I'd
have expected some static analyzer to have caught this by now.

Thanks,
Dennis
