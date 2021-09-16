Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5688E40D6ED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbhIPKAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236273AbhIPJ4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:56:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 768676127A;
        Thu, 16 Sep 2021 09:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631786126;
        bh=VbBtGGnEP0rRszkN+muWlKO8Pg69Fpqa5Zw3X5PVFBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/b7RLL7vYNI5GmRlpDAmgz1e97ex5XYrMKKEFHi6N/ChJMC31UVE2iLpeBTvbhCk
         D6xhdussZYmKqg5ZUnCauo5exkcuvJ/sLIHFWgjcpI/Vml+GMUe1LNA8n+JWpI+bbe
         /WWEl7Udwt0090p1L3veUkCazkyKu92gpuZzjsFUVXiQVHeL+1Bi3rFRHjQhP3mY7h
         06HuOoEBS3KdobHcHr0CFxbH4dDcInERCvYoTy41+b1njPhMvjodoA/64S+ilwDNsZ
         8JJrWB1Ys8MtmByD8D+uh58yNv3ViU8uCXe76wt5V16/Os/CTO1jhsfj2qOZU6yq4K
         kry1TvQqPoXIw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQo72-001vUM-Nw; Thu, 16 Sep 2021 11:55:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/23] MAINTAINERS: update intel,ixp46x-rng.yaml reference
Date:   Thu, 16 Sep 2021 11:55:15 +0200
Message-Id: <133cca5452d61c89544c2ec5bb4272b1e7bab4b8.1631785820.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631785820.git.mchehab+huawei@kernel.org>
References: <cover.1631785820.git.mchehab+huawei@kernel.org>
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
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bc18cfe73a6..91663dfd5af7 100644
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

