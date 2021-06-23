Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA21E3B21A1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 22:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFWUPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 16:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229726AbhFWUPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 16:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624479203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPS5S0IvDFy+C72CmNQKNdIO8Yy6w5eRS/q/XzOp9LU=;
        b=Zo/nNL+Al2J0ISx9ovIsyHBntXQiDxElRBbckF8fqrdSsEcNb1kQ3KHJS8u498nKlQQR/g
        ZhynuQMLa0Vycs1B1xKXsrwZ/W5o3dEY5QS8VnLeJAiNuXsbNtjTDtGd0ABVH+inhvstOd
        wi7mfjdEBjTLUAl9ivV3EitJQnufkq8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-URIfD-OGOZa2gyPlsiNaKQ-1; Wed, 23 Jun 2021 16:13:21 -0400
X-MC-Unique: URIfD-OGOZa2gyPlsiNaKQ-1
Received: by mail-ej1-f71.google.com with SMTP id lu1-20020a170906fac1b02904aa7372ec41so1242042ejb.23
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 13:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zPS5S0IvDFy+C72CmNQKNdIO8Yy6w5eRS/q/XzOp9LU=;
        b=OkjNRAEO1BntMf0HwhwYeeoZTF21DGr2IhU6ok/kXq10pyw6BUMgkw7c7v4OM+A60I
         U5uZHCVGDdFVVtwuU0vL76qOw+2Hk67tjThFWBeWk198y6HELxLUL+GJftVewUg51yan
         lwxeks205NWWkN+/Wj4PApsfHY3J5KrNgsbfOIPsppmYhC7gwMqe/cHrIT+itvf/ie9h
         QEwIYT9xqrOMwLVrbT3zxa8ROX02QIrx4lUHFhyiA83GREeuuGKEw3OisR2LzVmQYM6V
         exfDrtdL+o1Z4B7aRM1wxCS7E2uJITukE5LGyWStpgGcnM0NNngja/g4ZU1LMngzpVE9
         MmWg==
X-Gm-Message-State: AOAM530MeDS4RpBpChB+K9uDak8NImfP1/fuywqmqu8QZUD/XpyfpZYF
        vmqBMCPc1Uju+8eXbeHzSB6rbVu0oRQusIq4HRIhm3rY1T8Y8I7G4lGlLl3b3WwsXcn55D5Ey3x
        0BrOGmQyYbVWvBlk6dAqbjBGd
X-Received: by 2002:a17:907:6e9:: with SMTP id yh9mr1853172ejb.86.1624479200510;
        Wed, 23 Jun 2021 13:13:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXz/TF85ocEjS7tKoAxI9Fvz0zQu/S4X4/9uq11pN3P5WQxEpa/XpvRWkiMBf75n30HvN8UA==
X-Received: by 2002:a17:907:6e9:: with SMTP id yh9mr1853165ejb.86.1624479200333;
        Wed, 23 Jun 2021 13:13:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id bx11sm292565ejc.122.2021.06.23.13.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 13:13:19 -0700 (PDT)
Subject: Re: [PATCH 47/54] KVM: x86/mmu: Add helpers to do full reserved SPTE
 checks w/ generic MMU
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20210622175739.3610207-1-seanjc@google.com>
 <20210622175739.3610207-48-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d79fe507-44a2-8051-63d3-09469e36bc49@redhat.com>
Date:   Wed, 23 Jun 2021 22:13:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210622175739.3610207-48-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/21 19:57, Sean Christopherson wrote:
> +	/*
> +	 * Use a bitwise-OR instead of a logical-OR to aggregate the reserved
> +	 * bits and EPT's invalid memtype/XWR checks to avoid an extra Jcc
> +	 * (this is used in hot paths).

Probably s/this is used in hot paths/this is extremely unlikely to be 
short-circuited as true/, since we are at it.

Paolo

> +	 */
> +	return __is_bad_mt_xwr(rsvd_check, spte) |
> +	       __is_rsvd_bits_set(rsvd_check, spte, level);

