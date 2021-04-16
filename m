Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CE5361BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 11:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239288AbhDPIkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60009 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235226AbhDPIki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618562413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E/21KtrUJDrIPwXoawNEtFcajhDHUfFH4h+ED/BPh0I=;
        b=LoZq+lV/09ar6eica9yMXDuMH/+9B+zCQTn1sqsb4/jV03Rw+1wTcRl8KQX8eg5jOK5w4+
        m5Sw0rDm1lXvrwMP6UylGOPtNbMIRWWzACdE5D4XKKe4OA84LlGgBqG/kYcndsSI7onnFk
        RATNhrrysMUtQ6yN7IRHYclHAWMZCwQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-Iaa9UdIcM1WwpRfpeuJIcg-1; Fri, 16 Apr 2021 04:40:11 -0400
X-MC-Unique: Iaa9UdIcM1WwpRfpeuJIcg-1
Received: by mail-ed1-f71.google.com with SMTP id i25-20020a50fc190000b0290384fe0dab00so1055519edr.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 01:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E/21KtrUJDrIPwXoawNEtFcajhDHUfFH4h+ED/BPh0I=;
        b=PjhEgi2ueyE5TTyESUtDS7qM5oFkVqe2DSN2hdQ1uZ3Sw5diCwM0IUhGObv6CDHF2Y
         zctWqlTwHojEsAzB9DFS9omgbKkXO2LvymMXxBYz6R7kIuu7zzHwxGrFHwciCrHeB0dV
         GUF8Wzh2vuV5KEiVXiUGfjW0lULT6zGoaUa9SvbT7po8LP4Po/GpRlvGn2sJCZbF0DFX
         g8BJTf/SUvunRsWjulV/sijW3NVM6wFPTGXoA1sf792+DtIkAE6QuWcJJNY2q+siwap9
         U6BLCamIcRsoGEbseuobVpQbfE2gCq9jVvtVxH5+fPayZ9Ba6vCPzqOcizjTZI90hw8L
         ZDZA==
X-Gm-Message-State: AOAM531o/63q7FlgctwUUI2OozLr11FiiMW3NklwYcO24bQQDZFo2lIJ
        G2MHyOsILdiKTqE6YOmVKmaHy0jZO9ZfQjav9sXbMZ9MfTjzEq+7TdsQmO8tjNzKoI2n5dhFphF
        5KXWg3rZaJ2iT6AcWI6V/IUbi
X-Received: by 2002:a17:906:2596:: with SMTP id m22mr7477045ejb.175.1618562410233;
        Fri, 16 Apr 2021 01:40:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzNJnhs14GfiKHmwxiwSXkMkIYSx3t9HmyGiPAFsuoDS423ZgZVJAbSWmQrlHtBpNbXS2xKA==
X-Received: by 2002:a17:906:2596:: with SMTP id m22mr7477008ejb.175.1618562410070;
        Fri, 16 Apr 2021 01:40:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id b14sm4764203edx.39.2021.04.16.01.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:40:09 -0700 (PDT)
Subject: Re: [PATCH v2 3/7] KVM: x86: hyper-v: Move the remote TLB flush logic
 out of vmx
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
References: <cover.1618492553.git.viremana@linux.microsoft.com>
 <92207433d0784e123347caaa955c04fbec51eaa7.1618492553.git.viremana@linux.microsoft.com>
 <87y2di7hiz.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8a83b571-5c19-603e-193f-666b99a96461@redhat.com>
Date:   Fri, 16 Apr 2021 10:40:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <87y2di7hiz.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/21 10:36, Vitaly Kuznetsov wrote:
> - Create a dedicated set of files, e.g. 'kvmonhyperv.[ch]' (I also
> thought about 'hyperv_host.[ch]' but then I realized it's equally
> misleading as one can read this as 'KVM is acting as Hyper-V host').
> 
> Personally, I'd vote for the later. Besides eliminating confusion, the
> benefit of having dedicated files is that we can avoid compiling them
> completely when !IS_ENABLED(CONFIG_HYPERV) (#ifdefs in C are ugly).

Indeed.  For the file, kvm-on-hv.[ch] can do.

Paolo

