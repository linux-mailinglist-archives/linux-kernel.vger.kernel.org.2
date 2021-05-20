Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1970838A461
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 12:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhETKFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 06:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234899AbhETJ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 05:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621504673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XN0KVjrZHQNAp4floqlRnA9InqWCr8Nn/WaTDhZGHb8=;
        b=aM9FqjhBRwGCI0HalTnCtbcMl5eq4QzjiChEw7WkLqKHQw8+K7Um6mIbPU/sjbhphhd1mE
        9dy9A8L/qlzC9apA97Oc44oyNYVnBIVY0L+hA01/XLdDv3MvZbtBY8LVY2K0gJDnDr7j9j
        7ZLqYDIDwPdW3wHQ7lQMjIV9CHtsK9k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-2H1xG_LePheys97u-EhAmQ-1; Thu, 20 May 2021 05:57:51 -0400
X-MC-Unique: 2H1xG_LePheys97u-EhAmQ-1
Received: by mail-wm1-f70.google.com with SMTP id b206-20020a1c1bd70000b02901713122405eso1242319wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 02:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XN0KVjrZHQNAp4floqlRnA9InqWCr8Nn/WaTDhZGHb8=;
        b=g+2LATuz0vW7dsK+kyEKDzE00GnMwGGppXeBLROwHIF9/3jmK/VJUvrFCqkjfC7MRw
         yjxZw1vvj443fAbUeqKAYRTFaj/p8kw6Th58NmULbG/0YmNbxBuEL2LFNBvpoTws++PP
         fH9BwB4ESGRIKKLwFsQvxhL2+xDHt03DN6MbsDpkTfpATnxjq4r8oEZk4wmtroB7t/Tc
         EOv7A69UVlzegxGzeQwCq9V7rAbl6ybqgiH1LseNiG0Q8IOpV4XlaMj1izO35EyZeQ5p
         BrnUjrbqE6+WkmDAKxufIvmhmW+ZBLushEDY2dp2Ln7i1JS5JYnVS5AM3bWHQ+wXAcWx
         XW+A==
X-Gm-Message-State: AOAM532JJVY6rDWCTZyQbsm1eMXHREWNY5xthjXrJn4YNnu+oWZZN3VQ
        5Bn/77sKqBVpTvn8TBDvVfrKL2DJWe+y/tsBsMFJeaY7xu4kUpu48bXA1uC10iMtQndTvKJBPbm
        23mFSSoRZ4h1o07n5JAXaCqfJ
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr2803865wmj.149.1621504670707;
        Thu, 20 May 2021 02:57:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7c9CdXIXMXQXdc4v65xfwHEhSGYdwW2G3Q4+Bj/Rdj0IdckMPGiWGqXAAGwE1/8tAHAaxQg==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr2803849wmj.149.1621504670510;
        Thu, 20 May 2021 02:57:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id a11sm2607506wrr.48.2021.05.20.02.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 02:57:49 -0700 (PDT)
Subject: Re: [PATCH 5.10 005/289] KVM: x86/mmu: Remove the defunct
 update_pte() paging hook
To:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Yu Zhang <yu.c.zhang@intel.com>,
        Sean Christopherson <seanjc@google.com>
References: <20210517140305.140529752@linuxfoundation.org>
 <20210517140305.340027792@linuxfoundation.org> <20210519195651.GA14212@amd>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02d72616-2e95-f6cd-403c-60d5f2dfb3f1@redhat.com>
Date:   Thu, 20 May 2021 11:57:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519195651.GA14212@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/21 21:56, Pavel Machek wrote:
> Hi!
> 
>> From: Sean Christopherson <seanjc@google.com>
>>
>> commit c5e2184d1544f9e56140791eff1a351bea2e63b9 upstream.
>>
>> Remove the update_pte() shadow paging logic, which was obsoleted by
>> commit 4731d4c7a077 ("KVM: MMU: out of sync shadow core"), but never
>> removed.  As pointed out by Yu, KVM never write protects leaf page
> 
> First, this is cleanup, not a bugfix.

It was reported to also fix a bug.  Commit 4731d4c7a077 is 2008 vintage, 
so it is certainly in 5.10.

Paolo

> Second, AFAICT 4731d4c7a077 ("KVM: MMU: out of sync shadow core") is
> not in 5.10, so this will break stuff according to the changelog.



