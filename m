Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E9338E87E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 16:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhEXOOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 10:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232486AbhEXOOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621865568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YuolNKAChmee9Jf+0VWBlg4DUVbOcHignWbWcealYiA=;
        b=Wr9+rZY0haqMTauJefBWqaFStiBM1Na5cCtnTFzQVZ3js8AeUOE/fCCGFEwCEnwDmjMRyw
        416ljVUclW+qqDZ1bfmzM9olTLyR7yUidEIzsTQWgJLje4VaLvvLrJIo0JOUgz+pV+oFCr
        iAox/S2WEozKQfTmnUicYuVuiX747do=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-Dak9Ja1jOFaxQKlFKfOmhA-1; Mon, 24 May 2021 10:12:46 -0400
X-MC-Unique: Dak9Ja1jOFaxQKlFKfOmhA-1
Received: by mail-wr1-f72.google.com with SMTP id i102-20020adf90ef0000b029010dfcfc46c0so13200156wri.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 07:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YuolNKAChmee9Jf+0VWBlg4DUVbOcHignWbWcealYiA=;
        b=RXsVy8Q4ht11O48b6CDbx/hjS1UuIJM6D0DzmSvdd69VTbrjrxI58z+Gg3HxAz4l7D
         s7jXYVPwD1N65zegBWODkTaod/7fQvRrHqr/oIMzbDt7fKNFTE/fddivkePsUPHT7zfk
         diISMWskLnhyAtO5SEf1iksxhhs8p5UzAgvcwOJTvimmibdXlwkQ+6OOl5K/uHBSFlSy
         jMnMEs4N8V4klRKD0GF6X8AI3Qeypttg+XF6fB0mgkPtkIjJz5GSXqLM844UuGYNV4We
         diVlQg3Fq/QWnr4bmzmZlS6AGoVQOGB4hlwvSgabOpS/jFJKUOzSnc1vKlLx8++uyo+Y
         hmcw==
X-Gm-Message-State: AOAM533HUYle+d5Sz8sSV4vG7AL/HVaPW9eTCOZPyjA79BCW277mNlKm
        ZIhcyTtSqa9ZO3TW1Tr0K3hnzHe4Rf8KUBKuT/SMQoEdRB6NZ4s4pe66yI0SZdPyuauQoENI2xF
        Ow0y+QyTrIwmEzvlh8H0lvOlHgijzl/0Gct0xUBfdTr7Azz/VZuk5IF1E8hg7CDTemrj2OP5Tu5
        ol
X-Received: by 2002:a7b:cb1a:: with SMTP id u26mr3107077wmj.125.1621865565273;
        Mon, 24 May 2021 07:12:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD/BIip0u5D6aGgEPMzrRFJXFZvyigKfUb5+MO/5Z1Q7Fui91N4UswBlkNcyzQrACC9tXQkg==
X-Received: by 2002:a7b:cb1a:: with SMTP id u26mr3107060wmj.125.1621865565105;
        Mon, 24 May 2021 07:12:45 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c64sm8206839wma.15.2021.05.24.07.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 07:12:44 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] KVM: nVMX: Ignore 'hv_clean_fields' data when
 eVMCS data is copied in vmx_get_nested_state()
In-Reply-To: <b79562d2-c517-b86c-8871-e8f81537f247@redhat.com>
References: <20210517135054.1914802-1-vkuznets@redhat.com>
 <20210517135054.1914802-4-vkuznets@redhat.com>
 <b79562d2-c517-b86c-8871-e8f81537f247@redhat.com>
Date:   Mon, 24 May 2021 16:12:43 +0200
Message-ID: <87o8d08bl0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 17/05/21 15:50, Vitaly Kuznetsov wrote:
>> 'Clean fields' data from enlightened VMCS is only valid upon vmentry: L1
>> hypervisor is not obliged to keep it up-to-date while it is mangling L2's
>> state, KVM_GET_NESTED_STATE request may come at a wrong moment when actual
>> eVMCS changes are unsynchronized with 'hv_clean_fields'. As upon migration
>> VMCS12 is used as a source of ultimate truth, we must make sure we pick all
>> the changes to eVMCS and thus 'clean fields' data must be ignored.
>
> While you're at it, would you mind making copy_vmcs12_to_enlightened and 
> copy_enlightened_to_vmcs12 void?
>

Sure, no problem.

-- 
Vitaly

