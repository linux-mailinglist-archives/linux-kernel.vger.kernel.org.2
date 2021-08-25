Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BF43F75CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbhHYNVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:21:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240596AbhHYNVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629897619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l7RnXeyDXUNqOanca08GVZWTu16JtRWGuCp6iwT4F8o=;
        b=Fw1SQGVu8EQL5StSuFzrkw63NypLg6pEDI7F/88n4aFVUtfFzSWgLJQHLNHAzN2xZctc5+
        oijnZq74tcTpGSYhgi5G8kxMC6O7FqYjyisii3U+l73HJcCEsoNqKVcU8TC1TJJ6PZh5Hn
        ImgqfUqbfWKlQJ6iKLkdu3fsXYhcefU=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-Ng_reZrnPBqzAxQFFBn1sw-1; Wed, 25 Aug 2021 09:20:16 -0400
X-MC-Unique: Ng_reZrnPBqzAxQFFBn1sw-1
Received: by mail-yb1-f200.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso23457031ybq.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7RnXeyDXUNqOanca08GVZWTu16JtRWGuCp6iwT4F8o=;
        b=YYNfPdcR9QC1YCN3R4fHN6aMNQqV7v6Wj99Zu8RW76XBzq3R2XkZTvSouWOCJ+IcfE
         Bd4W/XRwPDIdK+/x75rJzSqYmtwJzidC7Yx25FNGjjrbhRPhH9NX6sACi8rfJDHIZ/EA
         1AWnFKJdIueqZYs0dS4+wqrE8CjeErX0EDJ43AuG8oJHVs4Nlgz0Ue8mx0P9dUnuaKlN
         kNfb6cNKIIsCpo1NDmJeSPLdX1MKpU8bxeTYjA1vtHq7aSjlcXIdY5BCvQ5DKR/e7jBV
         pIMqDhePy65NS8YuiMB4jINF1BqcFaJEdiX8219onBZRRYndda1a2hvc96lwB2XuNyyK
         5BLw==
X-Gm-Message-State: AOAM530YdtXxElrSJx2CN9ov18u5z0j2J44UK5ei9T0zdNqyzEB4AJIz
        tkrSchu0IPNgnctMHi0W9V9LmP0vv8T2gbQ+OR4xzMH7M4VlXrlErI3syrvF7U+AdCgyXYM5Hqx
        MWCI8+RjkwF+K9a5l5lAE+cLIi3U7m32zAKWTeNGr
X-Received: by 2002:a25:7285:: with SMTP id n127mr41235976ybc.439.1629897615727;
        Wed, 25 Aug 2021 06:20:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGqXKNz3fOpeHZpr8tHWyotd/bySIIJ9NyVvcLPUFNJU5Qxl6KpIRHsJrLWvsy1sNnWdFZmu9M2h0Ze9QiqME=
X-Received: by 2002:a25:7285:: with SMTP id n127mr41235937ybc.439.1629897615427;
 Wed, 25 Aug 2021 06:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210823143028.649818-1-vkuznets@redhat.com> <20210823143028.649818-5-vkuznets@redhat.com>
 <20210823185841.ov7ejn2thwebcwqk@habkost.net> <87mtp7jowv.fsf@vitty.brq.redhat.com>
 <CAOpTY_ot8teH5x5vVS2HvuMx5LSKLPtyen_ZUM1p7ncci4LFbA@mail.gmail.com>
 <87k0kakip9.fsf@vitty.brq.redhat.com> <2df0b6d18115fb7f2701587b7937d8ddae38e36a.camel@redhat.com>
 <87h7fej5ov.fsf@vitty.brq.redhat.com> <36b6656637d1e6aaa2ab5098f7ebc27644466294.camel@redhat.com>
 <87bl5lkgfm.fsf@vitty.brq.redhat.com>
In-Reply-To: <87bl5lkgfm.fsf@vitty.brq.redhat.com>
From:   Eduardo Habkost <ehabkost@redhat.com>
Date:   Wed, 25 Aug 2021 09:19:59 -0400
Message-ID: <CAOpTY_q=0cuxXAToJrcqCRERY_sUSB1HNVBVNiEpH6Dsy0-+yA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] KVM: x86: Fix stack-out-of-bounds memory access
 from ioapic_write_indirect()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 5:43 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Maxim Levitsky <mlevitsk@redhat.com> writes:
>
> > On Wed, 2021-08-25 at 10:21 +0200, Vitaly Kuznetsov wrote:
> >> Maxim Levitsky <mlevitsk@redhat.com> writes:
> >>
> >> > On Tue, 2021-08-24 at 16:42 +0200, Vitaly Kuznetsov wrote:
> >> ...
> >> > Not a classical review but,
> >> > I did some digital archaeology with this one, trying to understand what is going on:
> >> >
> >> >
> >> > I think that 16 bit vcpu bitmap is due to the fact that IOAPIC spec states that
> >> > it can address up to 16 cpus in physical destination mode.
> >> >
> >> > In logical destination mode, assuming flat addressing and that logical id = 1 << physical id
> >> > which KVM hardcodes, it is also only possible to address 8 CPUs.
> >> >
> >> > However(!) in flat cluster mode, the logical apic id is split in two.
> >> > We have 16 clusters and each have 4 CPUs, so it is possible to address 64 CPUs,
> >> > and unlike the logical ID, the KVM does honour cluster ID,
> >> > thus one can stick say cluster ID 0 to any vCPU.
> >> >
> >> >
> >> > Let's look at ioapic_write_indirect.
> >> > It does:
> >> >
> >> >     -> bitmap_zero(&vcpu_bitmap, 16);
> >> >     -> kvm_bitmap_or_dest_vcpus(ioapic->kvm, &irq, &vcpu_bitmap);
> >> >     -> kvm_make_scan_ioapic_request_mask(ioapic->kvm, &vcpu_bitmap); // use of the above bitmap
> >> >
> >> >
> >> > When we call kvm_bitmap_or_dest_vcpus, we can already overflow the bitmap,
> >> > since we pass all 8 bit of the destination even when it is physical.
> >> >
> >> >
> >> > Lets examine the kvm_bitmap_or_dest_vcpus:
> >> >
> >> >   -> It calls the kvm_apic_map_get_dest_lapic which
> >> >
> >> >        -> for physical destinations, it just sets the bitmap, which can overflow
> >> >           if we pass it 8 bit destination (which basically includes reserved bits + 4 bit destination).
> >> >
> >> >
> >> >        -> For logical apic ID, it seems to truncate the result to 16 bit, which isn't correct as I explained
> >> >           above, but should not overflow the result.
> >> >
> >> >
> >> >    -> If call to kvm_apic_map_get_dest_lapic fails, it goes over all vcpus and tries to match the destination
> >> >        This can overflow as well.
> >> >
> >> >
> >> > I also don't like that ioapic_write_indirect calls the kvm_bitmap_or_dest_vcpus twice,
> >> > and second time with 'old_dest_id'
> >> >
> >> > I am not 100%  sure why old_dest_id/old_dest_mode are needed as I don't see anything in the
> >> > function changing them.
> >> > I think only the guest can change them, so maybe the code deals with the guest changing them
> >> > while the code is running from a different vcpu?
> >> >
> >> > The commit that introduced this code is 7ee30bc132c683d06a6d9e360e39e483e3990708
> >> > Nitesh Narayan Lal, maybe you remember something about it?
> >> >
> >>
> >> Before posting this patch I've contacted Nitesh privately, he's
> >> currently on vacation but will take a look when he gets back.
> >>
> >> > Also I worry a lot about other callers of kvm_apic_map_get_dest_lapic
> >> >
> >> > It is also called from kvm_irq_delivery_to_apic_fast, and from kvm_intr_is_single_vcpu_fast
> >> > and both seem to also use 'unsigned long' for bitmap, and then only use 16 bits of it.
> >> >
> >> > I haven't dug into them, but these don't seem to be IOAPIC related and I think
> >> > can overwrite the stack as well.
> >>
> >> I'm no expert in this code but when writing the patch I somehow
> >> convinced myself that a single unsigned long is always enough. I think
> >> that for cluster mode 'bitmap' needs 64-bits (and it is *not* a
> >> vcpu_bitmap, we need to convert). I may be completely wrong of course
> >> but in any case this is a different issue. In ioapic_write_indirect() we
> >> have 'vcpu_bitmap' which should certainly be longer than 64 bits.
> >
> >
> > This code which I mentioned in 'other callers' as far as I see is not IOAPIC related.
> > For regular local APIC all bets are off, any vCPU and apic ID are possible
> > (xapic I think limits apic id to 255 but x2apic doesn't).
> >
> > I strongly suspect that this code can overflow as well.
>
> I've probably missed something but I don't see how
> kvm_apic_map_get_dest_lapic() can set bits above 64 in 'bitmap'. If it
> can, then we have a problem indeed.

It would be nice if the compiler took care of validating bitmap sizes
for us. Shouldn't we make the function prototypes explicit about the
bitmap sizes they expect?

I believe some `typedef DECLARE_BITMAP(...)` or `typedef struct {
DECLARE_BITMAP(...) } ...` declarations would be very useful here.

-- 
Eduardo

