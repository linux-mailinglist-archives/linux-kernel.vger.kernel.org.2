Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E13B4322CB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhJRP0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:26:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229696AbhJRP0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634570670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bzbj7/WHYC4aB2F27o/m+i0nHnYIjq7dD2pHXdTaMVg=;
        b=eRmDzagghKnV7YLzaT7nZ39QOiwSs72AB/8i8WG+FTrDWZjWN8/WLHbM78XLIJi+6L3CoP
        //XdbbutAFb7aqSiX/KY1nO62gVhqfVyy5TJWeuNbQN4mHllHN8mRaQV3UAYDsQU6ZIcRp
        Zize30I/ArqT4trHTpmEi4APHQ907Aw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-wcN8MqDDOVm2mkKS8Qjz9g-1; Mon, 18 Oct 2021 11:24:29 -0400
X-MC-Unique: wcN8MqDDOVm2mkKS8Qjz9g-1
Received: by mail-wr1-f72.google.com with SMTP id y12-20020a056000168c00b00160da4de2c7so8973595wrd.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Bzbj7/WHYC4aB2F27o/m+i0nHnYIjq7dD2pHXdTaMVg=;
        b=1yYDzIYsWLICwbzMahN46hSEckORibkYGitXP/yEoqvg9l/bI5nnLN2aHOTgOER4R3
         onJG9Mhv/uPHtAHCAsv8W5wsUxBzXnNL9/pFke+xiWdZ4Yx3Xr50MMKw2ZO5mpsGFIXP
         vCqSLPJw0X3kz3G9yvUPfIbnw1bN4Qin9vYwHAhJQ7g5C/Azx0uhkb4l/Pzmhtt1mRZd
         7i29+4cvOF8YzvSFPrx64Ro/tu8ddBAt2KHRGar+sX3JhweITHJHa6nDxQ7/0hNx5lk4
         3fkU+6GbxctNI6qF/pDGUn8k6sqpEL2Ip80FEMxQATkhtVQkr1ovS81PX+8KbcI+LFbb
         Bdag==
X-Gm-Message-State: AOAM533Vhf9sSuKAdBkyqA2gyiSQ9gDvfXKguo35stKxcOI5R7P4rft4
        QeoBzH22fboHDLPHnjGV8gq3u/KabDNvwQfksxFA3WGHsRZAWrhCx6fw+/T3FTPkMjLvVy0jAiV
        /HAqwfM/xHgxm52JR30yalbWX
X-Received: by 2002:a1c:808e:: with SMTP id b136mr44520175wmd.178.1634570667843;
        Mon, 18 Oct 2021 08:24:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLex9V8Y/SK54b7T17izOSoWI76LpQ8IvrCdfTvZy/V3PEmQpxz2kOC0Cxvfq99dNSrkmsEg==
X-Received: by 2002:a1c:808e:: with SMTP id b136mr44520151wmd.178.1634570667666;
        Mon, 18 Oct 2021 08:24:27 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id d1sm14562212wrr.72.2021.10.18.08.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 08:24:26 -0700 (PDT)
Message-ID: <59ccbca6-72ed-7c9f-8569-233627a399d0@redhat.com>
Date:   Mon, 18 Oct 2021 17:24:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] mm: allow huge kvmalloc() calls if they're accounted to
 memcg
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Willy Tarreau <w@1wt.eu>,
        syzbot+e0de2333cbf95ea473e8@syzkaller.appspotmail.com
References: <20211016064302.165220-1-pbonzini@redhat.com>
 <CAHk-=wijGo_yd7GiTMcgR+gv0ESRykwnOn+XHCEvs3xW3x6dCg@mail.gmail.com>
 <510287f2-84ae-b1d2-13b5-22e847284588@redhat.com>
 <CAHk-=whZ+iCW5yMc3zuTpZrZzjb082xtVyzk3rV+S0SUNrtAAw@mail.gmail.com>
 <10e3d402-017e-1a0d-b6c7-112117067b03@redhat.com>
 <202110180817.A2C3AE34@keescook>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <202110180817.A2C3AE34@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/21 17:19, Kees Cook wrote:
> Ah, so memcg wasn't doing sanity checks?
> 
> Is there a cheap way to resolve the question "does this much memory
> exist"? The "__" versions end up lacking context for why they're "__"
> versions. I.e. do we want something more descriptive, like
> __huge_kvmalloc_node() or __unbounded_kvmalloc_node()?

No problem with that, I think "unbounded" is descriptive enough that we 
can remove the __ too.  So that would be kvmalloc_node_unbounded / 
kvmalloc_array_unbounded / kvcallc_unbounded?

Paolo

