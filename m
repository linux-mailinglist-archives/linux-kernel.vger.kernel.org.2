Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5A8424BFD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 04:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbhJGDAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 23:00:22 -0400
Received: from dnyon.com ([82.223.165.189]:43418 "EHLO dnyon.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229867AbhJGDAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 23:00:19 -0400
Received: from dnyon.com (55.red-81-39-194.dynamicip.rima-tde.net [81.39.194.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id 9ABF03FD73;
        Thu,  7 Oct 2021 02:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1633574467; bh=WnOj3nDnOlWbXBemhgNWFlSBmGzYfqHP/xoy1vfWwBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eM3BbXs0iVWapdWcoLfVGu3NOEAmh08RxiUFLfXi85PhgfMonfw1Xr2PF+OemI/Vj
         YSyrvS/lQGfNIkd2k9YvBSAi/0VvQs2e7aBMhSQYTPFrS+qtQ0a4XFDOTinc9pfuxp
         Xku5bft6xbavjlcJUefxqHeyKB31t2aMRdljtshwcepULprw9SAfPqRbmA3r9OQSLi
         2QOitprEyTezEwrKu9iqHbMUZ7OxGU3Inq9zM+9CKMabJjzjQUAk0clTAv2qYfUoI+
         kcYNdh+TplYNWnibSydFKO1ikJKX7jJclxahGz5jbv8SDMHwLsiu+1K19OqdEDKCIG
         jouS3qTqLOwGg==
From:   Alejandro Tafalla <atafalla@dnyon.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Alejandro Tafalla <atafalla@dnyon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org
Subject: [PATCH v4 2/2] dt-bindings: sound: max98927: Add reset-gpios optional property
Date:   Thu,  7 Oct 2021 04:38:58 +0200
Message-Id: <5004d52da527bf1dd9e5b17e20b2ce50a0b57b5a.1633572679.git.atafalla@dnyon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633572679.git.atafalla@dnyon.com>
References: <cover.1633572679.git.atafalla@dnyon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
---
 Documentation/devicetree/bindings/sound/max9892x.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/max9892x.txt b/Documentation/devicetree/bindings/sound/max9892x.txt
index f6171591ddc6..98cb9ba5b328 100644
--- a/Documentation/devicetree/bindings/sound/max9892x.txt
+++ b/Documentation/devicetree/bindings/sound/max9892x.txt
@@ -30,6 +30,9 @@ Required properties:
 
   - reg : the I2C address of the device for I2C
 
+Optional properties:
+  - reset-gpios : GPIO to reset the device
+
 Example:
 
 codec: max98927@3a {
-- 
2.33.0

