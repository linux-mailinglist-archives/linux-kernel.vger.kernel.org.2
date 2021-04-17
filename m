Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5BB363017
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbhDQMxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 08:53:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47730 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236223AbhDQMxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 08:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618663973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xpi8u3rGuVt1oh/pHBvAbreNYDYIDAl7JDBjulEYZdI=;
        b=PsU6KeLEt8JTVqHKF4eHpK/MtXYBAG4OXxk33MsBs5onfJH7099O0KfKr1WBZKXm+ilicq
        piN5LfHtCHcqHFdfyyDB+XXV1cSzxTBmDKLXJ3ZA69Eoa2o2b8dLrWp+JU3wHA40VoGDmJ
        uSSLgmgkTKe0u64X8V4XL0K39tlGtwU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-hffYO90_NJmV_p4ylX_ZbQ-1; Sat, 17 Apr 2021 08:52:48 -0400
X-MC-Unique: hffYO90_NJmV_p4ylX_ZbQ-1
Received: by mail-ed1-f72.google.com with SMTP id y10-20020a50f1ca0000b0290382d654f75eso8596614edl.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 05:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xpi8u3rGuVt1oh/pHBvAbreNYDYIDAl7JDBjulEYZdI=;
        b=IQaS6qCU1RIlx7hyBTKtzCctpFCG2XRaVQjSJUkAlS17YI4k46O2sAbZElng6T982T
         RosQbT7qqjH/DAuMkOpoJ5eB+pWeKUPjiDh6KQDKuNtI9Oin+xEgfqSbqiSw0Fk1B+/V
         JPTYlB7LM4eWeAyKJ2iJFVkt7MyGAfmYrXWwnbVVdhSSHfqHx2lpEwkFqMeNz210lwsx
         XfrS/V6zI+ykEG2mGh7Oglznp2ua5Vf776L7bCiSRokFVwdqFcoYqAzTy3g7D+7EMeWB
         ffaKu3fHWzTxxYN/97Ttwbfn8nejeE+bIgDqUkqONgf/3iv2Uu7qh8OLw/Ue73RV8W4S
         IG+Q==
X-Gm-Message-State: AOAM530aasebFidIKRib19WtlybWAeE+2e3GUaIAOI24mFQy2Xll+AuB
        acn2Me87ePP+woPX1DMk7ocEvRuVnXYBliBRylH2sY8psi7yEVlAukt/GTRTGDyysHfCZAZft4f
        lSb+KB/N+IxvYsS8a0Pui37jdJI8dDklOQbHfxoiqbxVLKIy7pWxcsa28QDBWhJgC4eYcNtoHTH
        HG
X-Received: by 2002:a17:906:68da:: with SMTP id y26mr13241790ejr.442.1618663964909;
        Sat, 17 Apr 2021 05:52:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTpOMr7Ij1+3mQXgHXxMH+0QmMKVahk4yLdYEs4lQyEzw/0HUv+6EV0v6H4vJbDRkDD6BlJA==
X-Received: by 2002:a17:906:68da:: with SMTP id y26mr13241776ejr.442.1618663964695;
        Sat, 17 Apr 2021 05:52:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id l9sm6156786ejz.96.2021.04.17.05.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 05:52:44 -0700 (PDT)
Subject: Re: [PATCH] doc/virt/kvm: move KVM_X86_SET_MSR_FILTER in section 8
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210316170814.64286-1-eesposit@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e3286d6d-5b0b-9a40-072b-41f0209f2b21@redhat.com>
Date:   Sat, 17 Apr 2021 14:52:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210316170814.64286-1-eesposit@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/21 18:08, Emanuele Giuseppe Esposito wrote:
> KVM_X86_SET_MSR_FILTER is a capability, not an ioctl.
> Therefore move it from section 4.97 to the new 8.31 (other capabilities).

Here and in the subject I think KVM_X86_SET_MSR_FILTER should be 
replaced by KVM_CAP_PPC_MULTITCE.

Otherwise looks good, so I queued it.

Thanks,

Paolo

> To fill the gap, move KVM_X86_SET_MSR_FILTER (was 4.126) to
> 4.97, and shifted Xen-related ioctl (were 4.127 - 4.130) by
> one place (4.126 - 4.129).
> 
> Also fixed minor typo in KVM_GET_MSR_INDEX_LIST ioctl description
> (section 4.3).

