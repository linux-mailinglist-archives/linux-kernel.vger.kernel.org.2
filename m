Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE48D434AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 14:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhJTMGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 08:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25349 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230134AbhJTMGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 08:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634731469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UE/l4uetJOxWMqc3F4JFjX4DgIjZidmlZiM6BKW1Wgs=;
        b=X1O7AK1csLIoX3t+oSNx69w/PFb+PY9fpyHKJvJMGCJGJIuMRF5CMdXn7neaUdHWznP08+
        CaAd5brTvBCJgBTwMpGGPa19fbkcoDmaLs7SHqXDWOtKgKGV+/k5w9frcsbrFbTrtJBkaN
        GvVAVXsM3vV8XSTqfMfJ9qpBbyTuTHI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-nr-nrHyYMYePCvb1W5pabA-1; Wed, 20 Oct 2021 08:04:27 -0400
X-MC-Unique: nr-nrHyYMYePCvb1W5pabA-1
Received: by mail-ed1-f70.google.com with SMTP id f4-20020a50e084000000b003db585bc274so20719899edl.17
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UE/l4uetJOxWMqc3F4JFjX4DgIjZidmlZiM6BKW1Wgs=;
        b=Iw7naJP5WqP4WcKWDX7r1JydZXSbQrIfrmtHmOE9b5eVM6dx0luWBFsSYRwuYnIX6D
         0aSYFDrTMAWrb1QGfV+meiFMl0nCjBQR0DPbPK8uqy5Z7Ybi8xQRGSjDtQ0guT8VeanA
         WYMi+qriUWT6cL5GrugC67OP9Bc4bFpZd7wyiNS2EggOmupeCmoJr5O/toF/INMZBudC
         BgWQjRJZA3g/PfmqZmwhvp+oovdnGSYpkF7HcCxgBNfiU3dpVCPlPxFH2kzP51rXBx/O
         y0oqgoVqiW9B5YLHCD0Jmx3myF4r9+RMf3J5yVqlHj2VWEpum1aJ+l3Gn/1jwrU+Camb
         XeQQ==
X-Gm-Message-State: AOAM53281zYH0ojCyySMku161uQybNG8+Ql29fw3sHVwxChZaVluam4N
        yQQDs/Yi9XWTqExLEKvdmVTpXkFkJRyh+K1Shmup0UMRh5Lu2LF4o4niIgvNN04sLAgkRTbfpzb
        UoFUEVl62pDoreW8qs8UudPYP
X-Received: by 2002:a50:e1c4:: with SMTP id m4mr61532593edl.307.1634731466549;
        Wed, 20 Oct 2021 05:04:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZ5C06nGEqIWM/xJH71Ww90rK/u6cjEMP7r0VYOQvRtgXosZQm6GVJfl1z5ecQizV7PxnNyw==
X-Received: by 2002:a50:e1c4:: with SMTP id m4mr61532568edl.307.1634731466289;
        Wed, 20 Oct 2021 05:04:26 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id rk9sm955443ejb.31.2021.10.20.05.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 05:04:25 -0700 (PDT)
Message-ID: <bd4e3b80-fefd-43e8-e96b-ea81f21569bd@redhat.com>
Date:   Wed, 20 Oct 2021 14:04:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] rcuwait: do not enter RCU protection unless a wakeup is
 needed
Content-Language: en-US
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <wanpengli@tencent.com>
References: <20211020110638.797389-1-pbonzini@redhat.com>
 <YW/61zpycsD8/z4g@hirez.programming.kicks-ass.net>
 <98a72081-6a2b-b644-d029-edd03da84135@redhat.com>
 <CANRm+CyX+ZZh+LbLPBXEfMoExkx78qHpP-=yFCop9gX+LQeWDQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CANRm+CyX+ZZh+LbLPBXEfMoExkx78qHpP-=yFCop9gX+LQeWDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/21 14:01, Wanpeng Li wrote:
> Yes, in the attachment.
> 
>      Wanpeng

This one does not have CONFIG_PREEMPT=y, let alone CONFIG_PREEMPT_RCU. 
It's completely impossible that this patch has an effect without those 
options.

Paolo

