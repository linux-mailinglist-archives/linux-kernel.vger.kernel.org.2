Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFF83A081F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhFIAJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhFIAJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:09:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26E2C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 17:07:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso304656pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 17:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GV9nzlHjuf7NCFb6LdJq8dcslquY+0P8BRy8EWccMJQ=;
        b=IvLhda9dAdPsWp2e1qg11jdD25V8E+CyAlL2atOWouCB3ilCZeJv4x3h00X4H3vcFL
         4VDBMfvZkRAFh790xsI7hLTynbi5imIUzIdKJhLQI6q/l1JRVLAA0nbr3VC1JF9OOJVG
         4I0ghW/qGrT4Mqx420+rS9UmNCWzr5f/+JKJ1v60DI6PkepbqBRQm4nKUKq/WVXWfVvz
         rT/N5C/tytroucQPSqkMp9hfiVa61caGujH0EmZMTRkGA32WTtKNDOYXZBfeKWb4enCW
         zV4WPQAAE2YVhiMYJIn4R3q2dAJNblcCJ8FprosYRdOxNLss0oUw6cgUTJojtDNNbQoj
         DVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GV9nzlHjuf7NCFb6LdJq8dcslquY+0P8BRy8EWccMJQ=;
        b=fJ/c8glVWIdMymSBD63Hm5Ib9AnbN2IjW9iR7FVBFctqZZMtg3OsF3mRbMhmkc9ga0
         hTqiWF37m4ZqQH6vnfFNMPZl1HZ+cNf70z+uIZzLp+PKf5hmgDZB4SN64B/2yFtmhiJB
         B2x74yix+CFXvF6+bZ3GpjvRRd5Vr7sULGsT0AgMq67tJ3wREYAZvwovZdTg0/lInmMP
         jXYykR4+Wvh+fVF+DeNrfSMV8acFvDi7DwKb7TZ4QOFcrWA3baO843OTAfvHjK609nMn
         wxZAi9ubHeQaYeepC1amFS9seAFGV+d5Su3ta7HiU48mE+1MMgTlzUCMB5nSXoDiQAAi
         Evqg==
X-Gm-Message-State: AOAM530gHqMAGMx3pB589oWZObUnEhFdrcLVfEFNIiB16r95N34qjtoB
        ItRqeN3m7CUo0GvmpgFpYwL8+bALAb92jc9891FrEg==
X-Google-Smtp-Source: ABdhPJwOwb7XuxqU5bkXCuzqJvxOAaOUMiuAxR4pVlLHyGgFzYHmtGhJx2qXkz+4gbtmvaw28Qehpx8wS6Xv0nYErpk=
X-Received: by 2002:a17:902:ed0c:b029:104:fb4b:453c with SMTP id
 b12-20020a170902ed0cb0290104fb4b453cmr2617099pld.27.1623197233127; Tue, 08
 Jun 2021 17:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4jQ=Fcga3jyUzthjPW9O962vhy3L5XUM6jqR5Z_Zq83LQ@mail.gmail.com>
 <20210608213527.739474-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4hoxc2+50EOFuq8NOa_CBFKX_A549Vw4U24V5SG25ftxQ@mail.gmail.com> <9d88cb37-f594-534a-ae2a-5a51f97db2a8@intel.com>
In-Reply-To: <9d88cb37-f594-534a-ae2a-5a51f97db2a8@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jun 2021 17:07:02 -0700
Message-ID: <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
Subject: Re: [RFC v2-fix-v3 1/1] x86/tdx: Skip WBINVD instruction for TDX guest
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 4:38 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/8/21 4:32 PM, Dan Williams wrote:
> >> Persistent memory is also currently not supported. Another code
> >> path that uses WBINVD is the MTRR driver, but EPT/virtualization
> >> always disables MTRRs so those are not needed. This all implies
> >> WBINVD is not needed with current TDX.
> > Let's drop the last three paragraphs and just say something like:
> > "This is one of a series of patches to usages of wbinvd for protected
> > guests. For now this just addresses the one known path that TDX
> > executes, ACPI reboot. Its usage can be elided because FOO reason and
> > all the other ACPI_FLUSH_CPU_CACHE usages can be elided because BAR
> > reason"
>
> A better effort at transparency can be made here:
>
>         This patches the one WBINVD instance which has been encountered
>         in practice: ACPI reboot.  Assume no other instance will be
>         encountered.
>

That works too, but I assume if ACPI_FLUSH_CPU_CACHE() itself is going
to be changed rather than sprinkling protected_guest_has() checks in a
few places it will need to assert why changing all of those at once is
correct. Otherwise I expect Rafael to ask why this global change of
the ACPI_FLUSH_CPU_CACHE() policy is ok.
