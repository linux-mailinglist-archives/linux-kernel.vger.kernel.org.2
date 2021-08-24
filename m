Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D173F5C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbhHXK7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236377AbhHXK7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:59:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBD4461220;
        Tue, 24 Aug 2021 10:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629802742;
        bh=wopZdNWyHdTjQC3wTvrsahBSvF3dPz8U1JHvKdfduoo=;
        h=From:To:Cc:Subject:Date:From;
        b=DIyLT9aTvu2pQGnmlr5YH/llBnrgJibo3bF/on2JRfHEb74u9qDnXO3dihI6ceVg5
         Z1ejHFgOmKkdSnrtDcLfRIRuvLd0Rkro/vaLkmDFl/9+Ol1urHdAY39VVyM6RSF8vl
         rPz5rX3UIWHfmQ3ej7gSOPDHStkY/9POK3oA+1HEkGDLkfMOzmFHlsBMWZuS8i+EUK
         smHlo4SVllY3rSBj1HTx5DZVIASOBOk6oMZ86aPm3qB4Ug+olTE/Rz0WawCob8WGUU
         Rk/S+JhxbtDCWJ2uVKvvdkjO48JDEwzQf9z9ZWAnjRVcrQwp9zHpcXOPWIS1bEqjGT
         V9fSeP9PDRoWA==
From:   Roger Quadros <rogerq@kernel.org>
To:     ssantosh@kernel.org
Cc:     nm@ti.com, lokeshvutla@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 0/2] ARM: dts: keystone-k2*-evm: Fix mdio and dss node status
Date:   Tue, 24 Aug 2021 13:58:56 +0300
Message-Id: <20210824105858.19496-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

This series fixes mdio and dss status nodes from "ok" to "okay"

As per Device Tree Specification [1], the status parameter of nodes can
be "okay", "disabled", etc. "ok" is not a valid parameter.

U-boot Driver Model does not recognize status="ok" either and treats
the node as disabled.

[1] https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3

cheers,
-roger

Roger Quadros (2):
  ARM: dts: keystone-k2*-evm: Fix mdio node status to "okay"
  ARM: dts: keystone-k2g-evm: Fix dss node status to "okay"

 arch/arm/boot/dts/keystone-k2e-evm.dts  | 2 +-
 arch/arm/boot/dts/keystone-k2g-evm.dts  | 2 +-
 arch/arm/boot/dts/keystone-k2hk-evm.dts | 2 +-
 arch/arm/boot/dts/keystone-k2l-evm.dts  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.1

