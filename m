Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64BE4033DE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 07:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347550AbhIHFhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 01:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52181 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347310AbhIHFhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 01:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631079369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dFD339gZoGagg4tSSmQme6S+gWZOs2ChudJRNUISs54=;
        b=HevrQU/guIvoqFmZlZZlPPFy6d/ZC8T3/g9omj6WJ2eFIZj0pKFqs6jJyOmJCdyPcgHZwW
        kewSuCooxvY++aqAcYvD3ZVfgOIt+HuXnyA8wI7dbUGMz/5JVoAsl226P7y3BXi6304y8j
        o8TrboOhBz7B9Q2t6HGm1pYjCvgq7Ys=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-6qoacAHbNvOVNTr8bgiwoA-1; Wed, 08 Sep 2021 01:36:08 -0400
X-MC-Unique: 6qoacAHbNvOVNTr8bgiwoA-1
Received: by mail-ej1-f69.google.com with SMTP id ga42-20020a1709070c2a00b005dc8c1cc3a1so429011ejc.17
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 22:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dFD339gZoGagg4tSSmQme6S+gWZOs2ChudJRNUISs54=;
        b=opvmVomx0r+kc3KPOpHPuMrWOTV0vWGJ3D/xrb1SmBboYb8XPxNOvDsOBmzrbtqw+r
         dnL4Y1osw8PlJqT8merJO2zsk2Jxg7FZyraIdm8OeQL8zmBksi+o776Nnna+GSudcwFN
         2bJXWrLuGNU58D1kWmfdD6v5gyDXRRw/On3ypevkAXhkPhJeL/NIqDRYQf82hS2Ey52a
         1pcCW5fpr+3ht6/5wlpV2P4c6a6tCKpfdBok6tIbSkeoQhJRRvN6M79p7/6d3aPoOgK0
         VCNspOqsiHcbFRYlJsKmxUhJU5S/q2hyj3kkbMnm40aSRPVueu68l3QcII+oQAMwuu8g
         MZnw==
X-Gm-Message-State: AOAM5335GINTZM9cVgo4TQTYO92G5vM2PosO9+w9JYLwln8xTYIxZYjA
        +kn3LUGoAbMuk8sJNKOd62WwDViWZ7BPmnMB3b1FLTZMpv/UigUD+ODHiqdbTLPN8rKqc/YXUzs
        1N9rhqNI5cTYMaWEffVOy8Be0
X-Received: by 2002:a50:ab42:: with SMTP id t2mr2084741edc.113.1631079367434;
        Tue, 07 Sep 2021 22:36:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyc6RwiUcNrrlYLIs4pe6r1E3Z5trGvuncJEIl8W+/WZ0elXTSBFJvbD524S8a0IU4LMkBsQ==
X-Received: by 2002:a50:ab42:: with SMTP id t2mr2084726edc.113.1631079367262;
        Tue, 07 Sep 2021 22:36:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q9sm383547ejf.70.2021.09.07.22.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 22:36:06 -0700 (PDT)
Subject: Re: [syzbot] WARNING: kmalloc bug in memslot_rmap_alloc
To:     Sean Christopherson <seanjc@google.com>,
        syzbot <syzbot+e0de2333cbf95ea473e8@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        jarkko@kernel.org, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Gardon <bgardon@google.com>
References: <0000000000006096fa05cb454a9c@google.com>
 <YTehmR1+G34uOHh3@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2e6b9e6d-30b4-6cb4-1eb7-c626e5d2adb3@redhat.com>
Date:   Wed, 8 Sep 2021 07:36:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YTehmR1+G34uOHh3@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/21 19:30, Sean Christopherson wrote:
> The allocation in question is for KVM's "rmap" to translate a guest pfn to a host
> virtual address.  The size of the rmap in question is an unsigned long per 4kb page
> in a memslot, i.e. on x86-64, 8 bytes per 4096 bytes of guest memory in a memslot.
> With INT_MAX=0x7fffffff, KVM will trip the WARN and fail rmap allocations for
> memslots >= 1tb, and Google already has VMs that create 1.5tb memslots (12tb of
> total guest memory spread across 8 virtual NUMA nodes).

We can just use vmalloc.  The warning was only added on kvmalloc, and 
vmalloc suits the KVM rmap just fine.

The maximum that Red Hat has tested, as far as I know, is about 4TiB 
(and it was back when there was no support for virtual NUMA nodes in 
QEMU, so it was all in a single memslot).

Paolo

