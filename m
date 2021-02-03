Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB29230DBC1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhBCNtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:49:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232312AbhBCNsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612360006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wAKaUuKW6RzyViwzx4Xg+bK1O40C5bxcjPo5i3OoibA=;
        b=TfRI3ZdRDGeYfJ/mBJ3+L8VcpsJumzV/V+dPBUbC/DBkONQbKeT9u45OJujUEswTpBtoL9
        9e9Dv1uvGjNYLDg78r/xhzrI2iLjb0MJGPSRCAnDb1Pg/9YubEDZVxawWU2R/rk2LTVkZ4
        dsJN3/jErtxcyd3qOLWY5e+qVGnXEQw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-ltSxbXs5OaKjIvfcDXUrpw-1; Wed, 03 Feb 2021 08:46:45 -0500
X-MC-Unique: ltSxbXs5OaKjIvfcDXUrpw-1
Received: by mail-ed1-f69.google.com with SMTP id o8so11611640edh.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 05:46:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wAKaUuKW6RzyViwzx4Xg+bK1O40C5bxcjPo5i3OoibA=;
        b=ONBlTmIyKrzA4OBhu6moA1GrZg//8mzSnHOxF6fZPnQbSdYie9GYnyrfFwf1eTgojh
         j9kuetC242MRn2XGEQ1Mb+oG0BwOM0e8wWUfk02GSo7lfNZER1SBhUvKSpTeXo0usfcj
         e8zeJ7StHqIFEhIHZbhcdyPGhkqJgBAZYZSzQDJ8+FNWOqw7FrVnnWgKs/qqZ+LinG6Q
         FxIKaQEwDYUA8BU1f/BYIWP2H7s+kPvCGLPcfCZv27nk8lzRj/mkJQp7NzdFoZGIonCW
         3eTgwP4f5xPAK/WVjXrLnHF0rpkdWzhulOAdZhVx4DldEWbf+ovKyEcrwAbFKElJlvpU
         eibw==
X-Gm-Message-State: AOAM531fxZcWi84Lv+tJKh47q8BCZnXIcy8fmwnqlBUFho3gZkaYj3Lt
        6g1X4h8ecsT7B5i0o6zgCOIg/UvajrNdKqcxrn/QfgtTsZyc5o4macQCnGQd/DzZ+JqBtGRD/Ob
        LXnzBZsYE69KojSqYxtAtcAmwxeffw0EItiFAU6zrppPVp4LzJLXL5oG5miNjhXy4Y3ADL6d/xP
        aI
X-Received: by 2002:a50:bc15:: with SMTP id j21mr2979529edh.187.1612360003981;
        Wed, 03 Feb 2021 05:46:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrMI/vUqEDH4yk4FAlNYFigl+qqWJDgS3ikYYXxZ/cG6rxiZfYpeNd6AJ1QaBQx+4Ul+w4hQ==
X-Received: by 2002:a50:bc15:: with SMTP id j21mr2979490edh.187.1612360003764;
        Wed, 03 Feb 2021 05:46:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u17sm920466edr.0.2021.02.03.05.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 05:46:42 -0800 (PST)
Subject: Re: [PATCH 2/2] KVM: Scalable memslots implementation
To:     David Hildenbrand <david@redhat.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ceb96527b6f7bb662eec813f05b897a551ebd0b2.1612140117.git.maciej.szmigiero@oracle.com>
 <4d748e0fd50bac68ece6952129aed319502b6853.1612140117.git.maciej.szmigiero@oracle.com>
 <YBisBkSYPoaOM42F@google.com>
 <9e6ca093-35c3-7cca-443b-9f635df4891d@maciej.szmigiero.name>
 <4bdcb44c-c35d-45b2-c0c1-e857e0fd383e@redhat.com>
 <5efd931f-9d69-2936-89e8-278fe106616d@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <307603f3-52a8-7464-ba98-06cbe4ddd408@redhat.com>
Date:   Wed, 3 Feb 2021 14:46:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <5efd931f-9d69-2936-89e8-278fe106616d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/21 14:44, David Hildenbrand wrote:
> BTW: what are your thoughts regarding converting the rmap array on 
> x86-64 into some dynamic datastructre (xarray etc)? Has that already 
> been discussed?

Hasn't been discussed---as always, showing the code would be the best 
way to start a discussion. :)

However, note that the TDP MMU does not need an rmap at all.  Since that 
one is getting ready to become the default, the benefits of working on 
the rmap would be quite small and only affect nested virtualization.

Paolo

