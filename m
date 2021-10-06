Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30259423EB1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbhJFN0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbhJFNZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:25:40 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3A3C061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 06:23:34 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id l8-20020a4ae2c8000000b002b5ec765d9fso812755oot.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 06:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HIxpcPjjliDmNMsnuequZ0gFoYJjA+Pd57/rdj42aTk=;
        b=n6hubWn5AXF/sSj8MUZBeNdimUtLnR1jd7Gowh5bUbbHNEgTO1dd3wn5ZW/d5oCTmK
         nj6lavmhbq/1FojrFBMVYVckHnWUYi/xWSQpEzKh/4zr/n9ZCXz6JNaIra7xNErSt5dY
         ro8MOAGeDt+hNJ5jMuYaNhKQOEd/0NX+ZSsHwicj4JG+bWCC5MKzNy6prOp0cg5twf/S
         gy8hC/v3eQjgYdbu0LWCzfk8YW919QfKDO7aRU9jI98z0QYhsUrOBOK2AN4pOr30IBD2
         duYoa9Z6jrQrrNZsLXABUrtGiNsqlzhjYRfZ5qIo1XpWFUp46UpdoG5hZN2cQu9q0BFn
         wcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HIxpcPjjliDmNMsnuequZ0gFoYJjA+Pd57/rdj42aTk=;
        b=Td55dFiAvEcO9sg7aiNDseirBZOXBKVdadKfhlFLG4H8uZhKwapszMUIGekSqzSr5D
         /sIKRm5KcULq0uui6c7/2E5VL+LCA3nmmooPAv2JNeWfIUpBJ+1qvOdsmXlp+JFFk1+a
         KxczwNCF+B5eQX9h0U+XNcM8wJdXRw/YgbXk02u6+kpXdzzEOE414T3X211JJCWavT//
         JSE6Ez1jmV491heITc0sNGstfSGnQ4qnP4icvCLPZXECN45ojxUrlxyZTlkfBLu3VC7r
         CbG1EFEHac7ro4qHJcZBzPDZfRZxGD2wtBYG4A+kLWU2o2c8nXsLLIlZ5PsF/yfU8m/l
         3c5g==
X-Gm-Message-State: AOAM532sWy88EOUMyFi9SLuuUudxg6WX2eZf80OP9L1RAK3P36Z36goE
        t9Gs9wgobxP//ZcChGWR4nZMlHsrKUDWuJVmn0U=
X-Google-Smtp-Source: ABdhPJxcO+2T/Un2z3HL3UD8vAOe2oKNLbp3IiO1yhZMKelVD05AWN6AAmRCmewWXvsqFHh4Wm9IQ7YUGfdG6Ud31/o=
X-Received: by 2002:a4a:a6c6:: with SMTP id i6mr17948100oom.73.1633526614154;
 Wed, 06 Oct 2021 06:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com> <YV1vcKpRvF9WTwAo@zn.tnic>
In-Reply-To: <YV1vcKpRvF9WTwAo@zn.tnic>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 6 Oct 2021 09:23:22 -0400
Message-ID: <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To:     Borislav Petkov <bp@alien8.de>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 5:42 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Oct 05, 2021 at 10:48:15AM -0400, Alex Deucher wrote:
> > It's not incompatible per se, but SEM requires the IOMMU be enabled
> > because the C bit used for encryption is beyond the dma_mask of most
> > devices.  If the C bit is not set, the en/decryption for DMA doesn't
> > occur.  So you need IOMMU to be enabled in remapping mode to use SME
> > with most devices.  Raven has further requirements in that it requires
> > IOMMUv2 functionality to support some features which currently uses a
> > direct mapping in the IOMMU and hence the C bit is not properly
> > handled.
>
> So lemme ask you this: do Raven-containing systems exist out there which
> don't have IOMMUv2 functionality and which can cause boot failures when
> SME is enabled in the kernel .config?

There could be some OEM systems that disable the IOMMU on the platform
and don't provide a switch in the bios to enable it.  The GPU driver
will still work in that case, it will just not be able to enable KFD
support for ROCm compute.  SME won't work for most devices in that
case however since most devices have a DMA mask too small to handle
the C bit for encryption.  SME should be dependent on IOMMU being
enabled.

>
> IOW, can we handle this at boot time properly, i.e., disable SME if we
> detect Raven or IOMMUv2 support is missing?
>
> If not, then we really will have to change the default.

I'm not an SME expert, but I thought that that was already the case.
We just added the error condition in the GPU driver to prevent the
driver from loading when the user forced SME on.  IIRC, there were
users that cared more about SME than graphics support.

Alex

>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
