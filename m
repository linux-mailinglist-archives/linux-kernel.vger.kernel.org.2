Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BD53B8AED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 01:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbhF3XZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 19:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237921AbhF3XYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 19:24:52 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E89AC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 16:22:19 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id g5so7757392ybu.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 16:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lKl24N6sPsM4ASgBKdFjCfa0moU/cvzXMh2a1QKlpkU=;
        b=j3Ym/ZsVCZfTroeAxMj1erl4bKiNUsMgMrHh41T3GRd01qodxYgb+ozGru783rarNc
         HN9vFcEtg/j8Qyw3dSJ4JmylqQWxM+KAcz1Xk0SfKbj7uxg8feWEiuq9etNkZ7d2GkII
         WcRMN+2LnmTX7gEvy/qjktH9P4IjSWtxLzZpo62Bf2I9CYuoBIa+GP5gPIbl2FWAhQ/5
         cPkKgXc6c43U3hlCE2AwOX5K27BoxDgHmsnh1hINY604m9/c7nE1+w4DxvSnSZiWsjFN
         kYdWI7aFNBy2zyLAUjodFbxYY0We2lojoBByzmGSTslViJb/mUAaPKRKqycQ89nwzjCD
         e+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lKl24N6sPsM4ASgBKdFjCfa0moU/cvzXMh2a1QKlpkU=;
        b=NPIC5SG0ttnrsl5mYzh5HabeXkBd4uZSnwWmSwoOZ/M41wlAsPMH8qQu/PCMSYS9yy
         FL243P1cZw8baIDIP/vYzNmiEB5yy06swmwWVwST1xrAGn5MzSx2EyBiVr9BK2y4YO5E
         6lA/Ty4/qUwGvTJnHJK9VuSnSEozqm511lO/3NhGD2dxkLU9DzKE9hsaKlVLaOvOTgql
         ruHu1NP4Het/mLMMFzJjzgtQizxYjpRCjIN2DhG2EamFNfRiSTKEehNObUZXQlj6iYhm
         txCR/PFUZrkor0NPCVRUQNu29HUFlDZ8nQLjgi1W1iiUEabzL8KqNUce0NLa6YCeI9JE
         BQcQ==
X-Gm-Message-State: AOAM532J4ez+JM7cFMKeZ1zeJWD9J99jgGY7KRYr4Xu3LfReuJxVIc7i
        gRftX/PY98C3JE65dcqI/MdvkOHxpYCoOTiwy7iMljVQN+0=
X-Google-Smtp-Source: ABdhPJx2HpPKWhys+RUT9Mp3O3Y7o78tpme0ozncPoRZxyeqxcLvKmu4gkbgucX9dOTJ5RPdmfrwXigqFQGGV+KJ9uw=
X-Received: by 2002:a25:508e:: with SMTP id e136mr26513578ybb.275.1625095337836;
 Wed, 30 Jun 2021 16:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy Natarajan 
        <sathyanarayanan.nkuppuswamy@gmail.com>
Date:   Wed, 30 Jun 2021 16:22:06 -0700
Message-ID: <CAC41dw-ZUkLqNovzJ1=uJsdRoKY+bOfDYAyOW+sMGDFpkLo1Og@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Add TDX Guest Support (Initial support)
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi x86 maintainers,

On Fri, Jun 18, 2021 at 3:58 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi All,
>
> Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
> hosts and some physical attacks. This series adds the basic TDX guest
> infrastructure support (including #VE handler support, and #VE support
> for halt and CPUID). This is just a subset of patches in the bare minimum
> TDX support patch list which is required for supporting minimal
> functional TDX guest. Other basic feature features like #VE support for
> IO, MMIO, boot optimization fixes and shared-mm support will be submitted
> in a separate patch set. To make reviewing easier we split it into smalle=
r
> series. This series alone is not necessarily fully functional.
>
> Also, the host-side support patches, and support for advanced TD guest
> features like attestation or debug-mode will be submitted at a later time=
.
> Also, at this point it is not secure with some known holes in drivers, an=
d
> also hasn=E2=80=99t been fully audited and fuzzed yet.
>
> TDX has a lot of similarities to SEV. It enhances confidentiality and
> of guest memory and state (like registers) and includes a new exception
> (#VE) for the same basic reasons as SEV-ES. Like SEV-SNP (not merged
> yet), TDX limits the host's ability to effect changes in the guest
> physical address space. With TDX the host cannot access the guest memory,
> so various functionality that would normally be done in KVM has moved
> into a (paravirtualized) guest. Partially this is done using the
> Virtualization Exception (#VE) and partially with direct paravirtual hook=
s.
>
> The TDX architecture also includes a new CPU mode called
> Secure-Arbitration Mode (SEAM). The software (TDX module) running in this
> mode arbitrates interactions between host and guest and implements many o=
f
> the guarantees of the TDX architecture.
>
> Some of the key differences between TD and regular VM is,
>
> 1. Multi CPU bring-up is done using the ACPI MADT wake-up table.
> 2. A new #VE exception handler is added. The TDX module injects #VE excep=
tion
>    to the guest TD in cases of instructions that need to be emulated, dis=
allowed
>    MSR accesses, etc.
> 3. By default memory is marked as private, and TD will selectively share =
it with
>    VMM based on need.
>
> Note that the kernel will also need to be hardened against low level inpu=
ts from
> the now untrusted hosts. This will be done in follow on patches.
>
> You can find TDX related documents in the following link.
>
> https://software.intel.com/content/www/br/pt/develop/articles/intel-trust=
-domain-extensions.html
>
> Changes since v1 (v2 is partial set submission):
>  * Patch titled "x86/x86: Add early_is_tdx_guest() interface" is moved
>    out of this series.
>  * Rest of the change log is added per patch.

I have submitted the following list of TDX patch series 2-3 weeks back, and=
 so
far we only received feedback for a few patches in sets 1 and 4 (from Boris=
 &
Tom Lendacky). So, I was curious if you were planning on taking a look at
other sets of patch series in this submission or were waiting for new
revisions? Please let me know your comments.

sets 1-4 are core sets of patches that add TDX guest support.
set 4+ adds extra TDX features support.

Add TDX Guest Support (Initial support) [set 1] (currently v3 version)
 - https://lore.kernel.org/patchwork/project/lkml/list/?series=3D505232

Add TDX Guest Support (#VE handler support) [set 2] (currently v2 version)
 - https://lore.kernel.org/patchwork/project/lkml/list/?series=3D506230

Add TDX Guest Support (boot fixes) [set 3] (currently v2 version)
 - https://lore.kernel.org/patchwork/project/lkml/list/?series=3D506231

Add TDX Guest Support (shared-mm support) [set 4] (currently v2 version)
 - https://lore.kernel.org/patchwork/project/lkml/list/?series=3D506232

Add TDX Guest Support (Debug support) [set 5] (currently v1 version)
 - https://lore.kernel.org/patchwork/project/lkml/list/?series=3D506233

Add TDX Guest Support (Attestation support) [set 6] (currently v1 version)
 - https://lore.kernel.org/patchwork/project/lkml/list/?series=3D506234


--=20
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
