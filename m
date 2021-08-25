Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2DD3F710B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 10:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbhHYIVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 04:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229780AbhHYIVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 04:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629879669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QW7PXYP8IfyOJUWBjxnrPNW0xt14Kogt0NQDd6gwJ6Y=;
        b=XlnuEwNvZHW032qxtb+h2BIUdgbag86M7xdpw1zFKBHjArOF+1smPdmrI3V7t7OdIet5Nq
        ldhfY1GS52j+TYxaffrC7vG+DQgNR9Sa325ZIOzG6ugGrISShNI6mHr08uLu9TbICJ/vXf
        aBoBi6hiovc7BgEB2TpyluZ6d8q/X0Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-FCBE1qOqNoKZzdIL8xL4Mw-1; Wed, 25 Aug 2021 04:21:07 -0400
X-MC-Unique: FCBE1qOqNoKZzdIL8xL4Mw-1
Received: by mail-wm1-f70.google.com with SMTP id y188-20020a1c7dc5000000b002e80e0b2f87so2527620wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 01:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=QW7PXYP8IfyOJUWBjxnrPNW0xt14Kogt0NQDd6gwJ6Y=;
        b=VHMwIjxEnpKQbvQYh/J3v5KRmmECdV/8E7V6GoTS3BrTfsTjiMBfucLN7MWoncGdVr
         RiXxM0Onc/jLJHcv76K/OmgCSHXl+/Z15j75642Nrc9pb32a0lO4puMPz+ozMVCPgJF1
         rC2T3ZWvGKC7cgK8a4xjEfyDLdKVo1Ts+Plwzt7Q5QYlVilfHpq6W0cCT+oSFwl6EQW5
         qHpcBcDnXYVdcRcfC79II6D0GkaAOsHvlaPShdMPGxMEXq4umHHPVbEGJqWejnbHiAkT
         K5cCMv5geycoFTTXIt85URDXDUmbex4rWzeQT0SgorDavHvZFUnU1bUZVxWWuP88F3Yz
         iRBw==
X-Gm-Message-State: AOAM530h8TI3MMeT3nbLN2g0mwUUdMCExQYcYevBu2R/fSuzFCepj9j9
        DHXgqPpS6nZe+jnD2uphr69gQSaCH2k/BIxaji0fWBAPnm95R0+VGkjAs0O32CK3zqIL59kn9kg
        eR8RIcajOfmBWmVfuBDo5n7JJ
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr8046417wmg.36.1629879666477;
        Wed, 25 Aug 2021 01:21:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTA19up2LH13aznsuiyStC+W/wWm3m+AvccbfYlcYYMsVuq7TaIZTrQj6ozbcDLZF+FTmrug==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr8046395wmg.36.1629879666254;
        Wed, 25 Aug 2021 01:21:06 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id d24sm4510653wmb.35.2021.08.25.01.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 01:21:05 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v2 4/4] KVM: x86: Fix stack-out-of-bounds memory access
 from ioapic_write_indirect()
In-Reply-To: <2df0b6d18115fb7f2701587b7937d8ddae38e36a.camel@redhat.com>
References: <20210823143028.649818-1-vkuznets@redhat.com>
 <20210823143028.649818-5-vkuznets@redhat.com>
 <20210823185841.ov7ejn2thwebcwqk@habkost.net>
 <87mtp7jowv.fsf@vitty.brq.redhat.com>
 <CAOpTY_ot8teH5x5vVS2HvuMx5LSKLPtyen_ZUM1p7ncci4LFbA@mail.gmail.com>
 <87k0kakip9.fsf@vitty.brq.redhat.com>
 <2df0b6d18115fb7f2701587b7937d8ddae38e36a.camel@redhat.com>
Date:   Wed, 25 Aug 2021 10:21:04 +0200
Message-ID: <87h7fej5ov.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Tue, 2021-08-24 at 16:42 +0200, Vitaly Kuznetsov wrote:
...
>
> Not a classical review but,
> I did some digital archaeology with this one, trying to understand what is going on:
>
>
> I think that 16 bit vcpu bitmap is due to the fact that IOAPIC spec states that
> it can address up to 16 cpus in physical destination mode.
>  
> In logical destination mode, assuming flat addressing and that logical id = 1 << physical id
> which KVM hardcodes, it is also only possible to address 8 CPUs.
>  
> However(!) in flat cluster mode, the logical apic id is split in two.
> We have 16 clusters and each have 4 CPUs, so it is possible to address 64 CPUs,
> and unlike the logical ID, the KVM does honour cluster ID, 
> thus one can stick say cluster ID 0 to any vCPU.
>  
>  
> Let's look at ioapic_write_indirect.
> It does:
>  
>     -> bitmap_zero(&vcpu_bitmap, 16);
>     -> kvm_bitmap_or_dest_vcpus(ioapic->kvm, &irq, &vcpu_bitmap);
>     -> kvm_make_scan_ioapic_request_mask(ioapic->kvm, &vcpu_bitmap); // use of the above bitmap
>  
>  
> When we call kvm_bitmap_or_dest_vcpus, we can already overflow the bitmap,
> since we pass all 8 bit of the destination even when it is physical.
>  
>  
> Lets examine the kvm_bitmap_or_dest_vcpus:
>  
>   -> It calls the kvm_apic_map_get_dest_lapic which 
>  
>        -> for physical destinations, it just sets the bitmap, which can overflow
>           if we pass it 8 bit destination (which basically includes reserved bits + 4 bit destination).
>  
>  
>        -> For logical apic ID, it seems to truncate the result to 16 bit, which isn't correct as I explained
>           above, but should not overflow the result.
>  
>   
>    -> If call to kvm_apic_map_get_dest_lapic fails, it goes over all vcpus and tries to match the destination
>        This can overflow as well.
>  
>  
> I also don't like that ioapic_write_indirect calls the kvm_bitmap_or_dest_vcpus twice,
> and second time with 'old_dest_id'
>  
> I am not 100%  sure why old_dest_id/old_dest_mode are needed as I don't see anything in the
> function changing them.
> I think only the guest can change them, so maybe the code deals with the guest changing them
> while the code is running from a different vcpu?
>  
> The commit that introduced this code is 7ee30bc132c683d06a6d9e360e39e483e3990708
> Nitesh Narayan Lal, maybe you remember something about it?
>  

Before posting this patch I've contacted Nitesh privately, he's
currently on vacation but will take a look when he gets back.

>
> Also I worry a lot about other callers of kvm_apic_map_get_dest_lapic
>  
> It is also called from kvm_irq_delivery_to_apic_fast, and from kvm_intr_is_single_vcpu_fast
> and both seem to also use 'unsigned long' for bitmap, and then only use 16 bits of it.
>  
> I haven't dug into them, but these don't seem to be IOAPIC related and I think
> can overwrite the stack as well.

I'm no expert in this code but when writing the patch I somehow
convinced myself that a single unsigned long is always enough. I think
that for cluster mode 'bitmap' needs 64-bits (and it is *not* a
vcpu_bitmap, we need to convert). I may be completely wrong of course
but in any case this is a different issue. In ioapic_write_indirect() we
have 'vcpu_bitmap' which should certainly be longer than 64 bits.

-- 
Vitaly

