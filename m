Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B903A465C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhFKQVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229572AbhFKQVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623428357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RDL7ttxouIIhaHWr6IKTrlhJt0/pNbx4H3jjDvgIxo4=;
        b=dC0Bm5+LXYB5l8N3gq0vEDk2VKUe8DFZpigsA3Ed++D3uq+wJhQIHyWjgH7X0xZfZS0BQz
        4ewzNmuP1bSO61l8SEyKE3Om0gaCgDD0IavBVUQGi2xrjgK73NjkyKA1h87wwf3lHwN/DM
        uUdschRqdbkpvA+Sxm3gj1HjWt1roCQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-qDXYQfEwNZWMJw-2Uqc4Mw-1; Fri, 11 Jun 2021 12:19:16 -0400
X-MC-Unique: qDXYQfEwNZWMJw-2Uqc4Mw-1
Received: by mail-wr1-f69.google.com with SMTP id k11-20020adfe3cb0000b0290115c29d165cso2850123wrm.14
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RDL7ttxouIIhaHWr6IKTrlhJt0/pNbx4H3jjDvgIxo4=;
        b=H9UTmXxxCmurjNxNd4nZJGFte4kMzjtwFc2UbO0m8ZNSOVhBOXq6uhKpNj0CGuuq/o
         VUB2qndmBRK154PdV/Bkr4J0YxKpMM4g3Lk14WD6FDtmwHZo5GK8NoU34T/rf31dVdzc
         HXy4XwdWAvtE37C8+wrMBOogNIx78ZMgOf2bK2nkf7phSaMqfzTTYpr8fzg5Hy72wVUr
         ZWp6MBygbQ5lVFKJ0J+4z9VWA9L97CORVDXSc8Sby8h0x74QFFUEAYdtqSbHDomNn/F8
         PsPSWyKdgdM1qIdxc47PILS5ajdr1vF7XObNNbUj/YQqdAEmigWpk7QtBzzzfGktXm/P
         48OQ==
X-Gm-Message-State: AOAM531zNQ2cPwQdTqFhVjaHX1+yCDPY3KFwUs3sv5hEDfkYtulG+ubm
        edmOfqFgPeteHu8Ds+xHenUCkm7ZwlcCDm9GAfrP7N4UDyAMw/vjNM/75C6+cRzM62RazORQhyN
        70dcTDI3+EV0MXN7O7738kH4OS5sbxJbWLmT+SNz/awz7R/vcq8pTGpXVwlHzhDqHitEVrT3Uwv
        ZC
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr4852393wmj.134.1623428355082;
        Fri, 11 Jun 2021 09:19:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyINgCDbOBo9OC8UrfvxSwKA7rBXMHFGZv2HIog3Y74jrQqfeuhH0vfLgmiy1dyQd4XDq/0HQ==
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr4852366wmj.134.1623428354871;
        Fri, 11 Jun 2021 09:19:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id o18sm13192206wmh.38.2021.06.11.09.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 09:19:14 -0700 (PDT)
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210610220026.1364486-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: x86/mmu: Calculate and check "full" mmu_role for
 nested MMU
Message-ID: <b2084f55-3ce5-57c4-f580-d6a2de6ce612@redhat.com>
Date:   Fri, 11 Jun 2021 18:19:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610220026.1364486-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/21 00:00, Sean Christopherson wrote:
> things like the number of levels in the guest's page tables are
> surprisingly important when walking the guest page tables

Along which path though?  I would have naively expected those to be 
driven only by the context->root_level.

Paolo

