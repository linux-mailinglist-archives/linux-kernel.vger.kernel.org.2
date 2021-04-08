Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5F635833A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhDHM0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230449AbhDHMZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617884745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N8WC71YVcH2PzB7/MRu3TT5EAfVDS68BDlRAwibePTY=;
        b=BFOymnrUexHM4qGR2E/L1kdleoZo3oPz7gym6MmGdt0XOo5BHj13XzNePVRDjH6Mp6qJDb
        gZu5CmvVBrJo9fTfcYD6GG85I33d5DC+uhujSq9AjdL8QNj/vIb7s/RbKg5ADFDj9NPNpy
        ROm1UFeDrdFeruPCvmK1baDqexnL/vw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-oLTR8oEWPZCdSYTyZJHr7w-1; Thu, 08 Apr 2021 08:25:44 -0400
X-MC-Unique: oLTR8oEWPZCdSYTyZJHr7w-1
Received: by mail-ej1-f72.google.com with SMTP id v27so775411ejq.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 05:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N8WC71YVcH2PzB7/MRu3TT5EAfVDS68BDlRAwibePTY=;
        b=iLjhhLtA72e1G3/E47H0/m3yJ0AcUba6sAbEKBoGz6d2v6LWwLn7gIz/aaP+A+3k8Z
         fSyRbBaZDVEtH26hAUFxV6DwVuROBZIWDtq/HKrAulmF0uJKzpjJfwntz/VYwuNwQJy6
         DgE+MULQ6MqL/D3c5t3ZDrISWVYeF/0rIG5Jjo8k7Dk34/oTZUKBqfT4FjOPBbxIN7/c
         TW2qOJCMPus6/osM26vl6KNZSXYaPglzMJB9p99zu3Yj0vZ6GkI+IgVqO49UZfBliCx/
         GIYWr/K3N99JiWA60+O58AmlYEXcPQlDbJ7cH5QSr0w8wAFLi+HP6U0Ui9vpG3L8lpt2
         Cyjw==
X-Gm-Message-State: AOAM530SuTv9bV2cJG1+VlL026DT5wwTLXNOuSFT6kVhZ0YsjMYAsfaC
        zys3oq8tgfk7ysVOxbr7m0Rikr3yBlQDCzJR5y+pfVy59jcCH0aD07stljDYb3+rOkKHS0lZfeU
        bXTFCXCNZlH4utLjWt4bYp8Oj
X-Received: by 2002:a17:907:1614:: with SMTP id hb20mr9988512ejc.77.1617884742925;
        Thu, 08 Apr 2021 05:25:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOrCIDnw2gn0DIxYl9xIccpQ4md4ymI/6JnKD1M3OovnJwb9XKE+/tFGcSy6GkB9tvyHovaQ==
X-Received: by 2002:a17:907:1614:: with SMTP id hb20mr9988481ejc.77.1617884742753;
        Thu, 08 Apr 2021 05:25:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x24sm12332509edr.36.2021.04.08.05.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 05:25:42 -0700 (PDT)
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, dwmw@amazon.co.uk
References: <20210330165958.3094759-1-pbonzini@redhat.com>
 <20210330165958.3094759-2-pbonzini@redhat.com>
 <20210407174021.GA30046@fuller.cnet>
 <51cae826-8973-5113-7e12-8163eab36cb7@redhat.com>
 <20210408120021.GA65315@fuller.cnet>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] KVM: x86: reduce pvclock_gtod_sync_lock critical
 sections
Message-ID: <2abe4b19-e41e-34f9-0a3c-30812c7b719e@redhat.com>
Date:   Thu, 8 Apr 2021 14:25:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210408120021.GA65315@fuller.cnet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/21 14:00, Marcelo Tosatti wrote:
>>
>> KVM_REQ_MCLOCK_INPROGRESS is only needed to kick running vCPUs out of the
>> execution loop;
> We do not want vcpus with different system_timestamp/tsc_timestamp
> pair:
> 
>   * To avoid that problem, do not allow visibility of distinct
>   * system_timestamp/tsc_timestamp values simultaneously: use a master
>   * copy of host monotonic time values. Update that master copy
>   * in lockstep.
> 
> So KVM_REQ_MCLOCK_INPROGRESS also ensures that no vcpu enters
> guest mode (via vcpu->requests check before VM-entry) with a
> different system_timestamp/tsc_timestamp pair.

Yes this is what KVM_REQ_MCLOCK_INPROGRESS does, but it does not have to 
be done that way.  All you really need is the IPI with KVM_REQUEST_WAIT, 
which ensures that updates happen after the vCPUs have exited guest 
mode.  You don't need to loop on vcpu->requests for example, because 
kvm_guest_time_update could just spin on pvclock_gtod_sync_lock until 
pvclock_update_vm_gtod_copy is done.

So this morning I tried protecting the kvm->arch fields for kvmclock 
using a seqcount, which is nice also because get_kvmclock_ns() does not 
have to bounce the cacheline of pvclock_gtod_sync_lock anymore.  I'll 
post it tomorrow or next week.

Paolo

