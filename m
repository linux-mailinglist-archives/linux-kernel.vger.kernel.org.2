Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D1D398F17
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhFBPpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232324AbhFBPpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:45:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 662DE61405;
        Wed,  2 Jun 2021 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622648602;
        bh=LfGj8APGxDPw5Zztjfnc8Z3UqwOehL4ZqQms6eu0ZvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mU0x/I9vd0OegaAOrOvrxlwKtRAt+SbgbkYdw8qoq65gOhZ2eDoFjLc1FxSC/VoYG
         uhyyl5zAAMf0jAw1Lo6UXv/4coeP5VgTVBxyahJUQZRxCv6loWCZdOV4U4dV82yl1m
         89N9zbr/edLrvaRHl8Jdvraj8iHlNbCHvqTux/1HFEWFDBcAopdWesbXfgLkbl6OxB
         ZhFKkAzDSPLU5LuTVz6Wb4AYfz2+7Tr9qvTMSacCz3v3ErAXHAdqXoVlN0qBPny1B4
         NG+JyOBP9+MicRzmileysfLcWKCYHyUUrunTB2/qLruUhgIXq1/+Y3Cf/oFvAVmZuH
         3T5gYM9CiSefg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1loT1b-006XcF-Mf; Wed, 02 Jun 2021 17:43:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] MAINTAINERS: update ti,sci.yaml reference
Date:   Wed,  2 Jun 2021 17:43:17 +0200
Message-Id: <114241c42cbaa7c757fec0f04d8bffe29dc724b6.1622648507.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622648507.git.mchehab+huawei@kernel.org>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 5a9652f6994e ("dt-bindings: arm: keystone: Convert ti,sci to json schema")
renamed: Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
to: Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml.

Update its cross-reference accordingly.

Fixes: 5a9652f6994e ("dt-bindings: arm: keystone: Convert ti,sci to json schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d65784df8c8..a737ba26bdcd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18192,7 +18192,7 @@ M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
-F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
 F:	Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
-- 
2.31.1

