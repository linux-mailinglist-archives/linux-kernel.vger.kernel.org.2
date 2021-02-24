Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9997D324031
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbhBXOlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbhBXNcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:32:25 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C3BC061797
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:30:26 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v21so1791418wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dme-org.20150623.gappssmtp.com; s=20150623;
        h=to:cc:subject:in-reply-to:references:from:date:message-id
         :mime-version;
        bh=ES8CxboQIz6AjW5CHFU/CWTM4pBsOa7xcnXnVMVbXkU=;
        b=M9MugLXrFlb6ovZc+2MkUMDKnZIFGwzVaJMCZC8H15KQhB9QTv07B/4l6aOOaCRGsY
         jmo8+QwH/mj3P46D6nrpIu4fM/KC6W2DiQL4XyK27Joxs8MJ36ZzrU3rU38hbEGJqq3p
         my4lrImakbrPn8uVVZyohRZq+G64YLIB4aprKOocEfDS1kI+rXT4UYJZBjN/Y651AUke
         cjYyW4wE+vt3GLUeR18tECJsqU3WTl8wzUsZDZlOcF5squqZrBkU+evkXGJZxiKO2pjp
         xdI3KpG21qEz35nOVlONTAHISx0CzCuCCbbDEbR/3jnKhMOu8fLAj2UgLWU3Jpi9ERYs
         d1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
         :message-id:mime-version;
        bh=ES8CxboQIz6AjW5CHFU/CWTM4pBsOa7xcnXnVMVbXkU=;
        b=B33lspvLHVrcaobwHzVdpvwIS2SL8gwsuBZD7OluK1uo/AK2i1Upe4uV2ml499Y5Nb
         eE8659X4nqFe57f8A/M5yYY3aTqJs2PkhFSz2UJ61aWEngmLeUfDrENpQFsqU6X6qFD6
         fJS0AluZF8wwX5rFPDYRELc3fwpTY84r2l3g6coMS0m+Z44TPzePLOSViLflZeElMkcr
         YQcUrft+Q1zJQWyCdsJN7LYqFVeq0Hv4GQf62Xk2Hrwi2QjbdpddDaOtEB6HG53G+f4R
         W6FS1i9TrAUPMeGyKrpqVmeHI2Ij4eDPqGh5FYyzsnEi+geceLc8ZIPqXcgRNX2LXqeq
         QaiQ==
X-Gm-Message-State: AOAM533gGFtQPE4FeO453Ca7Ca+sa2i3mgGWNGGD8w91Tl2i3PkmhAgA
        mgNmYiYtWdBi+1lhYyCXXgD/UA==
X-Google-Smtp-Source: ABdhPJy7QgdrOQ3ILS2wBu6KOoHtnzv5EMq+MxCuh453z4TPTFMNPwoKeG5PVUf74ZcPeJs17jIllg==
X-Received: by 2002:a7b:c5d0:: with SMTP id n16mr3762898wmk.27.1614173425170;
        Wed, 24 Feb 2021 05:30:25 -0800 (PST)
Received: from disaster-area.hh.sledj.net (disaster-area.hh.sledj.net. [2001:8b0:bb71:7140:64::1])
        by smtp.gmail.com with ESMTPSA id h12sm4575853wru.18.2021.02.24.05.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 05:30:24 -0800 (PST)
Received: from localhost (disaster-area.hh.sledj.net [local])
        by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 8d0efa31;
        Wed, 24 Feb 2021 13:30:23 +0000 (UTC)
To:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: dump_vmcs should not assume
 GUEST_IA32_EFER is valid
In-Reply-To: <CALMp9eQ5HQqRRBu0HJbuTOJwKSUA950JWSHrLkXz7cHWKt+ymg@mail.gmail.com>
References: <20210219144632.2288189-1-david.edmondson@oracle.com>
 <20210219144632.2288189-2-david.edmondson@oracle.com>
 <YDWG51Io0VJEBHGg@google.com>
 <CALMp9eQ5HQqRRBu0HJbuTOJwKSUA950JWSHrLkXz7cHWKt+ymg@mail.gmail.com>
X-HGTTG: heart-of-gold
From:   David Edmondson <dme@dme.org>
Date:   Wed, 24 Feb 2021 13:30:23 +0000
Message-ID: <m235xlfv9s.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 2021-02-23 at 15:13:54 -08, Jim Mattson wrote:

> On Tue, Feb 23, 2021 at 2:51 PM Sean Christopherson <seanjc@google.com> wrote:
>>
>> On Fri, Feb 19, 2021, David Edmondson wrote:
>> > If the VM entry/exit controls for loading/saving MSR_EFER are either
>> > not available (an older processor or explicitly disabled) or not
>> > used (host and guest values are the same), reading GUEST_IA32_EFER
>> > from the VMCS returns an inaccurate value.
>> >
>> > Because of this, in dump_vmcs() don't use GUEST_IA32_EFER to decide
>> > whether to print the PDPTRs - do so if the EPT is in use and CR4.PAE
>> > is set.
>>
>> This isn't necessarily correct either.  In a way, it's less correct as PDPTRs
>> are more likely to be printed when they shouldn't, assuming most guests are
>> 64-bit guests.  It's annoying to calculate the effective guest EFER, but so
>> awful that it's worth risking confusion over PDTPRs.
>
> I still prefer a dump_vmcs that always dumps every VMCS field.

v3 now always shows the PDPTRs if they exist.

dme.
-- 
I've got a little black book with my poems in.
