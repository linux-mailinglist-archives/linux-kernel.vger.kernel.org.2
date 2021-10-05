Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3098E42256E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhJELmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232658AbhJELmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633434024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5jng+t/KM35rvlrjpFOnhlmQDfLsDuNmByDqJMmcgxQ=;
        b=Kgq3VI3mG6TPvUhfnt7RXpsaOSwukeO8aWPcZCOtcQXEpN5F/nkGfOeB7E7Jb10Y6/v3E1
        F2G7lMmgqwW8JQMvGrdD5bKYCDDs1/+1aLRF5PmagkB93ydnyIRR5ln9XgDoB1RBSyI4Ue
        ++k25W/jZ8gvacf/s00BsEFD4gcTTik=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-QLyqjWP1Pc2uft5xgHhZoQ-1; Tue, 05 Oct 2021 07:40:23 -0400
X-MC-Unique: QLyqjWP1Pc2uft5xgHhZoQ-1
Received: by mail-wr1-f70.google.com with SMTP id e12-20020a056000178c00b001606927de88so5600264wrg.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 04:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5jng+t/KM35rvlrjpFOnhlmQDfLsDuNmByDqJMmcgxQ=;
        b=2T1fbiZF1vvPNhQ312//naYfeN9G62w2Qh7PJjX965CeXmMcwei3f8zV/AOmlDmu5h
         JPgDKTdbKO12xqxA8dRpQIZicd/3jsnvsHqERPdTufwxbHKu5cN0VZ75LyYxngdqFUM8
         g49OCE7FUviSno7fV2s+hOfDdOZIw7sY3cGIDaYdDFhd54qmwzTiai4unxB+2g+Di6Zf
         ZiWx9m3vLp8v7IJRhqSw5W137pPlfJ8Oh1kwh2XRU7Ds5HM7ho32W+qZbsfTR/T89//C
         lYIKYg4HjR3mjg/4bQgm/gDkHe5OzTOftXrP2V0tB5ESOJV3Qedj4oNpO/3pCZfrTF0k
         oPww==
X-Gm-Message-State: AOAM531OO1os/io6LRZficPAqFCiE9817RhbHYJtch8D35jHYFz6Nc8b
        /3G7DPgCMnZKWW1ZaInjQQn7D5sREomsfBOJWxY8hUTXrBjOcFzGnYZK/Kwh+C7UK9TMAiaQVWf
        jMQBOmzblWTw2rITRx11docDoIZBmBw04XpM/EojU+gNb7HOh5T22QO4SIsXO2OxVcjdsTYjD5o
        I=
X-Received: by 2002:adf:f946:: with SMTP id q6mr20801011wrr.437.1633434021638;
        Tue, 05 Oct 2021 04:40:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyazp3VBDOnWtSY8G3MjsohPMvzJyMJLtngLNsfvR7sWs6QI+KrltPbhmkHqKDnOIrXSYvmXQ==
X-Received: by 2002:adf:f946:: with SMTP id q6mr20800984wrr.437.1633434021441;
        Tue, 05 Oct 2021 04:40:21 -0700 (PDT)
Received: from [192.168.100.42] ([82.142.3.114])
        by smtp.gmail.com with ESMTPSA id n14sm1823048wms.0.2021.10.05.04.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 04:40:21 -0700 (PDT)
Message-ID: <637cd2e5-8584-3ef5-6de8-bf43b581d0d6@redhat.com>
Date:   Tue, 5 Oct 2021 13:40:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 0/4] hwrng: virtio - add an internal buffer
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Potapenko <glider@google.com>,
        linux-crypto@vger.kernel.org, Dmitriy Vyukov <dvyukov@google.com>,
        rusty@rustcorp.com.au, amit@kernel.org, akong@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Matt Mackall <mpm@selenic.com>,
        virtualization@lists.linux-foundation.org
References: <20210922170903.577801-1-lvivier@redhat.com>
From:   Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20210922170903.577801-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2021 19:08, Laurent Vivier wrote:
> hwrng core uses two buffers that can be mixed in the virtio-rng queue.
> 
> This series fixes the problem by adding an internal buffer in virtio-rng.
> 
> Once the internal buffer is added, we can fix two other problems:
> 
> - to be able to release the driver without waiting the device releases the
>    buffer
> 
> - actually returns some data when wait=0 as we can have some already
>    available data
> 
> It also tries to improve the performance by always having a buffer in
> the queue of the device.
> 
> Laurent Vivier (4):
>    hwrng: virtio - add an internal buffer
>    hwrng: virtio - don't wait on cleanup
>    hwrng: virtio - don't waste entropy
>    hwrng: virtio - always add a pending request
> 
>   drivers/char/hw_random/virtio-rng.c | 84 +++++++++++++++++++++--------
>   1 file changed, 63 insertions(+), 21 deletions(-)
> 

Any comment?

Do we need a v2?

Thanks,
Laurent

