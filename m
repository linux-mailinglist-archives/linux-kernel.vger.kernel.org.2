Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6695431A5F2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhBLUUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhBLUUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:20:53 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A9BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:20:13 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l18so276603pji.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=8FRSOnqUpUq7EuOD8xnnTKHw7l2Js1Dkk8XYGKAJmDw=;
        b=NlwKSi9RVtFUyPntoS2LpRNEJRTGNDQRRE+SKH3sylayWFpf2ZJOA26tLIPPMAsM4X
         S5u4S5nW2IOBHWaUQYLLoO4Ih+zNZj3Kv1zxPL8LvX4B4KPRY/q9y6Su+6Yn10MzclKf
         8NYIm3Rfmxm7MR1cLwGR5k6BrwcA27+buoC2UPSzyWdO5/89J6hSdgRJI8gQ0yiLSR5z
         qez3o1BJAI29CzkraFdg09WtPgfsNhNJnww+BrNCr3r4j4P6fc50YG9UglnQrbQB8HKY
         zUeVWG+k4QQazyGypIEk6C0uSXv1vv4DulB4jUNMj9rWL+c0ooDQ8MLIAWPw/fYNXdwM
         gMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=8FRSOnqUpUq7EuOD8xnnTKHw7l2Js1Dkk8XYGKAJmDw=;
        b=JCk6yGuUvLSfAejOKBZsvDtV+CEiKBDSQgakwaDDlUAJwL9xNzKzgaDfs7/0n4pADH
         b+ZxGGJbcy70MaKAcUZ8vSSX1xXPfpSbmK8/93nOS5THjNdOwZ9jgfiQjrxm6Piwqnbi
         0QZkfAgSb1LFyZnaMyh+LKZRZtaE4bO2yjwDJ+rd+qtkQcUIz9j9qMoek7429Qk37xLE
         YbtdhF4CyOrZcZnFH8fFty4LN2bcsRvF0WFY2GFlRPKRGKXvCdzrPhFd0xBobfXZOas0
         OXWpx+KQVNZaP2wjdj7nVygI9M01ivBUAPsTMXO2SXNgH+OnwoRLeZ2F2zNvvzOU9lyN
         mq3Q==
X-Gm-Message-State: AOAM532HwXluT8mbBp0g0qqzdCMHAV7BIP9EzX9XNM9Fq9qPUe4DlHQ6
        OUn68gGsQk57cn1Q9TqLzd2PEg==
X-Google-Smtp-Source: ABdhPJzc5sKW2uPXs5DKZpJTr9R5AyhaDZ33zeskLY2YIyK3TqpKwbYZ7REPKbUrbCbGIgud2n39dg==
X-Received: by 2002:a17:902:6808:b029:e2:b405:fc0d with SMTP id h8-20020a1709026808b02900e2b405fc0dmr4231748plk.10.1613161212845;
        Fri, 12 Feb 2021 12:20:12 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:70f0:3400:772e:fd77? ([2601:646:c200:1ef2:70f0:3400:772e:fd77])
        by smtp.gmail.com with ESMTPSA id j9sm10495997pgb.47.2021.02.12.12.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 12:20:12 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC v1 05/26] x86/traps: Add #VE support for TDX guest
Date:   Fri, 12 Feb 2021 12:20:11 -0800
Message-Id: <A06CFC3D-53A8-45C1-9580-8459585F458E@amacapital.net>
References: <YCbfyde9jl7ti0Oz@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
In-Reply-To: <YCbfyde9jl7ti0Oz@google.com>
To:     Sean Christopherson <seanjc@google.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 12, 2021, at 12:06 PM, Sean Christopherson <seanjc@google.com> wrot=
e:
>=20
> =EF=BB=BFOn Fri, Feb 12, 2021, Andy Lutomirski wrote:
>>> On Fri, Feb 5, 2021 at 3:39 PM Kuppuswamy Sathyanarayanan
>>> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>>=20
>>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>>=20
>>> The TDX module injects #VE exception to the guest TD in cases of
>>> disallowed instructions, disallowed MSR accesses and subset of CPUID
>>> leaves. Also, it's theoretically possible for CPU to inject #VE
>>> exception on EPT violation, but the TDX module makes sure this does
>>> not happen, as long as all memory used is properly accepted using
>>> TDCALLs.
>>=20
>> By my very cursory reading of the TDX arch specification 9.8.2,
>> "Secure" EPT violations don't send #VE.  But the docs are quite
>> unclear, or at least the docs I found are.
>=20
> The version I have also states that SUPPRESS_VE is always set.  So either t=
here
> was a change in direction, or the public docs need to be updated.  Lazy ac=
cept
> requires a #VE, either from hardware or from the module.  The latter would=

> require walking the Secure EPT tables on every EPT violation...
>=20
>> What happens if the guest attempts to access a secure GPA that is not
>> ACCEPTed?  For example, suppose the VMM does THH.MEM.PAGE.REMOVE on a sec=
ure
>> address and the guest accesses it, via instruction fetch or data access.
>> What happens?
>=20
> Well, as currently written in the spec, it will generate an EPT violation a=
nd
> the host will have no choice but to kill the guest.

Or page the page back in and try again?

In regular virt guests, if the host pages out a guest page, it=E2=80=99s the=
 host=E2=80=99s job to put it back when needed. In paravirt, a well designed=
 async of protocol can sometimes let the guest to useful work when this happ=
ens. If a guest (or bare metal) has its memory hot removed (via balloon or w=
hatever) and the kernel messes up and accesses removed memory, the guest (or=
 bare metal) is toast.

I don=E2=80=99t see why TDX needs to be any different.=
