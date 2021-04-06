Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785C8354C83
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 08:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhDFGFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 02:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232411AbhDFGFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 02:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617689145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=438n2iekob+JtljwuNE0nR9jiXz0o9aFbj9Xm8ulZ9s=;
        b=KlbiybKBn7geiT23UizOLStwT2mL0AZmDTGlU1Rx2kOUhvqp7XQ75GdEyXd7NOQZpCW/vZ
        yZDL9HOXxCLPRPA8VrQN61ozE4caGjcrom8JkYzkqdKa/EGz9QwjITPc46g4NKYJ7PsVhX
        rQuZNfMm1b6lAYLhtoK3oISW2wNvU+E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-DQBaI7TzOfmC9iAELqyVaQ-1; Tue, 06 Apr 2021 02:05:42 -0400
X-MC-Unique: DQBaI7TzOfmC9iAELqyVaQ-1
Received: by mail-ej1-f72.google.com with SMTP id o11so1315183ejx.23
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 23:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=438n2iekob+JtljwuNE0nR9jiXz0o9aFbj9Xm8ulZ9s=;
        b=s0jESCSp0gIZLnUkJZgcHYTrNw+RtYZmTGjQu2+L5iD2fG1LSnDM6inWxklToGHM/M
         H8uKpeerI+HAYxaUH+cyeSQxo/OhegFwDeLPqso1KKAS/182zAOCU0ujcYKHQOblR/KE
         dJ3hV2qUGCKylGNU1xfeyNHNsGbXEc69yOTmJOo5Z8nFL8h2hkCkoYAmieOy6XVcVYue
         yKyvojZ7fDT1T29Y4iBaPMSpcGyBr6XwnqIpz5srRvrBIJZ24sXG670w6w4Q0i+VT9GE
         /ML8Qds0z36rwKzgRnSTZU9KlN598vF/mwzJ1fLRum7yiMYvX/3gjZDXsZhgh6BhmnKB
         Lj3A==
X-Gm-Message-State: AOAM533CQlGV5FKRlCWQP+Svi56qzP3sNP0YbQMhG9djBPHPFjyMGkUS
        Bt6JgRJD7O3NxRfYHuW6APF+yqTExP4dXEHTajFa4/vD4+76MguRWtq3o+4nGa+nEvtGe1oD3Zc
        ki7SSG5sEiHdgyRgn8Umwb4kb
X-Received: by 2002:aa7:dd05:: with SMTP id i5mr35528033edv.300.1617689141725;
        Mon, 05 Apr 2021 23:05:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeSXQqMyBxAbWNuqiAxTvmAGWEq1pKGvAj5/3y0/o4g7G74ZQxI9YjrUKSrMh/jG+PrH5fxw==
X-Received: by 2002:aa7:dd05:: with SMTP id i5mr35528012edv.300.1617689141565;
        Mon, 05 Apr 2021 23:05:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x9sm13118850edv.22.2021.04.05.23.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 23:05:41 -0700 (PDT)
Subject: Re: [PATCH 2/4] KVM: MIPS: rework flush_shadow_* callbacks into one
 that prepares the flush
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        seanjc@google.com, "open list:MIPS" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <20210402155807.49976-1-pbonzini@redhat.com>
 <20210402155807.49976-3-pbonzini@redhat.com>
 <CAAhV-H4wskLvGD1hhuS2ZDOBNenCcTd_K8GkYn1GOzwnEvTDXQ@mail.gmail.com>
 <aab8a915-6e73-3cba-5392-8f940479a011@redhat.com>
 <CAAhV-H72z9DbbV=_fEhCeeOaP8fQ_qtr4rQMD=f5n08ekG=Ygw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <510e59e7-91b0-6754-8fb5-6a936ef47b3c@redhat.com>
Date:   Tue, 6 Apr 2021 08:05:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H72z9DbbV=_fEhCeeOaP8fQ_qtr4rQMD=f5n08ekG=Ygw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/21 03:36, Huacai Chen wrote:
>> I tried the merge and it will be enough for Linus to remove
>> arch/mips/kvm/trap_emul.c.  So I will leave it as is, but next time I'd
>> prefer KVM MIPS changes to go through either my tree or a common topic
>> branch.
> Emmm, the TE removal series is done by Thomas, not me.:)

Sure, sorry if the sentence sounded like it was directed to you.  No 
matter who wrote the code, synchronization between trees is only the 
maintainers' task. :)

Paolo

