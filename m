Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0966A34657F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhCWQkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 12:40:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233126AbhCWQkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616517624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5BWe9jizGou9Z7iIZPltb/vzhcc5F+JZOIptQ1l0XQc=;
        b=JgHAVWZUDSDVH76OG6TLRhyh9rOLmNiN2YLQH0QxFylzMbmtxNtk5TCE/C1xMlqxEShnkO
        XesmBHbWTH8QvWsH86sDPLvAixkaLqBi0Gpq2Tplqpe6DEAFJTCIRbsf9Ihb4vHtyAaRYK
        2oKpFzoQeEsgWenzUCrK7cxWkq/n85M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-9eguR09DPXitp6ZzakBMdA-1; Tue, 23 Mar 2021 12:40:22 -0400
X-MC-Unique: 9eguR09DPXitp6ZzakBMdA-1
Received: by mail-wr1-f70.google.com with SMTP id t14so1351664wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5BWe9jizGou9Z7iIZPltb/vzhcc5F+JZOIptQ1l0XQc=;
        b=DzXjWN2qfwSBF/WWQf+fuOlDk5kBszfpxwF0RqOgynhYfxU3OcJy8LgELTz9p7OqhZ
         bONCgwtgrl3XUZgpsVwPLopeMWtz+/2BGJGrWHtScZVy910ngjpSqsNBfngPhdlA/mq7
         0gpTTSAyELrIv70FpfyjX2wB6B0FfsQHO8dKy+i4iNpeklqdVwSS8jGNA4KY9cctUdQ3
         CJ1D1NZMCTqSbjr379z4vSTX2c4wyCFbg439Erk9W+803YKubteSc26zu/uVWxffUUyI
         0I8GJFlY3l/1Lqz6FQyH9zSVffhvJ8a5yO17DGB9F90b4yd1cdCIGGFJMmMCJvAqEb3q
         SZAg==
X-Gm-Message-State: AOAM531xnA+2c8fRNVWGPmAJrld+xf+EE6oxeW6ZC66waFbAJXs0C3pg
        VRcdbT60AHONdlk4bCWlAwBt7O3uxC7UTa6kOEhOn2exXXQK25YT0AQEgWMB/GXfd7KQiV3zzNB
        n2CxD0B0z+rz+qqHC44S6+g0B
X-Received: by 2002:a05:600c:3514:: with SMTP id h20mr4212917wmq.45.1616517621100;
        Tue, 23 Mar 2021 09:40:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgV8GAIHS3AZ2N+inHsbLx96rBH1y6Aiui1UHTThEyadz05ZOLO7nAbQtNg5qeojn2V0JkcA==
X-Received: by 2002:a05:600c:3514:: with SMTP id h20mr4212895wmq.45.1616517620917;
        Tue, 23 Mar 2021 09:40:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k4sm30869920wrd.9.2021.03.23.09.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 09:40:20 -0700 (PDT)
To:     Kai Huang <kai.huang@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org,
        x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko@kernel.org, luto@kernel.org,
        dave.hansen@intel.com, rick.p.edgecombe@intel.com,
        haitao.huang@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com
References: <cover.1616136307.git.kai.huang@intel.com>
 <062acb801926b2ade2f9fe1672afb7113453a741.1616136308.git.kai.huang@intel.com>
 <20210322181646.GG6481@zn.tnic> <YFjoZQwB7e3oQW8l@google.com>
 <a2e01d7b-255d-bf64-f258-f3b7f211fc2a@redhat.com>
 <20210323094336.ab622e64594a79d54f55e3d7@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 03/25] x86/sgx: Wipe out EREMOVE from
 sgx_free_epc_page()
Message-ID: <0918025f-736e-de4a-832e-b4b6d903eba2@redhat.com>
Date:   Tue, 23 Mar 2021 17:40:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210323094336.ab622e64594a79d54f55e3d7@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/21 21:43, Kai Huang wrote:
>> That was my recollection as well from previous threads but, to be fair
>> to Boris, the commit message is a lot more scary (and, which is what
>> triggers me, puts the blame on KVM).  It just says "KVM does not track
>> how guest pages are used, which means that SGX virtualization use of
>> EREMOVE might fail".
>
> I don't see the commit msg being scary.  EREMOVE might fail but virtual EPC code
> can handle that.  This is the reason to break out EREMOVE from original
> sgx_free_epc_page(), so virtual EPC code can have its own logic of handling
> EREMOVE failure.

I should explain what I mean by scary.

What you wrote above, "EREMOVE might fail but virtual EPC code can 
handle that" sounds fine.  But it doesn't say the failure mode, so it's 
hiding information.

What I would like to have, "EREMOVE might fail and will be leaked, but 
virtual EPC code will not crash and in any case there are much worse 
problems waiting to happen" is fine.  (It's even better with an 
explanation of the problems).

Your message however was in the middle: "EREMOVE might fail, virtual EPC 
code will not crash but the page will be leaked".  It gives the failure 
mode but not how the problem arises, and it is this combination that 
results in something scary-sounding.

Paolo

