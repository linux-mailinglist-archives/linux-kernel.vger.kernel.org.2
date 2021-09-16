Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644A340D5D8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbhIPJQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235626AbhIPJPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:15:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3CCB61391;
        Thu, 16 Sep 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631783661;
        bh=d/p4SVK0pew6QaRrn57KYVF/7hRgydYOHWrBy364hyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGPOxw8VqlHx6PSzCfo5kqoEacn8vnGLfPNTF4LfR74zXVtoGDSuRmYQz8WjlyNAy
         S410enue6zr+NlFfvgf1rhaE/V2BNu61tXc81O8oyBDwO4VW76Kescg5OA9FrGref0
         I1dq5SDM/4NmhijRjbd7rqz3rMVIzxDAfqtMlL76IKR93Ee9ILoZZzgXegDdQs+/WW
         JbaEOK9PTTiaXw3j3ubAc+V6FyVk8zIfpYdxE6mjvGKvyQEks0MrZhHqeTUZ01Ms7q
         m1PXmgBKFprrDhckq9SBhUo2ee2sOaX80V+Jyt8uM3//nOCwLVrFje+7mGzl0oXPIk
         /P0tq+HZHoXGQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnTI-001sMD-3d; Thu, 16 Sep 2021 11:14:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 23/24] MAINTAINERS: update chipone,icn8318.yaml reference
Date:   Thu, 16 Sep 2021 11:14:16 +0200
Message-Id: <db813df22e44459c72069315d4c5783a3c14bd69.1631783482.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631783482.git.mchehab+huawei@kernel.org>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 04647773d648 ("dt-bindings: input: Convert ChipOne ICN8318 binding to a schema")
renamed: Documentation/devicetree/bindings/input/touchscreen/chipone_icn8318.txt
to: Documentation/devicetree/bindings/input/touchscreen/chipone,icn8318.yaml.

Update its cross-reference accordingly.

Fixes: 04647773d648 ("dt-bindings: input: Convert ChipOne ICN8318 binding to a schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index adce2bdedb9e..4bfa4d72589e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4397,7 +4397,7 @@ CHIPONE ICN8318 I2C TOUCHSCREEN DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-input@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/input/touchscreen/chipone_icn8318.txt
+F:	Documentation/devicetree/bindings/input/touchscreen/chipone,icn8318.yaml
 F:	drivers/input/touchscreen/chipone_icn8318.c
 
 CHIPONE ICN8505 I2C TOUCHSCREEN DRIVER
-- 
2.31.1

