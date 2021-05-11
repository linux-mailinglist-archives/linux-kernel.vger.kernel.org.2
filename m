Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18DE37AF51
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 21:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhEKTae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 15:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231454AbhEKTab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 15:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620761364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8VQQPkbOEAUOoAyHQFpuOhcMTPtNaQqkF/sYSE/zpM=;
        b=B/bIyXmmCG5jisfd8ld2Jy1J3qMRichwyBQTaMrcNrBmaB4Cnn0lZ2zN9VSC+qYGlSYdU1
        9TII28oWI2RcFO5qUor/cf+kKFZvIk/62EP6x0fFMSlEWHiNVKKzRa+dxdUhOieoYpyKkV
        eafbQ53O0IJWk2cy2/hD6+lEs2X2fis=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-4GY_eSRMNymZtJWpLlRRSg-1; Tue, 11 May 2021 15:29:22 -0400
X-MC-Unique: 4GY_eSRMNymZtJWpLlRRSg-1
Received: by mail-ed1-f70.google.com with SMTP id g19-20020a0564021813b029038811907178so11462874edy.14
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 12:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U8VQQPkbOEAUOoAyHQFpuOhcMTPtNaQqkF/sYSE/zpM=;
        b=TgoRhOI4bxWiixI2LgMhDuOKQdE9UXMLg7RobedWUyhUJOepHwCR2I7AqNwX0uTWZ6
         cI1z8BehBEQ7tBM7vU6oyhxaN4Jv98vmu7MPouJ767BSWDZECp3Zgx8TS0hUyEWLWBsh
         PZ7R7s7DrPQNa+HiguaqUzfi7HlwOvAD6DwB5x2pz/OrQ0lKzp7EzDtscuTttcsHinnq
         4WAiCxKpdZvOI9keMtFc1DvCVsT+H1n4YscxlG6krIlK8f/f6Mq8kHGluJKxkOK2svMA
         sE4LhVcEUPaxNnopylE8hEoVxeaWMC2pZrWvW61V5ApvCoh1R4rnQulVaOdTMcyr0eby
         fumw==
X-Gm-Message-State: AOAM5327Vn6sxCtsNP4Zjx7q6kx57GwsBW22UE7fQO0Uqt7LmWEAEQhh
        jK99EKULgHLO7DDO1/t49VH8EJpvkNZHkJdRzkLzvVQLhWtQfMSuGvHQnn9pksCcwBP95sIoMxn
        YpksS/YLFiQpuwD1+ylZleHzI
X-Received: by 2002:a17:907:1181:: with SMTP id uz1mr33342235ejb.194.1620761361661;
        Tue, 11 May 2021 12:29:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0Dx7qUS1VH55IC/UGrUERRS9i04SgOldQ9s1zOM6fqquzgDeHq4sdHSqIP00yWitAHY9XFw==
X-Received: by 2002:a17:907:1181:: with SMTP id uz1mr33342216ejb.194.1620761361418;
        Tue, 11 May 2021 12:29:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u4sm1654908eds.1.2021.05.11.12.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 12:29:20 -0700 (PDT)
To:     Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>,
        David Hildenbrand <david@redhat.com>
References: <20210511171610.170160-1-bgardon@google.com>
 <20210511171610.170160-5-bgardon@google.com> <YJrZKkW9Cb9t+fU5@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 4/7] KVM: mmu: Add slots_arch_lock for memslot arch
 fields
Message-ID: <ef473b52-0b71-a524-ed36-c2c1a9d0fb03@redhat.com>
Date:   Tue, 11 May 2021 21:29:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJrZKkW9Cb9t+fU5@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/21 21:21, Sean Christopherson wrote:
>> +	/* Released in install_new_memslots. */
> 
> This needs a much more comprehensive comment, either here or above the declaration
> of slots_arch_lock.  I can't find anything that explicitly states the the lock
> must be held from the time the previous memslots are duplicated/copied until the
> new memslots are set.  Without that information, the rules/expecations are not
> clear.

Indeed, this needs basically a description of the races that can happen, 
as you explained them in the v1 review.

> Unfortunately I'm just whining at this point since I
> don't have a better idea 

Yeah, the synchronize_srcu call in install_new_memslots throws a wrench 
in most alternatives.

Paolo

