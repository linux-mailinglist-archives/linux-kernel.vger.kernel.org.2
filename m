Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177DD41317A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhIUK3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231713AbhIUK3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632220084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IP/Ry7TfXJSJbGlXKKX4dVEELbv/TH/7UBpdWIwImZ4=;
        b=Sbsnu0NQ3ds4MGZy/kjtpNL6kHXa+SfWdbSADacI3g1pvohN3KkGObNWIV6g5N4ruC6Yuh
        rUF3llK80LFmxYNOPVamCRMNaTBRTCyA7wb+L7N/9YWVIy6F8SIe48ht4M3iWiZcvYGr5l
        loKsDMFnHMtKOygzZGcADBAGpVhqs9Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-rjZOuUoJPkqdg-xvALLYvg-1; Tue, 21 Sep 2021 06:28:03 -0400
X-MC-Unique: rjZOuUoJPkqdg-xvALLYvg-1
Received: by mail-ed1-f70.google.com with SMTP id r23-20020a50d697000000b003d824845066so10158380edi.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IP/Ry7TfXJSJbGlXKKX4dVEELbv/TH/7UBpdWIwImZ4=;
        b=b/cHK+gKPSyFfS5OViD7JSBeOwy1DrCQn2KE2bjpaLXeqEF5Qdy0qbQbXZVSUEdGZO
         4qo2mr4V/4X6ObHL7d7uaiDyV3NZkQZzuTF1ZjSnE7FHz2z5/tiue0ZbrbqMChvcA+IA
         /ebTZhgSWEbI0rs4knoscnKtYmamxD8a4Co0c2VkmU3fcs7yyUpGpum6J63CsAQlBI+g
         OIFmq+Cf/d2VrJ3zzClnMTe5NiFTjVEJdNuqmOMNgV7x+rZCUT5FkiIzwz+u1RYSYb7R
         /XM4X2jpUYo/O07NscN50Leo42jEwDsM0QaJhQ9OG2aDIExBg9uky6IpUvnLV4fOspFo
         rg/Q==
X-Gm-Message-State: AOAM532SoNVQ1K3uwRU5v9cO8d1uvKkqQGNEGAQkoLFHd6QtN6JIow2U
        m03MLTnU6+n7ZRPBFUuRBkx52onFBd5ifoQgzB0NgLRrZu8X3dsvLWtlJECs2M1UnWP77jz9Cth
        E5GUHH8bRH/D7XnwwwEVwtJBs
X-Received: by 2002:a17:907:6297:: with SMTP id nd23mr35080857ejc.62.1632220082161;
        Tue, 21 Sep 2021 03:28:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuFdS6sov9Hv8z2jx8fmfjChNJQUUjz1uvyE2T/Z4LMO6ndC/MCpzRZPVBseaf2sJ84TpraA==
X-Received: by 2002:a17:907:6297:: with SMTP id nd23mr35080837ejc.62.1632220082004;
        Tue, 21 Sep 2021 03:28:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c21sm7168400ejz.69.2021.09.21.03.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 03:28:01 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] KVM: allow mapping non-refcounted pages
To:     David Stevens <stevensd@chromium.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        open list <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
References: <20210825025009.2081060-1-stevensd@google.com>
 <CAD=HUj6_CFE0ZjexVMQMansmVcFRm3-udG=_12ROKfWDroNt-g@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7c9cf3aa-7edc-4f02-b7cd-4c3d4950beae@redhat.com>
Date:   Tue, 21 Sep 2021 12:27:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAD=HUj6_CFE0ZjexVMQMansmVcFRm3-udG=_12ROKfWDroNt-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/21 08:27, David Stevens wrote:
> Is there any feedback on these patches? CVE-2021-22543 was fixed by
> disallowing mapping of non-refcounted memory. These patches add proper
> support for mapping that type of memory.

Sorry, I was busy the past few weeks and I'm now back to KVM work.

Paolo

