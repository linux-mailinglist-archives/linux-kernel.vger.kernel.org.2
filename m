Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF63426030
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbhJGXIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbhJGXIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:08:21 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292E5C061755
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 16:06:26 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BD07D806A8;
        Fri,  8 Oct 2021 12:06:21 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1633647981;
        bh=V5jRFXD4f6RFjyknJn8RXjM/mGtdfUVdJ1dQT2sORiQ=;
        h=From:To:Cc:Subject:Date;
        b=F7y8L7knr9Ah5Llz54TexB9+Yw52yJ6lBdUH2ml2QVXBJnbykbz7kP5YnX7dF924c
         EHFUiBWeYHBQEbeqVCsbL+9HiAWwWtXZG2cijk0hyBiVNhKeRmCSJ3xWqdmlnw1Vvr
         e9UbVCaY/6kokhJYdH5FG9CGmv5jcTcEok/j5bTDZPDUUpSyB1TfaiflCoE1Y6K0tb
         saD57H6drpVmojHTuIIUvB39btjDpW4GZvfnUH+p2mIfJ42SZTnncl98GQYcy9GrRw
         5BNjAvgxVg3eUMkCZrOe0WLYqh0efBzbYdImpIpZtG6YhO/e1jkHKuOe6/mvBykfIS
         7gJ9EGQdhNJMw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B615f7d6d0000>; Fri, 08 Oct 2021 12:06:21 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.26])
        by pat.atlnz.lc (Postfix) with ESMTP id 8FB2813EE39;
        Fri,  8 Oct 2021 12:06:21 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 8D1302A0B00; Fri,  8 Oct 2021 12:06:21 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        kostap@marvell.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/2] arm/arm64: dts: Enable more network hardware
Date:   Fri,  8 Oct 2021 12:06:17 +1300
Message-Id: <20211007230619.957016-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=fKRHIqSe c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=8gfv0ekSlNoA:10 a=__zsmxHhwBNjUnNrKTkA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables the Switch and 2.5G Ethernet port on the CN9130-CRB. =
The
changes are based on the Marvell SDK.

Chris Packham (2):
  arm/arm64: dts: Enable 2.5G Ethernet port on CN9130-CRB
  arm/arm64: dts: Add MV88E6393X to CN9130-CRB device tree

 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi | 129 +++++++++++++++++++-
 1 file changed, 127 insertions(+), 2 deletions(-)

--=20
2.33.0

