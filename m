Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDBB3B3CCA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 08:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhFYGpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 02:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56009 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230404AbhFYGo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 02:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624603356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G9jRj0tpYxmkhpGWsyUbyAZnE8Gx5cKf3gFKh8399ko=;
        b=A4Q0NnSaVK36qAeSNRrojEuxxUNMwgK4qaMCzNX1BeVzY8hRGG96ZwXN9cMHo4kaKIFhw2
        4kgQXDifLXjqBgIbZbB6xyV2xx/M3DhRPc2BtMqzvH36+FQo2tte/CgMOstddA2kO1R+y4
        6Ve+Xxlaw42UHn04RH/oy5V26VOyYHA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-2rOvPHCtPwSG6cShjSaxOg-1; Fri, 25 Jun 2021 02:42:35 -0400
X-MC-Unique: 2rOvPHCtPwSG6cShjSaxOg-1
Received: by mail-wr1-f72.google.com with SMTP id v8-20020a5d43c80000b029011a94e052f2so3137396wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 23:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G9jRj0tpYxmkhpGWsyUbyAZnE8Gx5cKf3gFKh8399ko=;
        b=dKseaLZa5ZwDLq9NbBYXByMUurXGWjsdo7x4tUApcgWI2DpQSSDvcbXVxr74PkDBvU
         32uue60KNcbvDMrPAWd20o+p4aqTEGEIu4A5ya69xJOm8nd9DtUQdbbGrzRdyzF1+owa
         x/MKQeBNc+BFEfFjVWO17jNCtjzCueKHPPQ1X0maPRNLZAUrAtYzD8/yRJLw6+5+svzI
         iiaJeFwaDH4iJxhWhhmNAKLA8XJIRhk+H68GZtJmzdYU5l7ggxbK7u0Aj8W0xk3CjJoq
         nJGG9wRWQLG3cJZPN7Nufs3hx8qAPJ6eqSYHTs7t+6wXDLehQXKYJJguagxfgZ9y7PGr
         ph5w==
X-Gm-Message-State: AOAM531WKfHwzKLHofUV7cSugm6QqCPdp0h9P/8Z9GfdC8Yg//ulzETG
        54BABFEOI/uwWJSS2dRbfbCAqCP67FKjnFJNGuZZXoTT0Y+b1JBkpcEvmoqUfZBGKRpZ7J+OOiR
        JpM1la1R5CDCaJAb/JoYGtSpm
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr8884401wrx.206.1624603354054;
        Thu, 24 Jun 2021 23:42:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw92gxo6icRkyIW2W9jDfsnK0lVx5O0U/fJfH24QR4NPITd1aULbry65dD0d5lmfFtShv6qCw==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr8884384wrx.206.1624603353946;
        Thu, 24 Jun 2021 23:42:33 -0700 (PDT)
Received: from redhat.com ([77.124.79.210])
        by smtp.gmail.com with ESMTPSA id v18sm5762831wrv.24.2021.06.24.23.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 23:42:33 -0700 (PDT)
Date:   Fri, 25 Jun 2021 02:42:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, jasowang@redhat.com,
        brouer@redhat.com, paulmck@kernel.org, peterz@infradead.org,
        will@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH net-next v2 0/2] add benchmark selftest and optimization
 for ptr_ring
Message-ID: <20210625024131-mutt-send-email-mst@kernel.org>
References: <1624591136-6647-1-git-send-email-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624591136-6647-1-git-send-email-linyunsheng@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 11:18:54AM +0800, Yunsheng Lin wrote:
> Patch 1: add a selftest app to benchmark the performance
>          of ptr_ring.
> Patch 2: make __ptr_ring_empty() checking more reliable
>          and use the just added selftest to benchmark the
>          performance impact.
> 
> V2: add patch 1 and add performance data for patch 2.

Thanks for the patches!
There are some things to improve there - I sent comments
in response to invididual patches.

> Yunsheng Lin (2):
>   selftests/ptr_ring: add benchmark application for ptr_ring
>   ptr_ring: make __ptr_ring_empty() checking more reliable
> 
>  MAINTAINERS                                      |   5 +
>  include/linux/ptr_ring.h                         |  25 ++-
>  tools/testing/selftests/ptr_ring/Makefile        |   6 +
>  tools/testing/selftests/ptr_ring/ptr_ring_test.c | 249 +++++++++++++++++++++++
>  tools/testing/selftests/ptr_ring/ptr_ring_test.h | 150 ++++++++++++++
>  5 files changed, 426 insertions(+), 9 deletions(-)
>  create mode 100644 tools/testing/selftests/ptr_ring/Makefile
>  create mode 100644 tools/testing/selftests/ptr_ring/ptr_ring_test.c
>  create mode 100644 tools/testing/selftests/ptr_ring/ptr_ring_test.h
> 
> -- 
> 2.7.4

