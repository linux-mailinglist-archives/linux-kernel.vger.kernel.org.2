Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D34456D50
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbhKSKcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:32:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234378AbhKSKcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637317779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7VVfU7MoxGcDgca+a4FR3TmIq0TVABKMELw1cCVOhzA=;
        b=Vs0i9K7AhdSBZw0e/n8MtvJ4V++r6t/84vRCYoRFfEfJuKD1h9/gWfDv3BJDNT8A87pTCm
        9OLNKzpkywLx4RamRqDCAZq0FZwqArmo05SPdcVT28lH+2EzwjBoymD+2MU+WgXS4pF9JP
        3VMs5f1PRB6lxsIRJTK0d2Jh19MHrh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-409-NCWidOJTNCu-XXZJ16An0w-1; Fri, 19 Nov 2021 05:29:36 -0500
X-MC-Unique: NCWidOJTNCu-XXZJ16An0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2C7F100CCC0;
        Fri, 19 Nov 2021 10:29:34 +0000 (UTC)
Received: from [10.39.194.192] (unknown [10.39.194.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4105519811;
        Fri, 19 Nov 2021 10:29:30 +0000 (UTC)
Message-ID: <50caf3b7-3f06-10ec-ab65-e3637243eb09@redhat.com>
Date:   Fri, 19 Nov 2021 11:29:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/4] KVM: x86/pmu: Reuse find_perf_hw_id() and drop
 find_fixed_event()
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
References: <20211116122030.4698-1-likexu@tencent.com>
 <20211116122030.4698-4-likexu@tencent.com>
 <85286356-8005-8a4d-927c-c3d70c723161@redhat.com>
 <e3b3ad6f-b48a-24fa-a242-e28d2422a7f3@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <e3b3ad6f-b48a-24fa-a242-e28d2422a7f3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/21 08:16, Like Xu wrote:
> 
> It's proposed to get [V2] merged and continue to review the fixes from 
> [1] seamlessly,
> and then further unify all fixed/gp stuff including 
> intel_find_fixed_event() as a follow up.

I agree and I'll review it soon.  Though, why not add the

+            && (pmc_is_fixed(pmc) ||
+            pmu->available_event_types & (1 << i)))

version in v2 of this patch? :)

Paolo

> [1] https://lore.kernel.org/kvm/20211112095139.21775-1-likexu@tencent.com/
> [V2] https://lore.kernel.org/kvm/20211119064856.77948-1-likexu@tencent.com/

