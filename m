Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04CD42CD4C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhJMWHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhJMWHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:07:41 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE9DC06174E;
        Wed, 13 Oct 2021 15:05:37 -0700 (PDT)
Received: from crub.agik.hopto.org (pd95f1d7c.dip0.t-ipconnect.de [217.95.29.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: agust@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A991D835F5;
        Thu, 14 Oct 2021 00:05:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1634162733;
        bh=6nMPFPuHyhN5ls8iUQT3OcQ653qjKPBIRYt3/m7YKaA=;
        h=From:To:Cc:Subject:Date:From;
        b=Ker72RLk8hNyrRSai7W0AWAcX/HaNGc+z8B79ZUl7/IumYS1OEitXv4mJuVnSDy0X
         C1afdiVchnRha75SBPOspZdh/O68e8ace0uj3KWl2aNAffQGtSlzSpGtXENXmPp3Ym
         bZy1inQMOEw4Sh1yhfYhZJr6OGV8A5jR02sJAsgUHBPj3X9DSPPId5Tdi+m1d6Q/Wr
         O8ChaXQFpA5/QzJXFrsGt9LrirvBbJoMCpdzIsyhz+m/Xh9HmAUfDPLq3MLHIpPxZ4
         /hvDcnzRUY7sQF5s7dZCge/YHDhmbtjAmCEnV65wfrWwsGfehUrEIdi8gvawigtEmH
         Sn7+SBHFKU/sA==
From:   Anatolij Gustschin <agust@denx.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 0/4] Update mpc5200 dts files to fix warnings
Date:   Thu, 14 Oct 2021 00:05:28 +0200
Message-Id: <20211013220532.24759-1-agust@denx.de>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes localbus, memory and pci node build warnings.
It was tested with current linux-next on digsy_mtc and tqm5200
boards.

Anatolij Gustschin (4):
  powerpc/5200: dts: add missing pci ranges
  powerpc/5200: dts: fix pci ranges warnings
  powerpc/5200: dts: fix memory node unit name
  powerpc/5200: dts: fix localbus node warnings

 arch/powerpc/boot/dts/a3m071.dts    | 12 ++++-----
 arch/powerpc/boot/dts/a4m072.dts    | 26 ++++++++++----------
 arch/powerpc/boot/dts/charon.dts    | 22 ++++++++---------
 arch/powerpc/boot/dts/cm5200.dts    |  7 ++++--
 arch/powerpc/boot/dts/digsy_mtc.dts | 24 +++++++++---------
 arch/powerpc/boot/dts/lite5200.dts  | 12 ++++-----
 arch/powerpc/boot/dts/lite5200b.dts | 14 ++++++-----
 arch/powerpc/boot/dts/media5200.dts | 28 +++++++++++----------
 arch/powerpc/boot/dts/motionpro.dts | 32 +++++++++++++-----------
 arch/powerpc/boot/dts/mpc5200b.dtsi |  8 +++---
 arch/powerpc/boot/dts/mucmc52.dts   | 38 +++++++++++++++--------------
 arch/powerpc/boot/dts/o2d.dts       | 12 +++++----
 arch/powerpc/boot/dts/o2d.dtsi      | 14 ++++++-----
 arch/powerpc/boot/dts/o2d300.dts    | 10 +++++---
 arch/powerpc/boot/dts/o2dnt2.dts    | 12 +++++----
 arch/powerpc/boot/dts/o2i.dts       |  4 +--
 arch/powerpc/boot/dts/o2mnt.dts     |  4 +--
 arch/powerpc/boot/dts/o3dnt.dts     | 12 +++++----
 arch/powerpc/boot/dts/pcm030.dts    |  8 +++---
 arch/powerpc/boot/dts/pcm032.dts    | 34 ++++++++++++++------------
 arch/powerpc/boot/dts/tqm5200.dts   | 12 ++++-----
 arch/powerpc/boot/dts/uc101.dts     | 14 ++++++-----
 22 files changed, 195 insertions(+), 164 deletions(-)

-- 
2.17.1

