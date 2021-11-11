Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BFF44D78B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 14:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhKKNwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 08:52:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230177AbhKKNwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 08:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636638564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jzBhsEwuoJuSTlvyNlQnTvtJ8SKuAqHgEV8XjPneeOM=;
        b=JvGB6FWumYFRAUTMnDq7oUIus7Ldl5OhzCQgZor2aNzB/qPTTmnkSK1Gu5ifIbsFBECg++
        16KyGDBElH4q8syNnzi7On9xAOHXcyl2D3t2g3fHZsCSvQkazVmp395PRVG20+02AIpvj7
        y99igi3gNt52W5PELMpFvAnlO7rgQq8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-gnMpYo_GNT-6bBZ8wUqjnQ-1; Thu, 11 Nov 2021 08:49:22 -0500
X-MC-Unique: gnMpYo_GNT-6bBZ8wUqjnQ-1
Received: by mail-wm1-f71.google.com with SMTP id l4-20020a05600c1d0400b00332f47a0fa3so2703227wms.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 05:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=jzBhsEwuoJuSTlvyNlQnTvtJ8SKuAqHgEV8XjPneeOM=;
        b=kZnxp3K3nNWrpzA3wkXsqhkNIQkiWlx/FO/qJgkd24mlxCqpmMN1GRgDZk7j4h+FMB
         eYHvX0elKXrQzGELP7XOUZnPIb9fz4zm2t/jrZniMP7y14uPjaCmEr3RBSDNTPFDASot
         sGjGX6ysBkUyHIXytcEy5wdLgRe2KgMtZdWbNMHlN+HGE+N+HTxFfT+RCTCetQoZPNlC
         f75tFhiDo3JYvtYMoxDlTG0U96dEu8EBTp1kj2Sig3WOPj0Oi37HSDK6h4Jj8kzwm3+t
         FICZsQKpZW82Pw4mUQrLXOcPafb3H81XCVdW1g5bQApF1eZaQQi0FcuFkQRN3Uhw7Ao7
         hbtg==
X-Gm-Message-State: AOAM533aAcMOUEtsc7zPycGplMCApUR7B/mI5JddpGxCzNJLKFNL93y2
        w5Ob4+wIYkao9f5Yd0mx+8CfP+YX1OwkAVFVo3TOGtv0xH5MDO6G3lz1RlOSm3Oe8FYW3BvdDxW
        mq2ud3N2nP8hPj6o04iR2kZvW
X-Received: by 2002:a5d:534b:: with SMTP id t11mr8915753wrv.75.1636638561800;
        Thu, 11 Nov 2021 05:49:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwARs1EjsZNTJ0THivmhgZUzzHFHSApy+M0J5gwtqlX2N4msGBD0kwGpr04DSoq3LNzhzDYZg==
X-Received: by 2002:a5d:534b:: with SMTP id t11mr8915730wrv.75.1636638561562;
        Thu, 11 Nov 2021 05:49:21 -0800 (PST)
Received: from [192.168.3.132] (p4ff23ee8.dip0.t-ipconnect.de. [79.242.62.232])
        by smtp.gmail.com with ESMTPSA id d16sm8504519wmb.37.2021.11.11.05.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 05:49:21 -0800 (PST)
Message-ID: <aab58924-f1c0-4bc4-90e0-0ec6f76a5cae@redhat.com>
Date:   Thu, 11 Nov 2021 14:49:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1] vmscan: make drop_slab_node static
Content-Language: en-US
To:     Gang Li <ligang.bdlg@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20211111062445.5236-1-ligang.bdlg@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211111062445.5236-1-ligang.bdlg@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.21 07:24, Gang Li wrote:
> drop_slab_node is only used in drop_slab. So remove it's declaration from
> header file and add keyword static for it's definition.
> 
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> ---
>  include/linux/mm.h | 1 -
>  mm/vmscan.c        | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a7e4a9e7d807..08b36283a57a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3167,7 +3167,6 @@ int drop_caches_sysctl_handler(struct ctl_table *, int, void *, size_t *,
>  #endif
>  
>  void drop_slab(void);
> -void drop_slab_node(int nid);
>  
>  #ifndef CONFIG_MMU
>  #define randomize_va_space 0
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fb9584641ac7..b02548a32a1d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -951,7 +951,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>  	return freed;
>  }
>  
> -void drop_slab_node(int nid)
> +static void drop_slab_node(int nid)
>  {
>  	unsigned long freed;
>  	int shift = 0;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

