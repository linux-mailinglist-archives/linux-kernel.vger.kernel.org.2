Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EACA3C1A84
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 22:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhGHU1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 16:27:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230238AbhGHU1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 16:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625775900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6amVMDUb/Hi3saNiHAOx2mrfmfmrxj1UyTOgCVIlUVE=;
        b=ILekeMPxn1i+P6gSu0xI0OgH5+AuDar7VYcvKKZBknbYLvHVvy9e9p1nISEv6lhZtLI486
        XUQ4o2xqxevPLTKASE/tfsc8HhrO9pAxeRitXg+7qD7FTqqHAguPq6kDS2MI9jiHP/exxB
        nKkTSp1yJmOPuhwOuTyXhxV/4U7dnYM=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-KFT-korAMgC4nCKGofD7KQ-1; Thu, 08 Jul 2021 16:24:57 -0400
X-MC-Unique: KFT-korAMgC4nCKGofD7KQ-1
Received: by mail-ot1-f69.google.com with SMTP id p4-20020a0568301d44b02904b420812511so1734777oth.18
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 13:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6amVMDUb/Hi3saNiHAOx2mrfmfmrxj1UyTOgCVIlUVE=;
        b=JVrCVFMhTQNYcTzt7lhbA+3PprhNu1vBI2kArEKXfAay5yDPs0ypXI0q34o/TNoyT8
         CiSnU9P2PScEhfCcqbMcrEYDnM6+LJrOySFE672uc0UarfDEEBg2CGm8XOXkXr0EJQTK
         YUmopaa0nFgHG/r+BjRJW4FazH2CA4IvoNUZxLB4bjxxfla9VpxTBetC/FT4kn45TTpn
         sJl0wfGyLYDJtRI2kCcxz8/A6WCKeBXKxDjJstLm+hSNmh0+yH7gtUv41IVPk3JUBuDi
         3iAsJizhFrWtD7Yw0LzcJ4sXnDUi3z14rHPu06o7qUBjQ3dcHM3fpt4Z8cNxAyBy3IAM
         xEIA==
X-Gm-Message-State: AOAM533qommHoXOgHsBlN2q9rk3tKQriK52xoiUfABi1d0/Ybe8VtMLK
        pXnh75L4LCUnUItZ53oo7wFqRxzTG7ti6B4Nzg4qtLqH+ysmOEaZ23gAqjlhOC/v0keS0eYZoqR
        Qeu+e/DHtHJiu+Iq9d95aeBoi
X-Received: by 2002:a9d:491:: with SMTP id 17mr16534521otm.184.1625775896751;
        Thu, 08 Jul 2021 13:24:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNNYCOTyh0Fp/3tdG3l31BTtUlQpSQlmvr+WIJaq7RUYUYmACs73ASFB4mE1t+QQ3TNMSp9A==
X-Received: by 2002:a9d:491:: with SMTP id 17mr16534500otm.184.1625775896494;
        Thu, 08 Jul 2021 13:24:56 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id i16sm695741otp.7.2021.07.08.13.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 13:24:56 -0700 (PDT)
Date:   Thu, 8 Jul 2021 14:24:54 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v9 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210708142454.566608c1.alex.williamson@redhat.com>
In-Reply-To: <20210705143739.nghgqghnskp7emai@archlinux>
References: <20210705142138.2651-1-ameynarkhede03@gmail.com>
        <20210705142138.2651-2-ameynarkhede03@gmail.com>
        <20210705143739.nghgqghnskp7emai@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2021 20:07:39 +0530
Amey Narkhede <ameynarkhede03@gmail.com> wrote:

> On 21/07/05 07:51PM, Amey Narkhede wrote:
> > Add has_pcie_flr bitfield in struct pci_dev to indicate support for PCIe
> > FLR to avoid reading PCI_EXP_DEVCAP multiple times.
> >
> > Currently there is separate function pcie_has_flr() to probe if PCIe FLR
> > is supported by the device which does not match the calling convention
> > followed by reset methods which use second function argument to decide
> > whether to probe or not. Add new function pcie_reset_flr() that follows
> > the calling convention of reset methods.
> >
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> >  drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +-
> >  drivers/pci/pci.c                          | 59 +++++++++++-----------
> >  drivers/pci/pcie/aer.c                     | 12 ++---
> >  drivers/pci/probe.c                        |  6 ++-
> >  drivers/pci/quirks.c                       |  9 ++--
> >  include/linux/pci.h                        |  3 +-
> >  6 files changed, 45 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c  
> [...]
> > index 3a62d09b8..a95252113 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1487,6 +1487,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
> >  {
> >  	int pos;
> >  	u16 reg16;
> > +	u32 reg32;
> >  	int type;
> >  	struct pci_dev *parent;
> >
> > @@ -1497,8 +1498,9 @@ void set_pcie_port_type(struct pci_dev *pdev)
> >  	pdev->pcie_cap = pos;
> >  	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
> >  	pdev->pcie_flags_reg = reg16;
> > -	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
> > -	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
> > +	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &reg32);
> > +	pdev->pcie_mpss = reg32 & PCI_EXP_DEVCAP_PAYLOAD;
> > +	pdev->has_pcie_flr = reg32 & PCI_EXP_DEVCAP_FLR ? 1 : 0;  
> On the side note, removing ternary here as Alex suggested doesn't work
> for some reason.

Probably I'm just incorrectly extrapolating boolean behavior to
bitfields, but indeed it doesn't work that way.  The other option is to
use the !! trick, ie. has_pcie_flr = !!(reg32 & PCI_EXP_DEVCAP_FLR),
but both solutions are used elsewhere in this file.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

