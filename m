Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A2A3AEC9F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFUPkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230161AbhFUPkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624289917;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/PT2H+5rBlFaNgMWz3m8mH4Pq2q3IOb/grR2Heyyj5M=;
        b=h3M7RrIUraXMVZiEIDWYZNj6aWvtQ6JKsgffrlyf+xgOXwW9onFLPF17GChKowLoox5rmE
        34cLYQRwpyA93VSWCo/P9IIwvEzQQk/0mvB+Ed8mHi4TzGfcf9cblqRaayhtJk81XtD7Us
        aBN8kuyfbruJj/LS6gpBDxEaX+hM1fg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-D78cwcsvNq-gPPalZnftfQ-1; Mon, 21 Jun 2021 11:38:36 -0400
X-MC-Unique: D78cwcsvNq-gPPalZnftfQ-1
Received: by mail-wr1-f69.google.com with SMTP id v9-20020a5d4a490000b029011a86baa40cso4108034wrs.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=/PT2H+5rBlFaNgMWz3m8mH4Pq2q3IOb/grR2Heyyj5M=;
        b=YoZmUc4mHPfi2j6pMFoaYnT/hQQgArfGPdQz84wi7tqX1huaZSNHfrI0Urg5jRjM6I
         Ij5cC41cKsSaoiqYlOzKHTyU0S1OL6d0pekVeLg5qKZ+ArmMTTyjs/LXjAH6jLlI8s71
         YKCVCoSrDKs+P+O0dm50BLNdKmnXFRPvSfv0e1LZEKlT00T3JznLWe3RhsQY2+bZdDXm
         A9rs0IXLR6i1cGE99HMDEHPrik3OkidSN/Gd6DYasXUtC5La+WD1FJxQtM3oEsAvhQ0h
         vKjgzemObBcJWrjnyF8DN7rtSQtpMqVi6MmLlFnZkpBB2LlcAmAtDNZJCP0uRtWMZM7a
         Raow==
X-Gm-Message-State: AOAM5322O1kQZKXF5uAmpIbewHXuNBQhuk39tVbbYyknIQU9M1MIV5oV
        QbTInxNl/ur3z3jWXX9OXNEhdL1T4um4kMcyoaSF1aWsMa0Fc7oNPRzy2HirrDuoYT5yrszs/OD
        V3hIhzK/3XgIu/9PNc+TMAtMj
X-Received: by 2002:a05:6000:1001:: with SMTP id a1mr26918932wrx.418.1624289914096;
        Mon, 21 Jun 2021 08:38:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBmisgDmIC43EwBLz2kszOmTyi7ROWV2l0j77EjN7RpHdmMIn2XY6HwlfXesCj3PgXQh5ttw==
X-Received: by 2002:a05:6000:1001:: with SMTP id a1mr26918915wrx.418.1624289913893;
        Mon, 21 Jun 2021 08:38:33 -0700 (PDT)
Received: from [192.168.43.95] ([37.173.110.237])
        by smtp.gmail.com with ESMTPSA id n13sm19466650wrg.75.2021.06.21.08.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 08:38:33 -0700 (PDT)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH for-stable-5.4] KVM: arm/arm64: Fix
 KVM_VGIC_V3_ADDR_TYPE_REDIST read
To:     Greg KH <greg@kroah.com>
Cc:     eric.auger.pro@gmail.com, stable@vger.kernel.org, maz@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
References: <20210621124232.793383-1-eric.auger@redhat.com>
 <YNCvA4qDuc2Tlmi0@kroah.com>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <acd4fdcb-d6d4-755b-6f9d-9acf4b08d564@redhat.com>
Date:   Mon, 21 Jun 2021 17:38:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YNCvA4qDuc2Tlmi0@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 6/21/21 5:23 PM, Greg KH wrote:
> On Mon, Jun 21, 2021 at 02:42:32PM +0200, Eric Auger wrote:
>> When reading the base address of the a REDIST region
>> through KVM_VGIC_V3_ADDR_TYPE_REDIST we expect the
>> redistributor region list to be populated with a single
>> element.
>>
>> However list_first_entry() expects the list to be non empty.
>> Instead we should use list_first_entry_or_null which effectively
>> returns NULL if the list is empty.
>>
>> Fixes: dbd9733ab674 ("KVM: arm/arm64: Replace the single rdist region by a list")
>> Cc: <Stable@vger.kernel.org> # v5.4
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reported-by: Gavin Shan <gshan@redhat.com>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> Link: https://lore.kernel.org/r/20210412150034.29185-1-eric.auger@redhat.com
>> ---
>>  virt/kvm/arm/vgic/vgic-kvm-device.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> Both now queued up, thanks.
>
> Next time, give us a hint as to what the upstream commit id is, so that
> we do not have to dig it up ourselves :)
Sure I will.

Thanks!

Eric
>
> thanks,
>
> greg k-h
>

