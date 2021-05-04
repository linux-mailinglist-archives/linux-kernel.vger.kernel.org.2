Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D67137314E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhEDUUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54955 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231750AbhEDUUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620159558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XT5wmldVjcj9qzq2rbcAVF3LYdtWWQb01hB//6q8U0E=;
        b=bqAyKmwEHiq6DP2cmhHzQ9qgFLavH3abSpTeQh+CHW1Zns5Jnxhq44vRmVVNd0+th/OQ5Y
        sQrJVHu4wJgMg26TcBANKihXQz7aKVVO3+PGEhAS/XMms8RGmqLfzAuY3jWxyEOizIUWVc
        PVhrCqSxsd7la2dqd7mNPqksbJegA4c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-oDBK-wU1PqGAwnbCRvvScw-1; Tue, 04 May 2021 16:19:15 -0400
X-MC-Unique: oDBK-wU1PqGAwnbCRvvScw-1
Received: by mail-ed1-f70.google.com with SMTP id q18-20020a0564025192b02903888712212fso6815906edd.19
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 13:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XT5wmldVjcj9qzq2rbcAVF3LYdtWWQb01hB//6q8U0E=;
        b=UajaNAUAaP1g/2LGl757RWJfxeoPlsPNml9YFCURWT5ZxenxYBbNcs1WvmOzeclJUl
         MXGPTMaWvie1VmWIpsyorIeIu3UX0UI8vdY0JSRr9XwQfrLWKKIyPeaJTe9vk7W1NAPE
         K8EQKmN++f7romZaTHRvBaB6jiiIH5b20F93eQHrYNk/FjiPHpW54jyrrDqhwnPJMLle
         9VW1ZKXtB1zmccdegy2eeTe7Jc5Ms6ECVVA5frxyK7keO1Q4x6RB9C51D9Ao2FuNzIc4
         trjlbF3x5DswkWiHfCMhp8aVHONMkiJkLxBwWxicDaUyC9xjlBso/fw1I9Vh6DcjXPAT
         Ev7A==
X-Gm-Message-State: AOAM533WHP8aWn6PCE8n5REy1fpbkrlX589ZSlMAu+2tymMG/DGinpLR
        Ku4NJaGDQy9AFExJF8bJeMlddGV2+U2ZqUbV3uLabuAnsSNU+M4f02xvZuh3IyJinwzQZCx8MRB
        ur0yGgLoSOi9emvFkXbcp9azH
X-Received: by 2002:a17:906:f0d1:: with SMTP id dk17mr24298930ejb.256.1620159554133;
        Tue, 04 May 2021 13:19:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7qgPDq/WT4usRYakJCroraJvYEIPirrEpNH9of0IyZWOEVewfiFFivXTogMTwWuarhK6EJQ==
X-Received: by 2002:a17:906:f0d1:: with SMTP id dk17mr24298918ejb.256.1620159553980;
        Tue, 04 May 2021 13:19:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id m9sm2013860ejj.53.2021.05.04.13.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 13:19:13 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] KVM: x86/mmu: Lazily allocate memslot rmaps
To:     Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210429211833.3361994-1-bgardon@google.com>
 <20210429211833.3361994-8-bgardon@google.com> <YJGqzZ/8CS8mSx2c@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <781d2549-bbb1-23a2-44bf-58379ba23054@redhat.com>
Date:   Tue, 4 May 2021 22:19:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJGqzZ/8CS8mSx2c@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/21 22:13, Sean Christopherson wrote:
>> +	/*
>> +	 * If set, the rmap should be allocated for any newly created or
>> +	 * modified memslots. If allocating rmaps lazily, this may be set
>> +	 * before the rmaps are allocated for existing memslots, but
>> +	 * shadow_mmu_active will not be set until after the rmaps are fully
>> +	 * allocated.
>> +	 */
>> +	bool alloc_memslot_rmaps;
> Maybe "need_rmaps" or "need_memslot_rmaps"?
> 

Since we're bikeshedding I prefer "memslots_have_rmaps" or something not 
too distant from that.

Paolo

