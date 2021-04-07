Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFA2356688
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347021AbhDGIVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237082AbhDGIVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:21:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 398FA6139C;
        Wed,  7 Apr 2021 08:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617783662;
        bh=7IqdzPYBZnfDwDgNhyOQYNHRJFE9fqjd6Hurn7Yh8Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=moFdoVAjSfEjTE96HMhKqWWwG2xWpKlpJ9tNaemvSm3TgWKhuFPm37usUCcBp+IuM
         Cj048kw3F+CbtkBumaZxMUyBVTq/Q3cceBbnP+rD9UtmJEzfj+lDsliO56IiINZeka
         2iDKxUc4LLv/zfNbkeCWRtMXust6b2qLoVoSlepaVJjuIcKkLXTiLDExqJW5phAaNH
         hVM0iXoiv0YT5sWb6oCECyohnRvjnJtebD9wGWh51J38jfEEoctybb7U1/+u9x3sGb
         4f5Neaa2leZQoQ/KVDpdCSkW+wAs0l0MEhlmitk0eOSJwBomXH/rHFxqXBHl7ZV5/g
         Bv9nC7c5PupKA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lU3Qq-005i2C-BR; Wed, 07 Apr 2021 10:21:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/19] MAINTAINERS: update mtk-sd.yaml reference
Date:   Wed,  7 Apr 2021 10:20:43 +0200
Message-Id: <7d06b4116e2a8142d66ab41f7f0ef4895aefc56d.1617783062.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617783062.git.mchehab+huawei@kernel.org>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset c626695ecd8b ("dt-bindings: mmc: Convert mtk-sd to json-schema")
renamed: Documentation/devicetree/bindings/mmc/mtk-sd.txt
to: Documentation/devicetree/bindings/mmc/mtk-sd.yaml.

Update its cross-reference accordingly.

Fixes: c626695ecd8b ("dt-bindings: mmc: Convert mtk-sd to json-schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 02e29e4461a5..735d48d18a57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11293,7 +11293,7 @@ F:	drivers/media/platform/mtk-vpu/
 MEDIATEK MMC/SD/SDIO DRIVER
 M:	Chaotian Jing <chaotian.jing@mediatek.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/mmc/mtk-sd.txt
+F:	Documentation/devicetree/bindings/mmc/mtk-sd.yaml
 F:	drivers/mmc/host/mtk-sd.c
 
 MEDIATEK MT76 WIRELESS LAN DRIVER
-- 
2.30.2

