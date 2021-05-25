Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9403838F859
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 04:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhEYCvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 22:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhEYCvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 22:51:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F84C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 19:49:45 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t9so7172773ply.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 19:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RjUxczq/nqMEjX9sdIWYG4HmaJBRApXr6SB13aFoV7Q=;
        b=hUnHt3EMFV79dKc63ygbkWS3Vr7duo0Ks9mqkX6rmAWlpDX5DV8akntFsTNdy1bkO+
         2rnH26tGYIpfrZvIdpnpSnu0Pn2+4Y3Dm26KpAvxT8/yECnnvtjIw1sc2/O3dWXXA4J7
         kS7DeQqQvD+xRHdnVvnZFTHDgKQqCSemKL0GpbkbxXB/G+Cg81P3Q5Z+DKAkaJR1M9Ez
         aa89a7X0PxISyCAfm+sJGY3TxbdAxc8NomOUeJbSv87z720OzAKE/Vkms1gOFmcp8Jg3
         S+IUFr98GaDYZxxtMxw5uvbTM/X88fE/4tlsTNzN8sdDeO6RkeG5atkFoFcxWbrpBKrz
         RG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RjUxczq/nqMEjX9sdIWYG4HmaJBRApXr6SB13aFoV7Q=;
        b=daeRten4yRnnDn7PRYFXvo/m7j0bD3apVPL1d2jYG/SU3couesk6F8ylH+l056Ibbc
         rNR6DIbGzfwWQ9fOa16qlZo2qO8P//e2rlrpoXOqqzlcOoK4hzAHRHCh1cgKGrlzmfCJ
         jsx1Eut57xMtJBPUtutrV9HgvqK8EzOahI4LysP10xBZ7xAD2K8aE3u2fxZAvySuDuVl
         /If4X/iE5DrW+LUk5Iqzvxdq0W1OsbOzxRN24xiGFU2PGoGw1Gl4+Xh+SRU9zByUkEoM
         uanlcGj34hbvsC57kifsTFndpZRJ17AwUvKCejtPUu+axotTaYoR1kezt0DPoIV6Ubc6
         7MFw==
X-Gm-Message-State: AOAM530IJQkHCa/3rDWLOepAQ9j0stdnmMH6f3rKGvZ6urigy2nXsMwC
        9bdSzJNaoEVFxrMXQYmbmI3bq4nwuC9BdzvvmL3Dug==
X-Google-Smtp-Source: ABdhPJzo8i/d6XE2QJ9mfBLZIegf1LLnapT9V9X3OH4MZMo3N3tWPOyjO9Se4+SiR2er216ep/PJN2wPGhnBBemx+s0=
X-Received: by 2002:a17:90a:2f06:: with SMTP id s6mr2350165pjd.168.1621910984842;
 Mon, 24 May 2021 19:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <37ad50ca-f568-4c62-56e2-9e9b1f34084c@linux.intel.com>
 <20210524233211.802033-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210524233211.802033-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jKY0rmewFnyL6My5-b+w8ANAwDY2tLXZk4CYKydoVbtg@mail.gmail.com>
 <b420a7af-5202-fee9-9e0b-39680d0cc9c8@linux.intel.com> <CAPcyv4gNz9gKsHVcindp3OsHz4hMRWPZgsNu1A5xrDQg7tYqNA@mail.gmail.com>
 <cea7c704-5f1c-3f84-e47b-c62da18e358e@linux.intel.com> <CAPcyv4h4=eNZFS7d13WvzpWzTkHAMF7Mxo0frqf2gdmaFN3++Q@mail.gmail.com>
 <125f8362-b1e3-d304-f943-3fc2f07b5d79@linux.intel.com>
In-Reply-To: <125f8362-b1e3-d304-f943-3fc2f07b5d79@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 24 May 2021 19:49:38 -0700
Message-ID: <CAPcyv4gRDnm0y4=RWhvTSoY2sk=BOyeDDNcCifZD=opyJf05LQ@mail.gmail.com>
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

On Mon, May 24, 2021 at 7:13 PM Andi Kleen <ak@linux.intel.com> wrote:
[..]
> > ...to explicitly error out a wbinvd use case before data is altered
> > and wbinvd is needed.
>
> I don't see any point of all of this. We really just want to be the same
> as KVM. Not get into the business of patching a bazillion sub systems
> that cannot be used in TDX anyways.

Please let's not start this patch off with dubious claims of safety
afforded by IgnorePAT. Instead make the true argument that wbinvd is
known to be problematic in guests and for that reason many bare metal
use cases that require wbinvd have not been ported to guests (like
PMEM unlock), and others that only use wbinvd to opportunistically
enforce a cache state (like ACPI sleep states) do not see ill effects
from missing wbinvd. Given KVM ships with a policy to elide wbinvd in
many scenarios adopt the same policy for TDX guests.
