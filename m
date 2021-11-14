Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536A044F709
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 07:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhKNGZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 01:25:27 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:56945 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhKNGZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 01:25:26 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 96C04100EF4D1;
        Sun, 14 Nov 2021 07:22:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 55E2BF5A09; Sun, 14 Nov 2021 07:22:31 +0100 (CET)
Date:   Sun, 14 Nov 2021 07:22:31 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kw@linux.com
Subject: Re: [PATCH v1 1/1] PCI: probe: Use pci_find_vsec_capability() when
 looking for TBT devices
Message-ID: <20211114062231.GA10937@wunner.de>
References: <20211109151604.17086-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109151604.17086-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 05:16:04PM +0200, Andy Shevchenko wrote:
> -	while ((vsec = pci_find_next_ext_capability(dev, vsec,
> -						    PCI_EXT_CAP_ID_VNDR))) {
> -		pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER, &header);
> -
> -		/* Is the device part of a Thunderbolt controller? */

Could you preserve that code comment please so that an uninitiated
reader knows what the is_thunderbolt flag is about?

Thanks!

Lukas

> -		if (dev->vendor == PCI_VENDOR_ID_INTEL &&
> -		    PCI_VNDR_HEADER_ID(header) == PCI_VSEC_ID_INTEL_TBT) {
> -			dev->is_thunderbolt = 1;
> -			return;
> -		}
> -	}
> +	vsec = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_TBT);
> +	if (vsec)
> +		dev->is_thunderbolt = 1;
