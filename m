Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536AA332E86
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 19:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhCISuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 13:50:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230035AbhCIStv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 13:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615315791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9Xym80t0AfeRZOHjiWsVqVWWv3spvSFZ9P4PZSjvAg=;
        b=O7DG2O1ZuaFb7o/C3fA5F+cdG8pXgcpdyM20cg8jM/5vzjFbMKZ4mIMpKcjSjcp+7D7f2D
        sT/lj9yub13ipCqOz8CtvcSlWMReib3SHy/lIWA68j6167EatjO/ZmW7WHqVLoJAFyed/x
        BmG+0NpWz4nWd0GIDC/sZjS+N0phdU8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-Puy1zNhwNhukt9P_bDC-yA-1; Tue, 09 Mar 2021 13:49:49 -0500
X-MC-Unique: Puy1zNhwNhukt9P_bDC-yA-1
Received: by mail-wm1-f72.google.com with SMTP id z26so1541782wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 10:49:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m9Xym80t0AfeRZOHjiWsVqVWWv3spvSFZ9P4PZSjvAg=;
        b=hhkI0boTG/xdzGxkI1yyNxtQy0XH3rz8JJORyzoZEUv8mtrs8hsXDEn7p0gAxbE4Ak
         KcgfzMHjLY6ZcVnm4TJSfqmz/Ft6UhdB/InHVs8hk/aly6w8S+m1Y0rObAxNQhE3aZBP
         eO1Vy3jGZM8QGgQLDhY4sywZg5gji67Xnqt3mCCk2bnUcxbG+2DAPUxT9Y4j1AUgJ3Hb
         XDeO5jWH3PppIWtF7bH4zr1fBaDfU0OudQiGYq3jHtt/pePhsVPD4Jn3zfSSSkrpWycI
         BpIgmfMRsbGgXuXSRbsQodkG7YjUCVjVVBmWXrBZ2NNcSde12ILPp3gIKcc49fHE3Q2r
         ZcGQ==
X-Gm-Message-State: AOAM5322gbDOZhhVTbz5ac+R/vT14aosQjY6iuoCHR23+/C8TfiFw/hu
        GEB6lmd9CJQk34w1NgaEe0tHp2s94ABVfn2sJ3xGGW8ccgNXneDOuD10JKfEEDrYWRq/13Gt3TS
        La+JccNv7jsar+jw9MDDKHMTo
X-Received: by 2002:a05:6000:1a8c:: with SMTP id f12mr29860099wry.173.1615315788524;
        Tue, 09 Mar 2021 10:49:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLvc9I8lVKzz6AHteBnYBDwX8zS4xde1F0yjVbAXTx+neuz8trrr19wOyyEGbfiZBgdAWiUw==
X-Received: by 2002:a05:6000:1a8c:: with SMTP id f12mr29860076wry.173.1615315788359;
        Tue, 09 Mar 2021 10:49:48 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n66sm5211597wmn.25.2021.03.09.10.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 10:49:47 -0800 (PST)
Subject: Re: [PATCH v2 00/25] KVM SGX virtualization support
To:     Borislav Petkov <bp@alien8.de>, Kai Huang <kai.huang@intel.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanjc@google.com, jarkko@kernel.org,
        luto@kernel.org, dave.hansen@intel.com, rick.p.edgecombe@intel.com,
        haitao.huang@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, jethro@fortanix.com, b.thiel@posteo.de,
        jmattson@google.com, joro@8bytes.org, vkuznets@redhat.com,
        wanpengli@tencent.com, corbet@lwn.net
References: <cover.1615250634.git.kai.huang@intel.com>
 <20210309093037.GA699@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <51ebf191-e83a-657a-1030-4ccdc32f0f33@redhat.com>
Date:   Tue, 9 Mar 2021 19:49:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210309093037.GA699@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/21 10:30, Borislav Petkov wrote:
> On Tue, Mar 09, 2021 at 02:38:49PM +1300, Kai Huang wrote:
>> This series adds KVM SGX virtualization support. The first 14 patches starting
>> with x86/sgx or x86/cpu.. are necessary changes to x86 and SGX core/driver to
>> support KVM SGX virtualization, while the rest are patches to KVM subsystem.
> 
> Ok, I guess I'll queue 1-14 once Sean doesn't find anything
> objectionable then give Paolo an immutable commit to base the KVM stuff
> ontop.

Sounds great.

Paolo

