Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5310D41DADC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350789AbhI3NVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:21:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349722AbhI3NVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633007963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZv7l8Yj7eNVgmG5QYsyeWS3wzELp5S4do4Vgd3D9xs=;
        b=U0epm2Ecs6dejpYGATzuv21VbX4ThWsWtrisT4uk4SKJOjQeMx7YSnqSG6PvQ79iUL1BqY
        8baab0uSViqzWyOb+dt+GlueS0QCt8au37sulsLkOfnrtvc7avK+y+PpiLgyNDdot/ksd/
        CqlDJnl1e/QgEdxnlWJj1PvOnVOQNbg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-54IvbTFuPASv5j_W_K5_wA-1; Thu, 30 Sep 2021 09:19:22 -0400
X-MC-Unique: 54IvbTFuPASv5j_W_K5_wA-1
Received: by mail-wm1-f71.google.com with SMTP id n3-20020a7bcbc3000000b0030b68c4de38so1959013wmi.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wZv7l8Yj7eNVgmG5QYsyeWS3wzELp5S4do4Vgd3D9xs=;
        b=YpPw3tvoyaELjt4aJzl2ZX8lMxWraZsF29UEBtF+wYy9+N+iPO1HycU6CmzFaDr3fV
         Sdkca/4RfmaOoeO5ey/Mrz9iluhoSJoNjrY3sJOVScYJt2qucwnej6I2DbUFAsPq+Frq
         smqMNP+uR0+i4Z0Pb8G5hzAVvRdGl94UMwAITY+ab2FSef3IYgTlJWa1o/FrgyXK+wnw
         iyMUFOkTKYx5EhPQKJAJlh9+Gm4epPECJBXyUYO5dNHLu+cWHFeLHffCFWvFisBG8HTw
         WUGvvUNVx4+p2SywgsnVa/nBrffYv7WzbwGwsQCvK5x5cXBCy5pKswF8oSk031z1F4f/
         X/Zg==
X-Gm-Message-State: AOAM532PrnbzKP24+XHbUnMuTYplZUz0uRa2OGRL3nmwFLovqsKCl9aO
        XIBA2Lk0976fMrR/RfG2dF794OybZ0v3Hwkr9fowMvxHVKx6uzqMb9QC7ue1FMjdjpjB0A0BVFQ
        ZraWeexL4HbCjWLXVIY+rlUJMQhCf9wSLsPJ9Qx/6JMqWL8AsgOiKN0vSU1patwzu22zb4sng
X-Received: by 2002:a7b:c390:: with SMTP id s16mr5561199wmj.132.1633007960900;
        Thu, 30 Sep 2021 06:19:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweMNF0ciSceHxW1rW4G/Bm5Qh/3jTzpjv5D10NKVFHLsnKvjJiTzkjXwSkUeby5zMoR5Y+7Q==
X-Received: by 2002:a7b:c390:: with SMTP id s16mr5561161wmj.132.1633007960566;
        Thu, 30 Sep 2021 06:19:20 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64bb.dip0.t-ipconnect.de. [91.12.100.187])
        by smtp.gmail.com with ESMTPSA id s13sm4842678wmc.47.2021.09.30.06.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 06:19:20 -0700 (PDT)
Subject: Re: [PATCH] mm/huge_memory: disable thp if thp page size is too large
To:     Hao Peng <flyingpenghao@gmail.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <CAPm50aLBfe7N_udxCkS3-PKbTmUvSpqu0sL7U6qHXZ=OWGQnTQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <914a0b38-cb44-f4be-43aa-bc42bee1553b@redhat.com>
Date:   Thu, 30 Sep 2021 15:19:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPm50aLBfe7N_udxCkS3-PKbTmUvSpqu0sL7U6qHXZ=OWGQnTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.09.21 04:14, Hao Peng wrote:
> From: Peng Hao <flyingpeng@tencent.com>

"disable thp if thp page size is too large" you disable thp if there is 
not sufficient memory installed in the system (and for that, you use THP 
size), something doesn't add up here.

> 
> After seting the page size to 64k on ARM64, the supported huge page

s/seting/setting/

Fortunately, most distributions already switched to 4k, because 512MB 
THP is pretty much useless, especially on any system that doesn't have 
memory in the range of hundreds of megabytes or terrabytes.

> size is 512M and 1TB. Therefore, if the thp is enabled, the size
> of the thp is 512M. In this case, min_free_kbytes will be too large.
> 
> On an arm64 server with 64G memory, the page size is 64k, with thp
> enabled.
> cat /proc/sys/vm/min_free_kbytes
> 3335104
> 
> Therefore, when judging whether to enable thp by default, consider
> the size of thp.
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>   mm/huge_memory.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 5e9ef0fc261e..03c7f571b3ae 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -437,7 +437,7 @@ static int __init hugepage_init(void)
>           * where the extra memory used could hurt more than TLB overhead
>           * is likely to save.  The admin can still enable it through /sys.
>           */
> -       if (totalram_pages() < (512 << (20 - PAGE_SHIFT))) {
> +       if (totalram_pages() < (512 << (HPAGE_PMD_SHIFT - PAGE_SHIFT))) {
>                  transparent_hugepage_flags = 0;
>                  return 0;
>          }
> --
> 2.27.0
> 


-- 
Thanks,

David / dhildenb

