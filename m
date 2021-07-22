Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDD23D219F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhGVJXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231516AbhGVJTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB1FA6128A;
        Thu, 22 Jul 2021 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626948020;
        bh=JVPvBrmhKFAnXsnCiibA0RpPVGfRsxeb1/Y92PU/O7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCDbnTWXaFjt8ULDD6JJqiM51SFTd6ZJKjYC0WQDUogKTqpHsE2SPqbCYnufUvg9k
         9F1Q9L167L9NIID7adGYquoViC4fsEuLcfvbNn1g84zfspKgb1/Fq2SrkHgfUtXY/a
         /uHC6dmlPzgdUVwtsmLpke6iir/9vriBIK42PB6LXjkC8Ey0jqzLcPmGGbBBFmrdSx
         QmRYkjP5EXLWbSJ2gGOPs04VhQ9VnttvJyoA6xboScprJY3AVohdSCvMdvqyaRXWJv
         xC7KfxgZF7z5bMxnli0k2ueB2yD4cdG8fB5p03VMfhBus3nbOVplSVkV9C1qKwmWj7
         7t+JbFBQnEQQg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m6VUz-008mHT-H0; Thu, 22 Jul 2021 12:00:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] dt-bindings: firmware: update arm,scpi.yaml reference
Date:   Thu, 22 Jul 2021 11:59:59 +0200
Message-Id: <b5a2b0cb83e7f8193b4be4cef9250dd4c42877ab.1626947923.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626947923.git.mchehab+huawei@kernel.org>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 1496be719468 ("dt-bindings: firmware: arm,scpi: Convert to json schema")
renamed: Documentation/devicetree/bindings/arm/arm,scpi.txt
to: Documentation/devicetree/bindings/firmware/arm,scpi.yaml.

Update its cross-reference accordingly.

Fixes: 1496be719468 ("dt-bindings: firmware: arm,scpi: Convert to json schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/hwmon/scpi-hwmon.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/scpi-hwmon.rst b/Documentation/hwmon/scpi-hwmon.rst
index eee7022b44db..1e3f83ec0658 100644
--- a/Documentation/hwmon/scpi-hwmon.rst
+++ b/Documentation/hwmon/scpi-hwmon.rst
@@ -32,5 +32,5 @@ Usage Notes
 
 The driver relies on device tree node to indicate the presence of SCPI
 support in the kernel. See
-Documentation/devicetree/bindings/arm/arm,scpi.txt for details of the
+Documentation/devicetree/bindings/firmware/arm,scpi.yaml for details of the
 devicetree node.
-- 
2.31.1

