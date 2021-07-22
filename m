Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2173D2194
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhGVJUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231486AbhGVJTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C9F96127C;
        Thu, 22 Jul 2021 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626948020;
        bh=4bDA0DxHuVQv8b0x7pfxVtVsMTX7rXTC5TkpMPrd7lQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fMnU1xVVaehpcCT1sRqhSgmlfyo2id6XbfclKiSH95ao5okMEwZhTf5epXmT6me9y
         CZyEjx0jAk9kvCN+rSpdyzg2Lk95d2kx5iFgyorTe8YpwdfGUdU2mLBXNmpQj1xfx5
         gxmO24WcTYc2fJQ6g9rAx9uJtFmYeyhxD4zNaJvOHVvAoiIKXw0AnMzHXsX2azZ5RS
         ktKvR1XrlFN9oSIlu2BGKXHADp45aKaMruKSohBID1Td2iFbX5LQUGNbg63A4SjcUg
         OjbkO3p/NopYfdvDO9p0KAetcRrkCjQG46nRp0NBOvK0ndo6zon37r02xK1Bn04VwF
         eED6+o5BtlQ/Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m6VV0-008mI6-AX; Thu, 22 Jul 2021 12:00:14 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] MAINTAINERS: update intel,ixp46x-rng.yaml reference
Date:   Thu, 22 Jul 2021 12:00:11 +0200
Message-Id: <95289c73673861f462954ae8383eb88804ae7a0c.1626947923.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626947923.git.mchehab+huawei@kernel.org>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file name: Documentation/devicetree/bindings/display/intel,ixp46x-rng.yaml
should be, instead: Documentation/devicetree/bindings/rng/intel,ixp46x-rng.yaml.

Update its cross-reference accordingly.

Fixes: cca061b04c0d ("hw_random: ixp4xx: Add DT bindings")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a571273f308..efcd2d461fc0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9411,7 +9411,7 @@ F:	include/linux/soc/ixp4xx/qmgr.h
 INTEL IXP4XX RANDOM NUMBER GENERATOR SUPPORT
 M:	Deepak Saxena <dsaxena@plexity.net>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/intel,ixp46x-rng.yaml
+F:	Documentation/devicetree/bindings/rng/intel,ixp46x-rng.yaml
 F:	drivers/char/hw_random/ixp4xx-rng.c
 
 INTEL KEEM BAY DRM DRIVER
-- 
2.31.1

