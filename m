Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED15A3BBC8C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 14:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhGEMDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 08:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231248AbhGEMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 08:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625486438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Frdoj+ZjARxXF+aE+TMcxBtbn6BFh0i20yJs0cc9ZHs=;
        b=ZxdscZN6pgC21/KbzuDef+dFFGIlw9P4bTnV/lac1RoJDE4+w0P4gsWwBSokkwgj1WakO5
        V8YJ50TdBseHzuGUOtak7F8HvkuynuvbkZRaA9imh7YnFd2bN3xsdzndmRDVFzPR2iRUAQ
        mq78JG4zQrnHEXWvzFG5RvaFI7KyXOY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-m5ZdJuq6NCqmWFppmKX0gA-1; Mon, 05 Jul 2021 08:00:37 -0400
X-MC-Unique: m5ZdJuq6NCqmWFppmKX0gA-1
Received: by mail-wm1-f70.google.com with SMTP id 9-20020a05600c2289b02901f519cc69a8so2402561wmf.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 05:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Frdoj+ZjARxXF+aE+TMcxBtbn6BFh0i20yJs0cc9ZHs=;
        b=aQ5hR1Fr9wqCD+NLsi634YHyID107ijIMiWmeIGe5kqxDCUI91t4iLEP0E3Jsolo38
         eBiTEDBb0zYA/KkhoCK5b67bTDxOMLrzfneWlKgX5n/7mk/tQOKdLhVZaV6dS2BkjVj2
         JAHIV6S8uE2pz8WOdh5yHUl1NkMOlJ+pZKD9PWOJPA4YhbbsEPq8np1AiIbtt7BIftU+
         pziXeWNQiZxswXoRMhQBMHsABKe+KFIIn89G7s8CWZOSgMdnpmmNqeEqikkLV9g/u2MF
         KFaYMB8JKMU6khYC5pR+Ad+6OPm9SiQTrhP8vxG2BGgx7p+NuNkSa5iVnp1tkNoyX1Cy
         n26A==
X-Gm-Message-State: AOAM532BtCf8oI4wG1Om+1N21U9BaojH0yzPlMGFOWhF5bUJgXaPAtZG
        HovboPdZWhkIshPpfESkTguKYhLqLpWc39X/vxcdSNxO72HxrptvUPdEY9wkmfuaUq9XPultlbB
        wGaj2otd21/0ntgyXABSNA+Ln
X-Received: by 2002:a05:600c:4e93:: with SMTP id f19mr14896071wmq.169.1625486436170;
        Mon, 05 Jul 2021 05:00:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEbdFb4IP520IT9EZ6hU4VMV/VOhP8VpVq70iX7ljzXN/0x5gxBj3yUJ6ZAFAQE99nDLTeZw==
X-Received: by 2002:a05:600c:4e93:: with SMTP id f19mr14896047wmq.169.1625486435917;
        Mon, 05 Jul 2021 05:00:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id a9sm13202160wrn.8.2021.07.05.05.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 05:00:35 -0700 (PDT)
Subject: Re: [PATCH 5.10 049/101] KVM: selftests: Fix kvm_check_cap()
 assertion
To:     Fuad Tabba <tabba@google.com>, Pavel Machek <pavel@denx.de>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20210628142607.32218-1-sashal@kernel.org>
 <20210628142607.32218-50-sashal@kernel.org> <20210703152144.GB3004@amd>
 <CA+EHjTzO5Tsns4c6-7qXsyRtyGRwf4Yf_rBAPaVF303R1ih3EA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2dd3a5a3-8bcd-4139-a636-d6faf009d87a@redhat.com>
Date:   Mon, 5 Jul 2021 14:00:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CA+EHjTzO5Tsns4c6-7qXsyRtyGRwf4Yf_rBAPaVF303R1ih3EA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/21 09:10, Fuad Tabba wrote:
>>>
>>>        ret = ioctl(kvm_fd, KVM_CHECK_EXTENSION, cap);
>>> -     TEST_ASSERT(ret != -1, "KVM_CHECK_EXTENSION IOCTL failed,\n"
>>> +     TEST_ASSERT(ret >= 0, "KVM_CHECK_EXTENSION IOCTL failed,\n"
>>>                "  rc: %i errno: %i", ret, errno);
> There's at least one case that I am aware of that potentially would
> return a value other than -1 on error, which is a check for
> KVM_CAP_MSI_DEVID (-EINVAL, -22):
> 
> https://elixir.bootlin.com/linux/latest/source/arch/arm64/kvm/arm.c#L229

In userspace that becomes -1, errno == EINVAL.  I probably just misread 
the "ret != -1" as "ret == 0" when applying this patch; it doesn't hurt 
but it is certainly not needed for stable.

Paolo

