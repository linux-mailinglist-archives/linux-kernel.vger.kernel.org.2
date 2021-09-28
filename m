Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFB341B472
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241896AbhI1Qx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:53:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241871AbhI1Qx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632847907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0U/aUim/4LHhbhUv9UEUbwD6KDK/YSTUb8tP/0dO0Y=;
        b=aKJjB+ZemIaTE+lVG9Ekv3vuFZcQafL32p4kRc1sAA+JwK9S3gAwIclrYwbIjnVamyw96J
        kGs00AXRqk7uufBQng6sxO3bvGJq72sFFn3Eg5C0/HuXQPpLr/wzQssHcbKr845IjI5unO
        xXR8MZmuiUsSsNS11NPElx70dg8NZrs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-sjSQlYcjOue9yRmMsceQrg-1; Tue, 28 Sep 2021 12:51:46 -0400
X-MC-Unique: sjSQlYcjOue9yRmMsceQrg-1
Received: by mail-ed1-f69.google.com with SMTP id b7-20020a50e787000000b003d59cb1a923so22509901edn.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 09:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K0U/aUim/4LHhbhUv9UEUbwD6KDK/YSTUb8tP/0dO0Y=;
        b=JB70xdvDMKPvPNXj4wzBhnEisKl/hkp7mDxt6vnDsgwttsC0kgLKTLlpGGPPPHWZJa
         tkFurHbFFtrT+XLOE+F9DYLmlBMp4oEpg7ZbMioFyvJ1hY8o6h8VzRZVqeNJnyIxVxBg
         D4Qlm8MF8gSTLdfOr1dSxyF0ie+btb+c0qAiJak9hdwxa/iHVsIGrEeu1je/sAAgCSxb
         mwn19CTjbjZvrAL0JbQ1HeJtBBifupUEoq1TIoh0IrllI0byHN9w218PRbPOcQd0Cv3g
         DrJqcjoSQSDurKSpJRJVi2GWe10bZxfr3JYpvdvStGMJyd7C2GCtf0aymv5DbncldwMd
         O2Qw==
X-Gm-Message-State: AOAM532PU/2MXXFp5Lr1zW4Dt856MLxqn3bpdQLTT/1e1pLY7WHaq/yG
        9ef1c+0sxYG5SFqPi5EYoROUKlYeDfJNnjAdRlBFD6rj7XPcxObn6EuSIwe03iExqQ/S/oRAFUp
        juwHoxgmMEkG163+J8nN2KqI8
X-Received: by 2002:a17:906:bfe7:: with SMTP id vr7mr7845981ejb.32.1632847904920;
        Tue, 28 Sep 2021 09:51:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrgO30G5UqckzSQL/S2GTFgTozWvqhmKmQoBR4II1OCTVmjMnRsHAH/sjMzvRkHvA+3JbhaQ==
X-Received: by 2002:a17:906:bfe7:: with SMTP id vr7mr7845959ejb.32.1632847904757;
        Tue, 28 Sep 2021 09:51:44 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u18sm5378579ejc.26.2021.09.28.09.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 09:51:43 -0700 (PDT)
Message-ID: <46b08118-b5a2-ee9b-f0fa-49f830465243@redhat.com>
Date:   Tue, 28 Sep 2021 18:51:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 2/4] nSVM: introduce smv->nested.save to cache save
 area fields
Content-Language: en-US
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
References: <20210917120329.2013766-1-eesposit@redhat.com>
 <20210917120329.2013766-3-eesposit@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20210917120329.2013766-3-eesposit@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/21 14:03, Emanuele Giuseppe Esposito wrote:
> +static void copy_vmcb_save_area(struct vmcb_save_area_cached *dst,
> +				struct vmcb_save_area *from)
> +{
> +	/*
> +	 * Copy only necessary fields, as we need them

"Copy only fields that are validated" etc.

Paolo

> +	 * to avoid TOC/TOU races.
> +	 */

