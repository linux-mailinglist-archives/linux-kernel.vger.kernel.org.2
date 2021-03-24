Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C17B3480EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbhCXStq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbhCXSt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:49:29 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB30C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 11:49:29 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 11so18012124pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 11:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=pmbPpEKsJkRcMr/+EGl0xO5iqNgXKyXmsvkfUXs17ck=;
        b=GBA61vQ119NNAnbkQDmcX11wSj86geUW1JZS3YUHuEvQkf1BwUzlNncgIIvNIFmdPZ
         3izambxW+MX40279EcICBTOsiQciP9EDbXt++M4fzoIZg9ZFhV6vDxKoVeNRVMiIfUS1
         V8m7n+L2Ux2lD6wWoTMvNfdRDkCVfElLphsuNWNN2/2oHDIfEacVW2c2ldE6PKC+uKIF
         7dWmvpxFI5EML5jlB0e8BP1Ax1JFNPBqqjxiKK0hMk+zIJYguQvD6XVdnqsIViwlB/CD
         Yww8JH+7CfmThVL1w6xAHj95H7aDU3QUjHkI40W24npSy+C7CTSZ94Z9JAhYaVLjnQEF
         5OEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=pmbPpEKsJkRcMr/+EGl0xO5iqNgXKyXmsvkfUXs17ck=;
        b=dQzuqDkziPHX0T8euBb8ICIE2Jc9C3/K8iLs3L2N+2IEll13EtwAiHRSKpQOXaO8dm
         LpiqsTzQFOrBw0oBIQvrzZH5HrPFx8bMDBe561b6DoScGDY6NZSwQ/l8DgfZMcMK9/Z2
         7S9jl0Ytxklv4+YfQ4e0eMkhY1EVaeqMfZOvRMXUZ8IKblrjIB+6/H5b8O/uSPM26zxW
         KIXWuayq3j647swBimRcB/GZF8TRz6OKtS6+Pd8BEMBzwfyXH6BozFZbg7yd6HUS2+YG
         61RK9q3QXxMc1hDJ06GcgGS8vpOcwbv6Hv5q63f4jICXE/6buJlqURroWSI1Z2VxXUY4
         7W5w==
X-Gm-Message-State: AOAM5310t0bHfui78edKrhdSYIfUqCTJNd6oZCDTnhk6y0/1wIEcarSX
        jp3D0rz2S5wev5Ix+1S3Xqj03Q==
X-Google-Smtp-Source: ABdhPJzj1SdlJ6U8pMVkuYXepWh2p1vb3JaOyahgyUnvOxyqaXoD8M5HWASAoyKxVLELeJwlz7NtHA==
X-Received: by 2002:a65:4203:: with SMTP id c3mr4192417pgq.65.1616611769124;
        Wed, 24 Mar 2021 11:49:29 -0700 (PDT)
Received: from [2620:15c:17:3:4192:718f:4827:be5] ([2620:15c:17:3:4192:718f:4827:be5])
        by smtp.gmail.com with ESMTPSA id y8sm3175606pjb.11.2021.03.24.11.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 11:49:28 -0700 (PDT)
Date:   Wed, 24 Mar 2021 11:49:27 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] mm/slub.c: Trivial typo fixes
In-Reply-To: <20210324130619.16872-1-unixbhaskar@gmail.com>
Message-ID: <8a21e996-93f9-d22a-65b9-4bdafc43b36e@google.com>
References: <20210324130619.16872-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021, Bhaskar Chowdhury wrote:

> diff --git a/mm/slub.c b/mm/slub.c
> index 3021ce9bf1b3..cd3c7be33f69 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3,7 +3,7 @@
>   * SLUB: A slab allocator that limits cache line use instead of queuing
>   * objects in per cpu and per node lists.
>   *
> - * The allocator synchronizes using per slab locks or atomic operatios
> + * The allocator synchronizes using per slab locks or atomic operation

operations
