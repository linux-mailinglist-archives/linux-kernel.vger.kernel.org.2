Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDEC3F2161
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 22:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbhHSULh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 16:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234838AbhHSULd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 16:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629403856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUjdriWE/mhfhMVe0BuBsPE//HBSVrp7FmonS2UDWFE=;
        b=fAjvY6G1GNoeNlKEv3lbFsH495o+5Ji8MZPE6Pe13pJqro3evmmPsUNiH3SXrOmYtjBKMp
        iUxIhZzjZTVK/N4aR9Xq1prHy1BNKxm2cIOIlxdc5q8ZE+I9IqUXZFglue1ZZ9U4MofE2n
        64mbtSIAef8j1zWiNnLf/0XDPj+hKPk=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-87JkhaiBOyyUqugzdzIoxA-1; Thu, 19 Aug 2021 16:10:55 -0400
X-MC-Unique: 87JkhaiBOyyUqugzdzIoxA-1
Received: by mail-oo1-f69.google.com with SMTP id e25-20020a4ab9990000b0290260d4063992so3203247oop.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 13:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hUjdriWE/mhfhMVe0BuBsPE//HBSVrp7FmonS2UDWFE=;
        b=tmcxOEwxhkBGoPe+fkpxmeAJ+1Lxrh656Ffs4HwkdqFNZVd8b2mZkBJaQbCU8Y5lMW
         OlPDf2UTCdQx0VpIBx+nJcLp4oMJF8yTxzUJGAFJpb523AoWPHZRaRUpDEee658j4q/5
         5co0iCTL0WDs+huFooz/4ixCHGI5zGXE/yA5UrFj2VMJ6wo2ZH5Wnh2GN7ThgM4acRG5
         7zgCJ7mbV7KYDZbGtTNQynZon1P1JDrlc3OKIQ2nmlEU3NNLdcdOASMtLpXtDqCVA0ah
         tVxou5ZklnIdCeOjZsHTSG4EQCu6OpBW2XYPlH7mmxZBz+dwK7kbdQSdwdyUKyk+uaXd
         K5hw==
X-Gm-Message-State: AOAM532Mot3wiFfpkhGBVIqWpKTHZ77YbqtCMAB+edBw8/9DFbINWcDi
        DDwBXawLsZ93oT+1Gfe8EOH+MRiUjuuCRRjjJiq9jSTDtHa3GZxLxpsLAfRGfKmrjPACTM0Onnh
        ftyWouuFDrF3Hein1OjtbjU2P
X-Received: by 2002:aca:c614:: with SMTP id w20mr422929oif.18.1629403854960;
        Thu, 19 Aug 2021 13:10:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYzfVMo89adB0Sr6k8XaEyMhANuwC29Sepd1aOJQdORyWUa8WnrbwQLI0ExdAAqE1tRww9bQ==
X-Received: by 2002:aca:c614:: with SMTP id w20mr422909oif.18.1629403854733;
        Thu, 19 Aug 2021 13:10:54 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id r1sm793429ooi.21.2021.08.19.13.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 13:10:54 -0700 (PDT)
Date:   Thu, 19 Aug 2021 14:10:53 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ionel-Catalin Mititelu <ionel-catalin.mititelu@intel.com>,
        Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mei: improve Denverton HSM & IFSI support
Message-ID: <20210819141053.17a8a540.alex.williamson@redhat.com>
In-Reply-To: <20210819150703.GA3204796@bjorn-Precision-5520>
References: <20210819145114.21074-1-lukas.bulwahn@gmail.com>
        <20210819150703.GA3204796@bjorn-Precision-5520>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2021 10:07:03 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex]
> 
> On Thu, Aug 19, 2021 at 04:51:14PM +0200, Lukas Bulwahn wrote:
> > The Intel Denverton chip provides HSM & IFSI. In order to access
> > HSM & IFSI at the same time, provide two HECI hardware IDs for accessing.
> > 
> > Suggested-by: Ionel-Catalin Mititelu <ionel-catalin.mititelu@intel.com>
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Tomas, please pick this quick helpful extension for the hardware.
> > 
> >  drivers/misc/mei/hw-me-regs.h | 3 ++-
> >  drivers/misc/mei/pci-me.c     | 1 +
> >  drivers/pci/quirks.c          | 3 +++
> >  3 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
> > index cb34925e10f1..c1c41912bb72 100644
> > --- a/drivers/misc/mei/hw-me-regs.h
> > +++ b/drivers/misc/mei/hw-me-regs.h
> > @@ -68,7 +68,8 @@
> >  #define MEI_DEV_ID_BXT_M      0x1A9A  /* Broxton M */
> >  #define MEI_DEV_ID_APL_I      0x5A9A  /* Apollo Lake I */
> >  
> > -#define MEI_DEV_ID_DNV_IE     0x19E5  /* Denverton IE */
> > +#define MEI_DEV_ID_DNV_IE	0x19E5  /* Denverton for HECI1 - IFSI */
> > +#define MEI_DEV_ID_DNV_IE_2	0x19E6  /* Denverton 2 for HECI2 - HSM */
> >  
> >  #define MEI_DEV_ID_GLK        0x319A  /* Gemini Lake */
> >  
> > diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
> > index c3393b383e59..30827cd2a1c2 100644
> > --- a/drivers/misc/mei/pci-me.c
> > +++ b/drivers/misc/mei/pci-me.c
> > @@ -77,6 +77,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
> >  	{MEI_PCI_DEVICE(MEI_DEV_ID_APL_I, MEI_ME_PCH8_CFG)},
> >  
> >  	{MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE, MEI_ME_PCH8_CFG)},
> > +	{MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE_2, MEI_ME_PCH8_SPS_CFG)},
> >  
> >  	{MEI_PCI_DEVICE(MEI_DEV_ID_GLK, MEI_ME_PCH8_CFG)},
> >  
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 6899d6b198af..2ab767ef8469 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4842,6 +4842,9 @@ static const struct pci_dev_acs_enabled {
> >  	{ PCI_VENDOR_ID_INTEL, 0x15b7, pci_quirk_mf_endpoint_acs },
> >  	{ PCI_VENDOR_ID_INTEL, 0x15b8, pci_quirk_mf_endpoint_acs },
> >  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_rciep_acs },
> > +	/* Denverton */
> > +	{ PCI_VENDOR_ID_INTEL, 0x19e5, pci_quirk_mf_endpoint_acs },
> > +	{ PCI_VENDOR_ID_INTEL, 0x19e6, pci_quirk_mf_endpoint_acs },  
> 
> This looks like it should be a separate patch with a commit log that
> explains it.  For example, see these:
> 
>   db2f77e2bd99 ("PCI: Add ACS quirk for Broadcom BCM57414 NIC")
>   3247bd10a450 ("PCI: Add ACS quirk for Intel Root Complex Integrated Endpoints")
>   299bd044a6f3 ("PCI: Add ACS quirk for Zhaoxin Root/Downstream Ports")
>   0325837c51cb ("PCI: Add ACS quirk for Zhaoxin multi-function devices")
>   76e67e9e0f0f ("PCI: Add ACS quirk for Amazon Annapurna Labs root ports")
>   46b2c32df7a4 ("PCI: Add ACS quirk for iProc PAXB")
>   01926f6b321b ("PCI: Add ACS quirk for HXT SD4800")
> 
> It should be acked by somebody at Intel since this quirk relies on
> behavior of the device for VM security.

+1 Thanks Bjorn.  I got curious and AFAICT these functions are the
interface for the host system to communicate with "Innovation Engine"
processors within the SoC, which seem to be available for system
builders to innovate and differentiate system firmware features.  I'm
not sure then how we can assume a specific interface ("HSM" or "IFSI",
whatever those are) for each function, nor of course how we can assume
isolation between them.  Thanks,

Alex

