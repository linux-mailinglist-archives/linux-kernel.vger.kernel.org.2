Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE9D30E257
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhBCSSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:18:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34165 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232633AbhBCSOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612376004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7mEzELI6VGDqJgms7YlaIDMnBK1xZ38+y7d1UQDPDLI=;
        b=GWcuU5aneZjnhjZCC7lLzy3PYRQbu0EfJNBpg3CYQaqMhYrl0JszmdQyrEF1xjUsdF+UC2
        T2C5vvfxSKHyLo7Erza+pE0LoqLIRJe8gLVTQmaWJU769/+Gg7oFAweYUN0KE6gToiRFSi
        XM+aq5DUgb41K0Eft6qVHcMGWWLpuzg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-Wk4oBh5aN36cs1lXEHbQmw-1; Wed, 03 Feb 2021 13:13:23 -0500
X-MC-Unique: Wk4oBh5aN36cs1lXEHbQmw-1
Received: by mail-ed1-f69.google.com with SMTP id f4so367984eds.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 10:13:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7mEzELI6VGDqJgms7YlaIDMnBK1xZ38+y7d1UQDPDLI=;
        b=gFeohQB0a5Sd37UfTDhnvUZ2RiVAQ17EUycr9H18Ir2/zrwgPUJ/FM1pgYxAmosUBm
         AzSm4zwNpyLFXAB2TCl5iq1pJI3ATSg9VAaZuDkfLcLEqXnrv0XRyq2XHNSLMQ4Q0h1K
         aj34d/TdQLlvlM2UR8/iH7Vpf3+O9CkFzycgRRNg7mWKcZGU5F5ld1YAJ4EwMqGurW01
         mU3g0vNpcjvpEpUTf026MVAFRGoR5UxEiiyxCOyLyWjxdE+lXx/RDWDe4gKyY9VhkbEW
         eAr4hleZNlT6Mj7qEod+Uj30fJTSWMEtwnvK9+bkh/lqGGWYvzOZwuvvFS+ZacZUKtXt
         nnnA==
X-Gm-Message-State: AOAM533RTW/wely5ADYgP1QJ8ABmuKdOAVubJKmYtquuU+mjeAyzWS6C
        47zk/4Gjy0kv8wcO0tha+u9jZf6wkx0/eMz4lkByDcE/KLFw349X3Xzs5OeIpYolauALhzr/ZNA
        SMMkROcmmKXfW5E6/jjGK8IUV
X-Received: by 2002:a17:906:b09a:: with SMTP id x26mr4486900ejy.199.1612376002008;
        Wed, 03 Feb 2021 10:13:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvx08YVvWBOv1FsaocCimE+9T+b03KeQmGm/mgeHOyaUJ6lXeOEni35QjD6HAHSVfuEpPRqw==
X-Received: by 2002:a17:906:b09a:: with SMTP id x26mr4486749ejy.199.1612376000145;
        Wed, 03 Feb 2021 10:13:20 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p25sm824268eds.55.2021.02.03.10.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 10:13:19 -0800 (PST)
Subject: Re: [PATCH v2 00/28] Allow parallel MMU operations with TDP MMU
To:     Sean Christopherson <seanjc@google.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210202185734.1680553-1-bgardon@google.com>
 <298548e9-ead2-5770-7ae8-e501c9c17263@redhat.com>
 <YBrjZ775SImFPGWV@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6e1d6acb-b987-54c8-74e6-54abf2d1c623@redhat.com>
Date:   Wed, 3 Feb 2021 19:13:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YBrjZ775SImFPGWV@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/21 18:54, Sean Christopherson wrote:
> On Wed, Feb 03, 2021, Paolo Bonzini wrote:
>> Looks good!  I'll wait for a few days of reviews,
> 
> I guess I know what I'm doing this afternoon :-)
> 
>> but I'd like to queue this for 5.12 and I plan to make it the default in 5.13
>> or 5.12-rc (depending on when I can ask Red Hat QE to give it a shake).
> 
> Hmm, given that kvm/queue doesn't seem to get widespread testing, I think it
> should be enabled by default in rc1 for whatever kernel it targets.
> 
> Would it be too heinous to enable it by default in 5.12-rc1, knowing full well
> that there's a good possibility it would get reverted?

Absolutely not.  However, to clarify my plan:

- what is now kvm/queue and has been reviewed will graduate to kvm/next 
in a couple of days, and then to 5.12-rc1.  Ben's patches are already in 
kvm/queue, but there's no problem in waiting another week before moving 
them to kvm/next because it's not enabled by default.  (Right now even 
CET is in kvm/queue, but it will not move to kvm/next until bare metal 
support is in).

- if this will not have been tested by Red Hat QE by say 5.12-rc3, I 
would enable it in kvm/next instead, and at that point the target would 
become the 5.13 merge window (and release).

Paolo

