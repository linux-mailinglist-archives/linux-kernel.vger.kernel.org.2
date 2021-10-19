Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE88B4330AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhJSIHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234766AbhJSIGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:06:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12C2461391;
        Tue, 19 Oct 2021 08:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634630672;
        bh=2A561v897STUW9N/El0ducHR0zmDURkTioj6ePTyLAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q+//9H8/Z9WMhO9+v8H3UKQjPmeBU+1miouUD10oRi4/ZFlEzInWYhh3N62r63QVQ
         Kf/F/qkWe2HefwjTyEe9gY3Qdon9Ia7RhN/PF1wk4zhu37s4dDg7dGpUxkt9BCM+4T
         bNDSQBGdhi5NSAYhQMRsltFZBQGnpdpIsbzXDARgGzP9+x8a9y5aMfFPWV1YABaPs4
         sYVzL6zvMfYS4irtx99OkyAX2Xyrcd5PgSZ24ge3KwbxU6NjkBKo5stugup6CHMcSp
         yKljDJBqJIYvKUg1s4f/7fnNaIPQzKeVzKV3myU0gUZqNFS76bGaj8ZRyCn/5Oh1Rl
         DhyYD0XR5aLCQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mck6j-001oJ0-1y; Tue, 19 Oct 2021 09:04:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/23] MAINTAINERS: update arm,vic.yaml reference
Date:   Tue, 19 Oct 2021 09:04:03 +0100
Message-Id: <ec54d0aa65a3b98ae425721663f196b499a59513.1634630485.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634630485.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset b7705ba6d0c4 ("dt-bindings: interrupt-controller: Convert ARM VIC to json-schema")
renamed: Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
to: Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml.

Update its cross-reference accordingly.

Fixes: b7705ba6d0c4 ("dt-bindings: interrupt-controller: Convert ARM VIC to json-schema")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a10b915292e1..22efd0c518a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1560,7 +1560,7 @@ ARM PRIMECELL VIC PL190/PL192 DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml
 F:	drivers/irqchip/irq-vic.c
 
 ARM SMC WATCHDOG DRIVER
-- 
2.31.1

