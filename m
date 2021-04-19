Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1811363E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhDSJNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:13:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52013 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhDSJNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:13:39 -0400
Received: from mail-lj1-f200.google.com ([209.85.208.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lYPxs-0003C9-H1
        for linux-kernel@vger.kernel.org; Mon, 19 Apr 2021 09:13:08 +0000
Received: by mail-lj1-f200.google.com with SMTP id b21-20020a2ebc150000b02900bdf5989812so5972506ljf.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 02:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHrGaUBBYyCaNzmHKZvwphNNADBKXI78oljxwo2iTJU=;
        b=YXehmpnE0CUnG0g18UBgnlK+BXrFj6ZQFjRuwWGQR5Vv+eA/nbqtuK9kj6hiTg1h0Z
         58SDZQEM8oCVEGB376c9tbwCdVWgAGTdlfhmC2ybUQEMeyQFPOYcRCWjQfAfEsDS5JwC
         B5mS2AliMqMjNqUbAi0NdPag4LvNz6HKdEGxDwPTc1EgrhFkKVsGFBpv89d2QEgqpPEg
         VrSd/8d/glh18kh+77xjwK7RmAmmqp1n3jjWyPMwJKrj1jUwQXss1TF077FpsN6B3h5i
         mZW1aHRz9jM/YHB17AnGiZf9OwOPp+LJXdPGTR/9MPOHAdc7qc/FGlsKPKp1i3tPB+vb
         nv/w==
X-Gm-Message-State: AOAM532mnAnq5VSQm4DRsmbPwhCs07/ia+oGNik4UhCqmETs2b3GC8zO
        LC3f8GbU+08lhLoTTXtC3JMY4uyC6vEUtiXQCM+MCdHPck7umkJxcLszxIGXeVZNABTUzkAupEr
        26F860b5exds5asLASG06mRrEIjmsIaEJj5Y3DELslfA82C41uldqy3i95Q==
X-Received: by 2002:a2e:88cc:: with SMTP id a12mr10499428ljk.402.1618823587974;
        Mon, 19 Apr 2021 02:13:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5p4Cqe2LM2xihhB901ADZVyCoqpBYFwrEVNhlgmv694HLCWYkSrMQLviXTAGoM6hTk/BVK+Ahw4DphBE194o=
X-Received: by 2002:a2e:88cc:: with SMTP id a12mr10499417ljk.402.1618823587729;
 Mon, 19 Apr 2021 02:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210329052339.20882-1-kai.heng.feng@canonical.com> <CAAd53p7fBKadTdsWZOe4O8ZuQDS6BCmkuA1ettZC7vxAxNw7Bw@mail.gmail.com>
In-Reply-To: <CAAd53p7fBKadTdsWZOe4O8ZuQDS6BCmkuA1ettZC7vxAxNw7Bw@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 19 Apr 2021 17:12:56 +0800
Message-ID: <CAAd53p7cVuT6tjS3DQUxVw4--4vhF5Kb0C5yN1_hNLrX=QEnew@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Disable D3cold support on Intel XMM7360
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 4:18 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Mon, Mar 29, 2021 at 1:23 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > On some platforms, the root port for Intel XMM7360 WWAN supports D3cold.
> > When the root port is put to D3cold by system suspend or runtime
> > suspend, attempt to systems resume or runtime resume will freeze the
> > laptop for a while, then it automatically shuts down.
> >
> > The root cause is unclear for now, as the Intel XMM7360 doesn't have a
> > driver yet.
> >
> > So disable D3cold for XMM7360 as a workaround, until proper device
> > driver is in place.
> >
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212419
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> A gentle ping...

Ok, I think I found the root cause:
https://lore.kernel.org/lkml/20210419090750.1272562-1-kai.heng.feng@canonical.com/

So we can ignore this patch.


Kai-Heng

>
> > ---
> > v2:
> >  - Add comment.
> >
> >  drivers/pci/quirks.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 653660e3ba9e..c48b0b4a4164 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5612,3 +5612,16 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
> >  }
> >  DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
> >                                PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> > +
> > +/*
> > + * Device [8086:7360]
> > + * When it resumes from D3cold, system freeze and shutdown happens.
> > + * Currently there's no driver for XMM7360, so add it as a PCI quirk.
> > + * https://bugzilla.kernel.org/show_bug.cgi?id=212419
> > + */
> > +static void pci_fixup_no_d3cold(struct pci_dev *pdev)
> > +{
> > +       pci_info(pdev, "disable D3cold\n");
> > +       pci_d3cold_disable(pdev);
> > +}
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7360, pci_fixup_no_d3cold);
> > --
> > 2.30.2
> >
