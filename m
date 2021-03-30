Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E2A34E119
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 08:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhC3GT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 02:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhC3GTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 02:19:22 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D5DC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 23:19:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f17so5609473plr.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 23:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Wntns3ARiXICiDfUR6aRU71JIRxADrA3zKs3aGI5BBM=;
        b=efEB3t5k3IG2v7+qm3KM7GePq74NecKE3GfGVw9Bhr0XtS0JIx1vPcbXzIvLS47846
         qwPHetgSOUwC6CaCZxQl+sPhNWulA1c53gISFw+L0aBrZc4HLGhA9s/YXnJRz8mClvX6
         OQVx8gLgrpybX4WIPfESHitRETDX12b53nvsNILif8jlVWNBiec8pv3Mx45hXGXl0feH
         laAxvU5SXPDDVkiUB8c4r9s12EDLH85pbgClK/D9uIvqj97bNRLK2YNgl1jCgQHBsE5J
         RDgFVX4k4AGAyyxgzeLf4UWeVP/nSFvMuLy8BF5Ty1RodbcndUyDGeI5GlUWXmDKXVxx
         YGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Wntns3ARiXICiDfUR6aRU71JIRxADrA3zKs3aGI5BBM=;
        b=TyjjuH6eRU/Uov5rZmktiG7dlT3gDTOiEDQuTdZMzk0Iwt8ipEhaMGn65f3xtjpzNH
         Yo2C+IlMzyqBM6aomMmAD8oC+mmY8QNIH65G4vt0Fys5AqHxnc0R8PZ1MNBjtG+7JJrX
         oBypgJOWB73nLCy0tF+XueerQIq7Et4RBOF0tngZy0cXsi0AcsH49m5HnVdXjj5MC6r9
         JofjjUn+yKEAALhu1HJybQMVc8/3mqsSlQBvq7jOGSsfCna9cChVpoEKPpwScucoRHw3
         a1NVGBw77rtByyDxeGvNgvWZ09o5iueQVOjc0ySfT5il251nn4gymEjqQaYRA18ctG5d
         4WUA==
X-Gm-Message-State: AOAM532lQRa+dLvfeMTEzRECsPJ4QX8w+LRpDnQxGydPZAQxpqnLymxG
        QFRVKYOtWEF59yXoXYC0wIOF3g==
X-Google-Smtp-Source: ABdhPJyaqyX4B5bJqmEI0fiz+XDTFousPYZKlhj+LGM0gL7a8gawlvGvUw4nbZ7DULYoj7fsyMICxQ==
X-Received: by 2002:a17:902:9b8b:b029:e6:b027:2f96 with SMTP id y11-20020a1709029b8bb02900e6b0272f96mr33264341plp.28.1617085162278;
        Mon, 29 Mar 2021 23:19:22 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q25sm18713746pfh.34.2021.03.29.23.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 23:19:21 -0700 (PDT)
Date:   Mon, 29 Mar 2021 23:19:21 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Mar 2021 23:19:20 PDT (-0700)
Subject:     Re: [PATCH] riscv: remove unneeded semicolon
In-Reply-To: <1616402316-19705-1-git-send-email-yang.lee@linux.alibaba.com>
CC:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, kasan-dev@googlegroups.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        yang.lee@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     yang.lee@linux.alibaba.com
Message-ID: <mhng-f2509677-edc1-4e9b-b718-74ba0b9484fe@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 01:38:36 PDT (-0700), yang.lee@linux.alibaba.com wrote:
> Eliminate the following coccicheck warning:
> ./arch/riscv/mm/kasan_init.c:219:2-3: Unneeded semicolon
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/riscv/mm/kasan_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index 4f85c6d..937d13c 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -216,7 +216,7 @@ void __init kasan_init(void)
>  			break;
>
>  		kasan_populate(kasan_mem_to_shadow(start), kasan_mem_to_shadow(end));
> -	};
> +	}
>
>  	for (i = 0; i < PTRS_PER_PTE; i++)
>  		set_pte(&kasan_early_shadow_pte[i],

Thanks, this is on fixes.
