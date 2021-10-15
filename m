Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B6E42EBE9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbhJOIWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:22:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233121AbhJOIV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:21:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6028760249;
        Fri, 15 Oct 2021 08:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634285959;
        bh=ZtB79vn0N+nDpFFIfpwm8g6mWwuaDQm7mVlJLNDK7nY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=l6xJIVZQLzDcy+1R0WUSiieiyp674YTinwCtDARIUvlSRKlLeFA68sOGYLhHIUPFw
         W/9jgsQTsh1xELW5qOnSpfBDer61gUVrp3Mzazvypls8lIfab1INUyODnezZfshRwZ
         RkxucAwgtUbUjEEzJekRkQzB+Q8ek2+bOyjt/fmwXkkDugGOFAzpJH1xoVCq8ydund
         xb2rQD/gpPUl8DQDB+U2v5Y3+ndi3FoE7m8FwTpN7gIAWEdjYmUEucGYR3klRhKXti
         gw5KYdg3+Icx3SAbJdskGoILaYcCIB2o2CdGXwNv2VX/VMQxPLuNt39FdVcwu4GJ4r
         728cxCySUaypA==
Message-ID: <747ce6bf4b3511fd13408a52a301f63e37210883.camel@kernel.org>
Subject: Re: [PATCH] staging: vchiq_arm: Add 36-bit address support
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Mwesigwa Guma <mguma@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Amarjargal Gundjalam <amarjargal16@gmail.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, fedora-rpi@googlegroups.com,
        Joel Savitz <jsavitz@redhat.com>,
        Chukpozohn Toe <ctoe@redhat.com>,
        Clark Williams <clark@redhat.com>
Date:   Fri, 15 Oct 2021 10:19:13 +0200
In-Reply-To: <20211014223230.451659-1-mguma@redhat.com>
References: <20211014223230.451659-1-mguma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mwesigwa,

On Thu, 2021-10-14 at 18:32 -0400, Mwesigwa Guma wrote:
> Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Ojaswin Mujoo <ojaswin98@gmail.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Amarjargal Gundjalam <amarjargal16@gmail.com>
> Cc: Phil Elwell <phil@raspberrypi.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-rpi-kernel@lists.infradead.org 
> Cc: linux-arm-kernel@lists.infradead.org 
> Cc: linux-staging@lists.linux.dev 
> Cc: fedora-rpi@googlegroups.com
> Cc: Joel Savitz <jsavitz@redhat.com>
> Cc: Chukpozohn Toe <ctoe@redhat.com>
> Cc: Clark Williams <clark@redhat.com>
> 
> This is a forward port of Phil Elwell's commit from the Raspberry Pi
> Linux fork described as follows [1]:
> 
>     Conditional on a new compatible string, change the pagelist encoding
>     such that the top 24 bits are the pfn, leaving 8 bits for run length
>     (-1), giving a 36-bit address range.
>     
>     Manage the split between addresses for the VPU and addresses for the
>     40-bit DMA controller with a dedicated DMA device pointer that on non-
>     BCM2711 platforms is the same as the main VCHIQ device. This allows
>     the VCHIQ node to stay in the usual place in the DT.
> 
> This commit enables VCHIQ device access on a Raspberry Pi 4B running the 
> mainline Linux kernel.
> 
> Tested on Fedora Linux running on a Raspberry Pi 4B.
> 
> [1]: https://github.com/raspberrypi/linux/commit/97268fd23eb8d08dc74eac5e3fd697303de26610
> 
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>

I see a lot happening on this patch. You're:

 - Registering a number of child devices that don't seem to exist upstream
   ('vcsm-cma', 'bcm2835-codec', and 'bcm2825-isp').
 - Updating vchiq_register_child(). 
 - Adding brcm,bcm2711-vchiq's compatible string (no dt bindings? see
   Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt).
 - Looking for 'brcm,bcm2711-dma' in the devicetree.
 - Using 'brcm,bcm2711-dma's' device node to re-generate the page lists.

Each one of these should at least be a separate patch, which proper
justification[1]. You can't just take downstream fixes, rebase them and send
them upstream. You really have to own them, undestand what's happening and
repurpose everything so it's up to standard even if it means diverging from
what downstream is doing.

Regards,
Nicolas

[1] Have a look at Documentation/process/submitting-patches.rst.

