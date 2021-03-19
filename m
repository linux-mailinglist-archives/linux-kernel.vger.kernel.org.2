Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C987F341735
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbhCSIR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234240AbhCSIRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616141825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GPmISnyfdyOHYuw/DXCIruI/XlrV8vtOEMpbuKM3mnk=;
        b=ilXJ81eslHb/SiQIDua2vabDE9ha2gB6iPbKxBrnNJ1pXx0amn0t/aKOBEcYgt2GTOBxwr
        QTNkXSlmZDQxwobd0LMmbfxAvCcAAS5bM5p5dCW9mbZWzKF088sY3/T8NY7NKclRnwlDqr
        pO3idR4dArC5rbx4lHMzfqeRsaFLmQ4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-IUBakxxxN-2fJJyVVPFQCw-1; Fri, 19 Mar 2021 04:17:02 -0400
X-MC-Unique: IUBakxxxN-2fJJyVVPFQCw-1
Received: by mail-ed1-f72.google.com with SMTP id m8so16797085edv.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GPmISnyfdyOHYuw/DXCIruI/XlrV8vtOEMpbuKM3mnk=;
        b=aHBofg2orUTW0RNmOSWHyM0wS8wJkeKTgci67ss+YLYFJiojSlCm53G8VmUTmw9PUh
         smrw4yWg/l9iBK6PwsnqnGZRaUkcpgZLhjVf89RdLn530ui5ItW1WvXOJvhYVvQC4nMg
         EL3MHMVSkG+/nJuWtoc3OruwKISvpgvxGAtVu+mTbtIsAOIcOoMnBmJmPEeqQ/HyBDok
         1U1PspSyfRRk5moyul/Zgnup1yGc6rWNksAGfumFwBIpsonNVyGORIrMmAKj9IUgYT3q
         HfsXF0m+S56ZLiRgaIwkufaE1TsmozwIyoHzOo+xZkZPPeaKN8eZW1NfN5FjCuuq+Jo6
         ahtw==
X-Gm-Message-State: AOAM530xE+mzr70sHMCdZ0qhUgUvAeyVcjFKTe8W/gVdqdEdxghLJKI+
        NGEjUXfuEf+JHYDsJq9225S4AmDODNLVJFL3X2nEfXnRNc/6qHTUxcLfI4kRPkiiC8G1kt50hsY
        HOPsulRnLjdSWotS6e3NH679eG9fvR/i5tAL+W9agMbonGRupkyIC1/+nTSn5YoX7Zj5/fFKA9j
        uJ
X-Received: by 2002:a17:907:2661:: with SMTP id ci1mr2901604ejc.403.1616141821357;
        Fri, 19 Mar 2021 01:17:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy+umNIHUPhcVpo/tua+gabccjV+G857drOdgkFOgKy+Gzwdh2jGJrp54AkTYYu2Pd5+rwTQ==
X-Received: by 2002:a17:907:2661:: with SMTP id ci1mr2901589ejc.403.1616141821192;
        Fri, 19 Mar 2021 01:17:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q26sm3273413eja.45.2021.03.19.01.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 01:17:00 -0700 (PDT)
Subject: Re: [PATCH] selftests/kvm: add get_msr_index_features
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Andrew Jones <drjones@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210318145629.486450-1-eesposit@redhat.com>
 <20210318170316.6vah7x2ws4bimmdf@kamzik.brq.redhat.com>
 <52d09cdf-3819-0cd8-5812-387febaa1ab3@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d556faf6-fcf4-ec64-546e-ab80b107751e@redhat.com>
Date:   Fri, 19 Mar 2021 09:16:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <52d09cdf-3819-0cd8-5812-387febaa1ab3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/21 09:07, Emanuele Giuseppe Esposito wrote:
>>
>> I'm not sure why the original kvm selftests authors decided to do this
>> internal stuff, but we should either kill that or avoid doing stuff like
>> this.
> 
> I need this include because of the KVM_DEV_PATH macro, to get the kvm_fd.
> No other reason for including it in this test.

I'll take care of moving that macro to the non-internal kvm_util.h 
header, thanks.

No need to do anything, I'll send the pull request later today.

Paolo

