Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A85930BAD2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhBBJVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:21:53 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:20977 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhBBJV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1612257511;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:Message-Id:Cc:Date:From:Subject:Cc:Date:From:Subject:Sender;
        bh=de7Ntg8H9dLGdY5MX+WYevzdbRLQdOtlFX5cvfBgC6k=;
        b=ntYIDU2IgoxJpGaf1Iqo+Tm8CgoGf3MTxJIvnxEH0Sw4B4BOSyLbv+mPRWSVL7nGgn
        PY19jij/Xh01Kpgf0snsjiL0huXY6vViAANYdajNpu7/6YI7qvcL7JQu3UMq3l4NYhs+
        fLccqqlwpTNCKrxzItk+xEddDyCEVIEynd7w3uAGTXkJCXQZgRWE7+LywMbm/2NEAEK1
        NnXJfKtZxcNrCPHYsMxlftRnMtoygY3/V6YS1aLQ2AVsN5Zy6nlpt3YpxZi4dQW1aP2E
        +BteccB4lQMR0qhdFkPbRxQqgBISS+9QK8NPxDcwFgBlxXRGsuubrXOjQryneExISBoX
        S8zA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/PqwDOsGq4="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.16.0 DYNA|AUTH)
        with ESMTPSA id R01a2bx129I2KwT
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 2 Feb 2021 10:18:02 +0100 (CET)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: BOG: commit 89c7cb1608ac3 ("of/device: Update dma_range_map only when dev has valid dma-ranges") seems to break Pinephone display or LCDC
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
Date:   Tue, 2 Feb 2021 10:18:02 +0100
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <81FE44A3-38C8-4B78-BB77-C09B4FC80B0A@goldelico.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Rob Herring <robh@kernel.org>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
since v5.11-rc6 my Pinephone display shows some moir=C3=A9 pattern.

I did a bisect between v5.11-rc5 and v5.11-rc6 and it told me that
the commit mentioned in the subject is the reason.

Reverting it makes the display work again and re-reverting fail again.

IMHO it seems as if the display DMA of the pinephone (allwinner =
suni-a54)
got influenced and stopped to scan the framebuffer.

The only dma-ranges I could find are defined here:

	arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi

	dma-ranges =3D <0x00000000 0x40000000 0xc0000000>;

but I can't tell if they are "valid" or not.

Any insights are welcome. And please direct to the right people/mailing =
lists
if they are missing.

BR and thanks,
Nikolaus Schaller

