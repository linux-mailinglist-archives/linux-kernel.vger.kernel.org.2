Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FFC434A32
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhJTLkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:40:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56401 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230135AbhJTLkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634729879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WMFMpI2ywfhiF/WZQ2cVNkUkb9LeUHwe6nPMf/N51Uk=;
        b=aQFDcANytmItAGaSf5tN7Vz/GZDXKPkQnoJ5sMNgHI0Va+YoKQgJxK3z92uWiYogPtJd/9
        zvAftN4chdTrqUsMaPreCAtl7iTFob5t8vnNf8sEImf2FhzSCmDkb5ZYTAXhVWuztjK1Ci
        XHvxbAtYnvHw0KyG4ABdLvnW2yAm0hM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-aBDm0ShZNL-6d9U21462sw-1; Wed, 20 Oct 2021 07:37:57 -0400
X-MC-Unique: aBDm0ShZNL-6d9U21462sw-1
Received: by mail-ed1-f72.google.com with SMTP id h19-20020aa7de13000000b003db6ad5245bso20795661edv.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WMFMpI2ywfhiF/WZQ2cVNkUkb9LeUHwe6nPMf/N51Uk=;
        b=ncja1cdFAOVbWTVgRvj7hQNMmvhtqt2f03wHU9fIteMfz+W019QAuHTmLXMpfsBhfi
         DkNZaoiBE6YE0FMsOULr4vHnNqcx6+YTiuUHmULI9VQR9PxrvU1Ot0GuXs6Mts5MsdYv
         IU9sx+W83KkdXDFsCfqT9z3Ty7FhhK/MbKKhuo9FqJNUF2W+yM9P7UaocuPTdzRTOjw2
         oGBh6BbfAjnjkBnK37odGBmCtRlKXtzO3UXhh+zGEqduzIGdVp791pwZAbAXvO7YkY4K
         DS3SAZGwppXJTwbADRb6H75UjKEkmc7SL4UH5zXBOd/9HOCm0uGa4T6muZ78S9t0qLLL
         PzqQ==
X-Gm-Message-State: AOAM532QO2X/Nno4ntCtBCvloQ5PMY5RhTCSueDexRs9ymk+qs/V48iF
        3GwHQQ7K0vTHvx/IaVbAt9NOByWzu8wOXZHUELHgJn3N7HfojO+Jy5LGUA3/53x/TiM789+QwIc
        HFNpZualO2jsfItWmRGegx7Ct
X-Received: by 2002:a05:6402:90b:: with SMTP id g11mr62795971edz.32.1634729876486;
        Wed, 20 Oct 2021 04:37:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/Kwn3SPasef1rECuTy0s1D3BJoVygPew/lcZ8vA2zu273zdL7RPPGrnK4RDV3fBbQVimbrg==
X-Received: by 2002:a05:6402:90b:: with SMTP id g11mr62795932edz.32.1634729876202;
        Wed, 20 Oct 2021 04:37:56 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id nb29sm1084687ejc.54.2021.10.20.04.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 04:37:55 -0700 (PDT)
Message-ID: <659fbd82-7d18-0e76-6fe4-b311897b4ae0@redhat.com>
Date:   Wed, 20 Oct 2021 13:37:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] rcuwait: do not enter RCU protection unless a wakeup is
 needed
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <wanpengli@tencent.com>
References: <20211020110638.797389-1-pbonzini@redhat.com>
 <YW/61zpycsD8/z4g@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YW/61zpycsD8/z4g@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/21 13:17, Peter Zijlstra wrote:
> AFAICT, rcu_read_lock() for PREEMPT_RCU is:
> 
>    WRITE_ONCE(current->rcu_read_lock_nesting, READ_ONCE(current->rcu_read_lock_nesting) + 1);
>    barrier();

rcu_read_unlock() is the expensive one if you need to go down 
rcu_read_unlock_special().

Paolo

> Paul?

