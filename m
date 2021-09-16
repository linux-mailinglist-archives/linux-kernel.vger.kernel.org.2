Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FED40D5CF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbhIPJQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235633AbhIPJPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:15:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD02961283;
        Thu, 16 Sep 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631783661;
        bh=jZ+YuMwIRm8yO99k5rOkj2OohhYMN2RebEYpArnFa9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GWY1JiUUXVvuRZwJxo0HYxeOaDzpmRfvQSGmM0UTi2qzWhAJRGiHaBae69wGPB1cL
         9J2VcoGZGXKilzInl3PSj7fipUi+8g7Cf9aNBfQ0/S2uZvPiezIg8JIsSHVq49Btem
         aiiof4xR+8b56Zfyi63zdayjgomhvRHFP3CwGXa92NlteRxNzN+M5olcC6YEgfcZrh
         cZq/fEm6hVqyuxkRSooDM2CFuPFpGvUcUClD+w8bjkFdTODecLs5JOFQCxT9iPGRXF
         r2Hf7oxUJH6OpLNsFYF7uong91z9LU3rzts0lL7Qr74j1+7/b9i+lF4bJNZbNA8V51
         Z6DQKgGQ70Mmw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnTI-001sMH-4c; Thu, 16 Sep 2021 11:14:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 24/24] MAINTAINERS: update silergy,sy8106a.yaml reference
Date:   Thu, 16 Sep 2021 11:14:17 +0200
Message-Id: <eed037d15b9b919d6401898cd5cdeea0542a41d5.1631783482.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631783482.git.mchehab+huawei@kernel.org>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
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
index 4bfa4d72589e..8fed382b1935 100644
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

