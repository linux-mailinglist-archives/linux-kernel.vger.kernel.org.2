Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2EE3B1F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 19:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhFWRJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 13:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229758AbhFWRJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 13:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624468019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPVt+K/jMh/0Kfe0YLtFKBFaxz7RZ0N0HZlRqVxmqDs=;
        b=FzfEfxCkp2MWl63I6EEQgiJ85vNz3ph/2C5LD9KJJLbn6SmmudnF+xDb/fHXoOqgtezCOP
        QTee03HfQ39fZRneSghdn2YGDT/7sWk/3VmVwjuD7mYsiUINvIOFO+Jcsta4Bk155bGHgh
        ChzcvwHTNvGEl9wj44pBwddm5/6A6uw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-Ah_67_5eMyuIRHNaCSSb5g-1; Wed, 23 Jun 2021 13:06:57 -0400
X-MC-Unique: Ah_67_5eMyuIRHNaCSSb5g-1
Received: by mail-ed1-f70.google.com with SMTP id m4-20020a0564024304b0290394d27742e4so1678718edc.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 10:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nPVt+K/jMh/0Kfe0YLtFKBFaxz7RZ0N0HZlRqVxmqDs=;
        b=WRu8UhdGoJqfno5fBPJ0RkUdgaQJlZQhsQWjHizY/oalSWO4bG4ofoMLytTpm3HxvY
         gQ6hFc06zrE6uqS93fH36Zhh/Za5HDQIGBZdu1b4/aR35vFRboUo/kuK7pMXX70sgAAe
         ppsAm+ruNSZ6qu06Yf0AQyI/9ncHaqoQ+ynTnDxRJmqaQSTS52UgVU8MPk1X1D8+//ij
         hqW6esye9M9SzobCBtB/NHTqQ3BO//igk6UOTWwlRH3SaTtX6V40jeyQyux+aQRfWTQy
         NitYj6na3gw2xo9lsq+r6d2Zidd3o8wW6NAwFRVXzxdaAXJRV7q60LCbEE4CeCTFyNFO
         /oVg==
X-Gm-Message-State: AOAM533i7J2zSGHw7S/WyIJUx3HmP2Xi+is2Yay74+gWWd62uGO56Unm
        F+Py7MiXXeU4whEfa2jLFCHZkz0429fd3raFmJ0PU5iW/q+AySmPGGa3Yyenxt/zQTKIs8KCmWS
        Zbg1yROvh4P2SOS3YbJvfJMap
X-Received: by 2002:a05:6402:b17:: with SMTP id bm23mr1038645edb.173.1624468016100;
        Wed, 23 Jun 2021 10:06:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLFwygq5KyPf04IwpHKYc7htZRNliOVInK6MiB1I1WnqSCK5JY1zXrVoLimYgI18Y5jIgZ2w==
X-Received: by 2002:a05:6402:b17:: with SMTP id bm23mr1038619edb.173.1624468015958;
        Wed, 23 Jun 2021 10:06:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id yh11sm154201ejb.16.2021.06.23.10.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 10:06:55 -0700 (PDT)
Subject: Re: [PATCH 15/54] KVM: nSVM: Add a comment to document why nNPT uses
 vmcb01, not vCPU state
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20210622175739.3610207-1-seanjc@google.com>
 <20210622175739.3610207-16-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b759e31b-6269-a401-9fbb-49227b8be009@redhat.com>
Date:   Wed, 23 Jun 2021 19:06:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210622175739.3610207-16-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/21 19:57, Sean Christopherson wrote:
> +	/*
> +	 * L1's CR4 and EFER are stuffed into vmcb01 by the caller.  Note, when
> +	 * called via KVM_SET_NESTED_STATE, that state may_not_  match current
> +	 * vCPU state.  CR0.WP is explicitly ignored, while CR0.PG is required.
> +	 */

"stuffed into" doesn't really match reality of vmentry, though it works 
for KVM_SET_NESTED_STATE.  What about a more neutral "The NPT format 
depends on L1's CR4 and EFER, which is in vmcb01"?

Paolo

