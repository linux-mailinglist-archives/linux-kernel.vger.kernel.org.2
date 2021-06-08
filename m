Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1CB39F0B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhFHIX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhFHIXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623140522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJTKcfxIsjmEFU6dgYPKfcU2cHrW0DEChNz7vI4HQQE=;
        b=Qrprcf2WQQertUatRVdZMKr9zhMWJ/ywHZ2iz/cD5oD4t6uwU/ahjVQHx2A1ft8s6gBwD6
        Tpt+PAPdG8ZtEF914jsLh7tKsVT9tDCNo2NidcLuzUSrhdWJ+NHctJt6FqI9W+9mzFW0aG
        Br9rmpZhHdJ0FtvOCNUK+jAth/nIQs4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-3KkjrDnDM3yM3-f_QaFOzw-1; Tue, 08 Jun 2021 04:21:58 -0400
X-MC-Unique: 3KkjrDnDM3yM3-f_QaFOzw-1
Received: by mail-wr1-f72.google.com with SMTP id u5-20020adf9e050000b029010df603f280so9086900wre.18
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 01:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PJTKcfxIsjmEFU6dgYPKfcU2cHrW0DEChNz7vI4HQQE=;
        b=fiUaz0cTrdAuMXdOj4geQSZkmLJinXgKG8xKw7D/v1SaVmh8azUratNVx6wT02Qm14
         B2hheKlQcI0dZ34+ufJ20DqUzXfCFedEJuNMoOtrCy02R5agRCO4CyF1x3cWhjrwp2yp
         O3Is39Kxsos4o0CC8KFEiGDi8HudKnX5RbI2U53g6EjQqBzNlJ3Wu9ncONgFXyojeJSm
         Ye3Ya8ZGSqfg8hRomILZb6HTT3xK1FF7qIgM6GKQtxmzKFneb3GHoymeiegswL6C6wLv
         YTnXylajK1qTOyzmQls24IkAePQkvo+zQzJ8bR9BJ8jcgjFbmJBqBbUggabj/QsIPNia
         82/g==
X-Gm-Message-State: AOAM530P5rbKRnz46mMJAGWBlnMSttZWpQ7t0rcBlu8KUK/Zu5BDR+/L
        J4BM3+sozbzMBh3AiQwzzTMWr6E1Bcw741idRbYisuOUi5I1Dnhmsef07/pV9o2quPKayhlMKX7
        I2LsDjuy1QjwifP0bpBf1Nk/C
X-Received: by 2002:a05:6000:1864:: with SMTP id d4mr2461573wri.369.1623140517383;
        Tue, 08 Jun 2021 01:21:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKJ401ab57NtThzysxJhlh6/PClnrNovLY9N5K2/QDDXuD8Kh7AVwnQ5JTXw77SRoYR59lEg==
X-Received: by 2002:a05:6000:1864:: with SMTP id d4mr2461557wri.369.1623140517270;
        Tue, 08 Jun 2021 01:21:57 -0700 (PDT)
Received: from gator (93-137-73-41.adsl.net.t-com.hr. [93.137.73.41])
        by smtp.gmail.com with ESMTPSA id b22sm13800890wmj.22.2021.06.08.01.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 01:21:57 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:21:54 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, maciej.szmigiero@oracle.com,
        pbonzini@redhat.com, shuah@kernel.org
Subject: Re: [PATCH 2/3] Revert "selftests: kvm: fix overlapping addresses in
 memslot_perf_test"
Message-ID: <20210608082154.hvspwojjl22hiltu@gator>
References: <20210608233816.423958-1-zhenzhong.duan@intel.com>
 <20210608233816.423958-3-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608233816.423958-3-zhenzhong.duan@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 07:38:15AM +0800, Zhenzhong Duan wrote:
> This reverts commit 000ac42953395a4f0a63d5db640c5e4c88a548c5.
> 
> As (39fe2fc96694 "selftests: kvm: make allocation of extra memory take
> effect") is reverted, this relevant commit should be reverted too.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  tools/testing/selftests/kvm/memslot_perf_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
> index 9307f25d8130..11239652d805 100644
> --- a/tools/testing/selftests/kvm/memslot_perf_test.c
> +++ b/tools/testing/selftests/kvm/memslot_perf_test.c
> @@ -267,7 +267,7 @@ static bool prepare_vm(struct vm_data *data, int nslots, uint64_t *maxslots,
>  	data->hva_slots = malloc(sizeof(*data->hva_slots) * data->nslots);
>  	TEST_ASSERT(data->hva_slots, "malloc() fail");
>  
> -	data->vm = vm_create_default(VCPU_ID, 1024, guest_code);
> +	data->vm = vm_create_default(VCPU_ID, mempages, guest_code);
>  
>  	pr_info_v("Adding slots 1..%i, each slot with %"PRIu64" pages + %"PRIu64" extra pages last\n",
>  		max_mem_slots - 1, data->pages_per_slot, rempages);
> -- 
> 2.25.1
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

