Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64AC4023F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 09:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbhIGHU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 03:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32615 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236364AbhIGHU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 03:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630999160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SJ+BQHl0jBl7TBG1tqREEvwhD9MCuAV7riDwhB45i0Q=;
        b=PzX8nud28oWgyVihYEBFaPginhMCQMvYKSoPHbFfTl67B1GGQ7aBGJa0TcISesUr0imczR
        oGWpCr5eENE+OQ1GuQGCvLADddg2Mb/Y3MGCQL8jKGz6MQTd21MyBXiWrpD5KY4g/vPS4H
        nKxTcrLsqIxxv04QFUHPIeqCqayVPVs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-lRqcPvujNZ2qt4hXXOLNXQ-1; Tue, 07 Sep 2021 03:19:13 -0400
X-MC-Unique: lRqcPvujNZ2qt4hXXOLNXQ-1
Received: by mail-ed1-f69.google.com with SMTP id ch11-20020a0564021bcb00b003c8021b61c4so4619440edb.23
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 00:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SJ+BQHl0jBl7TBG1tqREEvwhD9MCuAV7riDwhB45i0Q=;
        b=mjN4738CeRSSu9rBtGnECBFPmpmoVSZccB1+ZfTu/qQe9A95PRxdqvouR75S5ZMfr+
         JWey2+eIlmV30TAFIPfgyk3G6Iv5yfCFu2LWJad4NF0MkP7vQU/x+kRnMM+j7ekqBSub
         C0SKNmq7VGMHC4kmb4NTbrplEulg8Gybf7tPmDU2mXGMqCJrcPnYER7i084CpBLgLiQQ
         5Dli+NXYYFRHvdDv0ZCkReiKCzzi50zbZdx5lqCcvo/3WSVKnDsZaoE9x4xt0bbECKMq
         kd1VcHFKJ4mt03DrEm03HLk7rA2HLWYnYlw2KvY34H8CiuSe39udLAtqXhhsWeePxAV+
         IjAA==
X-Gm-Message-State: AOAM5316CPaSRbnDV5N35Eo+J1/f5KCPBC3kmRqqufeGB5V+jJ59aTdM
        P9bddOeaKv1I1MmqNS5a+SOAr+nHC9p09W90dx99fxEc5FSFqfNDE9llkvWElaUMfxODjuQeHw1
        05vPWujC2roGXPDKCdk4bz6lw
X-Received: by 2002:a50:8ad7:: with SMTP id k23mr17205131edk.310.1630999152308;
        Tue, 07 Sep 2021 00:19:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpO8ZRCV3gq3aPjZE3eB6TifvVjWEdqq6Grmkwr7q3eq7TIU5OWKnXbaQl5M7Z42F15H2Fvw==
X-Received: by 2002:a50:8ad7:: with SMTP id k23mr17205116edk.310.1630999152132;
        Tue, 07 Sep 2021 00:19:12 -0700 (PDT)
Received: from steredhat (host-79-51-2-59.retail.telecomitalia.it. [79.51.2.59])
        by smtp.gmail.com with ESMTPSA id lu4sm4923354ejb.103.2021.09.07.00.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 00:19:11 -0700 (PDT)
Date:   Tue, 7 Sep 2021 09:19:09 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org,
        Jorgen Hansen <jhansen@vmware.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add VM SOCKETS (AF_VSOCK) entry
Message-ID: <20210907071909.qooj2opczrklljwi@steredhat>
References: <20210906091159.66181-1-sgarzare@redhat.com>
 <YTYWkupSYR29IMuM@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YTYWkupSYR29IMuM@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 02:24:34PM +0100, Stefan Hajnoczi wrote:
>On Mon, Sep 06, 2021 at 11:11:59AM +0200, Stefano Garzarella wrote:
>> Add a new entry for VM Sockets (AF_VSOCK) that covers vsock core,
>> tests, and headers. Move some general vsock stuff from virtio-vsock
>> entry into this new more general vsock entry.
>>
>> I've been reviewing and contributing for the last few years,
>> so I'm available to help maintain this code.
>>
>> Cc: Dexuan Cui <decui@microsoft.com>
>> Cc: Jorgen Hansen <jhansen@vmware.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>
>> Dexuan, Jorgen, Stefan, would you like to co-maintain or
>> be added as a reviewer?
>
>Please skip me for now. I'm available if you take an extended period of
>time off and other special situations but don't have enough time to play
>an active role.

Yep, thanks for that!

Stefano

