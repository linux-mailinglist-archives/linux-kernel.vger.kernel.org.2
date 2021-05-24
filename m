Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763E638E7BD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhEXNhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51816 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232401AbhEXNhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621863365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vKJ7Xmipw+loMCTi+Pu30+gNzhTSZcxxbwDM5OKce/I=;
        b=MAduVn/K9U3JxOUVbVc/Su2hsjAjWn1O3x0ADHA3N6NocaKyGpslKafoUeRtsc7NP5+14y
        uNzrO88T5atH/BluJUv1hdUMMJGb3j++iiv+PKp0FLafR2C317uweTwiUr29n/l5OSGkGu
        y5uAV4RtH7ab2l3GkO9X0U/pr9gQ9BA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-K3sNBxIqMEytCSaHSr8cZw-1; Mon, 24 May 2021 09:36:04 -0400
X-MC-Unique: K3sNBxIqMEytCSaHSr8cZw-1
Received: by mail-ed1-f69.google.com with SMTP id u14-20020a05640207ceb029038d4bfbf3a6so12024275edy.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 06:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vKJ7Xmipw+loMCTi+Pu30+gNzhTSZcxxbwDM5OKce/I=;
        b=Pks9BrJoDVG8sPcY0JKrEQ++IlhfYDUAMwk1kRMwsY7bj4Sy/BgQQYTNRNSaOMp6ZD
         vaOJbrAr0cqOxap2Ht/PRag9RCTpEPoStKJg040JVs7SMV16iYBKLS0bczim3PpmWd5F
         Mg19m7rVKcLpTK2tP32EZqD2x5QEnFLGxH/PpRaq4+x+nza8NgWXT+dSp02oJrNXda4J
         LF39L+d0iqOTLrYLn+dLRVsMikm9klPOd3l7J8au3O91IB8c9hUkaNvbxZ+TKELO5M2T
         D9K1dznGlGMuzudgpCnWe+QPyn4L7LXIC4YR2LHOeMN5xDUcLsYTIjjPON6zF61vyTbX
         xiLA==
X-Gm-Message-State: AOAM533UehoS7OWHei6X6VAQxGuhydk6zlnEatjS2SDPZhhzM+gsBtEk
        u1/4yAg0O5pX4TqlbH5EVae/1vDiFxRO7dyd1zj00x+wzySezE22ew/x9Zedl5KzOjchPuLuRQb
        ixMPkDK8irGqGSG4YwQnyuWjX
X-Received: by 2002:a17:906:4714:: with SMTP id y20mr11266322ejq.235.1621863362960;
        Mon, 24 May 2021 06:36:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrB+HntDmfllKmZV7OfrD2S77X7t2bGH5QT3Yr0wq41gHiubUsw3kmfGsTv7xcMeF6bxT7Dw==
X-Received: by 2002:a17:906:4714:: with SMTP id y20mr11266295ejq.235.1621863362747;
        Mon, 24 May 2021 06:36:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id v12sm9816149edb.81.2021.05.24.06.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 06:36:02 -0700 (PDT)
Subject: Re: [PATCH v2 09/10] KVM: selftests: allow using UFFD minor faults
 for demand paging
To:     Ben Gardon <bgardon@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Oliver Upton <oupton@google.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
References: <20210519200339.829146-1-axelrasmussen@google.com>
 <20210519200339.829146-10-axelrasmussen@google.com>
 <CANgfPd-O5aEvK74DSxkbJaTBv5gResLgvNSjpuzP+PJwifNmfQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b02ff62b-13e8-9ebb-7002-04b0d47ba410@redhat.com>
Date:   Mon, 24 May 2021 15:36:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CANgfPd-O5aEvK74DSxkbJaTBv5gResLgvNSjpuzP+PJwifNmfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/21 00:20, Ben Gardon wrote:
>> +       printf("usage: %s [-h] [-m mode] [-u mode] [-d uffd_delay_usec]\n"
> NIT: maybe use uffd_mode or some word other than mode here to
> disambiguate with -m
> 

Changed to "[-m vm_mode] [-u uffd_mode]".

Paolo

