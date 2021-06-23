Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CEA3B1717
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 11:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFWJl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 05:41:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43842 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230170AbhFWJly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624441176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nk49XlXeHosOswVGCCNxHMrFlyXg5sckW14ipg09Etw=;
        b=ifnvWxl5uL0qoLZTJOoQnJSsE5V4Imw8CS0baXcFr2UJ7iyBeRx7Wr7i08dINGMbBWEYps
        zvXy9k6sZAtNdXHmlVnxNj1BtVO6Y+kCVmiDHkSRoykgzLjMfx3thy3clhVmqGf2PxSZcv
        R25yy7FzJkhqyGlgU4XglqD0n9VsNE4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-hsdo36C_NF-IwKg1yJ6qAQ-1; Wed, 23 Jun 2021 05:39:35 -0400
X-MC-Unique: hsdo36C_NF-IwKg1yJ6qAQ-1
Received: by mail-wr1-f71.google.com with SMTP id p2-20020a5d63820000b029011a9ecaf55dso829712wru.19
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 02:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nk49XlXeHosOswVGCCNxHMrFlyXg5sckW14ipg09Etw=;
        b=iLN3O0IN37yWEUbdugzhaEb9J3KYYmOUqMmcN7nmLhbT5x0I+LQhMoXOcNwub39lBx
         ovgQNCWOPj7FDAwYbY/FtyEAsT6H1IjdkbHWWbCtum/jdv8597/V/0EPEPWVLJOuNG9Y
         qyegvMaNbFrtP2GH3vyRsERDMYqoKi5rZukuM4otNKhKjSOafxRcmyPj0GrmYWfcNADp
         WA8yohp2IoQWCB4iIRtNqTN7vgyd+i35QdBiu/r2zTYWsT3dRoysHcFyQXOIh8FRqkYg
         icksiQDNF3evuwtV+xpPeyYg788ilUqRzOqovEI4bBiVBxDXzum8bmvnNes3NXe+n9U9
         hvKQ==
X-Gm-Message-State: AOAM530J59Wudd5awEH3H4mWt2guo79MQe3GIv+CcJTzqjMy0aIr4nnl
        0wqL2Z7yYNBZoPXCHZwncQIlNlr1MdrVd+R9HSxgbbjC4fSZ1Gm2eenDBMq+ayarzTH2sz8Orjm
        EEw2TDffjiCbuxOgyEGdyGpTajAjk2OjcHJoh8as97kasP2g/kf0HqA/RZGHSJBqq6E51EKCx+/
        80
X-Received: by 2002:adf:f946:: with SMTP id q6mr10260017wrr.283.1624441173938;
        Wed, 23 Jun 2021 02:39:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhIlzIfSpKT+lNu6OZDVYqOFhFkR+ZB2WuZ/Xszdb1cxSHhgpp7LV9CAMtlxzmCLxqDCiCeg==
X-Received: by 2002:adf:f946:: with SMTP id q6mr10259987wrr.283.1624441173707;
        Wed, 23 Jun 2021 02:39:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s23sm5715276wmh.5.2021.06.23.02.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 02:39:33 -0700 (PDT)
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20210623074427.152266-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC] KVM: nSVM: Fix L1 state corruption upon return from
 SMM
Message-ID: <a3918bfa-7b4f-c31a-448a-aa22a44d4dfd@redhat.com>
Date:   Wed, 23 Jun 2021 11:39:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210623074427.152266-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/21 09:44, Vitaly Kuznetsov wrote:
> - RFC: I'm not 100% sure my 'smart' idea to use currently-unused HSAVE area
> is that smart. Also, we don't even seem to check that L1 set it up upon
> nested VMRUN so hypervisors which don't do that may remain broken. A very
> much needed selftest is also missing.

It's certainly a bit weird, but I guess it counts as smart too.  It 
needs a few more comments, but I think it's a good solution.

One could delay the backwards memcpy until vmexit time, but that would 
require a new flag so it's not worth it for what is a pretty rare and 
already expensive case.

Paolo

