Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD7A3DF4F7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 20:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbhHCStt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 14:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231815AbhHCStr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 14:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628016575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s4KWyk744Q3wL6JnNmKsjJ+6uacfM+MwhnkOhezWa0A=;
        b=Yt9Wmh6AWMZAttkxqQDTZjv64eFlptitZYz13GilTQ4cfPd/oYD6d/NkVVAv/gPxF3LV5J
        ccDyaMNXH765adDpVd06xtY7NnngjijcpcEeHju8B8MU6xH3471InvzaGR61fK8qZ9KUXr
        SbqLKJNCjZxo5jxFCY2fiM5NEHpxHnU=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-YGpOzpNqP8qiNOqnJXbZbA-1; Tue, 03 Aug 2021 14:49:34 -0400
X-MC-Unique: YGpOzpNqP8qiNOqnJXbZbA-1
Received: by mail-oo1-f69.google.com with SMTP id e12-20020a4aa60c0000b02902794b4965ceso7043521oom.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 11:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s4KWyk744Q3wL6JnNmKsjJ+6uacfM+MwhnkOhezWa0A=;
        b=LS5LBVW+4C6kWzDQfXES2WJTwiGPSpttlabkhvKYO0IQkklyhl38WPM/kiNUPPLZ1t
         6yO3hQnxEP/y8gx9cVLchUg0Iy94N2TmP6c2AyEvLA8Kj38ZbhX5XppzbDBTh55i9cMA
         Ze4/6XpMVnhCN17V4ZQ7h5GCG9j0GbRWfXu9iOse+f9MS4s6a+Z6yMRbq74exluPnoi+
         o4tb5erNo/RgBPYu8jEAIQWjuSm+mAHmJP+rPROCDkt2aB/MKABqk/Qk2khdugyrjeVO
         4/0e+X72ncez30xFunVzCN/r1IOMbq8/75VeRAPLFsI8LxoWN8PCMguX01OeT4eqds3D
         +FiQ==
X-Gm-Message-State: AOAM531ZCs2yNxC/iGOYVDi7daD8OPAfBTJg/JxPvCcQi0894Chj9BaG
        nLvcRm7uS6P2s94FS67mD3VluoV+or2SGyYTN6zmgfQlHt1c0xq7d7M6wz5PR39WZ3K/CNCVRXn
        k5HTnvtA7Lq/KdKyuG7QEsYml
X-Received: by 2002:aca:1316:: with SMTP id e22mr1740846oii.95.1628016573567;
        Tue, 03 Aug 2021 11:49:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZQM1+YFE6lxRBMxrtzJJI52rqczFbFNXJHgIRseGVa5PUBazAFaaqedCQhuwCwnPD1MZ+MQ==
X-Received: by 2002:aca:1316:: with SMTP id e22mr1740836oii.95.1628016573438;
        Tue, 03 Aug 2021 11:49:33 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id r5sm2547956oti.5.2021.08.03.11.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 11:49:33 -0700 (PDT)
Date:   Tue, 3 Aug 2021 12:49:31 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     rajatja@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ACS: Enforce pci=noats with Transaction Blocking
Message-ID: <20210803124931.270ca006.alex.williamson@redhat.com>
In-Reply-To: <162404966325.2362347.12176138291577486015.stgit@omen>
References: <162404966325.2362347.12176138291577486015.stgit@omen>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bump.

On Fri, 18 Jun 2021 14:55:14 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> PCIe Address Translation Services (ATS) provides a mechanism for a
> device to provide an on-device caching translation agent (device
> iotlb).  We already have a means to disable support for this feature
> via the pci=noats option.  For untrusted and externally facing
> devices, we not only disable ATS support for the device, but we use
> Access Control Services (ACS) Transaction Blocking to actively
> prevent devices from sending TLPs with non-default AT field values.
> 
> Extend pci=noats to also make use of PCI_ACS_TB so that not only is
> ATS disabled at the device, but blocked at the downstream ports.
> This provides a means to further lock-down ATS for cases such as
> device assignment, where it may not be the hardware configuration of
> the device that makes it untrusted, but the driver running on the
> device.
> 
> Cc: Rajat Jain <rajatja@google.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/pci/pci.c    |    4 ++--
>  drivers/pci/quirks.c |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 68f57d86b243..5aa1bb2ddd80 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -915,8 +915,8 @@ static void pci_std_enable_acs(struct pci_dev *dev)
>  	/* Upstream Forwarding */
>  	ctrl |= (cap & PCI_ACS_UF);
>  
> -	/* Enable Translation Blocking for external devices */
> -	if (dev->external_facing || dev->untrusted)
> +	/* Enable Translation Blocking for external devices and noats */
> +	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
>  		ctrl |= (cap & PCI_ACS_TB);
>  
>  	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6d74386eadc2..d541076c083a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5031,7 +5031,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
>  	ctrl |= (cap & PCI_ACS_CR);
>  	ctrl |= (cap & PCI_ACS_UF);
>  
> -	if (dev->external_facing || dev->untrusted)
> +	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
>  		ctrl |= (cap & PCI_ACS_TB);
>  
>  	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
> 
> 

