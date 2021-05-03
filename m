Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F376F371ECF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhECRlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhECRlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:41:35 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88863C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 10:40:42 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y2so3223607plr.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 10:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=r5uCxLpw+/AkjOQHQeEq9LbJCvIa253YnVnEMRCu02Q=;
        b=tShQjFC7tZ4ELoIXJ0TtsljGOy6AOuB4G7DI3UdCZzL0r+rNt9hxfiFFXtnNOO3Rab
         abq5KKnZODK2SdyB5misltn3ozaHm/yghdRjigf3ME7FLOue6bQwVC3lKE/Tkk34PpI/
         HZJYDzUV/YzHUAfPzQTFvo+QsKoOtsem3xa5Uwq9f59IV63M/ocRyXS2OwJXzMG6c+3I
         uzZUO4Y5LXoo5kHJD0BbQ/VayfwXfhjzR5I+pqcfBU7d4Y71B2RpYrtsBdVMEj2tTVQl
         pgdWM3GLHcPhbIWJD7fQboPrIfA800sfeK9h91a9lShYphEr1klq2C2q6nLUoLM6rGYV
         Gu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=r5uCxLpw+/AkjOQHQeEq9LbJCvIa253YnVnEMRCu02Q=;
        b=AfShG5G0CHZRVCHfLwF+q1w5a2Joa3r35pQ59xsPXm/1922eVl8mtwmUW3JMgZQ3VJ
         sjZSkHYFMjBzz3usSx0/WxsAL0RQi5w11dMHqywQnSLjdSGycxgw5Px3J+5gVYcuKthH
         FV+Qoo21VLBThW71Y4RwgeOFUZpDowfttdHT9dxJEfnUBW3eqenarB5AdDKeSkhMMdJQ
         nnBIqivJr1A5I7EO2TztjsKgaZhH6lHb7U30oi2JwHy4YcdPQONcb/hrgSaVkpnvsazM
         8OGLk+cw0qI+kH4IYF2N7rhWL12DRWiatL+imYhLYtJwBTXFKshKqNCS884JX8grmjyA
         iyiw==
X-Gm-Message-State: AOAM531VplKy1H1S03VV06WcWIIxIe+EtJUrBsIJZwxYcbsNWVnNGGCR
        epRPiGGTz4yT7CKUJph3h+LASQ==
X-Google-Smtp-Source: ABdhPJw5H9WjXpUkII5g5Kord0HaCFb9TebqozV/X09QpJ2Qfhy8GgVblzViD1OT/3SIItmvKKDFkw==
X-Received: by 2002:a17:90a:3948:: with SMTP id n8mr23329212pjf.32.1620063641569;
        Mon, 03 May 2021 10:40:41 -0700 (PDT)
Received: from smtpclient.apple ([2600:1012:b045:bfcd:1901:995b:42d3:ee59])
        by smtp.gmail.com with ESMTPSA id w14sm9814220pff.94.2021.05.03.10.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 10:40:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH Part2 RFC v2 10/37] x86/fault: Add support to handle the RMP fault for kernel address
Date:   Mon, 3 May 2021 10:40:36 -0700
Message-Id: <40C2457E-C2A3-4DF7-BD16-829D927CC17C@amacapital.net>
References: <9e3e4331-2933-7ae6-31d9-5fb73fce4353@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, jroedel@suse.de,
        Thomas.Lendacky@amd.com, pbonzini@redhat.com, mingo@redhat.com,
        rientjes@google.com, seanjc@google.com, peterz@infradead.org,
        hpa@zytor.com, tony.luck@intel.com
In-Reply-To: <9e3e4331-2933-7ae6-31d9-5fb73fce4353@amd.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
X-Mailer: iPhone Mail (18E199)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 3, 2021, at 10:19 AM, Brijesh Singh <brijesh.singh@amd.com> wrote:
>=20
> =EF=BB=BF
>> On 5/3/21 11:15 AM, Dave Hansen wrote:
>>> On 5/3/21 8:37 AM, Brijesh Singh wrote:
>>> GHCB was just an example. Another example is a vfio driver accessing the=

>>> shared page. If those pages are not marked shared then kernel access
>>> will cause an RMP fault. Ideally we should not be running into this
>>> situation, but if we do, then I am trying to see how best we can avoid
>>> the host crashes.
>> I'm confused.  Are you suggesting that the VFIO driver could be passed
>> an address such that the host kernel would blindly try to write private
>> guest memory?
>=20
> Not blindly. But a guest could trick a VMM (qemu) to ask the host driver
> to access a GPA which is guest private page (Its a hypothetical case, so
> its possible that I may missing something). Let's see with an example:
>=20
> - A guest provides a GPA to VMM to write to (e.g DMA operation).
>=20
> - VMM translates the GPA->HVA and calls down to host kernel with the HVA.
>=20
> - The host kernel may pin the HVA to get the PFN for it and then kmap().
> Write to the mapped PFN will cause an RMP fault if the guest provided
> GPA was not a marked shared in the RMP table. In an ideal world, a guest
> should *never* do this but what if it does ?
>=20
>=20
>> The host kernel *knows* which memory is guest private and what is
>> shared.  It had to set it up in the first place.  It can also consult
>> the RMP at any time if it somehow forgot.
>>=20
>> So, this scenario seems to be that the host got a guest physical address
>> (gpa) from the guest, it did a gpa->hpa->hva conversion and then wrote
>> the page all without bothering to consult the RMP.  Shouldn't the the
>> gpa->hpa conversion point offer a perfect place to determine if the page
>> is shared or private?
>=20
> The GPA->HVA is typically done by the VMM, and HVA->HPA is done by the
> host drivers. So, only time we could verify is after the HVA->HPA. One
> of my patch provides a snp_lookup_page_in_rmptable() helper that can be
> used to query the page state in the RMP table. This means the all the
> host backend drivers need to enlightened to always read the RMP table
> before making a write access to guest provided GPA. A good guest should
> *never* be using a private page for the DMA operation and if it does
> then the fault handler introduced in this patch can avoid the host crash
> and eliminate the need to enlightened the drivers to check for the
> permission before the access.

Can we arrange for the page walk plus kmap process to fail?

>=20
> I felt it is good idea to have some kind of recovery specially when a
> malicious guest could lead us into this path.
>=20
>=20
>>=20
>>> Another reason for having this is to catch  the hypervisor bug, during
>>> the SNP guest create, the KVM allocates few backing pages and sets the
>>> assigned bit for it (the examples are VMSA, and firmware context page).
>>> If hypervisor accidentally free's these pages without clearing the
>>> assigned bit in the RMP table then it will result in RMP fault and thus
>>> a kernel crash.
>> I think I'd be just fine with a BUG_ON() in those cases instead of an
>> attempt to paper over the issue.  Kernel crashes are fine in the case of
>> kernel bugs.
>=20
> Yes, fine with me.
>=20
>=20
>>=20
>>>> Or, worst case, you could use exception tables and something like
>>>> copy_to_user() to write to the GHCB.  That way, the thread doing the
>>>> write can safely recover from the fault without the instruction actuall=
y
>>>> ever finishing execution.
>>>>=20
>>>> BTW, I went looking through the spec.  I didn't see anything about the
>>>> guest being able to write the "Assigned" RMP bit.  Did I miss that?
>>>> Which of the above three conditions is triggered by the guest failing t=
o
>>>> make the GHCB page shared?
>>> The GHCB spec section "Page State Change" provides an interface for the
>>> guest to request the page state change. During bootup, the guest uses
>>> the Page State Change VMGEXIT to request hypervisor to make the page
>>> shared. The hypervisor uses the RMPUPDATE instruction to write to
>>> "assigned" bit in the RMP table.
>> Right...  So the *HOST* is in control.  Why should the host ever be
>> surprised by a page transitioning from shared to private?
>=20
> I am trying is a cover a malicious guest cases. A good guest should
> follow the GHCB spec and change the page state before the access.
>=20
>>=20
>>> On VMGEXIT, the very first thing which vmgexit handler does is to map
>>> the GHCB page for the access and then later using the copy_to_user() to
>>> sync the GHCB updates from hypervisor to guest. The copy_to_user() will
>>> cause a RMP fault if the GHCB is not mapped shared. As I explained
>>> above, GHCB page was just an example, vfio or other may also get into
>>> this situation.
>> Causing an RMP fault is fine.  The problem is shoving a whole bunch of
>> *recovery* code in the kernel when recovery isn't necessary.  Just look
>> for the -EFAULT from copy_to_user() and move on with life.
