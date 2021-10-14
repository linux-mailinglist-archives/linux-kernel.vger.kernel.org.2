Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE3C42E01A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 19:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhJNRe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 13:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhJNRey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 13:34:54 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88A1C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 10:32:49 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id i15so12940274uap.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 10:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=NNLIU855d3FWPmYu6pUhg7wLsuUsKX7VYiKpRPPe7Bk=;
        b=b4Nc5rxCC1om0hpdesQnbN8+7Hnc5yD378P5ZIuX8gCQBGWHyYQZI7eEbE0Ml3qbOO
         pJ4L0I6vHDW6efOTv4gwn77szHRZ6cxCkJQUahE/0OELaDdLTAD2rVnBxrnhxgC6AXtU
         nOc/kgio9SDYCrj9ynQ53MGYPkBSVObJyE1Ow60Kkr7EGImxAerBJY2WnxCuMH2GkVl9
         k1e5n528ToVyZGb5gwJj3A++cabKLWRCRM0DFdOaKZIKXO/vOCDDrBTmK+B6SdwkS8bN
         TAiXGcqwvWK8bbjC55ZqD812en8Z5rGCZE1jj1CPTwPJM9sdVBSOrxYarPJq88lX/AAs
         /qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NNLIU855d3FWPmYu6pUhg7wLsuUsKX7VYiKpRPPe7Bk=;
        b=TARZ7EGVDXwUvds2TQNDkZT6/5jcK7H77nYTF7NC62yASOqK7UeoWVNSkBkVjejt32
         BPvBNFK19+0VxdZ8CyiJXHAzxH4aUtSbeHv4XfJKlKA1DK0tRHornfxsp6Ry0ax+nud+
         RMCjueX2swkf7oDbTy5SyRMRgpG0MNOTrUK5qJKcyB1rEmuoi9BDTXSJw+g2LYdoqhJY
         YPoIrEqHxyvJ5Xax3l7gRTij/Jo+WO7HgzgAaH+7NxDxN6xpXvVNkENvil6PJ5XYVggQ
         wTkcnYK5Rb9nuXX+VV0qrAhCji3Zv5jNjcnfeom36yPv7FT4SUxEUJjohSft2rrDVqCO
         fJXQ==
X-Gm-Message-State: AOAM532Nl37evCgrNDDO3ZEQeV7M8qJ5JDT5qC8kDT7b5k3Ol+xlT8g/
        a59u0A0zZcc8jP2fLnhVhP72Miee024=
X-Google-Smtp-Source: ABdhPJwEO+fPpwYjQ94fUfOQc9qKYHLagRSqUkrs3ttA+88eYNhX+twHOdUKwk2KJNogZRIXsrztNg==
X-Received: by 2002:ab0:6d8d:: with SMTP id m13mr7661022uah.113.1634232768841;
        Thu, 14 Oct 2021 10:32:48 -0700 (PDT)
Received: from ?IPv6:2804:14c:b382:8c61:6dfb:957c:fd41:44ce? ([2804:14c:b382:8c61:6dfb:957c:fd41:44ce])
        by smtp.gmail.com with ESMTPSA id q62sm2090340vkg.22.2021.10.14.10.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:32:48 -0700 (PDT)
Message-ID: <52f1cec812e81b45dbbc28eef3cd90cc9c0a90ae.camel@gmail.com>
Subject: Re: [PATCH] powerpc/pseries/iommu: Add of_node_put() before break
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Date:   Thu, 14 Oct 2021 14:32:43 -0300
In-Reply-To: <20211014075624.16344-1-wanjiabing@vivo.com>
References: <20211014075624.16344-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wan, thank you for this patch.


On Thu, 2021-10-14 at 03:56 -0400, Wan Jiabing wrote:
> Fix following coccicheck warning:
> 
> ./arch/powerpc/platforms/pseries/iommu.c:924:1-28: WARNING: Function
> for_each_node_with_property should have of_node_put() before break
> 
> Early exits from for_each_node_with_property should decrement the
> node reference counter.

Yeah, it makes sense to me. 

for_each_node_with_property calls of_find_node_with_property() at each
step, which ends up calling of_node_put() after using each node.

Introducing this break caused this of_node_put not to happen to the
last node, so IIUC this patch fixes a possible issue if kzalloc() fails
in ddw_list_new_entry().

Another option would be s/break/continue here, but it does not make
sense to keep trying next nodes if there is no memory to allocate for a
struct dma_win (4 pointers).

On the other hard, failing on allocating such small space should not
happen often (if it will ever happen), so a 'continue' here makes code
simpler.  
 
Anyway, FWIW:
Reviewed-by: Leonardo Bras <leobras.c@gmail.com>


Best regards,
Leo

> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  arch/powerpc/platforms/pseries/iommu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c
> b/arch/powerpc/platforms/pseries/iommu.c
> index 269f61d519c2..c140aa683f66 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -929,8 +929,10 @@ static void find_existing_ddw_windows_named(const
> char *name)
>                 }
>  
>                 window = ddw_list_new_entry(pdn, dma64);
> -               if (!window)
> +               if (!window) {
> +                       of_node_put(pdn);
>                         break;
> +               }
>  
>                 spin_lock(&dma_win_list_lock);
>                 list_add(&window->list, &dma_win_list);


