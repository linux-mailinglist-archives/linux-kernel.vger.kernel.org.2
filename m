Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA2F3A305C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 18:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFJQTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 12:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26978 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229823AbhFJQTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623341860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZV1bVT+oVuvRwSag1zc65v0K9NM/OVSkL9nei36QNwU=;
        b=Js/uGmJGGPc4MTjKtvj2vppBlaeKorOapUPP2LQVjS96tlptWd7lCK982NMtMWSVwtb96R
        zoGxoiyVCGqevUUhtSYfDq/6U23aMjpnqgJ9Srdgyn74iaOpFo4CcP+2IhrIGRmCxjzsEM
        IlLOctNxhwtoY2p6GrMGndYIKRjJ4Qk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-rk7GBxvqP_KQpGTyP83wUw-1; Thu, 10 Jun 2021 12:17:38 -0400
X-MC-Unique: rk7GBxvqP_KQpGTyP83wUw-1
Received: by mail-wr1-f69.google.com with SMTP id h10-20020a5d688a0000b0290119c2ce2499so1168474wru.19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 09:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZV1bVT+oVuvRwSag1zc65v0K9NM/OVSkL9nei36QNwU=;
        b=Z2ZwYL7oZB9Ms3IB87GdLXEToMqM6owLxYnAfGO798cCc5ylnYJZ2uHrwmV3R1dy/c
         Q8OjgLHUI7tT7xFKhea2P1eK5/mTS43obKXRUbBAcjUlQs1p9QkRwglQYgw6aLHRptfi
         IWlT3GpwvH+vqT2f52tK9a/MLu6i6tJCkkWZp0rNLYgVVjUDlRVfwCYLjpYos4EguqTs
         bjuGHJ7VOOOl2eneP3jg08/KzejYOINBpHRDRcYdZSXs7l47NEZzWNPaMuZERBtcfhg1
         cOkC5Pdcqy5D1xcQWB0pUrlNu3ES012cIagKulzelo/jKougbcsyBMgQBtry6+y3MVNN
         XUkQ==
X-Gm-Message-State: AOAM532H4j6999TjWGlepO8S8VVtP1OFMxUyb/VNjGbUs406h1F7UvqU
        Q3VXfiEERonXbU79ObujAQc0Nbtkjw1reujundn+zjF5/R2t6rTdwX39i5TpE9PR5GHrWMUPFWC
        HaSl4PnlzVC096y2XKzIDXNUuT4lTtQy+QGr2CWXn1Npr5K7HsuetRKdACEJW+Y0Qjv1Ome7jbv
        9g
X-Received: by 2002:a05:600c:4f4e:: with SMTP id m14mr15919088wmq.157.1623341857388;
        Thu, 10 Jun 2021 09:17:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqLRREr8mEsplysYivjXvH3AgrXT1Q52Hk9vF4ThTmdBEaWk4iHeWyUUKviP99g/YadNhJfg==
X-Received: by 2002:a05:600c:4f4e:: with SMTP id m14mr15919044wmq.157.1623341857072;
        Thu, 10 Jun 2021 09:17:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id 25sm9762200wmk.20.2021.06.10.09.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 09:17:36 -0700 (PDT)
Subject: Re: [PATCH v3 2/8] KVM: Integrate gfn_to_memslot_approx() into
 search_memslots()
To:     Sean Christopherson <seanjc@google.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1621191549.git.maciej.szmigiero@oracle.com>
 <b8258ced64a81c7d90320c2921fe08b11eb47362.1621191551.git.maciej.szmigiero@oracle.com>
 <YKWB9bPyyFfo0uhf@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb9d336a-67dd-6a31-51c2-cbcd72c49824@redhat.com>
Date:   Thu, 10 Jun 2021 18:17:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKWB9bPyyFfo0uhf@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/21 23:24, Sean Christopherson wrote:
> An alternative to modifying the PPC code would be to make the existing
> search_memslots() a wrapper to __search_memslots(), with the latter taking
> @approx.

Let's just modify PPC to use __gfn_to_memslot instead of search_memslots().

__gfn_to_memslot() has never introduced any functionality over 
search_memslots(), ever since search_memslots() was introduced in 2011.

Paolo

> We might also want to make this __always_inline to improve the likelihood of the
> compiler optimizing away @approx.  I doubt it matters in practice...
> 

