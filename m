Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64807344FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhCVTM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:12:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231802AbhCVTMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616440323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UfnyDJKd+AIhgsgjhm7fjzOjPp4nvTJYPKMus8kh4Is=;
        b=bcI7cGLe1VaPHFnfFGAygbBQvRmRm6Uj120jXr/uSJ8N+Kpxhzps0Yzw5aKFELXgDsZ938
        C8cXWjlmhkJCKWgDQ1mNxFZFHe93xvtGmdxnOi+cpn/+4JU3tBnawt2OtlOeSenKtApKYU
        wcZs07JSh6pNQvvMuo12H/kve++jgy8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-INax7f_yOTykSbPZMFyLlA-1; Mon, 22 Mar 2021 15:12:01 -0400
X-MC-Unique: INax7f_yOTykSbPZMFyLlA-1
Received: by mail-wm1-f71.google.com with SMTP id r18so14213wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UfnyDJKd+AIhgsgjhm7fjzOjPp4nvTJYPKMus8kh4Is=;
        b=IIE+mzic2AAymwfwtdJ0aKUnQKLgqKZY5glxC/6dbUDmUoKxT+dnNPg5p5gOpJ1mIA
         sP7BS9tLB/RK4wfCGNjgqPF+5IlW/zgINuZ/TWrGvrqCumZ5TW/tgu+GRuHH0pEm/MeJ
         uaBTU9Miw53eIajU3Jzwe1CW456n61+YCUWB/AkJRP3kbl7Lau2+BS0GEUW83DawdGeU
         9M7eno9hKCW0a2LCSLI/pBOv2zg6hROZ1apY3VJ7wM+g1rzojMOkjPzeVlxYbtwqxVKR
         UpaDT5RPlhmEOsySI2tOUJYjVDfqorMB1zCa6qy55Ur9s/3VMTw6eJCGI+nNhvWXMbUU
         mfrw==
X-Gm-Message-State: AOAM531YX6vxTZyoUcSEEyNxQw4AzZFiAWGRsztbSE2sLnbeMBKZ3GZE
        gV+ERKOACdUwinpH7UH1UD9F3nNNVybrx37CJm6NA/XwTAPiDz6Fy1w9qXCHs7ZHkLx9g2DHpWr
        DjO4ah56/gq+vPIXlJ1ISZd7v
X-Received: by 2002:adf:d1cd:: with SMTP id b13mr71227wrd.47.1616440320267;
        Mon, 22 Mar 2021 12:12:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/cLnNqtKWv7V1/Fpeb5aRH7hZpgdnHA/Zo2qiXqHKF8asFjWbETSgysqD6vFP3G2Q+t5LNw==
X-Received: by 2002:adf:d1cd:: with SMTP id b13mr71209wrd.47.1616440320100;
        Mon, 22 Mar 2021 12:12:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x11sm347291wme.9.2021.03.22.12.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 12:11:59 -0700 (PDT)
Subject: Re: [PATCH v3 03/25] x86/sgx: Wipe out EREMOVE from
 sgx_free_epc_page()
To:     Sean Christopherson <seanjc@google.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Kai Huang <kai.huang@intel.com>, kvm@vger.kernel.org,
        x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko@kernel.org, luto@kernel.org,
        dave.hansen@intel.com, rick.p.edgecombe@intel.com,
        haitao.huang@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com
References: <cover.1616136307.git.kai.huang@intel.com>
 <062acb801926b2ade2f9fe1672afb7113453a741.1616136308.git.kai.huang@intel.com>
 <20210322181646.GG6481@zn.tnic> <YFjoZQwB7e3oQW8l@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a2e01d7b-255d-bf64-f258-f3b7f211fc2a@redhat.com>
Date:   Mon, 22 Mar 2021 20:11:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YFjoZQwB7e3oQW8l@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/21 19:56, Sean Christopherson wrote:
> EREMOVE can only fail if there's a kernel or hardware bug (or a VMM bug if
> running as a guest).  IME, nearly every kernel/KVM bug that I introduced that
> led to EREMOVE failure was also quite fatal to SGX, i.e. this is just the canary
> in the coal mine.

That was my recollection as well from previous threads but, to be fair 
to Boris, the commit message is a lot more scary (and, which is what 
triggers me, puts the blame on KVM).  It just says "KVM does not track 
how guest pages are used, which means that SGX virtualization use of 
EREMOVE might fail".

Paolo

