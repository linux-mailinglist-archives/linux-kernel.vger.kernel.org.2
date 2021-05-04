Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5750F3731E6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 23:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhEDV00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 17:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33967 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232684AbhEDV0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 17:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620163528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fsp3FlXsqJBpt92Hz6adn7ap1GpuklGqqHiakX9gLLU=;
        b=KKA1QlhzWAhKdgS/4OWOZMoHaa+1O83Ebs414k/RRjrCspfdjLvxapvYd8S82P9QNRpaes
        JbhNCkt9CbaBEg3fQF0IW4G3kaRoyV6mcua1I+COW27B56E6FL2ZJ5iGja2z8yFBpo0A/Y
        BgrkA26jNcyjpDXxTCqk6kCiupAE8HQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-XiD8hpiSO9enG_DZwbIKSw-1; Tue, 04 May 2021 17:25:27 -0400
X-MC-Unique: XiD8hpiSO9enG_DZwbIKSw-1
Received: by mail-ed1-f70.google.com with SMTP id f8-20020a0564020688b029038840895df2so7039681edy.17
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 14:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fsp3FlXsqJBpt92Hz6adn7ap1GpuklGqqHiakX9gLLU=;
        b=eTmJW47gfFr8v2iFOV8ErAaj5zP9xewOn1afd4qr9VKtBEfsEHAfdGHRmI+oDDHwbZ
         8AxkLv4cYYYOr1upQiMujQcgN4jIB9uSeji+bzcC3mCSEMiP3RvUpJIR5cFelPp1m+Zg
         ZtP6jFSP7pwH2XFUqhH7M5YZfeLWWnCRaNszSuHj1IaDq+70jF15TW+LSByM0Ykz4MhW
         aOK/5f7qmVeglldcgwSqLF8yGsCpcTQAEJawjXGk8XD3r9vOySDJRdgKpcbHFzn7beZo
         ErqvHTIUZJ2pP5yYxct06WBs9lfmZzBdDorsaaDOPTTdjVDapBctPQjx8iquofGzD5kU
         Az5w==
X-Gm-Message-State: AOAM533CXYhmbdA/C9Yy3hCiMxgkyWGD+j44FsDz5ACMNRDY/zePZN4O
        P3/qjy2TGRKktAc/IwF5DspF9LUb23VOZy1UyvrLD0nSF2CoBhgI0ERJEtu+/LmH6r/Mjp95UBr
        +mGLbTeKC4EAidev0wMmSyziD
X-Received: by 2002:a17:906:edc7:: with SMTP id sb7mr23622779ejb.443.1620163526309;
        Tue, 04 May 2021 14:25:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNdRsSLIeqH6Uw0edbDZemsL8P5hNANy2svhJza8YxUf7uijluasL2a4SVjIMTg7/VSGYCKQ==
X-Received: by 2002:a17:906:edc7:: with SMTP id sb7mr23622750ejb.443.1620163526099;
        Tue, 04 May 2021 14:25:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id ck4sm13977457edb.56.2021.05.04.14.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 14:25:25 -0700 (PDT)
Subject: Re: [PATCH] KVM/VMX: Invoke NMI non-IST entry instead of IST entry
To:     Andy Lutomirski <luto@amacapital.net>,
        Sean Christopherson <seanjc@google.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Juergen Gross <JGross@suse.com>,
        Joerg Roedel <jroedel@suse.de>, Jian Cai <caij2003@gmail.com>
References: <YJG6ztbGjtuctec4@google.com>
 <38B9D60F-F24F-4910-B2DF-2A57F1060452@amacapital.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <625057c7-ea40-4f37-8bea-cddecfe1b855@redhat.com>
Date:   Tue, 4 May 2021 23:25:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <38B9D60F-F24F-4910-B2DF-2A57F1060452@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/21 23:23, Andy Lutomirski wrote:
>> On May 4, 2021, at 2:21 PM, Sean Christopherson <seanjc@google.com> wrote:
>> FWIW, NMIs are masked if the VM-Exit was due to an NMI.

Huh, indeed:  "An NMI causes subsequent NMIs to be blocked, but only 
after the VM exit completes".

> Then this whole change is busted, since nothing will unmask NMIs. Revert it?

Looks like the easiest way out indeed.

Paolo

