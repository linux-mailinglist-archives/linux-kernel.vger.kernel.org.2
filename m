Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E681F43309B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbhJSIHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234705AbhJSIGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:06:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DBAE61390;
        Tue, 19 Oct 2021 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634630667;
        bh=cygLgH5ZY3lIXQKvPD8oyJHKouY0yhIQi14h93eZ/60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=awDOkQ736AnNoB2JKDz6dZgQvSmIz5tVYPOcO86OVuFGcxSfZuibt8G+hHMMADiPX
         KbhQJGdUpa2bRdhOfkOfnJyo0HUNnW836ocWAYntpwufSEgybhG1saEgVCMr7KHrOv
         PCKurHuwjxXeviKPAWtfd0Gw6O8TJ004qDEOst1eY+XSAA2XQK1D+OrVept0I4d2a1
         7Csb3VcQAMAeAKc9ywwcMSQoNuTOuphfr7nRyZIJtSidPOP62VhrtXf/RD4VLernUP
         /JkfiPV9gJDKN/Jkkv17DDOicYoNTiUFRkb/n/bhvIYvOT9cIjBG8h3fCz7OSSoKgA
         AbzqrktsfEPkg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mck6j-001oJC-4d; Tue, 19 Oct 2021 09:04:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/23] MAINTAINERS: update intel,ixp46x-rng.yaml reference
Date:   Tue, 19 Oct 2021 09:04:07 +0100
Message-Id: <70a3d6696de52a3d6112adbf7247a4b4ae9c7e11.1634630486.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634630485.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5459f6ec8c10..843cb9779f4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9608,7 +9608,7 @@ F:	include/linux/soc/ixp4xx/qmgr.h
 INTEL IXP4XX RANDOM NUMBER GENERATOR SUPPORT
 M:	Deepak Saxena <dsaxena@plexity.net>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/intel,ixp46x-rng.yaml
+F:	Documentation/devicetree/bindings/rng/intel,ixp46x-rng.yaml
 F:	drivers/char/hw_random/ixp4xx-rng.c
 
 INTEL KEEM BAY DRM DRIVER
-- 
2.31.1

