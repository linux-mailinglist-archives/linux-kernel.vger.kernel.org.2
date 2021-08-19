Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110623F1248
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 06:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhHSEQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 00:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHSEQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 00:16:04 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270CCC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 21:15:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso3893509pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 21:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=w221Be1EofjnjmiRhYveteUIPXXfoWBMfLJIKwhzc6c=;
        b=fhEA6xLbFlhjCuprHe1t9zZjCHnVtAM2fFfth+B1eUBRu6EInah6dTHDMDKwsz0mV1
         65BqyoyCpNPZLSPi8XCLuuOA1+WEfawyX/VoKt1E6KGHsSqmRqLH0CYhis0m0bEyFhm6
         GxHz9MjLC+9q453UuBgVTOwQGhg8cEVz5iusw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=w221Be1EofjnjmiRhYveteUIPXXfoWBMfLJIKwhzc6c=;
        b=ZX5GmCFNSGPogclOzmwc/Utw4sgL2OfkSnrY+c9LXyNysDMVZ3KJIfP8SVLXrcYb8V
         t34KiUAEGlHGlZC4KFQLupUs9ssOR4W94VTo4+f4u716t6Ch4wllyDTzhiYJshqLx5Gc
         McGAyGsU3yv+gFWHmzsqVqauKMXXFQ/n8KmkkL5crwGWlqASJnKpgz6nbDIoAgjlPOqS
         Kc9IoNW0GfeZyoSl2eKbdCNCmommqBXhWBe9s9/BOjPDD/JWQoP44tblnaWUXG6N4Qnd
         OSRHsRkClhknXGLIuXPJAd5W1urFZ3pM7As+JRf7tJ9t3t0WMhfSWvOBvGrRtZ4w1Vbp
         wqFg==
X-Gm-Message-State: AOAM533sEN8zyY1CxHA2cC5IBMv+3luMY5rcFMvRkup5DFUGHzfsQ+Ea
        I0GJ7yEjgDvdRdQu8/uQ4J5KaQ==
X-Google-Smtp-Source: ABdhPJzUBrbcAUKyLF8ssbZuxfEH/VxtoJMLhDuWpgrTCiufrvnOHyomjO1vi21CQR+W587Vz3n2AQ==
X-Received: by 2002:a17:902:f703:b029:12c:982:c9ae with SMTP id h3-20020a170902f703b029012c0982c9aemr10078207plo.20.1629346528626;
        Wed, 18 Aug 2021 21:15:28 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:bc71:80fb:7292:eb8e])
        by smtp.gmail.com with ESMTPSA id 141sm1421497pfv.15.2021.08.18.21.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 21:15:28 -0700 (PDT)
Date:   Thu, 19 Aug 2021 13:15:23 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@google.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Complete prefetch for trailing SPTEs for
 direct, legacy MMU
Message-ID: <YR3a21l6TC/gmw3/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818235615.2047588-1-seanjc@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[..]

> Make a final call to direct_pte_prefetch_many() if there are "trailing"
> SPTEs to prefetch, i.e. SPTEs for GFNs following the faulting GFN.  The
> call to direct_pte_prefetch_many() in the loop only handles the case
> where there are !PRESENT SPTEs preceding a PRESENT SPTE.
> 
> E.g. if the faulting GFN is a multiple of 8 (the prefetch size) and all
> SPTEs for the following GFNs are !PRESENT, the loop will terminate with
> "start = sptep+1" and not prefetch any SPTEs.
> 
> Prefetching trailing SPTEs as intended can drastically reduce the number
> of guest page faults, e.g. accessing the first byte of every 4kb page in
> a 6gb chunk of virtual memory, in a VM with 8gb of preallocated memory,
> the number of pf_fixed events observed in L0 drops from ~1.75M to <0.27M.
> 
> Note, this only affects memory that is backed by 4kb pages as KVM doesn't
> prefetch when installing hugepages.  Shadow paging prefetching is not
> affected as it does not batch the prefetches due to the need to process
> the corresponding guest PTE.  The TDP MMU is not affected because it
> doesn't have prefetching, yet...


Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>



I ran some tests.


- VM Boot up

From

EPT_VIOLATION    1192184    75.18%     4.40%      0.77us  18020.01us      4.32us ( +-   1.71% )

to

EPT_VIOLATION     947460    69.92%     4.64%      0.69us  34902.15us      5.06us ( +-   1.64% )



- Running test app (in VM)

From

EPT_VIOLATION    6550167    71.05%    11.76%      0.77us  32562.18us      3.51us ( +-   0.36% )

to

EPT_VIOLATION    5489904    68.32%    11.29%      0.71us  16564.19us      3.92us ( +-   0.29% )
