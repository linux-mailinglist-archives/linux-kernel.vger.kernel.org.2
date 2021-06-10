Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DEB3A2AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 13:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhFJLta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 07:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230117AbhFJLt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623325652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dDd4rQY3d5j3xrJnO3ArKwas+QUnm/Z8mhbVgv+WoZU=;
        b=NBeGdWN7MfPohlofYMtPzuCEVrOuy0mIGk5QAk6XfROpu8+vM3e3AMXRK6e6mRUKlrsQ+s
        1Fu1gEefBW0EP2DqIzYWk1FkPmleCNl3yQM/57EV6i2k0/TBie2GHcb1luZTmDc+2I19T5
        JG6/mq5AUgwbRGH3IqwFz5p2U4BjbfQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-BbzY0RFvOUeNSEsgqPE--g-1; Thu, 10 Jun 2021 07:47:31 -0400
X-MC-Unique: BbzY0RFvOUeNSEsgqPE--g-1
Received: by mail-wm1-f69.google.com with SMTP id m33-20020a05600c3b21b02901a44b1d2d87so2926624wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 04:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dDd4rQY3d5j3xrJnO3ArKwas+QUnm/Z8mhbVgv+WoZU=;
        b=sO2IisHJZRh9vsHKZ50vt8Nf8vgzCMsFa8X9JrKopO+9hXSEx3QYkahyn4D0lanzI/
         f+w1S0RWQfg98WqivRLt4gvJK4crwGJAqodK+jVG6tQY4se7AI3k0qYM+zb25x4fHSHD
         jaDictr2REN6uIn5H1WVfZ0osX/CycVy0g7+UrTiVNEmOCCIiIE4TXd2sfZsq/6TB08l
         RxSRPHwRCRHGDfEY7gFfDiXIKV6sib3Eog4hStmbZER1h2UOOVOe/35DnjmWhsAuyGcb
         P1UAA1bmU58AE5Kj3uliN188ifb1wUCLoRt/GD6Vlm81EbzUfZXmC7OnOPYxr/Iy58T0
         6/5g==
X-Gm-Message-State: AOAM532V49G6n8GdS2yEmBilmp/twcOd3Kb1r0VEikUnO4l6n6GQCSgQ
        RzbsV1GAFVKu8H8pPcWUnb6dboNt8FZPLiNqCGQ9/39+BejrEDUxkt6e+LcULTYrR8qUIAqsuDf
        9DKD8TyUuledvdX1+5zvDQ+Ds
X-Received: by 2002:a1c:f717:: with SMTP id v23mr14357529wmh.32.1623325649916;
        Thu, 10 Jun 2021 04:47:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+sXKFIOHP2+a1GEIENYS8UPE6tzU8sUF3npm3kE8jEzS6PG0kNk/546ByPA1ZFfb4my7v6A==
X-Received: by 2002:a1c:f717:: with SMTP id v23mr14357515wmh.32.1623325649758;
        Thu, 10 Jun 2021 04:47:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id o18sm8865082wmq.23.2021.06.10.04.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 04:47:29 -0700 (PDT)
Subject: Re: [PATCH -next] KVM: SVM: fix doc warnings
To:     ChenXiaoSong <chenxiaosong2@huawei.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
References: <20210609122217.2967131-1-chenxiaosong2@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7541d362-253a-5a56-1716-1ca9ef33cbae@redhat.com>
Date:   Thu, 10 Jun 2021 13:47:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609122217.2967131-1-chenxiaosong2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/21 14:22, ChenXiaoSong wrote:
> Fix gcc W=1 warnings:

These are not gcc W=1 warnings, they are kernel-doc warnings.  Anyway, 
patch queued---thanks!

Paolo

> arch/x86/kvm/svm/avic.c:233: warning: Function parameter or member 'activate' not described in 'avic_update_access_page'
> arch/x86/kvm/svm/avic.c:233: warning: Function parameter or member 'kvm' not described in 'avic_update_access_page'
> arch/x86/kvm/svm/avic.c:781: warning: Function parameter or member 'e' not described in 'get_pi_vcpu_info'
> arch/x86/kvm/svm/avic.c:781: warning: Function parameter or member 'kvm' not described in 'get_pi_vcpu_info'
> arch/x86/kvm/svm/avic.c:781: warning: Function parameter or member 'svm' not described in 'get_pi_vcpu_info'
> arch/x86/kvm/svm/avic.c:781: warning: Function parameter or member 'vcpu_info' not described in 'get_pi_vcpu_info'
> arch/x86/kvm/svm/avic.c:1009: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> Signed-off-by: ChenXiaoSong<chenxiaosong2@huawei.com>
> ---
>   arch/x86/kvm/svm/avic.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

