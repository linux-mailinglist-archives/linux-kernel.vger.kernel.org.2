Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78460362A86
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 23:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344514AbhDPVox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 17:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238469AbhDPVov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:44:51 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A747AC061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:44:25 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id x16so29126957iob.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gya0uGDA0BTi7a09+Rx8AXf5+gm+2mbaqlNfj7rDsCk=;
        b=djQDgKetOxkFVNC8IqsdRamVjJDX1GK5UIiT5fqduHdvAflwkIi7TyKSSlD5wxJZyw
         CtKeJfTRJ21x1lyVxpTLhSO6o81MrUvrHWdO2X8BMt2BYz52lGdPW/Ln5EtZ6QLYmM+f
         k7wkHR0LXfrUiCjntxjJMXPQ4oZfSTaELCxuYLKYoP9luzQNcUiChk18iAWToszsFcyn
         7vZzSSTI5oA1UoecgWStceLtG2ZYLrdxP1t53tysqMIxLEPjL5DjF7F03fA3xEy7hzMM
         Bubz4bgENF8lJN8aJmtNsDQFPfL9gEeTIDPly+1twZvS2enrZnCJXT4LO6uxO5FdA8s5
         y0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gya0uGDA0BTi7a09+Rx8AXf5+gm+2mbaqlNfj7rDsCk=;
        b=Ir+aW92ORvsPHTctP6Vv8EcH4rfw0AhMJy9TYkukbg5NNxwo2X9lrN72KtVQ4vuQJY
         L6Oq66pMSZjmMoP166t2kZWNg0BVhTGYHOs/KGzqdhpjnymCpphG3qgOXZOP3m1xpzG7
         1Qw9DRf0Er/D+dwQIcpw2FX+LJY4QDYU+tgPsyhTciXXLnkyghcQHXYiIHrmb9i6L7f0
         r5z0ZQxWYjhwPEOFB1iXY/tz7FQj43Imxxw+S9KfChS7UuVBPjoIvpQQ1o4/hvBi8UNV
         Exod+Q6grO0CwLlUnwUku6QK4ww3bGJtnHkwJgWBL2l3GTn3V7RGTw17xn2iv8extD3f
         l5Lg==
X-Gm-Message-State: AOAM531VI/l9nF03qqO22AH/WbTFFHDmfd643Lds5mUNPbhPlHebWqbC
        DhTkBxlg1dgt+KVqfNIoHqYra+bJBYJnIDoRk8AYog==
X-Google-Smtp-Source: ABdhPJw4z1JlRVq810x+cGKZCslt3RGfNYYHbRXWQZO2samxI/4DNYiFyPbVExShPNCpPXOQcI4mSAg9KD9sgdQ1w9s=
X-Received: by 2002:a6b:f111:: with SMTP id e17mr5202652iog.8.1618609464828;
 Fri, 16 Apr 2021 14:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1618498113.git.ashish.kalra@amd.com>
In-Reply-To: <cover.1618498113.git.ashish.kalra@amd.com>
From:   Steve Rutherford <srutherford@google.com>
Date:   Fri, 16 Apr 2021 14:43:48 -0700
Message-ID: <CABayD+dGWWha8opC7rFgNYs=bgWbohE+ngTRfKjw12fXrT+Q+g@mail.gmail.com>
Subject: Re: [PATCH v13 00/12] Add AMD SEV guest live migration support
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 8:52 AM Ashish Kalra <Ashish.Kalra@amd.com> wrote:
>
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> The series add support for AMD SEV guest live migration commands. To protect the
> confidentiality of an SEV protected guest memory while in transit we need to
> use the SEV commands defined in SEV API spec [1].
>
> SEV guest VMs have the concept of private and shared memory. Private memory
> is encrypted with the guest-specific key, while shared memory may be encrypted
> with hypervisor key. The commands provided by the SEV FW are meant to be used
> for the private memory only. The patch series introduces a new hypercall.
> The guest OS can use this hypercall to notify the page encryption status.
> If the page is encrypted with guest specific-key then we use SEV command during
> the migration. If page is not encrypted then fallback to default.
>
> The patch uses the KVM_EXIT_HYPERCALL exitcode and hypercall to
> userspace exit functionality as a common interface from the guest back to the
> VMM and passing on the guest shared/unencrypted page information to the
> userspace VMM/Qemu. Qemu can consult this information during migration to know
> whether the page is encrypted.
>
> This section descibes how the SEV live migration feature is negotiated
> between the host and guest, the host indicates this feature support via
> KVM_FEATURE_CPUID. The guest firmware (OVMF) detects this feature and
> sets a UEFI enviroment variable indicating OVMF support for live
> migration, the guest kernel also detects the host support for this
> feature via cpuid and in case of an EFI boot verifies if OVMF also
> supports this feature by getting the UEFI enviroment variable and if it
> set then enables live migration feature on host by writing to a custom
> MSR, if not booted under EFI, then it simply enables the feature by
> again writing to the custom MSR. The MSR is also handled by the
> userspace VMM/Qemu.
>
> A branch containing these patches is available here:
> https://github.com/AMDESE/linux/tree/sev-migration-v13
>
> [1] https://developer.amd.com/wp-content/resources/55766.PDF
>
> Changes since v12:
> - Reset page encryption status during early boot instead of just
>   before the kexec to avoid SMP races during kvm_pv_guest_cpu_reboot().

Does this series need to disable the MSR during kvm_pv_guest_cpu_reboot()?

I _think_ going into blackout during the window after restart, but
before the MSR is explicitly reenabled, would cause corruption. The
historical shared pages could be re-allocated as non-shared pages
during restart.

Steve
