Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7038339391F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 01:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbhE0XXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 19:23:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49106 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236567AbhE0XXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 19:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622157689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nCWKzoy9kj1pT7s/LMAs2R0z3NMNhJpdEi2dqYprz/8=;
        b=SRSPXVFG1Epz1+Asu3MkXQ0V9pBUz86biq/PMyYM3sL+RxhJVNmp/EQSe1cz5eHywEJ90q
        V3RcaCjc4Yg7w8RYU3jyo+tLIbQm8V2Jc9VIk1Gw79rchdOmCM3hsQ3WJih0bTIhLu7ij7
        q1xOME7VbubN4OQUW6/5bRLiP/eSHIA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-o1I5THqMObuaGC6DsFOQZA-1; Thu, 27 May 2021 19:21:27 -0400
X-MC-Unique: o1I5THqMObuaGC6DsFOQZA-1
Received: by mail-ed1-f69.google.com with SMTP id h18-20020a05640250d2b029038cc3938914so1086828edb.17
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 16:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nCWKzoy9kj1pT7s/LMAs2R0z3NMNhJpdEi2dqYprz/8=;
        b=W2uxFtMLoKOsyASAa0d9OfeOebdd2LZqF/Bfrm1QFW0qx6d5nmWvdbagLieZ3p7hKh
         E9Du7DtTNViU8ILpOfLXwJW3LzL+9EdZX11+OYJK8zFKIA7sHOky8SBhHw0p7OgA8Sv+
         /2DVFvqkCbTfg7OLByO/I4BGa5E5VJky+7/RdGcogtBn7stO7FWfmeYj1AwRufkDMH6P
         dFXPDzRqMm+Ho54cg2W/MzSTs0gSzLTNGHE2XmpzwY14Ux0+7UX8ZbyIPQFDjd/eXetI
         A2Ns89WfSmfKLRjaXwioLbZMoLQY84CtZ/vEDyV0w7AEguqfumYQrsGC9RQ/PfINGwex
         iVNw==
X-Gm-Message-State: AOAM532suTJidLNNhDPM8OG+Z49Ol99NWarFXCs9VOf5CkAf2BPvbBsX
        JYxMJvgDsVcH24BstPcaQiuHCNaMsfOmBys5lvg7MCHG4MAg5oExCLo5YPBpyIw9rF+6SKyW3d6
        xcFgomdBpqazD/1hjCWaaVVaq
X-Received: by 2002:a17:906:68c:: with SMTP id u12mr6263657ejb.470.1622157686503;
        Thu, 27 May 2021 16:21:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzgiXFMi0YlkhIN3byuem1Kgwi4TTcVzAYR+6zTso/Cq/N5U9JF7ehTOA7isPY90/EHZ2CWQ==
X-Received: by 2002:a17:906:68c:: with SMTP id u12mr6263641ejb.470.1622157686347;
        Thu, 27 May 2021 16:21:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e22sm1889267edu.35.2021.05.27.16.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 16:21:25 -0700 (PDT)
Subject: Re: [syzbot] WARNING in x86_emulate_instruction
To:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+71271244f206d17f6441@syzkaller.appspotmail.com>,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        jarkko@kernel.org, jmattson@google.com, joro@8bytes.org,
        kan.liang@linux.intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, seanjc@google.com,
        steve.wahl@hpe.com, syzkaller-bugs@googlegroups.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
References: <000000000000f3fc9305c2e24311@google.com>
 <87v9737pt8.ffs@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0f6e6423-f93a-5d96-f452-4e08dbad9b23@redhat.com>
Date:   Fri, 28 May 2021 01:21:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87v9737pt8.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/21 00:52, Thomas Gleixner wrote:
> 
> So this is stale for a week now. It's fully reproducible and nobody
> can't be bothered to look at that?
> 
> What's wrong with you people?

Actually there's a patch on list ("KVM: X86: Fix warning caused by stale 
emulation context").  Take care.

Paolo

