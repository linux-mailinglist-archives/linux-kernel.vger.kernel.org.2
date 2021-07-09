Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A784E3C27E1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 18:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhGIRBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229491AbhGIRBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625849937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5t7qcA+aXv0/a7HPeQ4gEqXkgrf5UzKGV2mhxZXbkQ=;
        b=OLRWUBG2C+74q4KlwQtYLi7Uk3nHL01yGgzrYhb2fq1n3DJc5uiLSbqDOvrzJju9Ohf0S7
        gfg7t8Entnw4rBS0/4n/6kFDMiAvxLvnjKg03uuXel3bJiqHmGRYu1ro0me7RevySifzfx
        6yrh8zghecWhdMDbDpnHMM2eCCrTeQU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-9rsDkm5FNlybbcgsoxNx_A-1; Fri, 09 Jul 2021 12:58:55 -0400
X-MC-Unique: 9rsDkm5FNlybbcgsoxNx_A-1
Received: by mail-ej1-f70.google.com with SMTP id p5-20020a17090653c5b02903db1cfa514dso3402837ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 09:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D5t7qcA+aXv0/a7HPeQ4gEqXkgrf5UzKGV2mhxZXbkQ=;
        b=W0RZRuNJp5hNfm6N7wyrn9k0JWsiYbDgiIXPtcswPpJLSJ5kc6OeEhUkyy0CcoU2m+
         9E6/f69wSERi8Df3gBk3oZY3S4jETqQxJcv5Xz2mmkOWP3zg3B9dZRPJQqs9EbAoZXph
         zqQ2yAeuvVH5PrvgqnCkRMeaU7xfIBtbBkjjSFVBs8FxPrPp/Gi577yeSSZHbnNCgGx5
         GWfOrLCuOMUK0QeF1CBY7qJuakrkRIqKyZPKXW5/J6QG7xR5WZ+9uOOujUv99RrK36kb
         oiIi+XmUwTLJaKk5JaQuGz07nyWqnDVth8o4MzeXGGxP1XyOQkWZmE5Bsi9H7f+0Prjk
         bd0A==
X-Gm-Message-State: AOAM533kF0O5zLoXxJuM/LRtNIlLBDkpw1f0dc/VJsTCsyLm9gVoORqR
        LZF/n/mkKkHAtabwBNUOmHy9CAgTIh3bEA5SHG0YI8uz8V/cgXzxf/gRUBjHMZxSEnJrkOAfz/t
        ed6woxd/VAklSi6Fay8oYjnJZ
X-Received: by 2002:a17:906:a94:: with SMTP id y20mr15711805ejf.399.1625849934798;
        Fri, 09 Jul 2021 09:58:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPTA2RyzHuLzpJGh0SOmyPWBtHEGUYVRMCcTHP1l97WwYEmb0Adq2pK21QS+mlLNC9cIf1OQ==
X-Received: by 2002:a17:906:a94:: with SMTP id y20mr15711784ejf.399.1625849934590;
        Fri, 09 Jul 2021 09:58:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c28sm2473420ejc.102.2021.07.09.09.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 09:58:54 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Also reload the debug registers before
 kvm_x86->run() when the host is using them
To:     Jim Mattson <jmattson@google.com>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org
References: <20210628172632.81029-1-jiangshanlai@gmail.com>
 <46e0aaf1-b7cd-288f-e4be-ac59aa04908f@redhat.com>
 <c79d0167-7034-ebe2-97b7-58354d81323d@linux.alibaba.com>
 <397a448e-ffa7-3bea-af86-e92fbb273a07@redhat.com>
 <a4e07fb1-1f36-1078-0695-ff4b72016d48@linux.alibaba.com>
 <01946b5a-9912-3dfb-36f0-031f425432d2@redhat.com>
 <CALMp9eQWnUM-O7VmMWTGE2C2YraWxM2K0QcOQnbkctkzg_1pUA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bac2de6d-ae6d-565d-38f2-0c46b06cee0f@redhat.com>
Date:   Fri, 9 Jul 2021 18:58:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eQWnUM-O7VmMWTGE2C2YraWxM2K0QcOQnbkctkzg_1pUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/21 18:35, Jim Mattson wrote:
>>>> Just what you said, it's not easy and the needs are limited.  I
>>>> implemented kvm_vcpu_check_breakpoint because I was interested in
>>>> using hardware breakpoints from gdb, even with unrestricted_guest=0
>>>> and invalid guest state, but that's it.
>>> It seems kvm_vcpu_check_breakpoint() handles only for code breakpoint
>>> and doesn't handle for data breakpoints.
>> Correct, there's a comment above the call.  But data breakpoint are much
>> harder and relatively less useful.
> 
> Data breakpoints are actually quite useful. I/O breakpoints not so much.

Normally yes; much less for the specific case of debugging 
invalid-guest-state or other invocations of the emulator.

Paolo

