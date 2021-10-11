Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346A94297C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 21:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbhJKTtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 15:49:47 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:56163 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbhJKTtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 15:49:46 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7E740100FBFF2;
        Mon, 11 Oct 2021 21:47:40 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5CED64A8C4; Mon, 11 Oct 2021 21:47:40 +0200 (CEST)
Date:   Mon, 11 Oct 2021 21:47:40 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH 16/22] PCI: pciehp: Use RESPONSE_IS_PCI_ERROR() to check
 read from hardware
Message-ID: <20211011194740.GA14357@wunner.de>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
 <36c7c3005c4d86a6884b270807d84433a86c0953.1633972263.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36c7c3005c4d86a6884b270807d84433a86c0953.1633972263.git.naveennaidu479@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 11:37:33PM +0530, Naveen Naidu wrote:
> An MMIO read from a PCI device that doesn't exist or doesn't respond
> causes a PCI error.  There's no real data to return to satisfy the
> CPU read, so most hardware fabricates ~0 data.
> 
> Use RESPONSE_IS_PCI_ERROR() to check the response we get when we read
> data from hardware.

Actually what happens is that PCI read transactions *time out*,
so the host controller fabricates a response.

By contrast, a PCI *error* usually denotes an Uncorrectable or
Correctable Error as specified in section 6.2.2 of the PCIe Base Spec.

Thus something like RESPONSE_IS_PCI_TIMEOUT() or IS_PCI_TIMEOUT() would
probably be more appropriate.  I'll leave the exact bikeshed color for
others to decide. :-)


> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Lukas Wunner <lukas@wunner.de>
