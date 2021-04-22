Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEB3368595
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbhDVRKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238441AbhDVRIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619111290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yC6jYB+ZSoRXAPzU+6mh57F+j0CveYL3H5XLHePHZGc=;
        b=fj2uQJC7HNc6vG+FEifhvuHW4gsTNU+vWkBPbm9q7TNjtNW8kTyo8Oo+i5w2ex4+b+DylB
        aFCqlsfpLgzsvZKC2zsUuHSOJVH04uqvrXs8Pb+pNZLZyVGzRC8un58dUL+XC1piYbJNE7
        LFo9r03se1wRouC+/zLIME5GV+2A5zI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-gH5IqeuFP32497ir3sKcFA-1; Thu, 22 Apr 2021 13:08:08 -0400
X-MC-Unique: gH5IqeuFP32497ir3sKcFA-1
Received: by mail-ed1-f70.google.com with SMTP id f9-20020a50fe090000b02903839889635cso15132586edt.14
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yC6jYB+ZSoRXAPzU+6mh57F+j0CveYL3H5XLHePHZGc=;
        b=aWjC4y4OUsop+TDmGjNcgo68M40AWs+qLpjgdhojfj1FJ/V21N5wxVmjjaEboO6zg0
         Ey1csOD1dl8l3rW+/On1xKkrpktTERXN15pxpEKBWcvfdRjvxfb4twS5wCkQpDYEVDWS
         Dyuw799YfOXrNF37FndRSfB7FNkCWeSg7x2YloOBQkyH5NStbLc+Fr8fHFyNI1UmQXky
         lVq3L/ZtHrz1mEh/QXcPM7UmlI6cpbKLpxgRdoHzBReY8VsPDVKypTPDLo7wfDKzMwe9
         89TQvSU4/WTWom7yfuqta9oSJBLUWWoQYVAVcVqkbygWBoqpNqRBek/VBqN2SbMoa5kH
         MzGA==
X-Gm-Message-State: AOAM532yYrCywly/g+K0hFztruE/Bi0W101PGAvqi4hJvPzdJoq/kWZ2
        GIFZJ00r6PT45XSr88idnacEZw3kmqH/p7ogm4IXqpL8x7i9XHPh7GrepUFRx+dBeL8DVC2l1kg
        W0+vCPSbazEMiYOaHaAu1+vbB
X-Received: by 2002:aa7:d94c:: with SMTP id l12mr5122834eds.290.1619111287659;
        Thu, 22 Apr 2021 10:08:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQ0ak30i9v5JnaeacFr9s7EA6LuLRC3LEAdNab/++6Eo3It4oY6sQ3gt+tQlbj1cX61I6TSA==
X-Received: by 2002:aa7:d94c:: with SMTP id l12mr5122798eds.290.1619111287447;
        Thu, 22 Apr 2021 10:08:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id d15sm2704139edu.86.2021.04.22.10.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 10:08:06 -0700 (PDT)
Subject: Re: [PATCH v5 03/15] KVM: SVM: Disable SEV/SEV-ES if NPT is disabled
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wei Huang <wei.huang2@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <20210422021125.3417167-1-seanjc@google.com>
 <20210422021125.3417167-4-seanjc@google.com>
 <5e8a2d7d-67de-eef4-ab19-33294920f50c@redhat.com>
 <YIGhC/1vlIAZfwzm@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <882d8bb4-8d40-1b4d-0742-4a4f2c307e5b@redhat.com>
Date:   Thu, 22 Apr 2021 19:08:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YIGhC/1vlIAZfwzm@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 18:15, Sean Christopherson wrote:
>> Support for 5-level page tables on NPT is not hard to fix and could be
>> tested by patching QEMU.  However, the !NPT case would also have to be fixed
>> by extending the PDP and PML4 stacking trick to a PML5.
>   
> Isn't that backwards?  It's the nested NPT case that requires the stacking trick.
> When !NPT is disabled in L0 KVM, 32-bit guests are run with PAE paging.  Maybe
> I'm misunderstanding what you're suggesting.

Yes, you're right.  NPT is easy but we would have to guess what the spec 
would say about MAXPHYADDR, while nNPT would require the stacking of a 
PML5.  Either way, blocking KVM is the easiest thing todo.

Paolo

