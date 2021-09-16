Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534F540D6E5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbhIPJ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236292AbhIPJ4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:56:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0F72613A2;
        Thu, 16 Sep 2021 09:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631786126;
        bh=Mi4uBazC0bhIAqaCEy19qWVkPvDv5otuz6QsDCCsr4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2DypBf+Ybu38tNMawE0nSueXJHCM227hDR4DgQ2tU7/dcUiGML8NlkcuurRYFqwV
         NHWVUldgQ9jCMJaia88B+LTMrLbyls+2RnllhDJroTvfgWRNyNpmn2gCkn4Nh4kHhY
         4c5c+qQWyrpSDDfzPt/Y+Igrm/F6ubgkPGgPnJoSFrsiAl44GHSSUX4p5HTgY1Lq3j
         dS3emQG01nfhz/18IQyClYaYH2t/+cKwa7R5BIa8Oyx3eEevlK/jvdTL4fjZSJQo95
         UUYYUOcvkJIUVjDh0ovt+MV3+kZ8Tb8/yirm+R10Q68hpgQOUIoJ+m2l62QxL4pP/U
         tfM1KFel+2YNQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQo72-001vUg-Ty; Thu, 16 Sep 2021 11:55:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/23] MAINTAINERS: update silergy,sy8106a.yaml reference
Date:   Thu, 16 Sep 2021 11:55:20 +0200
Message-Id: <d8a40e9523405be1c05d265589270e298ff42ae4.1631785820.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631785820.git.mchehab+huawei@kernel.org>
References: <cover.1631785820.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset b1c36aae51c9 ("regulator: Convert SY8106A binding to a schema")
renamed: Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt
to: Documentation/devicetree/bindings/regulator/silergy,sy8106a.yaml.

Update its cross-reference accordingly.

Fixes: b1c36aae51c9 ("regulator: Convert SY8106A binding to a schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6df4f5eb86a..819b9711dd77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18021,7 +18021,7 @@ F:	net/switchdev/
 SY8106A REGULATOR DRIVER
 M:	Icenowy Zheng <icenowy@aosc.io>
 S:	Maintained
-F:	Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt
+F:	Documentation/devicetree/bindings/regulator/silergy,sy8106a.yaml
 F:	drivers/regulator/sy8106a-regulator.c
 
 SYNC FILE FRAMEWORK
-- 
2.31.1

