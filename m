Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F30B4347D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhJTJX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33940 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhJTJX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634721672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2FTm4hB908w4qRaSg9DMpXYtjbgTyekA3fgrUlsXzrg=;
        b=C68uORIATUmJalh3etreSPz+xULkkP7i2MaSXMLvQ9wTdu6N5dA7fRlY2Y83os9Bj+VpFC
        ghe44IZdDuqSXiQ9Wr3hWIG4x9ecT2ID7Hr6UsmU1T38Zf6ymoob+xTaTKuEhKx/vBKyJK
        OCaTxwAJEAlybbdBUuh7OwtOxAp0FYQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-8Q3rLmWSMsOdqXZ3eJc0xQ-1; Wed, 20 Oct 2021 05:21:10 -0400
X-MC-Unique: 8Q3rLmWSMsOdqXZ3eJc0xQ-1
Received: by mail-wm1-f72.google.com with SMTP id p3-20020a05600c204300b0030daa138dfeso3874383wmg.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2FTm4hB908w4qRaSg9DMpXYtjbgTyekA3fgrUlsXzrg=;
        b=MMVMN8AcTrroiWEYHWCUSXnkvy/l2OPCFU9wE18FuNQUMsvs/GE8F2nTEE33Q4Quof
         JKaua+LG6hDrIIZ/Lb/XepTW+7pJ/FmF+IZCQjW11itoh1NHvaEh+Qeac/0JfL0zqxV0
         wFvY+yzhiwkJFDOuo9j/8Y4Z7LfKnUQMLHEJLyrQtQjk97jWH8+U8BVyafqapfWKqwl3
         IyHkQ/Ve2+QtZ19N+cLXvJ8DrNjhdzkPKuj8rqbmN3gCMWAt3uLIGtSVllB+Trz0MEpi
         VEUJZPxQqIS6JgKhZFdJSeR/bpbg5bJylRRrqbi9ux8O2gkiNmRJMR4gLTbJXP9wIrlu
         rseA==
X-Gm-Message-State: AOAM530mjiVsDbHAop0LXzfk1ESUGH3TcVb0lItXThdTItF53ngy4CkM
        pi/D0n85rmyHoG3BqNdVjKAZJdzduuXb/mSrOLIeI0v3ynvzYut1FKQUNfPJEzD4/VKJ4H31hGA
        jkzzt0a992efLUMm7Ei2R7Nho
X-Received: by 2002:adf:a78a:: with SMTP id j10mr51574909wrc.105.1634721669588;
        Wed, 20 Oct 2021 02:21:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8K9SqjdnLTu+AtEqO80YHThHgWgyLObp8OQmz0jj1gpserb3ZGDdiVUyHxxkUmPdPJmBTMQ==
X-Received: by 2002:adf:a78a:: with SMTP id j10mr51574880wrc.105.1634721669335;
        Wed, 20 Oct 2021 02:21:09 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id z1sm1517895wre.21.2021.10.20.02.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 02:21:08 -0700 (PDT)
Message-ID: <dd914336-efca-e74e-521d-dbf57ad4eba3@redhat.com>
Date:   Wed, 20 Oct 2021 11:21:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] KVM: cleanup allocation of rmaps and page tracking data
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     seanjc@google.com, David Stevens <stevensd@chromium.org>
References: <20211018175333.582417-1-pbonzini@redhat.com>
 <6eb45cc24c433f5620f08d7bcd0c9cc179b696e8.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <6eb45cc24c433f5620f08d7bcd0c9cc179b696e8.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/21 21:28, Maxim Levitsky wrote:
>> +static inline bool kvm_memslots_have_rmaps(struct kvm *kvm)
>> +{
>> +	return !kvm->arch.tdp_mmu_enabled || kvm_shadow_root_alloced(kvm);
>>   }
> Note that this breaks 32 bit build - kvm->arch.tdp_mmu_enabled is not defined.

Indeed, the right test is is_tdp_mmu_enabled(kvm).

Paolo

