Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A303F298F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 11:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbhHTJyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 05:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237305AbhHTJyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 05:54:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24D9B61075;
        Fri, 20 Aug 2021 09:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629453226;
        bh=nTvQjTgUtLV1Y6eAMkMaG9eP2vQYqQbaaR8M0tadm7E=;
        h=From:To:Cc:Subject:Date:From;
        b=rqMbw42VtQFRlBN711mbdgxsulS9oFm/Jf24dRpR8WfA4LyI/7iwXBD4uA+2SJsra
         cBNLPlruENpETKj8RRKkUY47Q9jws7SWAa2WnXOBCVA8W7xAfX7Lw06J77KJfoNx+m
         UpsJFbJsKTdIxBRwXfXjoxouk0QfFq2kLKoaf73IF0AI3KK49+rPu8KJTfhONmZhXz
         Es+igfQAdFCpPztutBFVInKxA97Xlo8D6W4sd5bjN/WFam5Bg035tqVrilwaW/FyZD
         23OfaUb3S3KpI9fsDGpPOLdHW/v+ye+of8ZUuTg7OT73nBc073FL9kbiziv3KKDGD/
         ZGU0a1IhuT4KQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     ssantosh@kernel.org
Cc:     nm@ti.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/2] ARM: dts: keystone-k2*-evm: Fix mdio and dss node status
Date:   Fri, 20 Aug 2021 12:53:39 +0300
Message-Id: <20210820095341.5619-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

This series fixes mdio and dss status nodes from "ok" to "okay"

As per Device Tree core schema [1], status parameter of nodes can be either
"okay" or "disabled".

U-boot Driver Model does not recognize status="ok" either and treats
the node as disabled.

[1] https://github.com/devicetree-org/dt-schema/blob/master/schemas/dt-core.yaml#L36

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

