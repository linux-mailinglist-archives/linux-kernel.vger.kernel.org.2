Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2027414929
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbhIVMmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236016AbhIVMmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632314450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oc3Q6F9LHhQ/23Lb3iu0juJPgymyqAuk3iNqpXm8I68=;
        b=WMuSRZg76k7QJXy8JAFEj+j80Kj1OqdXeMOYe9KnQmrDzN4BB/swrxn5Og0t62INZWrHAI
        E044MBgehzque42zOYynLDRAxDz43QZ/ZvwpuE0MYpzerXAN9eBFPAtC/CgTyRH2Q2RRIM
        MKRgEztYoBHGOxcTCAsDOmN4DJdo7c8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-msUeEGjUM5ePQ5feMfzsTw-1; Wed, 22 Sep 2021 08:40:49 -0400
X-MC-Unique: msUeEGjUM5ePQ5feMfzsTw-1
Received: by mail-ed1-f71.google.com with SMTP id m30-20020a50999e000000b003cdd7680c8cso2911710edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 05:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oc3Q6F9LHhQ/23Lb3iu0juJPgymyqAuk3iNqpXm8I68=;
        b=UT5Yog4/OvHYL6g8CdlKFFsyfo+9TjxKgn6rDCvP2mwDOX+pLfwqC/tk89iWa1hRlr
         +AI6x7OMBPQ7TlcjMJXNEtkYm3Bs5Rvo4IOfdSoKwizTori8j64BpwaYYWI0x1NYCguk
         vLOqBMg1udKCA/Qc7x75y3w0iMLMG3y4uugj+yKswM1Wg9lDpzz89A/4ICxJrC5hGIB+
         F55b6zRwo8oKkyR1ysOuiMs4sAkM8NkCJqReQziYU5+Or/87eM/5If1BOwTv1KOxZ/yZ
         1EH1S9cG9Jy5YVKi6t4CiBNiW9txP5tbFqrDZBbUNJvNvJTxQBY8MDI4xjuwK0ZQQMmS
         lROQ==
X-Gm-Message-State: AOAM530k+OBsl+RDtrCU3Q7jAluGXyLemvjsSVwhEbmq8CV8dEjxLRQL
        b+c1nYjSaz/BWyqm9oiBAURAreFY8+PqXJdIBp+PZfR1iTYsuJq+1LpCSpFEkLwpvWBQrKV3NZ8
        x7Hknor7hYjftWsk7iINWXibi
X-Received: by 2002:a05:6402:2cd:: with SMTP id b13mr41840756edx.267.1632314448403;
        Wed, 22 Sep 2021 05:40:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPcohitOYlJxmH82gHsF/0gv1vncG8Sjcah9w2Y9T/wly4AAteK5LpZI/K7wDkwVrBI+hw0A==
X-Received: by 2002:a05:6402:2cd:: with SMTP id b13mr41840730edx.267.1632314448163;
        Wed, 22 Sep 2021 05:40:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u19sm1173524edv.40.2021.09.22.05.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 05:40:47 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Check if bus lock vmexit was preempted
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Hao Xiang <hao.xiang@linux.alibaba.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chenyi.qiang@intel.com,
        shannon.zhao@linux.alibaba.com,
        Sean Christopherson <seanjc@google.com>
References: <1631964600-73707-1-git-send-email-hao.xiang@linux.alibaba.com>
 <87b411c3-da75-e074-91a4-a73891f9f5f8@redhat.com>
 <57597778-836c-7bac-7f1d-bcdae0cd6ac4@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a0d6bcd8-11e4-4efd-0317-0bec6e59f06a@redhat.com>
Date:   Wed, 22 Sep 2021 14:40:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <57597778-836c-7bac-7f1d-bcdae0cd6ac4@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/21 12:32, Xiaoyao Li wrote:
>>
> 
> EXIT_REASON.bus_lock_detected may or may not be set when exit reason == 
> EXIT_REASON_BUS_LOCK. Intel will update ISE or SDM to state it.
> 
> Maybe we can do below in handle_bus_lock_vmexit handler:
> 
>      if (!to_vmx(vcpu)->exit_reason.bus_lock_detected)
>          to_vmx(vcpu)->exit_reason.bus_lock_detected = 1;
> 
> But is manually changing the hardware reported value for software 
> purpose a good thing?

No.  That said, Hao's patch is just making the code clearer; there's no 
behavioral change since the "if" will just redo the same assignments as 
handle_bus_lock_vmexit.

Paolo

