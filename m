Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F96A306391
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhA0StO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 13:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhA0StB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:49:01 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71E4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 10:48:20 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id u20so2773273qku.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 10:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EUEoIQ9qWT1kGbtvZ5eDvB5BPzX/7KNE3wZ/wAEqoFw=;
        b=uzIRLSc0TOU1ddoC72VU6but+/NDZONq2N4qyfAWJHXSzRZ0y5RlIMeWrtCTRRs3cI
         EFPrDBoylPuFIUV5iq69uqRa3PxYK3di2Ez7NuFsadYoK5ZgYjwnRbQVi8fpaDuK/pQM
         mPT4UFyYZUrkFb5OAPdbiUdPr1INCMFixnvmX3wdfeQ4pnMxs5HF7J3ZEtD2sOadNMaD
         pbXUk911hKYsB0O7umukaCuy05nKM2XEHG5MROTawp6UO2ynMfJixaVW7UfopdLhBDjK
         7ESFU9ueSy2dy7dAqBOpq7L70g1qlacWigu1Zk8zj7+o+3+hCaTxrq5U3ypwoZGsfvt8
         yVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUEoIQ9qWT1kGbtvZ5eDvB5BPzX/7KNE3wZ/wAEqoFw=;
        b=bmSt88VbGH9Fbl74SXvy04bzxOejpbQXTN2t5QX47wTVhVq1vhIosHo2AGqwCOhqej
         geQnPXe5VHX2DLwUePnwY9ivIzvB1eNtN40O4/GYyIxRP5ZIABz8AAecnDsjXc8+kqGH
         iRKXGKQTfJs9lMvR2ijhbsey1KL7hH3M/xEDVsMqPOzls5C8X1+SNrnFmPoqes8wL7et
         JBIiOPMWNvlEtnUA8xDa+mYVI98iPCZwUxfHBMg00syK6Yuj/KQJfgLaCqb4m7Ch5ST9
         50CLHlpx9U5pPVDXvQtEuynEzUTL5yaCmVYs5/3jChm3KeFjn424dVIjdiFfGSJiLFyP
         qVAQ==
X-Gm-Message-State: AOAM530iLIfwif9G6a8uky9qbxvtmeB9vvREmQ2TsTymGd9Ia09yTaHK
        wWgidEIavrSuFWZO1kyhiBuYeFbfS7kooQVRZ8OOLw==
X-Google-Smtp-Source: ABdhPJxiy++dDTaPyD/SiNnlMw0KsigBT42ZNMGEmEEfMmo1EUM95b7kI9/EWGeLdb6r8JKZvD0UdL/MPMy1j+wioV4=
X-Received: by 2002:a05:620a:711:: with SMTP id 17mr10862573qkc.501.1611773299798;
 Wed, 27 Jan 2021 10:48:19 -0800 (PST)
MIME-Version: 1.0
References: <1611684201-16262-1-git-send-email-george.kennedy@oracle.com> <YBG0glwiK1wyJTeN@Konrads-MacBook-Pro.local>
In-Reply-To: <YBG0glwiK1wyJTeN@Konrads-MacBook-Pro.local>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 27 Jan 2021 19:48:08 +0100
Message-ID: <CACT4Y+a48smtXc6qJy9Wthwuqjk2gh6o7BK1tfWW46g7D_r-Lg@mail.gmail.com>
Subject: Re: [PATCH 1/1] iscsi_ibft: KASAN false positive failure occurs in ibft_init()
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     George Kennedy <george.kennedy@oracle.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, pjones@redhat.com,
        konrad@kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 7:44 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Tue, Jan 26, 2021 at 01:03:21PM -0500, George Kennedy wrote:
> > During boot of kernel with CONFIG_KASAN the following KASAN false
> > positive failure will occur when ibft_init() reads the
> > ACPI iBFT table: BUG: KASAN: use-after-free in ibft_init
> >
> > The ACPI iBFT table is not allocated, and the iscsi driver uses
> > a pointer to it to calculate checksum, etc. KASAN complains
> > about this pointer with use-after-free, which this is not.
> >
>
> Andrey, Alexander, Dmitry,
>
> I think this is the right way for this, but was wondering if you have
> other suggestions?
>
> Thanks!

Hi George, Konrad,

Please provide a sample KASAN report and kernel version to match line numbers.

Why does KASAN think the address is freed? For that to happen that
memory should have been freed. I don't remember any similar false
positives from KASAN, so this looks a bit suspicious.


> > Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> > ---
> >  drivers/firmware/Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> > index 5e013b6..30ddab5 100644
> > --- a/drivers/firmware/Makefile
> > +++ b/drivers/firmware/Makefile
> > @@ -14,6 +14,9 @@ obj-$(CONFIG_INTEL_STRATIX10_SERVICE) += stratix10-svc.o
> >  obj-$(CONFIG_INTEL_STRATIX10_RSU)     += stratix10-rsu.o
> >  obj-$(CONFIG_ISCSI_IBFT_FIND)        += iscsi_ibft_find.o
> >  obj-$(CONFIG_ISCSI_IBFT)     += iscsi_ibft.o
> > +KASAN_SANITIZE_iscsi_ibft.o := n
> > +KCOV_INSTRUMENT_iscsi_ibft.o := n
> > +
> >  obj-$(CONFIG_FIRMWARE_MEMMAP)        += memmap.o
> >  obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
> >  obj-$(CONFIG_FW_CFG_SYSFS)   += qemu_fw_cfg.o
> > --
> > 1.8.3.1
> >
