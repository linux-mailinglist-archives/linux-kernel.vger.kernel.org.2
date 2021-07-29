Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF643DA9DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhG2RR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:17:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229863AbhG2RRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627579038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uUAEdvE4SzIJpqzGhe66vfb/gL75mbbFYOZDgNw6wcc=;
        b=TG4ILWTFkSV5PuTh6vum7lQudA4muDx8e5Je+BVQS+hP/yktea8IX577682L4WGQ9/7Ugu
        OG2BJ4D322fvUm4cMzCja368eKyg5xFj/adOhxD2NHpwhyVe9oCwBVYEghC8ZqSNRXCTUd
        s+ows9O9wEXBXjLy2/443PTkdf0xVz0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-dO6fH-TIO3ytXZvwzgAIWg-1; Thu, 29 Jul 2021 13:17:17 -0400
X-MC-Unique: dO6fH-TIO3ytXZvwzgAIWg-1
Received: by mail-wr1-f72.google.com with SMTP id s22-20020adf97960000b02901535eae4100so2458730wrb.14
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uUAEdvE4SzIJpqzGhe66vfb/gL75mbbFYOZDgNw6wcc=;
        b=oIWQpgsHr8+rGLw9J5EiO14zsrYtatjMEIJeh2UspxgOm2J5WQ+qeAmD2ytxzJQeUm
         ASOsW5m0LXrydH8uapNZMkvc302NSyh3sHbdnpMCVnZ34/yKlSp9YAcnS2kgOoWQcON7
         U2xbNAh58MhdnprkTEHFNiK5rW8630oqSADBvgmEw0Q5dXo5ctclb6VN8cSyYmXPAhMa
         8dmhSq2XwDh3XY14df4V8KEs19vXEg2ReZ4pRodpLAi1kLv+ifJSQbXTl/KZwbZMlUW5
         abP90Ls3VGOZbuDtvBtGHdZ7nGgGs8Tb16KfKjFmsE6Ome/Je3nPqrwidSeK1+nd++lH
         MC7A==
X-Gm-Message-State: AOAM53025Crfwzd39WR4OBiCU58lQ5klu3u65txuUOFcGpLqt3rEB814
        kCwm6+gGfFpZz1FqKZFph6Tp/6Lu1hp0HUsm57nhB7DJn3te8exUJ4gzmNcDHTi94Zjvt16Otjz
        J/BeKe9XJH+RvdGumcflJA5dQ
X-Received: by 2002:a05:600c:4f90:: with SMTP id n16mr5900750wmq.71.1627579035917;
        Thu, 29 Jul 2021 10:17:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztK9lwXEjiositdfwsZfjfyd3/i0BC1cAByASyC8fn15BCQclVphSYK5712hZ+8vyco6tjxw==
X-Received: by 2002:a05:600c:4f90:: with SMTP id n16mr5900731wmq.71.1627579035752;
        Thu, 29 Jul 2021 10:17:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id h8sm9533062wmb.35.2021.07.29.10.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 10:17:15 -0700 (PDT)
Subject: Re: [RFC PATCH 00/10] KVM: x86/mmu: simplify argument to kvm page
 fault handler
To:     David Matlack <dmatlack@google.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
References: <cover.1618914692.git.isaku.yamahata@intel.com>
 <YK65V++S2Kt1OLTu@google.com>
 <936b00e2-1bcc-d5cc-5ae1-59f43ab5325f@redhat.com>
 <20210610220056.GA642297@private.email.ne.jp>
 <CALzav=d2m+HffSLu5e3gz0cYk=MZ2uc1a3K+vP8VRVvLRiwd9g@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <92ffcffb-74c1-1876-fe86-a47553a2aa5b@redhat.com>
Date:   Thu, 29 Jul 2021 19:17:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CALzav=d2m+HffSLu5e3gz0cYk=MZ2uc1a3K+vP8VRVvLRiwd9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/21 18:48, David Matlack wrote:
> On Thu, Jun 10, 2021 at 3:05 PM Isaku Yamahata <isaku.yamahata@gmail.com> wrote:
>>
>> Thanks for feedback. Let me respin it.
> 
> Hi Isaku,
> 
> I'm working on a series to plumb the memslot backing the faulting gfn
> through the page fault handling stack to avoid redundant lookups. This
> would be much cleaner to implement on top of your struct
> kvm_page_fault series than the existing code.
> 
> Are you still planning to send another version of this series? Or if
> you have decided to drop it or go in a different direction?

I can work on this and post updated patches next week.

Paolo

