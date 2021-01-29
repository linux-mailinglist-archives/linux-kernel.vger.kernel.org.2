Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281C330869D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhA2HjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:39:02 -0500
Received: from st43p00im-ztfb10061701.me.com ([17.58.63.172]:50266 "EHLO
        st43p00im-ztfb10061701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232304AbhA2HgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1611905716; bh=kXZkvWxB6eL6VKEAArF5bwSzPHyvmX4qrkAq3pvRG+s=;
        h=From:To:Subject:Date:Message-Id;
        b=K6UHYRnJAOLG3kjWV7wlprwVC6/CVPWt5uIXwyV1yJN/kLFHNzHmteeVMLtfU0h2c
         c7X09sF3eAQ5G77xakZNIX51hzV0vRWMZOhCLH9u87ji0EKW2CX/+W8bsNDNC6mf7n
         N5YCVGeFq+Z2BX1eQpiKzkupRVrTEiFdoAtEo07kZ9eEuWc/zvPhhDLIyra/z3o3tg
         NzETWmC0wT2cosW4ehIb0/aKmz1dp7etS29bmxEqppNoxFsQ3z6ItCAKMQXahBSf+Y
         azW9vk2BN0JwHCqxSWYXPqp8Y7NmPLKQFI6FNuFtM3rTBxqYQMSid/vQBwAW1Iz0eU
         cQipyUd4Jyzuw==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztfb10061701.me.com (Postfix) with ESMTPSA id ED766AC053A;
        Fri, 29 Jan 2021 07:35:14 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v2 0/3] Introduction of STiH418 based 4KOpen board
Date:   Fri, 29 Jan 2021 08:34:44 +0100
Message-Id: <20210129073447.18778-1-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-29_03:2021-01-28,2021-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=769 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2101290039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie introduces the 4KOpen (stih418-b2264) board based
on a stih418 soc. Since it is the first board to use the spi-fsm
SPI NOR controller available since stih407, the controller is
also added within the stih407-family DT.
It also contains a fix within the stih418 DT since the rng11 is not
available on this platform and is thus disabled.

Alain Volmat (3):
  ARM: dts: sti: add the spinor controller node within stih407-family
  ARM: dts: sti: disable rng11 on the stih418 platform
  ARM: dts: sti: Introduce 4KOpen (stih418-b2264) board

 arch/arm/boot/dts/Makefile            |   3 +-
 arch/arm/boot/dts/stih407-family.dtsi |  15 ++++
 arch/arm/boot/dts/stih418-b2264.dts   | 123 ++++++++++++++++++++++++++
 arch/arm/boot/dts/stih418.dtsi        |   4 +
 4 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/stih418-b2264.dts

