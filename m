Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B57440D5DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbhIPJQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235609AbhIPJPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:15:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B522561373;
        Thu, 16 Sep 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631783661;
        bh=I0zJgrJ074MHHhu9mtPme4IHH94Arp6S89AUJJj772g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a0b5h8l1FA46jf224AFwJrrrv5TH7oiVc5LT7Cxl6mXtl/Iq0NcuJCK1A67SYmLRV
         nNYMKp1cTYv4rgDt7w7KZxBskHGcxkSu96tITLrksxhcgK1FYw31zoRgx4MNwKOfyp
         FgSyR7fSN5/Ed3vortnD2k33z/rkl6AxW0Um6N2Kf7g3Z8wcnjv+RKpBTJ+1Tqso6P
         vxISo56AJrZYtn0PAH/rXaDP3p6TCu3i8PfdWaL/kFgR509IXLbOeCQH3rQ8fW47V8
         oBYXOCkh6VxHxLJlS+qaTboopeFThtSNzyfPD2gPaycjyA4yz8jMUiqnNiTxNtbh2v
         oQ0tQd4RHrNAA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnTH-001sLx-W0; Thu, 16 Sep 2021 11:14:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 19/24] MAINTAINERS: update intel,ixp46x-rng.yaml reference
Date:   Thu, 16 Sep 2021 11:14:12 +0200
Message-Id: <36ee194d1607df649e8bbed47eca37333818fa56.1631783482.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631783482.git.mchehab+huawei@kernel.org>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
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
index bb9daad21935..da9658e24496 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9509,7 +9509,7 @@ F:	include/linux/soc/ixp4xx/qmgr.h
 INTEL IXP4XX RANDOM NUMBER GENERATOR SUPPORT
 M:	Deepak Saxena <dsaxena@plexity.net>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/intel,ixp46x-rng.yaml
+F:	Documentation/devicetree/bindings/rng/intel,ixp46x-rng.yaml
 F:	drivers/char/hw_random/ixp4xx-rng.c
 
 INTEL KEEM BAY DRM DRIVER
-- 
2.31.1

