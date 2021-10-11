Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F594291E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237484AbhJKOfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbhJKOek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:34:40 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35177C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:32:27 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id n63so24844427oif.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2/ZTOy0q28dn/Ouhxt088aYYUW3NaH1tWSvL9KzCcik=;
        b=P/k1oVfKmFY5wGSr/y+gQwLi2aHhybye08VwzgW+vUlk/Izsyfx8dLHennK69xkCCY
         CWhh5iuax8ItdUlYtZaAfm3bUNePH+bVkpiy856Pm9suL8rFjiTZeNR3TVPA87EzzJfd
         Qg+GNKN4YbVd1huamqej/LMBCy/n6gXWAA2nQZzsyLMujir/YPbaUMov6PXKKreA1ugb
         AEqYVwzUQcAFK3DXVtMjFtc0LJtkrjkI6tru5ySiIz7tMMF38nLCq7HX/74LWUXGri0z
         8ePM+7jZdspWhEFaYcXlgCZR2Nm3+KxLWKdiYTGoZD5rBn05Vdelk+Sdc9DZTJW2XwKw
         1FeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2/ZTOy0q28dn/Ouhxt088aYYUW3NaH1tWSvL9KzCcik=;
        b=7zc1WaSNX09epQhMkLq5RxFQSUkJRHnMtf0j4o/oYNYttc60LdMQ4lg7Nygj1iKagK
         MMG5STCL77txPDd+GsCvXYgh6hc6I0lHvPpe5EC0Zjiu3B5/lIEnqprE0c1lu9wWzpup
         TM0DXUSbH5kvyS5J1FW1SZxxJb46nr0EHcwaN7RdwZXGGSrH8ctM931STiBXoGzsl9xY
         aTnFo9GwgV2MO3OHQqRoqZv1azKJkvv6/0r8CZcvgcPpbWyWmq23dbAfRWOQRnJa0yfH
         RI50CJUeQjsMNpI19b8f1FAph4dTuZ5e6p2N3mgd0BR5AdtQGAORAbga3D4K8Vwl+SQk
         2s0w==
X-Gm-Message-State: AOAM531+kyMkShTX1u6BNy6tMrfLJN/EL9ivVklfJrfVSDmf0b6rVbsM
        rBL0l874i5TeY1hhZoTBoDGWgPFqpKd4G4Q4peM=
X-Google-Smtp-Source: ABdhPJxuzkit/sOHalSr+6UHB9Gpc9rUb8EpsnE55/ckQ/rW0zX9VvQ3PO6tkY68syjSbrrw5nHLIoou8bLrojRbxlY=
X-Received: by 2002:aca:d6d2:: with SMTP id n201mr17936070oig.120.1633962746584;
 Mon, 11 Oct 2021 07:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic> <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
 <d704afb9-7c7c-fa55-4329-58bb2fa25b33@molgen.mpg.de> <YWQ3963xcO3xbFo5@zn.tnic>
 <87d93314-ba3e-464f-d051-84a8de674b06@amd.com> <139ed784-d622-b0d2-3650-736b42e624f0@molgen.mpg.de>
 <be2b3cca-9822-4bb7-12b4-4c5c89318625@amd.com> <8b21ebbd-f7ca-8af3-5398-8320c6ed6422@molgen.mpg.de>
In-Reply-To: <8b21ebbd-f7ca-8af3-5398-8320c6ed6422@molgen.mpg.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 11 Oct 2021 10:32:15 -0400
Message-ID: <CADnq5_OLaFFuK-LaEw+aXdbJcXa0pEUEBJaCbaeuOxVbEat_oA@mail.gmail.com>
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 10:21 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Tom,
>
>
> Am 11.10.21 um 15:58 schrieb Tom Lendacky:
> > On 10/11/21 8:52 AM, Paul Menzel wrote:
>
> >> Am 11.10.21 um 15:27 schrieb Tom Lendacky:
> >>> On 10/11/21 8:11 AM, Borislav Petkov wrote:
> >>>> On Mon, Oct 11, 2021 at 03:05:33PM +0200, Paul Menzel wrote:
> >>>>> I think, the IOMMU is enabled on the MSI B350M MORTAR, but
> >>>>> otherwise, yes
> >>>>> this looks fine. The help text could also be updated to mention
> >>>>> problems
> >>>>> with AMD Raven devices.
> >>>>
> >>>> This is not only about Raven GPUs but, as Alex explained, pretty much
> >>>> about every device which doesn't support a 48 bit DMA mask. I'll expand
> >>>> that aspect in the changelog.
> >>>
> >>> In general, non-GPU devices that don't support a 48-bit DMA mask work
> >>> fine (assuming they have set their DMA mask appropriately). It really
> >>> depends on whether SWIOTLB will be able to satisfy the memory
> >>> requirements of the driver when the IOMMU is not enabled or in
> >>> passthrough mode. Since GPU devices need/use a lot of memory, that
> >>> becomes a problem.
> >>
> >> How can I check that?
> >
> > How can you check what? 32-bit DMA devices? GPUs? I need a bit more
> > information...
>
> How can I check, why MEM_ENCRYPT is not working on my device despite the
> IOMMU being enabled.

I think there are several potential problem cases:

1. Device is in passthrough mode in the IOMMU and the device has a
limited DMA mask.  This could be due to a hardware requirements (e.g.,
IOMMUv2 functionality) or a hardware/platform requirements (e.g., ACPI
IOMMU tables define passthrough for a specific device or memory
region).  This is the case for Raven.

2. Device driver bug (e.g., driver not using the DMA API properly)

Alex

>
>
> Kind regards,
>
> Paul
