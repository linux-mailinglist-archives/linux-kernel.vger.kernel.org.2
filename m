Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2376938FAD4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 08:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhEYGY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 02:24:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230458AbhEYGYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 02:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621923804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJI9B3UDrsS5ZG82dGOTDBKrm8/JabWsy+34uznhI0Y=;
        b=NK4XKEtIoB2nQX1dfF0CIKAzeZ+eyIbLX6Rqztqwlq2GmEzKfM+xCluCSoF9nGAeJlBF7I
        7sDBITSX9ydjgdKtvreFz6tLi8qXeRwNrSm4Qu8MOVCIByiuD9UANBMQFQXkNq1eNj79cs
        oe/VflAD+125acE63wx8G1tefobt/Lg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-Rg-rKwErP_yNjyjytoQ5ww-1; Tue, 25 May 2021 02:23:22 -0400
X-MC-Unique: Rg-rKwErP_yNjyjytoQ5ww-1
Received: by mail-wr1-f70.google.com with SMTP id t5-20020adfb7c50000b029010dd0bb24cfso14089129wre.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 23:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kJI9B3UDrsS5ZG82dGOTDBKrm8/JabWsy+34uznhI0Y=;
        b=DFVYPuMJDCVTRY6uonLAAZpv2a1ZdhBTqXtAa7aRO6sphXmdO5/6j8QGtFo6wNku11
         lmRACl7SOeReY4nFMi8pJq4O3/eLyXy2g89kMcBeEHVrsCwKi7U3MuW0MyvPDASRXjJm
         +mKeo/1vpOO/D+zI0LcoNRQtFgHOZigknvyj2+IeTb7Cd0zYeqvFLNP5h4fdSqMPFONW
         Q6JKTs9UgCU2pXMM0HSa+1JxhFIbqS7osZdKdXm3edQiMyh4N893OW0AxYGHmQW1CvGF
         FMlnt2mobXBJ6Ns+WfJSjLOXmcqiAEB7T0QFdM7/MxUXwiiqcCppO9QO+jQzsWm26MAP
         UAhQ==
X-Gm-Message-State: AOAM530vqxEzVYETXT3vQMMtOh6pabxDYf04JedNuI8U8xpBigYLQhZc
        igr6i9d2zC9DKyYx+EOyGaMXyHl8HQ7pEG3Rt2HrIHiPdlmyfTr/jGmAPPQqyobMKNd6u6SMnBj
        B4bRSKX3WCjpv8FQFn6b2tErmhjt9Z2rDMNZT/R1q80b+96qPa3iToE6qK3FVzo7zzjz231FVDK
        dP
X-Received: by 2002:adf:fd81:: with SMTP id d1mr25720259wrr.37.1621923801692;
        Mon, 24 May 2021 23:23:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5iZuU+Q62kXzDBukK4J7FbYpVjOGZNWnlJDEeNvhevYharSYKA5CYOQitXD6QBTBf/I26hA==
X-Received: by 2002:adf:fd81:: with SMTP id d1mr25720236wrr.37.1621923801480;
        Mon, 24 May 2021 23:23:21 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 61sm15690877wrm.52.2021.05.24.23.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 23:23:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Kechen Lu <kechenl@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] KVM: x86: hyper-v: Deactivate APICv only when
 AutoEOI feature is in use
In-Reply-To: <82e2a6a0-337a-4b92-2271-493344a38960@redhat.com>
References: <20210518144339.1987982-1-vkuznets@redhat.com>
 <20210518144339.1987982-6-vkuznets@redhat.com>
 <82e2a6a0-337a-4b92-2271-493344a38960@redhat.com>
Date:   Tue, 25 May 2021 08:23:19 +0200
Message-ID: <87fsyb8h7s.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 18/05/21 16:43, Vitaly Kuznetsov wrote:
>> APICV_INHIBIT_REASON_HYPERV is currently unconditionally forced upon
>> SynIC activation as SynIC's AutoEOI is incompatible with APICv/AVIC. It is,
>> however, possible to track whether the feature was actually used by the
>> guest and only inhibit APICv/AVIC when needed.
>> 
>> TLFS suggests a dedicated 'HV_DEPRECATING_AEOI_RECOMMENDED' flag to let
>> Windows know that AutoEOI feature should be avoided. While it's up to
>> KVM userspace to set the flag, KVM can help a bit by exposing global
>> APICv/AVIC enablement: in case APICv/AVIC usage is impossible, AutoEOI
>> is still preferred.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> Should it also disable APICv unconditionally if 
> HV_DEPRECATING_AEOI_RECOMMENDED is not in the guest CPUID?  That should 
> avoid ping-pong between enabled and disabled APICv even in pathological 
> cases that we cannot think about.

When you run Hyper-V on KVM it doesn't use SynIC (let alone AutoEOI) but
we still inhibit APICv unconditionally. The patch as-is improves this
without any userspace changes required and I see it as a benefit. Going
forward, we will definitely add something like 'hv-synic-noaeoi' to QEMU
to make non-nesting setups benefit too but it'll take a while for this
option to propagate to real world configurations (sigh).

-- 
Vitaly

