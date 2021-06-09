Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664703A1F1C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFIVlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:41:37 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:35531 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhFIVld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:41:33 -0400
Received: by mail-ot1-f52.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so25474172otg.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 14:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5k8vn+rwyY8CVPFTxUS93yHoMkcoR1Qk+6hMUJrS458=;
        b=DvCE+bt+2SFBpEEqSVoxFeQdG4NT1jqDabvNdb6YYCb6mGbpHjrVN/nehVrTpJxmD5
         aajvqjMhpLeq3bNOQcwKDNIw5F/6XIA84x21hCeNhDy6GvKkjsnvoXMOp2Nk7/Lwu4yO
         IOtyBCGhZ7Urq3Plk1sD9fiXOvTQsIKn0AeFjrsY0B/H72HTK6awzdEp8fzHaAQXZuhg
         HvFuhoZ94NgT77jdJZQY69sDIIdxEgX98TfP/qvuh8WGNuFC8fm+t+N+JLv6rjhxnUfc
         vNMp5BY5b4hi+0fb6Ktj4Xte7ojXZT9ahoe5mmOv1xQ+7jRFUuST72i02i6SSPY+46bP
         qC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5k8vn+rwyY8CVPFTxUS93yHoMkcoR1Qk+6hMUJrS458=;
        b=R3AP2cAH5/tunDwHUd45gorpDJE0r4HBPUcjUt34uCk8d4opRar8hfLGFQGU6Wf5dV
         f5q0gwxVfbi9a8gRcjLAXYwd5KsQeqZZ+otRlRUjoEyA+DOgT4r3Q+gwJnSYa48Lltdp
         nipFdc+X+VbDcEJvFe8TFsorhgYLMd0sCdA8NwbTpAyhjTbzcOe1p71+Hwy7Jce2aNjR
         Vn2tyD//my7SuAVmnzI/8z6Ijj+iW+yFr7+o1rb3c8bn2z8mtAWOihvtrQa1EWM/QbR9
         PsTPP0UOS9Q2ztCGHVJBdEpjW96MbJsVkvTFwTkEQWewXU1abClSyF8v72CQ5CGMT78A
         fQEw==
X-Gm-Message-State: AOAM533zN5DuGw15P6mL3VDTTE0BiM6dZ94+VjVY3dktmJ43cSleQtMQ
        QvCh4RxH8VntrzwN9HJ6QaXAEsyAOkWpi9BzJV6LVw==
X-Google-Smtp-Source: ABdhPJzDh8hU7o/wmNZp0Z7zoKvbDvMacY6BoXb+u0QhdoWgNyasjZ/amkmorZnRSdGDfR75ZU4alb30y/HmFYF/jAM=
X-Received: by 2002:a9d:748d:: with SMTP id t13mr1286459otk.6.1623274717780;
 Wed, 09 Jun 2021 14:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <973add45-9fd2-7abc-3a97-96a26c263ea0@linux.intel.com>
 <20210609194926.1949859-1-sathyanarayanan.kuppuswamy@linux.intel.com> <7c06b567-9a65-8c7c-6046-3dcb32d4bb15@intel.com>
In-Reply-To: <7c06b567-9a65-8c7c-6046-3dcb32d4bb15@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Jun 2021 14:38:26 -0700
Message-ID: <CAPcyv4ismoYra_8=Qj=XLLs9+18tRiv8Y48GJWOAHvpzi3BZiw@mail.gmail.com>
Subject: Re: [RFC v2-fix-v5 1/1] x86: Skip WBINVD instruction for VM guest
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
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

On Wed, Jun 9, 2021 at 2:03 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> This changelog lacks both clear problem statements and a clear solution
> implemented within the patch.
>
> Here's a proposed changelog.  It clearly spells out the two problems
> caused by WBINVD within a guest, and the proposed solution which fixes
> those two problems.

Looks good to me modulo the comment below...

>
> Is this missing anything?
>
> --
>
> VM guests that support ACPI use standard ACPI mechanisms to signal sleep
> state entry to the host.  To ACPI, reboot is simply another sleep state.
>
> ACPI specifies that the platform preserve memory contents over (some)
> sleep states.  It does not specify any requirements for data
> preservation in CPU caches.  The ACPI specification mandates the use of
> WBINVD to flush the contents of the CPU caches to memory before entering
> specific sleep states, thus ensuring data in caches can survive sleep
> state transitions.e
>
> Unlike when entering sleep states bare metal, no actions within a guest
> can cause data in processor caches to be lost.  That makes these WBINVD
> invocations harmless but superfluous within a guest. (<--- problem #1)
>
> In TDX guests, these WBINVD operations cause #VE exceptions.  For debug,
> it would be ideal for the #VE handler to be able to WARN() when an
> unexpected WBINVD occurs. (<--- problem #2)

...but it doesn't WARN() it triggers unhandled #VE, unless I missed
another patch that precedes this that turns it into a WARN()? If a
code path expects WBINVD for correct operation and the guest can't
execute that sounds fatal, not a WARN to me.

> Avoid WBINVD for all ACPI cache-flushing operations which occur while
> running under a hypervisor, which includes TDX guests.  This both avoids
> TDX warnings and optimizes away superfluous WBINVD invocations. (<----
> solution)
>
