Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B7339CB5C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 23:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhFEV7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 17:59:23 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:54215 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhFEV7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 17:59:22 -0400
Received: by mail-pj1-f48.google.com with SMTP id ei4so7524630pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 14:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q92KLRBaN+TGTzRouKOXN6ZtVbUvC8kgL6nFwLg04f4=;
        b=C79Sx918BT0VxgYNOmAIbBgGT+WRWKqImgUdP1qP/y+wD30yeWQOGqMwQZerVCNSYc
         r26ivWz4RYQzOHmqW8/py+4MtR3bi21pvN6Gm6Ey24n+wBRjAC7l8xEIj1XbhUDTBFMK
         TwypVj+jBuSMkK+ATzl/fp2bUYAFQugbDkpb85itH2S+wylXBERyDeqYKz6L8fh9NRd9
         Ww/Qe14kZIjWo3dPlX34QnzDHKNtbhQJ3Phkz3eQ4LhgYYdVv+j0qRaLvDIonN+tygwS
         MpqBp2ZzG/mypSLsnntiAMmncx9DgOnmmIR8/LoemO/yGHloSKeh3rqTY6bs9Yb3yzZc
         9p9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q92KLRBaN+TGTzRouKOXN6ZtVbUvC8kgL6nFwLg04f4=;
        b=qXXS2THpDnlzal2u4RLxmJPlEd+Efk2NYUvOpU3Hdx1qr4XgWR+qmnr8/+hXE/h/Vf
         hpisOYf/T0lYD2WUDouZqJuBYYN6NPS6bqr6ZXHOwSB6oTK2CBGcohP4Tw3mK4Dqjlrf
         TpUJ0mTxEzs8vDFATaRWDxS+iPQSvpgi+N15y8L/WS5UzQejy4cK9flZWAvuW0fEI5kQ
         5AkvFwkWYvxfaF3fOHoGTy7iTdPKCwRwSrvGxUjAeY7NNVoIYlsJdI+QeeK18nNtCSfE
         1cl5xmxWl02xNFikXr/gAkoiNeisqy8jL8pIc80u98ZlDyhaAABHAgWNZ8fWl62rQr7C
         LByA==
X-Gm-Message-State: AOAM530swCHygVZwOCmKM2tm+cHIcGdJq6O5gWhkTHE/+gPiVZqlcTGX
        bBv5LWaOxuypua6We7xOPYCKeKP4+JJriog6UAcGjw==
X-Google-Smtp-Source: ABdhPJxYyUULKSZFmZJx8cSUjvLa9nYuGMrvs6fpGpdt+jLxXpF8RQmhiRE2dtCmc+ymwENzTs0UHiBjGtMG4CTKDFI=
X-Received: by 2002:a17:90a:414a:: with SMTP id m10mr23366177pjg.149.1622930193442;
 Sat, 05 Jun 2021 14:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210602194220.2227863-1-sathyanarayanan.kuppuswamy@linux.intel.com> <20210602194220.2227863-2-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210602194220.2227863-2-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 5 Jun 2021 14:56:22 -0700
Message-ID: <CAPcyv4jR4Ci=yKmCWk2toNFr-8NBy-MXfDYiH0Xmv9KFiBm2wQ@mail.gmail.com>
Subject: Re: [RFC v2-fix-v2 1/2] x86/sev-es: Abstract out MMIO instruction decoding
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 12:42 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>

Lead in with the what because I read 2 paragraphs to figure out that
this was a prep patch.

"In preparation for sharing MMIO instruction decode between SEV-ES and
TDX factor out the common decode into a new insn_decode_mmio()
helper."

> For regular virtual machine, MMIO is handled by the VMM: KVM
> emulates instruction that caused MMIO. But, this model doesn't
> work for a secure VMs (like SEV or TDX) as VMM doesn't have
> access to the guest memory and register state. VMM needs
> assistance in handling MMIO: it induces exception in the guest.
> Guest has to decode the instruction and handle it on its own.
>
> Instruction decoding logic is similar between AMD SEV and TDX
> code. So extract the decoding code to insn-eval.c where it can
> be used by both SEV and TDX.
>
> This code adds no functional changes. It is only build-tested
> for SEV.

The diff is such that I could not verify "no functional change" change
without doing more careful analysis. Typically with non-trivial
refactoring they are split out over a few patches with a final removal
of replaced infra at the end. This does the entire conversion all at
once.

How about an approach that has vc_handle_mmio() handle
MMIO_DECODE_FAILED for missing support in the common helper until the
final patch that can do:

> +       mmio = insn_decode_mmio(insn, &bytes);
> +       if (mmio == MMIO_DECODE_FAILED)
> +               return ES_DECODE_FAILED;

...i.e. insn_decode_mmio() is finally prepared to handle all scenarios
and vc_handle_mmio_twobyte_ops() can finally be deleted. This also
helps a future bisect that finds "whoops, 'no functional changes' was
incorrect".

>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Joerg Roedel <jroedel@suse.de>

Missing Sathya signed-off-by...
