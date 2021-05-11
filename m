Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F0D379BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhEKBI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhEKBIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:08:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D16C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 18:07:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y26so20864678eds.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 18:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z0A7p7l5UlP8ih6gnzpDJkXYmkZR04hOiCwPZ3G9az8=;
        b=uNSvNZJ7I2aVfpuVnun3OImfHtqcBraJYnFx2nsnhRGMPyAzddwShYZHnuadmC6aIU
         nNUWuPVfJtb8RLVOV3qAVaSzECkFXifsQv/AyDgs9vCD6L5qlONknM7gqhrmPe64NU3H
         Vu7UEFN/qlbDfqNNeTyOmeRIb3jTtqZMGdweHDJWq1ex5XT0Snz+bPwGlz/3bt0seiT0
         rtnPut1QJxc1F2+w+ya2bNlsCyXQ8smids2fYh/4YGZQ+7E2TULcEkTqddHuXUgCgBqn
         HCN99OdaEvBRD9LFY0EtM75OlkIE8bmBQ372e0HpKHvPwTdFG9XDHl/JViawCgegLh8U
         Qhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0A7p7l5UlP8ih6gnzpDJkXYmkZR04hOiCwPZ3G9az8=;
        b=ila9gQ7LMnyvY+5nmvYV0owYPhPKGHxzd4anRJ/RjRBWTtHCIF3CXJ5MOPob4IxtAz
         8g2g4yNu57ePT5CNDCw38R/piYx45XHxITzgmy9A8ar4Zb5kQVzdyp3ecRkYvP6d/r6q
         oclWiyZhqPvGQYKlqawqSP1GYiEa7QdIIfqEq/AciNHo2DQcBIN1MTS1U7cWCZEA8MPG
         jD182YDED3U9mjiCtmX0nYj7xz5T+cw+hUKZKktiKmSmaaJiJJAh9bklJCyFFKRN/icT
         KduCB/KBIgsUSNnPUMNNNQv1OEcx+02Pq5gTbPCTevrAykG6yBEIREEGqZl2LFAgr/J3
         +pyw==
X-Gm-Message-State: AOAM5305/WxJs8MMVPMhhgbztR8EvcuM8WxB6/ZsGeaQNzmEUq8+JZ3j
        atVL0kbimq+IegjFNZFo0D19fLgUqczFWtnABBdP2w==
X-Google-Smtp-Source: ABdhPJxYbgRMZM0H/Wq57eZV/1LKPdxOJPhErfwz6aDX58ob9rzKsdOdOvKGYPeQl6GBbnbbziXAVRIxt/P+O5srP20=
X-Received: by 2002:a50:ff13:: with SMTP id a19mr32734675edu.300.1620695237437;
 Mon, 10 May 2021 18:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0e7e94d1ee4bae49dfd0dd441dc4f2ab6df76668.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jPLGs6p0PNZQB6yKB3QDtEcGb234zcgCbJutXxZZEGnA@mail.gmail.com>
 <e8ac31bc-e307-f277-f928-24ebba4cbca7@linux.intel.com> <CAPcyv4iuRdXooQvCzEWd9babzPij4nXpM-z5fai9+SGaeFYswQ@mail.gmail.com>
 <9f89a317-11fa-d784-87a8-37124891900c@linux.intel.com>
In-Reply-To: <9f89a317-11fa-d784-87a8-37124891900c@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 10 May 2021 18:07:06 -0700
Message-ID: <CAPcyv4hymb73WZ7QqNsDyKiPzsFdPJF63+MLnOTfJMsQBFvSDg@mail.gmail.com>
Subject: Re: [RFC v2 14/32] x86/tdx: Handle port I/O
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
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

On Mon, May 10, 2021 at 5:30 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
[..]
> It is mainly used by functions like __tdx_hypercall(),__tdx_hypercall_vendor_kvm()
> and tdx_in{b,w,l}.
>
> u64 __tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
>                      struct tdx_hypercall_output *out);
> u64 __tdx_hypercall_vendor_kvm(u64 fn, u64 r12, u64 r13, u64 r14,
>                                 u64 r15, struct tdx_hypercall_output *out);
>
> struct tdx_hypercall_output {
>          u64 r11;
>          u64 r12;
>          u64 r13;
>          u64 r14;
>          u64 r15;
> };

Why is this by register name and not something like:

struct tdx_hypercall_payload {
  u64 data[5];
};

...because the code in this patch is reading the payload out of a
stack relative offset, not r11.

>
>
> Functions like __tdx_hypercall() and __tdx_hypercall_vendor_kvm() are used
> by TDX guest to request services (like RDMSR, WRMSR,GetQuote, etc) from VMM
> using TDCALL instruction. do_tdx_hypercall() is the helper function (in
> tdcall.S) which actually implements this ABI.
>
> As per current ABI, VMM will use registers R11-R15 to share the output
> values with the guest.

Which ABI, __tdx_hypercall_vendor_kvm()? The code is putting the
payload on the stack, so I'm not sure what ABI you are referring to?


> So we have defined the structure
> struct tdx_hypercall_output to group all output registers and make it easier
> to share it with users of the TDCALLs. This is Linux defined structure.
>
> If there are any changes in TDCALL ABI for VMM, we might have to extend
> this structure to accommodate new output register changes.  So if we
> define TDVMCALL_OUTPUT_SIZE as 40, we will have modify this value for
> any future struct tdx_hypercall_output changes. So to avoid it, we have
> allocated double the size.
>
> May be I should define it as,
>
> #define TDVMCALL_OUTPUT_SIZE            sizeof(struct tdx_hypercall_output)

An arrangement like that seems more reasonable than a seemingly
arbitrary number and an ominous warning about things that may happen
in the future.
