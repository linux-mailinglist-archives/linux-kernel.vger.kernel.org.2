Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7F235887F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhDHPb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:31:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231940AbhDHPax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617895840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f7y+qV1QX6itWVJvsPTpvv4qB/DYjHt3u6N1WcKj9Bg=;
        b=Hwi1BbFkEH57idIeebcQ49yiIgQ/CCCMBV3ZMrvOO2ANg531mL3S6qpTgmNSfHqmu6OAeu
        B9J3QNS5M0Egd5ipeaa+iFFNWtgZ3F1OfjZDdWWib7gcM4i7xCTs6jGHhRgiK64PKjjkPe
        UZCRif6YQjlHCev0rOmnkKmrPacNEVw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-iti5jVB7PPW0XPPAN_V_HA-1; Thu, 08 Apr 2021 11:30:38 -0400
X-MC-Unique: iti5jVB7PPW0XPPAN_V_HA-1
Received: by mail-ed1-f71.google.com with SMTP id c6so1221138edf.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 08:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f7y+qV1QX6itWVJvsPTpvv4qB/DYjHt3u6N1WcKj9Bg=;
        b=E3rKGuzjBW5j8aswushsWmaeAYvoaINBmaVLMdKdY0uwimLzbKmECOddmpL7HxIobA
         Kh44ZFqtoCX70TltYMpASke597zVk0PWZCzrjSt6wZZy+ywLMNK5aFTnlW+O07Xf5Rij
         cLA96OyXaOByR/9E+7oGfb0zBUHnj3oiWJm5rbo4vS69JyYWIQ8SmHg4U/6uMN9cxmyi
         RICd+YMWOrgIbHmxCoeZFRfezru6xZ4s3Gml4PMajxGhJfSHoPfKJjVGdGaOf4rZQsOp
         eGsZmobTCciIX4JcYSMArw/qEyckr0nDWbU6V76vFJ1QBKeICcMpz1aOkcwSSQYa3L0E
         PeMg==
X-Gm-Message-State: AOAM533iAh8FuG6+OUCSw77ZiU1QJwEZHmv66GRfCKLOnUSkOQa+wDlp
        VtOYY0uS9EEp7gxIs8GKuZK/PZEBlA2dAmZ8N7oIRTpw7nJoE0sC9vewzCjdBZ+cWuaclzMT3Mf
        BrOjZSDsrpRQHaL/3CwO+ezLN
X-Received: by 2002:a17:906:f2c4:: with SMTP id gz4mr11221036ejb.369.1617895835600;
        Thu, 08 Apr 2021 08:30:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0Y3dI6nxcGhLpQ0Wo61Aeoqztdw5kKwf3X3+bdymlXu5DaOTJRHYyc2lp0yIFxYtWUBsSww==
X-Received: by 2002:a17:906:f2c4:: with SMTP id gz4mr11220328ejb.369.1617895829796;
        Thu, 08 Apr 2021 08:30:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id h23sm6317924ejd.103.2021.04.08.08.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 08:30:28 -0700 (PDT)
Subject: Re: [PATCH 0/4] Add support for XMM fast hypercalls
To:     Wei Liu <wei.liu@kernel.org>,
        Siddharth Chandrasekaran <sidcha@amazon.de>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        graf@amazon.com, eyakovl@amazon.de, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20210407212926.3016-1-sidcha@amazon.de>
 <20210408152817.k4d4hjdqu7hsjllo@liuwe-devbox-debian-v2>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <033e7d77-d640-2c12-4918-da6b5b7f4e21@redhat.com>
Date:   Thu, 8 Apr 2021 17:30:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210408152817.k4d4hjdqu7hsjllo@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/21 17:28, Wei Liu wrote:
>> Although the Hyper-v TLFS mentions that a guest cannot use this feature
>> unless the hypervisor advertises support for it, some hypercalls which
>> we plan on upstreaming in future uses them anyway.
>
> No, please don't do this. Check the feature bit(s) before you issue
> hypercalls which rely on the extended interface.

Perhaps Siddharth should clarify this, but I read it as Hyper-V being 
buggy and using XMM arguments unconditionally.

Paolo

