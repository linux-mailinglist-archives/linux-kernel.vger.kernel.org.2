Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14A7371877
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhECPxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31696 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230184AbhECPxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620057128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AgYx5TvUhkEhNhkber8yC1nc2KvBXPUk7IuRSfPajIg=;
        b=ECgPWiTw9C34RfUo7UGwEJrMyN8GYTFvvznMwaMPQ9vE8Id4l8ILKtr5rTYdwPLuFCF5s3
        NSs8Q7x3gmRZDXnbWrgqzyoXPYCL7plhC0Tc+f45U2OHlBvIZP7S+QAV0zbPoU8l2SpieV
        rjGCavGCAgpuy0tgElhLPpX+0Iyc6AY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-xhh-1_eVNNS95ZCuhXgQZQ-1; Mon, 03 May 2021 11:52:07 -0400
X-MC-Unique: xhh-1_eVNNS95ZCuhXgQZQ-1
Received: by mail-ej1-f72.google.com with SMTP id z6-20020a17090665c6b02903700252d1ccso2219769ejn.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 08:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=AgYx5TvUhkEhNhkber8yC1nc2KvBXPUk7IuRSfPajIg=;
        b=MKkKYvlsIYBJdv2YQcf5fRToXysqzeqyXRUZ1QsuNMk6fsNgofpNUQqvBf4x/It/0r
         7szQCPjiUpE6pPjYZ63wU2HPWWJ/1kHG2wfVSnHD+uB8HkbhUXJ1qIXTD4oXBQUAnF6/
         3BVbnovNKZd9x9V1LF+4UchOuKAS5SSamApHv6yWRw9RkkV82EOw4hK4YRO30dMaaW+p
         NTdtQd0BHQTG45QShcWjotfzxeVXOtdBfcx6vFI/qMLsExcRfwV09GGM5J2+D5PyNoK2
         zJYX4i/P1nXTbrcluxryE6LgjiHttXIKpjZP/vsMb6KkE/aamPfyRRWXHpREf+1rnajA
         LcSw==
X-Gm-Message-State: AOAM530OTJI+R4qipJTXCy1WMQ6d5b19n++zfdnQJFSmQuhnHPy4/ePO
        /i270eeN2HzNQeZpklTczGtGp69BvXHDfAvrcd1jKN4u7hHz0jExGWROWdxIYU73MJpfblcQJ80
        oqaWUFMY50EzUgHCHADw1sLTb87cXkcEY8nHp05VbvCLKjSHJgfnxa9phvs3/rxAboqAVUuFMwc
        xz
X-Received: by 2002:a17:906:6b96:: with SMTP id l22mr17170293ejr.364.1620057126308;
        Mon, 03 May 2021 08:52:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCUo5Gkq+n05BuEimfpfMnbNcyojuAtgJrwufNe0jzK2qdxJaPLeyw1nkoONnfSe84qDPC4A==
X-Received: by 2002:a17:906:6b96:: with SMTP id l22mr17170271ejr.364.1620057126046;
        Mon, 03 May 2021 08:52:06 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id hp29sm45178ejc.47.2021.05.03.08.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 08:52:05 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] KVM: nVMX: Fix migration of nested guests when
 eVMCS is in use
In-Reply-To: <f2f7020d-9293-d9bb-093f-b9c857a962d8@redhat.com>
References: <20210503150854.1144255-1-vkuznets@redhat.com>
 <f2f7020d-9293-d9bb-093f-b9c857a962d8@redhat.com>
Date:   Mon, 03 May 2021 17:52:05 +0200
Message-ID: <87pmy7yfve.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 03/05/21 17:08, Vitaly Kuznetsov wrote:
>> Win10 guests with WSL2 enabled sometimes crash on migration when
>> enlightened VMCS was used. The condition seems to be induced by the
>> situation when L2->L1 exit is caused immediately after migration and
>> before L2 gets a chance to run (e.g. when there's an interrupt pending).
>
> Interesting, I think it gets to nested_vmx_vmexit before
>
>                  if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
>                          if (unlikely(!kvm_x86_ops.nested_ops->get_nested_state_pages(vcpu))) {
>                                  r = 0;
>                                  goto out;
>                          }
>                  }
>
> due to the infamous calls to check_nested_events that are scattered
> through KVM?

Yea,

vcpu_run() -> kvm_vcpu_running() -> vmx_check_nested_events() if I
remember it correctly.

-- 
Vitaly

