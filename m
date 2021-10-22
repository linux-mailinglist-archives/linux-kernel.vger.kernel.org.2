Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E39A43728F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 09:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhJVHQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 03:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230332AbhJVHQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 03:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634886860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cza0h9oBTg6po/zAY8pKYRgVqaiZyyoRw+riljno5Nw=;
        b=RV0q8prrvrH0zKutXlhyBGnSWutPfZmQy2h9rPraE1Mx/q/AKHEcqF80ev85pmE7qXyUCD
        RnDIn5camHRqgVTI+RQA1zOI3S/RnYQ8KuvrVC4jgAC1S69Udqb2m6x7leKYcPMnNsW4vl
        UWazlQp1jv+P8xhytninYz96XSRWtRc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-7Q-sPoc2O2i8003mnzTcgA-1; Fri, 22 Oct 2021 03:14:18 -0400
X-MC-Unique: 7Q-sPoc2O2i8003mnzTcgA-1
Received: by mail-ed1-f72.google.com with SMTP id t28-20020a508d5c000000b003dad7fc5caeso2786955edt.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 00:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cza0h9oBTg6po/zAY8pKYRgVqaiZyyoRw+riljno5Nw=;
        b=4CrbGDWGixPNEAdjnTMY55X/hMG1oDL28WhKMhP2wEpUv0r6HsqGFU0jFk5BWicKFI
         bLoW01NowF0Ro5hHG6VE/hc3wKT/NgsgJT44IztjT/S68r20Gqv3K06BjMr67JneQWmO
         nCF+A5CDJn6pg2Q3hK3wuKAL9mgpB9qX6hU0PQjcazJllPkqn/2susJI9VqrSn5jGVrL
         WBYgG72B2jixrjdHVafOJk4HrFDVKfCn0IoPH08xaVXcsAf/7rcVKlQ5szJCwu3SqSFr
         MU/ipTwZ+hR9b6yBRY2nm/r29ytOS/X/OV0wYVhG1mtUFmWAQu8SjK7fTROiY+rEFVDO
         kDAw==
X-Gm-Message-State: AOAM530fN3/V573ZcAw4jRgpPjY7Ub1TNQBLDAK574jKCLzTz5QLoscm
        k01X0IQOmFM5SqpPvEN61dlLubCSZ2cqOqWpbiZPoJ+1GHsqAaN9FkRXQWKTJRC40krBXa9+AaH
        PoEvjy5qRD5QmdVfW2ZCSrgUW
X-Received: by 2002:a05:6402:4309:: with SMTP id m9mr15085424edc.272.1634886857514;
        Fri, 22 Oct 2021 00:14:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziS1VmXe4Oyn5sD/JRqqBCmT5lfUoAQyDpJpl8mvevLLoT/oQS/Xmpls8mjaFdQkbQ87FWWg==
X-Received: by 2002:a05:6402:4309:: with SMTP id m9mr15085402edc.272.1634886857348;
        Fri, 22 Oct 2021 00:14:17 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id i6sm3374758ejd.57.2021.10.22.00.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 00:14:16 -0700 (PDT)
Message-ID: <48953634-5b7c-72d6-5fcb-a1b25800f443@redhat.com>
Date:   Fri, 22 Oct 2021 09:14:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 4/8] nSVM: use vmcb_save_area_cached in
 nested_vmcb_valid_sregs()
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
References: <20211011143702.1786568-1-eesposit@redhat.com>
 <20211011143702.1786568-5-eesposit@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211011143702.1786568-5-eesposit@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/21 16:36, Emanuele Giuseppe Esposito wrote:
> +
> +out_free_save:
> +	memset(&svm->nested.save, 0, sizeof(struct vmcb_save_area_cached));
> +

This memset is not strictly necessary, is it?  (Same for out_free_ctl 
later on).

Paolo

