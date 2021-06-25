Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB393B3B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 05:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhFYDi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 23:38:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233079AbhFYDi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 23:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624592196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6YWGZCgKdORiyTIspLBMoxf3AjxZ1H1bG+LhjiRSD4=;
        b=Ek6o8ymkzxf+/v25xdnxUgHWqKmj9VdcJhLqOR1UlYAoEcLtgOmcq/Jdqiab0uHtB0zter
        Nux+z5R2LjKikDL+Q1s23lQAFOv1k3QFU7G4TF/qvcpWTKcXROwKcrOmHYLlE/tYydqlw6
        RJhnKJgW31KCpF9Rpltg+KjApiV8igk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-jsZKArXLPkuRB70ei_D1fQ-1; Thu, 24 Jun 2021 23:36:32 -0400
X-MC-Unique: jsZKArXLPkuRB70ei_D1fQ-1
Received: by mail-pf1-f199.google.com with SMTP id q10-20020a056a0002aab02903096dd9b65eso382948pfs.17
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 20:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=n6YWGZCgKdORiyTIspLBMoxf3AjxZ1H1bG+LhjiRSD4=;
        b=SRgGL1G7On9vjmn0LOhCGKvzeqxN3KQvq3AF+NBipqxE+C3CuTronsrdtXimpEojBh
         R2cVuK2CFBy8TfUDSXiBV2jwKhv+ZAB41MrjjYW85ZNUKoiRnCqMM4Vkk0XUFALG2hZK
         0mbLS/+oQVX4WNt/Qtfbma0J2cV4JS0s2AmatHf0HJygeT7D+qET3DAcFR27TwHeHFch
         MVWO/8UO+RhNXP6phKaAjw2jczGY8jYZ6F69QC8nBOlbVV7WQV/4LM+zyLLUkz2sDDN0
         mS1YGt8jwzs5GXXlTHVJYaXU/8of3f/s7eLCuThG47kEDSOq6g4aGz6e69Rf4JvIWnnV
         7X+Q==
X-Gm-Message-State: AOAM5336VTZTj4gmYYt+Plld1rMzGcD5UVHweSVUbTcq7xNIkCJX9eNX
        wSwjY1HHfzkiZmNfCrx4YMPQIrFVejQwxMWkQA+iTLCeZen6zA4gS5R4RUMWIBp9iQl+e0rNWTW
        yU2SkgySc7VuUK12LvVqDPPSO
X-Received: by 2002:a62:1914:0:b029:304:502e:8a4c with SMTP id 20-20020a6219140000b0290304502e8a4cmr8395212pfz.63.1624592191581;
        Thu, 24 Jun 2021 20:36:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoLNm1pYRdlFPxoooLwqhPAkuDyU5Xx85yhUXY44HZvMOs5voXOZZ4mcLAUSUMRHvm/vxt4g==
X-Received: by 2002:a62:1914:0:b029:304:502e:8a4c with SMTP id 20-20020a6219140000b0290304502e8a4cmr8395183pfz.63.1624592191332;
        Thu, 24 Jun 2021 20:36:31 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y206sm3980669pfb.3.2021.06.24.20.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 20:36:30 -0700 (PDT)
Subject: Re: [PATCH net-next v2 1/2] selftests/ptr_ring: add benchmark
 application for ptr_ring
To:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, mst@redhat.com
Cc:     brouer@redhat.com, paulmck@kernel.org, peterz@infradead.org,
        will@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linuxarm@openeuler.org
References: <1624591136-6647-1-git-send-email-linyunsheng@huawei.com>
 <1624591136-6647-2-git-send-email-linyunsheng@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ff47ed0b-332d-2772-d6e1-8277ac602c8c@redhat.com>
Date:   Fri, 25 Jun 2021 11:36:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624591136-6647-2-git-send-email-linyunsheng@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/25 ÉÏÎç11:18, Yunsheng Lin Ð´µÀ:
> Currently ptr_ring selftest is embedded within the virtio
> selftest, which involves some specific virtio operation,
> such as notifying and kicking.
>
> As ptr_ring has been used by various subsystems, it deserves
> it's owner's selftest in order to benchmark different usecase
> of ptr_ring, such as page pool and pfifo_fast qdisc.
>
> So add a simple application to benchmark ptr_ring performance.
> Currently two test mode is supported:
> Mode 0: Both enqueuing and dequeuing is done in a single thread,
>          it is called simple test mode in the test app.
> Mode 1: Enqueuing and dequeuing is done in different thread
>          concurrently, also known as SPSC(single-producer/
>          single-consumer) test.
>
> The multi-producer/single-consumer test for pfifo_fast case is
> not added yet, which can be added if using CAS atomic operation
> to enable lockless multi-producer is proved to be better than
> using r->producer_lock.
>
> Only supported on x86 and arm64 for now.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>   MAINTAINERS                                      |   5 +
>   tools/testing/selftests/ptr_ring/Makefile        |   6 +
>   tools/testing/selftests/ptr_ring/ptr_ring_test.c | 249 +++++++++++++++++++++++
>   tools/testing/selftests/ptr_ring/ptr_ring_test.h | 150 ++++++++++++++
>   4 files changed, 410 insertions(+)


Why can't you simply reuse tools/virtio/ringtest?

Thanks

