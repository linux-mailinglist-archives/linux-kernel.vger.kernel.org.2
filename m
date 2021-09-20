Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46924110DD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 10:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbhITIXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 04:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230112AbhITIXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 04:23:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44E8361077;
        Mon, 20 Sep 2021 08:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632126109;
        bh=Fx3dg+d0MLkRz6SB8yEJs+eJdsfceLLV/A7PrbW6zfA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DHQ4d0wq/fhD3fC8IjEBgyJb7inLu4sEV7FQNTQ01HvIHMTRQkthx1CPDLVsl2VqZ
         uNSHlVT7jr/JxdZ6wL4gQVkDX9URSz7iT5k1q5k1qUqF47ob6LJZSkZd10IPDxB9sU
         v+sPT4wzqn+2m3K90QQUlXPOm37Dzmgjc2YNErj1iyC+wxFB9QpMx4nfRT/zNlJ+Bf
         fDn9S/9jESLyywF4MjJxdB0KASETL7qnAbsy/VHwD8qV6p5OoxTJbkASyyeY6lG0/q
         C1gv6tXu03AL5i9Fjt37ATYIpTrCueREbM7qfJ0f7XcGln12FTnQWCd3JHHF+g3DYL
         2MnK+lHcoW5WA==
Message-ID: <408e5e27fae24f22a408afdaf538702858cc324c.camel@kernel.org>
Subject: Re: [PATCH] ARM: dts: bcm2711-rpi-4-b: Fix pcie0, pci warning.
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 20 Sep 2021 10:21:46 +0200
In-Reply-To: <20210918143542.146060-1-tomm.merciai@gmail.com>
References: <20210918143542.146060-1-tomm.merciai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Sat, 2021-09-18 at 16:35 +0200, Tommaso Merciai wrote:
> Fix the following warning:
> 
> ./scripts/dtc/include-prefixes/arm/bcm2711-rpi-4-b.dts:220.10-231.4:
> Warning (pci_device_reg):
> /scb/pcie@7d500000/pci@1,0: PCI unit address format error, expected "0,0"
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---

This issue was already addressed here:
https://lore.kernel.org/all/20210831125843.1233488-2-nsaenzju@redhat.com/

It's available in linux-next and will eventually show up upstream.

Regards,
Nicolas

