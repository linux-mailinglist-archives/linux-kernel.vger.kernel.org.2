Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4C7430D53
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 03:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344932AbhJRBO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 21:14:27 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:41823 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344912AbhJRBO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 21:14:26 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 29B2A8365B;
        Mon, 18 Oct 2021 14:12:14 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1634519534;
        bh=WN3zjox2svwGoKWGCD6Z0a+gH5Ir3xcNl02i0rJdcgg=;
        h=From:To:Cc:Subject:Date;
        b=ndZ/xcuDC+WQqwbohdNC6O7qUN6ZKnfHtuAIqMIdCSKqw81+13THri5HJMjDJzeqZ
         ohubwmpkYXY0a9GnH/sXq8obCg/1P2Z2lnMPiJ9a9I6TX12R3TzU1BR5NgibfsrNYH
         a1pPqdYDTs9dTvaTLPE7WRfGyJLTASxL762qoPLaYL3TPYYFW42LwgEytB5RfUVyN4
         HPh1wWXxxuIj1HokcK2HaV9XGjbAm0h5DlT3PDKU/4ykZoqZy/o6aTJu9iyfDig4dt
         tcle5Ij3iojvXLp+8sjBKN2latZSNJxcGXkCb0QOleCrFx4cQIpwO0SKcOdRTUkm7z
         pIUpdl/GNzSfg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B616cc9ee0000>; Mon, 18 Oct 2021 14:12:14 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.26])
        by pat.atlnz.lc (Postfix) with ESMTP id F33DE13ED1E;
        Mon, 18 Oct 2021 14:12:13 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id F03DB2A0B00; Mon, 18 Oct 2021 14:12:13 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 0/2] arm/arm64: dts: Enable more network hardware
Date:   Mon, 18 Oct 2021 14:12:09 +1300
Message-Id: <20211018011211.3836590-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=eIJtc0h1 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=8gfv0ekSlNoA:10 a=P1OfKbyUusFMxSjCSHQA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables the Switch and 2.5G Ethernet port on the CN9130-CRB. =
The
changes are based on the Marvell SDK.

Note Gregory has already picked up the 2.5G Ethernet patch from v1 so I'v=
e not
included it in v2 of this series.

Also note that if anyone tries out the SFP+ port on a complete CRB shippe=
d from
Marvell the chassis prevents the ejector from working so the SFP will get
stuck. Taking the board out of the chassis allows the SFP to be
insterted/removed.

Chris Packham (2):
  arm/arm64: dts: Enable CP0 GPIOs for CN9130-CRB
  arm/arm64: dts: Add MV88E6393X to CN9130-CRB device tree

 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi | 139 ++++++++++++++++++++
 1 file changed, 139 insertions(+)

--=20
2.33.0

