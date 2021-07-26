Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5643D6854
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 23:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhGZUTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 16:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232597AbhGZUTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 16:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627333212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n/2NV58+R3TTXhlXYbDsz/es4LHmfDCv8omJdsxV3Uw=;
        b=G5qtq6/TKFfvF8q3ttJzdHGWU8uFnM3U4vso8wNgdrr5WNYqRgPXjQHom5NtBAtJ//Sq87
        JxrUtLqeuGMTN/FlZlYjDnwg+oloqCoi/OhHl30xufSEWGC6N764zMrtn6uMP4RN+DL3Jx
        wkUqIGPVZugerR10vLsDmZZLlpI6GTM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-HI2uE1jPPdyssdUeRN7t7w-1; Mon, 26 Jul 2021 17:00:11 -0400
X-MC-Unique: HI2uE1jPPdyssdUeRN7t7w-1
Received: by mail-ed1-f72.google.com with SMTP id n24-20020aa7c7980000b02903bb4e1d45aaso3652952eds.15
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 14:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n/2NV58+R3TTXhlXYbDsz/es4LHmfDCv8omJdsxV3Uw=;
        b=T75q+EsqPpfcx8RmXE1C9KZZ6SaZlm1DXt00Frn0PZdYrpEFE0qUEbsdHgZRwueItX
         rCxcQa3p/hBwJv9Am0zjtwnG9OjzefUM1LwF7k85+xuFLVHjKtIwQ/hca3v4x4Gn51ZQ
         0MAk4sfMnYnFajJOyKaContJy9kJQ1QtVZl/Nv2+JDlVi4Z68gPkT8M9tgZa4j2McCBY
         Q36Ol/RJr9mzgFUFJ9mgwhvOMAauPzetvkxETJHKqjFh/tnGuQvKNUugTs7GJcoPhGrI
         hcVW+kGXVo11Or9zDCxlkuo9E2J5GZZlnBep9nq+8iN9CugpKxwTrJJx2ThlkxkWmcWY
         1lgw==
X-Gm-Message-State: AOAM531/RbhhEOPHAyzimchPr83S6OHZkW+aJhxa2E7kpxHH1Tujt8Bp
        9S75P6Pl/iAGMqOagb4nyvs8wSGp3TzWoRC4JNOdj3jp8Y2M8AbY73MYVX7fbDvGgWJk344p5u6
        EZyZ4z2PV2OD1f/YYsznCVxmt
X-Received: by 2002:aa7:ccc1:: with SMTP id y1mr23484128edt.321.1627333209990;
        Mon, 26 Jul 2021 14:00:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztDsC08Z/aUiP1V66rA7QrjiGQa4Xn5UaHN+Ib73DVd8YXdXu3VfivStRUUmdTsaAqeK5HiA==
X-Received: by 2002:aa7:ccc1:: with SMTP id y1mr23484084edt.321.1627333209765;
        Mon, 26 Jul 2021 14:00:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id n14sm377090edo.23.2021.07.26.14.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 14:00:09 -0700 (PDT)
Subject: Re: [PATCH v2 41/46] KVM: VMX: Smush x2APIC MSR bitmap adjustments
 into single function
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
References: <20210713163324.627647-1-seanjc@google.com>
 <20210713163324.627647-42-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7ddb5bfb-f274-9867-3efb-0b6ba5224aa2@redhat.com>
Date:   Mon, 26 Jul 2021 23:00:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713163324.627647-42-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/21 18:33, Sean Christopherson wrote:
> +	if (!(mode ^ vmx->x2apic_msr_bitmap_mode))
> +		return;

Just !=, I guess?

Paolo

> +	vmx->x2apic_msr_bitmap_mode = mode;

