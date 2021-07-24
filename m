Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9643D466F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 10:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhGXIPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 04:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229770AbhGXIPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 04:15:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72D96600EF;
        Sat, 24 Jul 2021 08:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627116954;
        bh=BPzXCsH+dliAL05Kix+IppZdW0IfD0Vmq05TsoU07Kg=;
        h=From:To:Cc:Subject:Date:From;
        b=MPvIw0/QayLuOzvp9BZV0qtOU/mnMPqtn9++BSLmAzcw3uVtBFqg/2GEqQn02ld2f
         +luwtA7zN6o6plah/tlezPv0vx0m2gwMFzge7JOgJCLFVpDmz0ENToAwZEovUL+iF8
         +SUG4k8ZwNI7pYU0fRSNj2NQUZzty6vI2YYr0NP2gm62sTguHM78BIZJBrCyRlXAF0
         Z97/5uk5j0AXZwh06uHgkdy7GSl142Nf6/bzibCoZdjz60RbXrKUV1DAV7A2LcK0Ti
         DuqMbxD/qdw1NMgVPmeEZkKfxADHij67UH3H8cjSxCala9UymlkxeKYdRTKJJljYuv
         7QRMKcj7oNQXg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m7DRo-00BFoL-8Y; Sat, 24 Jul 2021 10:55:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add support for Kirin 970 PMIC and USB3
Date:   Sat, 24 Jul 2021 10:55:46 +0200
Message-Id: <cover.1627116285.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the PMIC driver was finally promoved from staging, add the DT
properties for both PMIC and USB3 for HiKey 970.

Mauro Carvalho Chehab (2):
  dts: hisilicon: add support for the PMIC found on Hikey 970
  dts: hisilicon: add support for USB3 on Hikey 970

 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 129 +++++++++++++++---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  56 ++++++++
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     |  86 ++++++++++++
 3 files changed, 252 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi

-- 
2.31.1


