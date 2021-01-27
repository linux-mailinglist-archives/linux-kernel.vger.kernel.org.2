Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F59A306584
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbhA0U51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 15:57:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233701AbhA0U4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 15:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611780916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xmqnn8rbcg26NVO4vw3SRhcUP24nD170tfktCoPpjrs=;
        b=ZPd/wQ9hnw95cS/MOPHuW0gUCHCZZ2inUE187aM7pECWGZzafCaEcFnjUPef/aIuquU2xn
        JLbvw0YH0jmvkI2g4ZuEwnsOeI4rh+6C2uFfJcUEHScwnSU4gVXpVWkCFKrwiPIMKwChm9
        JMN1AEpYRJNYTlyTGysLu22ffRzVS/Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-C7QUd0cvOCm5W3EigL93Lw-1; Wed, 27 Jan 2021 15:55:14 -0500
X-MC-Unique: C7QUd0cvOCm5W3EigL93Lw-1
Received: by mail-ed1-f70.google.com with SMTP id j12so2026285edq.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 12:55:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xmqnn8rbcg26NVO4vw3SRhcUP24nD170tfktCoPpjrs=;
        b=YTPa6JdUcoFI86ZkLVtUOxXJhvVl+fCssHzbNDcphv0D6h7ZC5bdnKQs+GLAoc8Tzt
         EAjAcVn4eVeuHjzI8pbh0jtOLNH4PNWdW3ChdZ+HRGtp6HdcNAliNymr9/2Rap90cuoZ
         arP3vBwCyTCmSKxB5PZRyDyWYZpo+rijFXltnc16S/GO98b7rMd0LzyMExQWQTu7t3ze
         4+ySKGnfB0mfSO+x+7nMfM79UshabXWGTVB6nZCA1xiuB/zEAA/aDN5Q+DKp6GTOJpA5
         Jv2q+w8jAvm4Xome7WPPQ5w7FMypywVOLv3jbS5F8ZSuQ752n5Wk5O5AxR++kyFjigvT
         u+Sw==
X-Gm-Message-State: AOAM531U6Pi0zR183LSNGvd3hfWZDOznpIeNfyjgE9e65JquXS1FLWEn
        vPq4ZaoO6x9SQYLAaZ9Dl3hliq79fkwcJ4FisO/FNsrCJ3EpceodeWmIzZ2I4cO2iUrjOCt1jKL
        7Oqhj42lkjJPugPeVes87kAss
X-Received: by 2002:a17:906:3e96:: with SMTP id a22mr6365584ejj.144.1611780913252;
        Wed, 27 Jan 2021 12:55:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqcwMloOiDIYYh5oyrCeUlD0mjUpjFJIikqBtvrKRgSHlSo5DKK/tY/ETaq8fcb7fS7bCNTA==
X-Received: by 2002:a17:906:3e96:: with SMTP id a22mr6365574ejj.144.1611780913130;
        Wed, 27 Jan 2021 12:55:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j25sm1960596edy.13.2021.01.27.12.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 12:55:12 -0800 (PST)
Subject: Re: [PATCH 15/24] kvm: mmu: Wrap mmu_lock cond_resched and needbreak
To:     Ben Gardon <bgardon@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210112181041.356734-1-bgardon@google.com>
 <20210112181041.356734-16-bgardon@google.com> <YAjIddUuw/SZ+7ut@google.com>
 <460d38b9-d920-9339-1293-5900d242db37@redhat.com>
 <CANgfPd_WvXP=mOnxFR8BY=WnbR5Gn8RpK7aR_mOrdDiCh4VEeQ@mail.gmail.com>
 <fae0e326-cfd4-bf5d-97b5-ae632fb2de34@redhat.com>
 <CANgfPd_TOpc_cinPwAyH-0WajRM1nZvn9q6s70jno5LFf2vsdQ@mail.gmail.com>
 <f1ef3118-2a8e-4bf2-b3b0-60ac4947e106@redhat.com>
 <CANgfPd9FaPhQiEkJ=VHKiVWZ_5S3k2uWHU+ViCi4nEF=GU4qsw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4c0d4c30-a95b-7954-d344-fb991270f79a@redhat.com>
Date:   Wed, 27 Jan 2021 21:55:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd9FaPhQiEkJ=VHKiVWZ_5S3k2uWHU+ViCi4nEF=GU4qsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/21 21:08, Ben Gardon wrote:
> I'm not entirely sure I understand this suggestion. Are you suggesting
> we'd have the spinlock and rwlock in a union in struct kvm but then
> use a static define to choose which one is used by other functions? It
> seems like if we're using static defines the union doesn't add value.

Of course you're right.  You'd just place the #ifdef in the struct kvm 
definition.

You can place static inline functions for lock/unlock in 
virt/kvm/mmu_lock.h, in order to avoid a proliferation of #ifdefs.

Paolo

