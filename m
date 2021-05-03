Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76988371839
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhECPod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230346AbhECPoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620056617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mLWn2Bm+ged3fuObrNXQRHmGzUAtT7+v1ZR4Rf0VlH0=;
        b=Ei5iKt1jOLp0ASngAHaXU3WMEIaKwBzCqHSExJXRUU2zc0IWSnusdJJXrkCaSsg5SvYtFh
        Vl/Wu8HF8kI0ZSUx+d0CjNgNQSi+gJ13war1LSrYjoNJ1AvpQA4zauBBabVE3wcLMhUmaN
        fYLgVi/SJOnl7/xkhJB9HEICp5PpmuE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-usaZspqMNNOFzhy-jb3-qQ-1; Mon, 03 May 2021 11:43:36 -0400
X-MC-Unique: usaZspqMNNOFzhy-jb3-qQ-1
Received: by mail-ej1-f69.google.com with SMTP id ne22-20020a1709077b96b02903803a047edeso2219949ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 08:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mLWn2Bm+ged3fuObrNXQRHmGzUAtT7+v1ZR4Rf0VlH0=;
        b=WIFNvjhVA/u6AXxtE0ng1kdS2WanBtaORJ2RxEF/qmE6xjxuqm65+VtL3CCfD1fCzy
         o6HejHb6Lgm96VLNUT6Frz6Sdls8Yx6u6FD1etiibmYCdSzkkyk/ell7w3nnECsXNvR+
         53OXmXIcbHYyRfDyDmuLtqYyqpD8AyRyzYHPrHYZF98zoG+kDrWMtbIZDVbFezcR5Xuw
         8Jrb5qiWNPWGKWGmZEY4TZOH7RZSsH3GA8zjs3hdXv+aaWBZC1rJ7Sif7f2Fx2Lni/vA
         XYuwPAFZTYqH829BtEzlHcV4N2oNfaBPOBA/SdlJB3A3A/6oTQocedLafVxZVRUqplUm
         f5Ew==
X-Gm-Message-State: AOAM531sRJqREo5BNjDY2whf7Pk8dFdzzHHmn1exvrU6d9ZAMF3BbUIk
        0TSiu3zfjBJbVnqZlriJX8Y15t9ys+E4iRMDx2iUI3rR2MI84+wJ/FW/cBwJVezj4J2lYKjg2yw
        bimTgpAazfqNAFlbfyaekjWxY9dTz29uREh+sJ1L28MRt+/CitmSb0nSu1Vs4lbTioat9WABsbg
        vD
X-Received: by 2002:a17:906:5495:: with SMTP id r21mr17457094ejo.471.1620056614115;
        Mon, 03 May 2021 08:43:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQ3e7UJClc0peO858Bwd60/xCVdE4PgXLIlXr7biXcndz1LngDtvWJv+JjpA6WpPzcFJBLsw==
X-Received: by 2002:a17:906:5495:: with SMTP id r21mr17457065ejo.471.1620056613892;
        Mon, 03 May 2021 08:43:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f7sm30061ejz.95.2021.05.03.08.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 08:43:33 -0700 (PDT)
Subject: Re: [PATCH 0/4] KVM: nVMX: Fix migration of nested guests when eVMCS
 is in use
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20210503150854.1144255-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f2f7020d-9293-d9bb-093f-b9c857a962d8@redhat.com>
Date:   Mon, 3 May 2021 17:43:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210503150854.1144255-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/21 17:08, Vitaly Kuznetsov wrote:
> Win10 guests with WSL2 enabled sometimes crash on migration when
> enlightened VMCS was used. The condition seems to be induced by the
> situation when L2->L1 exit is caused immediately after migration and
> before L2 gets a chance to run (e.g. when there's an interrupt pending).

Interesting, I think it gets to nested_vmx_vmexit before

                 if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
                         if (unlikely(!kvm_x86_ops.nested_ops->get_nested_state_pages(vcpu))) {
                                 r = 0;
                                 goto out;
                         }
                 }

due to the infamous calls to check_nested_events that are scattered
through KVM?

Paolo

