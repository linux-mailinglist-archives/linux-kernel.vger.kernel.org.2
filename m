Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B1C40D6EB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbhIPJ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:59:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236263AbhIPJ4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:56:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A1676137B;
        Thu, 16 Sep 2021 09:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631786126;
        bh=8Z4SYByvsFTowkV68qYVoCm/hdL/RbneX6heKSFbhl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjHHWUpx6BdEWdv2Bq1kn1JGWQ/Mgeztr8kUtCywXL2skfx4IvptYBeuiQlmGqqbb
         J7OeEHht7BzcABX61G2/NNQoaszNegX01C/kPtp031vXNuvtV5MPUczhKhO7CcPWgJ
         KHzIGPFUQzQWBuwwLKzXDV2079/KKUd2AScghYMlIM3xCgL8TVYxyv2gakp48NX2MY
         XkA12PfMBQExOwW1O+OpDo1P+QhyO/nT6jIlp+MlQEakNmHGPwZB57XDP1Eo8WulUN
         I5iiFihXcDLCBjeKFxK7u3JUhCdf3d00EO9vNJ4yrnOoJx58cXR/pyMlL1qEyfyLjI
         SPUc+Fk2djdAA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQo72-001vUU-QD; Thu, 16 Sep 2021 11:55:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/23] MAINTAINERS: update gemini.yaml reference
Date:   Thu, 16 Sep 2021 11:55:17 +0200
Message-Id: <158efe29e9876e4d1bf606a5408b7f4a3b7c429b.1631785820.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631785820.git.mchehab+huawei@kernel.org>
References: <cover.1631785820.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 7da6ebf5f5a5 ("dt-bindings: arm: Convert Gemini boards to YAML")
renamed: Documentation/devicetree/bindings/arm/gemini.txt
to: Documentation/devicetree/bindings/arm/gemini.yaml.

Update its cross-reference accordingly.

Fixes: 7da6ebf5f5a5 ("dt-bindings: arm: Convert Gemini boards to YAML")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 151a05f77873..2b18e6ad7842 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1872,7 +1872,7 @@ M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://github.com/ulli-kroll/linux.git
-F:	Documentation/devicetree/bindings/arm/gemini.txt
+F:	Documentation/devicetree/bindings/arm/gemini.yaml
 F:	Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt
 F:	Documentation/devicetree/bindings/pinctrl/cortina,gemini-pinctrl.txt
 F:	Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml
-- 
2.31.1

