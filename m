Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64C638F7AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 03:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhEYBrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 21:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhEYBrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 21:47:06 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB745C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 18:45:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p39so5996315pfw.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 18:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iXZ0+9ETp1B7CFCQZVO5oz6Pwzaz12W4xSxYSe2CX2g=;
        b=BPR/REaLxN75GNL8EQhOAMzv/t8gccNmT+pYCgFcPaf5KjWb5ZUOVbjew74hYw6YTh
         BYyM12Fct5J41cn/B2jYtn9R05rx7Pfq759bKPcCBnSZWuVbFLoViSWBgjclkWhkgzIi
         Di8feHkoaMsCwJ1cjfp2SWWYv7+Ll+NpNdPCCMqwv/4XbJry1z+pXLRdUnhM5spJR0st
         W31jvj5eSPCHpUsH2MAlILJGggzKWZwV13Dj0LJkEqpxo0fA5JK4a3baB92I06vXoJX4
         ots175BWdkSpPNJl/6DVjgPvbbUi3kAB0dkMtPnpQU/DOkCgux/vVGjqB2a0uL6a02vy
         H+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXZ0+9ETp1B7CFCQZVO5oz6Pwzaz12W4xSxYSe2CX2g=;
        b=R9UhIY+oLCHgpM9mwYzkBT10nqFUcdlSRbakA7ulUPJV/PFoOivBMYMWDZSoBPrtrW
         D/tsiD6yb0NrkxDlGpX19PaAg/rrgkVlQ7DvWoRlDa8BtRBI3wXN8ot501NPUXp0KfRW
         7/FHKQQRnXJhkNJSDLIw57CZn/EOVUkF+2w/hfowssQgaonb14oKikQ2jyyYoPf2Pb/x
         TU1euJWSSA0IcP5/5e5k1RUMGC4svWFDCs46OH8ypX0INM86BeM9ncVftRtKXN9wgp1E
         mJ3okLYxRDbtD5jNxTLsBO5g+m52PV49AKMHpnkrF9kDoRJjJCDKEl81Oa0leJgIA7rA
         5qRw==
X-Gm-Message-State: AOAM532Px28VSGsyPLjF14nT8rJSTNAYneat0uud79+76HHDEKoXFRbG
        DCj5O150OcVoObULG2E3IcsplQx6qq2IMlHYFpFc6Q==
X-Google-Smtp-Source: ABdhPJww/1ehWtjUv80BtzPOj1+7/CHScFxdIXI8PDYm4TxspBkbgveSZtyI8r+QjI/wKADJhCou5lvhdBrF4BeQCzc=
X-Received: by 2002:a63:4b43:: with SMTP id k3mr16442804pgl.450.1621907137243;
 Mon, 24 May 2021 18:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <37ad50ca-f568-4c62-56e2-9e9b1f34084c@linux.intel.com>
 <20210524233211.802033-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210524233211.802033-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jKY0rmewFnyL6My5-b+w8ANAwDY2tLXZk4CYKydoVbtg@mail.gmail.com>
 <b420a7af-5202-fee9-9e0b-39680d0cc9c8@linux.intel.com> <CAPcyv4gNz9gKsHVcindp3OsHz4hMRWPZgsNu1A5xrDQg7tYqNA@mail.gmail.com>
 <cea7c704-5f1c-3f84-e47b-c62da18e358e@linux.intel.com>
In-Reply-To: <cea7c704-5f1c-3f84-e47b-c62da18e358e@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 24 May 2021 18:45:30 -0700
Message-ID: <CAPcyv4h4=eNZFS7d13WvzpWzTkHAMF7Mxo0frqf2gdmaFN3++Q@mail.gmail.com>
Subject: Re: [RFC v2-fix-v2 2/2] x86/tdx: Ignore WBINVD instruction for TDX guest
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 6:02 PM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> > That makes KVM also broken for the cases where wbinvd is needed,
>
>
> Or maybe your analysis is wrong?

I'm well aware of the fact that wbinvd is problematic for hypervisors
and is an attack vector for a guest to DOS the host.

>
>
> > but
> > it does not make the description of this patch correct.
>
> If KVM was broken I'm sure we would hear about it.

KVM does not try to support the cases where wbinvd being unavailable
would break the system. That is not the claim being made in this
patch.

> The ACPI cases are for S3, which is not supported in guests, or for the
> old style manual IO port C6, which isn't supported either.

> The persistent memory cases would require working DMA mappings,

No, that analysis is wrong.The wbinvd audit would have found that
persistent memory secure-erase and unlock, which has nothing to do
with DMA, needs wbinvd to ensure that the CPU has not retained a copy
of the PMEM contents from before the unlock happened and it needs to
make sure that any data that was meant to be destroyed by an erasure
is not retained in cache.

> which we
> currently don't support. If DMA mappings were added we would need to
> para virtualized WBINVD, like the comments say.
>
> AFAIK all the rest is for some caching attribute change, which is not
> possible in KVM (because it uses EPT.IgnorePAT=1) nor in TDX (which does
> the same). Some are for MTRR which is completely disabled if you're
> running under EPT.

It's fine to not support the above cases, I am asking for the
explanation to demonstrate the known risks and the known mitigations.
IgnorePAT is not the mitigation, the mitigation is an audit to
describe why the known users are unlikely to be triggered. Even better
would be an addition patch that does something like:

iff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 4b80150e4afa..a6b13a1ae319 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -170,6 +170,9 @@ static int __nvdimm_security_unlock(struct nvdimm *nvdimm)
        const void *data;
        int rc;

+       if (is_protected_guest())
+               return -ENXIO;
+
        /* The bus lock should be held at the top level of the call stack */
        lockdep_assert_held(&nvdimm_bus->reconfig_mutex);

...to explicitly error out a wbinvd use case before data is altered
and wbinvd is needed.
