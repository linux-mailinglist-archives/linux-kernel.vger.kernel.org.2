Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C0A45430E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 09:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbhKQI6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 03:58:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234755AbhKQI6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 03:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637139318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xENkpia7n7HvGh692ZwbBL6DxWNpSkLGwR9xOlXO/HQ=;
        b=XzUbfAjB8E6UEe+NYoTuRIc1XwTQ3ApL29hcXXTnGyuhvAaVed8kObHvM2tyK6YdtA2R8g
        McPI8c4khOEu1KcMCrfxkj/8w2mPfUSNFKwklMF8QPXkDOB08zshO13V1f+m6MlM/8OKsd
        PSEfBgmfbtnfZctPqSf9SOaXwtmJANo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-4s9-GfVlMkGzW9tJ6AxLMQ-1; Wed, 17 Nov 2021 03:55:16 -0500
X-MC-Unique: 4s9-GfVlMkGzW9tJ6AxLMQ-1
Received: by mail-ed1-f71.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso1500331edj.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 00:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xENkpia7n7HvGh692ZwbBL6DxWNpSkLGwR9xOlXO/HQ=;
        b=4a4OPlvWex+W3blpobr4KygL4L9bmZSTNJUzxHv1aRHlkKqj8WOJC1v6SJFigaKQ6k
         VicyCV0rXOGmHWuT8GCdlT2+8foN1b9n1C1V9TS04RTs8zK8GGhxou0LdDTTaoePtN8t
         yvhFDnEQ6/VBFx/AVUIeSNnNuD15jMgEtKTRF3no9z8wkfFW6HO8rBzLGfVRbvmJZn7L
         CZ+v7U7IVGgYK3RYYZLgMPtRF8p8YolVNIFKsXhdXwC8859wzEWOR/qeoKYLMzUMqaq5
         qNKqcduZxgIRE1WiAeVEsV1/EPtJGcYUXHSD2FjC9l4qKvh6T8UUUvWOR5xJFBg+FyxV
         BLKQ==
X-Gm-Message-State: AOAM531jkUCMrnd0Q39+88duzpVwRt/sEoI8vRqNqJn41pELmSszV7KD
        JoB+a46E7OxElHrQAIOFtlAUnXW+Bd3rBVtPOzRg34M6GyNShWF1xVAZ0U2xvDbemd4Ki9o8Qiv
        GPyCev08AuCwigvjcUsXXo3ry
X-Received: by 2002:a50:e089:: with SMTP id f9mr20135875edl.290.1637139315751;
        Wed, 17 Nov 2021 00:55:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwz1G7+KTukj7HLgCjEc7/KCSGVgACyqoSnQKGAUqn7klrNU2bvb7RRjM33xhq8AtxbEthYdA==
X-Received: by 2002:a50:e089:: with SMTP id f9mr20135846edl.290.1637139315562;
        Wed, 17 Nov 2021 00:55:15 -0800 (PST)
Received: from localhost (net-188-218-25-126.cust.vodafonedsl.it. [188.218.25.126])
        by smtp.gmail.com with ESMTPSA id b11sm11082878ede.52.2021.11.17.00.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 00:55:15 -0800 (PST)
Date:   Wed, 17 Nov 2021 09:55:14 +0100
From:   Davide Caratti <dcaratti@redhat.com>
To:     Li Zhijian <zhijianx.li@intel.com>
Cc:     shuah@kernel.org, kuba@kernel.org, linux-kselftest@vger.kernel.org,
        lizhijian@cn.fujitsu.com, linux-kernel@vger.kernel.org,
        lkp@intel.com, philip.li@intel.com
Subject: Re: [PATCH v2 1/3] selftests/tc-testing: add exit code
Message-ID: <YZTDcjv4ZPXv8Oaz@dcaratti.users.ipa.redhat.com>
References: <20211117054517.31847-1-zhijianx.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117054517.31847-1-zhijianx.li@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Li,

On Wed, Nov 17, 2021 at 01:45:15PM +0800, Li Zhijian wrote:
> Mark the summary result as FAIL to prevent from confusing the selftest
> framework if some of them are failed.
> 
> Previously, the selftest framework always treats it as *ok* even though
> some of them are failed actually. That's because the script tdc.sh always
> return 0.

yes, also tdc was lacking support for KSFT_SKIP for a long time.

> 
>  # All test results:
>  #
>  # 1..97
>  # ok 1 83be - Create FQ-PIE with invalid number of flows
>  # ok 2 8b6e - Create RED with no flags
> [...snip]
>  # ok 6 5f15 - Create RED with flags ECN, harddrop
>  # ok 7 53e8 - Create RED with flags ECN, nodrop
>  # ok 8 d091 - Fail to create RED with only nodrop flag
>  # ok 9 af8e - Create RED with flags ECN, nodrop, harddrop
>  # not ok 10 ce7d - Add mq Qdisc to multi-queue device (4 queues)
>  #       Could not match regex pattern. Verify command output:
>  # qdisc mq 1: root
>  # qdisc fq_codel 0: parent 1:4 limit 10240p flows 1024 quantum 1514 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
>  # qdisc fq_codel 0: parent 1:3 limit 10240p flows 1024 quantum 1514 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
> [...snip]
>  # ok 96 6979 - Change quantum of a strict ETS band
>  # ok 97 9a7d - Change ETS strict band without quantum
>  #
>  #
>  #
>  #
>  ok 1 selftests: tc-testing: tdc.sh <<< summary result
> 
> CC: Philip Li <philip.li@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <zhijianx.li@intel.com>

Looks good to me!

Acked-by: Davide Caratti <dcaratti@redhat.com>

