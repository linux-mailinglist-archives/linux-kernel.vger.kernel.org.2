Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF4039C8C0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 15:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhFENVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 09:21:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230112AbhFENU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 09:20:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2734661448;
        Sat,  5 Jun 2021 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622899118;
        bh=zlUdrPVUJU1EIWuENgh6HqMK4e28J4JfFjwSRLcdyZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oqQdnSoafV4LtWDLZ5Jh3d1B1ytrDYZXu9yVloY1vajzKSqbYm8PN98ELsRbSnSMR
         caP3Cjn3/PRlUvtjfg3weISWe9ihk1A89+coIXhnm9IQjR8Ckm7p5mOikXJR30narL
         cSNsZ0xGdVToP97O9aNu2Xzeusc3CnQhezi6oAwORRTz1HlajLCLfKtDMsuUjJG2Yg
         5igWGKYgVV0Cm+sHD03K9ngVdI7nxJRndcapos2BCPOHendYnhVYY8f8tYUr0vPkqg
         Xu9ArI6l2cLEpHWjB1RR+D865YEg5qDp7vn4k113WQFNeieECXkLmbMDHB2BU2wt75
         MVFRQTtyA9w0g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lpWCC-008GFt-9d; Sat, 05 Jun 2021 15:18:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/34] docs: hwmon: adm1177.rst: avoid using ReSt :doc:`foo` markup
Date:   Sat,  5 Jun 2021 15:18:21 +0200
Message-Id: <32b0db7e79a3ed0e817213113c607a1b819e3867.1622898327.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622898327.git.mchehab+huawei@kernel.org>
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/hwmon/adm1177.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/adm1177.rst b/Documentation/hwmon/adm1177.rst
index 471be1e98d6f..1c85a2af92bf 100644
--- a/Documentation/hwmon/adm1177.rst
+++ b/Documentation/hwmon/adm1177.rst
@@ -20,7 +20,8 @@ Usage Notes
 -----------
 
 This driver does not auto-detect devices. You will have to instantiate the
-devices explicitly. Please see :doc:`/i2c/instantiating-devices` for details.
+devices explicitly. Please see Documentation/i2c/instantiating-devices.rst
+for details.
 
 
 Sysfs entries
-- 
2.31.1

