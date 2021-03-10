Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B956334191
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhCJPcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:32:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22548 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232470AbhCJPbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615390305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kqn/H5fuPIGwf1ju1Mr96gbuZcfhY+jjXfU5XdlrYUw=;
        b=ebf9GpLxnBJvu3MndaKwGMpBpAq+AyHaftXnHwV03VeOmeNtQP+6LXJzc8rDyvEt3gYolJ
        J6LtIlZL5dYiV28I6UF4ESd5QEfZGer/vltXi5OfACgercb9rhpQ9p7+bwLv0HEtQ7iugT
        75zL7pzh1SYeTcFo/duxLZERD32dUMA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-sk3ucdLpMdWErujgqgR1fg-1; Wed, 10 Mar 2021 10:31:44 -0500
X-MC-Unique: sk3ucdLpMdWErujgqgR1fg-1
Received: by mail-wr1-f72.google.com with SMTP id l10so8148927wry.16
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:31:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kqn/H5fuPIGwf1ju1Mr96gbuZcfhY+jjXfU5XdlrYUw=;
        b=ttHAjUMXedfpLD/8OhONgJ7dtT+S666mguG4hzKmXdF96mqZUdDcue6lb2qpgQ1E0M
         LsiOUkKv1LxyCD4EhBmEncUz14ut90pf86E2P84zQqbc6jN+gM9wuoE+YkGYNICTpRcM
         OvXd/Z5NV2LifzgipovnB7w93hTDZj07T1QwNcqnhiXlycocVfOjCYgfiUL6JCqKNDmq
         mRl5t/L3TC2N3LBn1WXhtigW13sBUGTGggQw4iug8YJTTUEbdKbsSJRYarRbYmh4UEUe
         hfcjS0KsNPSw/rJH2onMYvtrhN6YcgjIqYWmN2F9BV+l1laaOxwuUf2MfYPP4cV4j4c9
         EcmQ==
X-Gm-Message-State: AOAM532UxUqHIRqHBr1bt8m7I6ysQ3QW01PqadHucbXM8Lx73L3lBvel
        Q9AUhoqilmocXqOp4eicm4KvO8EiiMLSR3EevryX9IsMB13Unf/4kRBebZjtz0e/L1X4BiNEASi
        0oALHygsLxvXu1WRxhVMXFBgm
X-Received: by 2002:a1c:1f04:: with SMTP id f4mr4006897wmf.12.1615390302918;
        Wed, 10 Mar 2021 07:31:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoBR+vwFcI3PXqNnWfkSJVsAEAqiZviV0C5yEUoQMreC8qTBL/zFDifkL1BRCov8gAt7H46A==
X-Received: by 2002:a1c:1f04:: with SMTP id f4mr4006877wmf.12.1615390302769;
        Wed, 10 Mar 2021 07:31:42 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id 75sm10398681wma.23.2021.03.10.07.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 07:31:42 -0800 (PST)
Subject: Re: [PATCH v6 00/12] SVM cleanup and INVPCID feature support
To:     Babu Moger <babu.moger@amd.com>, Jim Mattson <jmattson@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Makarand Sonare <makarandsonare@google.com>,
        Sean Christopherson <seanjc@google.com>
References: <159985237526.11252.1516487214307300610.stgit@bmoger-ubuntu>
 <83a96ca9-0810-6c07-2e45-5aa2da9b1ab0@redhat.com>
 <5df9b517-448f-d631-2222-6e78d6395ed9@amd.com>
 <CALMp9eRDSW66+XvbHVF4ohL7XhThoPoT0BrB0TcS0cgk=dkcBg@mail.gmail.com>
 <bb2315e3-1c24-c5ae-3947-27c5169a9d47@amd.com>
 <CALMp9eQBY50kZT6WdM-D2gmUgDZmCYTn+kxcxk8EQTg=SygLKA@mail.gmail.com>
 <21ee28c6-f693-e7c0-6d83-92daa9a46880@amd.com>
 <01cf2fd7-626e-c084-5a6a-1a53d111d9fa@amd.com>
 <84f42bad-9fb0-8a76-7f9b-580898b634b9@amd.com>
 <032386c6-4b4c-2d3f-0f6a-3d6350363b3c@amd.com>
 <CALMp9eTTBcdADUYizO-ADXUfkydVGqRm0CSQUO92UHNnfQ-qFw@mail.gmail.com>
 <0ebda5c6-097e-20bb-d695-f444761fbb79@amd.com>
 <0d8f6573-f7f6-d355-966a-9086a00ef56c@amd.com>
 <1451b13e-c67f-8948-64ff-5c01cfb47ea7@redhat.com>
 <3929a987-5d09-6a0c-5131-ff6ffe2ae425@amd.com>
 <7a7428f4-26b3-f704-d00b-16bcf399fd1b@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <78cc2dc7-a2ee-35ac-dd47-8f3f8b62f261@redhat.com>
Date:   Wed, 10 Mar 2021 16:31:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <7a7428f4-26b3-f704-d00b-16bcf399fd1b@amd.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/21 15:58, Babu Moger wrote:
> There is no upstream version 4.9.258.

Sure there is, check out https://cdn.kernel.org/pub/linux/kernel/v4.x/

The easiest way to do it is to bisect on the linux-4.9.y branch of 
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git.

paolo

