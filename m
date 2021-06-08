Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EFA39FC8A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhFHQ3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:29:35 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:37636 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhFHQ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:29:33 -0400
Received: by mail-pj1-f49.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so14401045pjs.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+sfGZQeQbtYdMrk29dEyePh2D+wRTJxj0sqHMA/znyg=;
        b=yc+6pOFmHqKH9buRub49eORug5GWzrWtHUaXJ0/5t3nvANNzNxpL7fva1+9HmAPN5h
         65/EziO6nBWFgblSN94H0KxHMAg7hU5ZPLXeeAEyayCl5QMR5mNLN4RbsRb/mtb7oxmM
         venAV2aOBPLXcz+W8XAOggKWe+LLusARkUgSrUF2DTPt0lZa/VDJ8At5MNznq7khA+q9
         CnEPosFT44b7+6lGpir/iani2FxTL3I0PNlZU/PMrZ8KBgElReQpN2XQNUcsINras9Sr
         XTotkbRGioImgyF4JhrAhWIaNDs5aB64Vpbs32a7SQKASf3v6gb/3MB18ZQo1a1GA8tP
         H/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sfGZQeQbtYdMrk29dEyePh2D+wRTJxj0sqHMA/znyg=;
        b=GYvmcyz2eG+rAzGPrgXVYSsaSF8XyiZz4NS2t1od5fUg1cWPqRhBYfA7Lh1SmIBKdG
         2nGPSxn3IJCphu8QqnuiN7YmwCSB/tEbsOfUWqRS+CLggsuuI71XrkVleSaeVSOtWZH6
         ZeA2oQD1Nnj9zrxLiBUOWcAEj+aLCOGvKakMWsG9TNc+4I68pHSn89ZLfPdree62I1Oe
         9KM0PK035d0NC69k9VpA/ixxRoDXKRNAOw/cJTXfIQMjb334lQFW9jEyqxq5tEzx6yUS
         A0aoRR3K5SEIGAh/VAv516L3eKH5JOZjIbjtaofZX8EvxL7Z0Nlzrv73rwO2fT++fqXu
         S87g==
X-Gm-Message-State: AOAM5303icwgPLCPwky+A84eQAo5jt1LY9JZ21EFQktoCwrqIXNwS1wd
        dMfV2ZI0UGUb/9XMX8rzBGSlrnBwRt07I43tzuE1HA==
X-Google-Smtp-Source: ABdhPJyfVWIKBSHYEaXRqO7T5xbD/InZER0oHdlrsFfWeHIc1o0FVEcQWleibxolfnCubchd17SGgKIW/sYeu4exHKo=
X-Received: by 2002:a17:902:820a:b029:10c:a12b:e524 with SMTP id
 x10-20020a170902820ab029010ca12be524mr746634pln.79.1623169600121; Tue, 08 Jun
 2021 09:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623165571.git.sathyanarayanan.kuppuswamy@linux.intel.com> <369a29afba9bb561afa1b77e113a9dae4921fe53.1623165571.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <369a29afba9bb561afa1b77e113a9dae4921fe53.1623165571.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jun 2021 09:26:29 -0700
Message-ID: <CAPcyv4hC=OCpgM5gWNHV3Z77zKH7Bh_vqvPAvD6246+J4c2ORA@mail.gmail.com>
Subject: Re: [RFC v2-fix-v2 3/3] x86/tdx: Handle port I/O
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

On Tue, Jun 8, 2021 at 8:40 AM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> TDX hypervisors cannot emulate instructions directly. This
> includes port IO which is normally emulated in the hypervisor.
> All port IO instructions inside TDX trigger the #VE exception
> in the guest and would be normally emulated there.
>
> Also string I/O is not supported in TDX guest. So, unroll the
> string I/O operation into a loop operating on one element at
> a time. This method is similar to AMD SEV, so just extend the
> support for TDX guest platform.
>
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
> Changes since RFC v2-fix-v1:
>  * Fixed commit log to adapt to decompression support code split.

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
