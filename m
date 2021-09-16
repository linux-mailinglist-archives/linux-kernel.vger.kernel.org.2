Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5453140D6E8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbhIPJ7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:59:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236276AbhIPJ4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:56:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97B3B61391;
        Thu, 16 Sep 2021 09:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631786126;
        bh=ZcxvkAbWjBsIcFPKpT1xpJuBqiIZbL/L98Lbld4uPuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxfhP/0T/WN0qknT4xXozXWLabRvKo4yzrfRVuBUK1D07wBz/6l/JLRHS2eIxLnt7
         kqckjsqWGedg2cWifIvcOqrJnYUZAxgDLfdlSc7cOXhDzZNoI09vaYrs5ZX+5/cbGv
         DiGif1x9flHsNwgAB8jU6n6QNzRZRF8zl0wX86nEP2okzVwlOl5bhbXaSrBXeZ8t/8
         t8fR/6dBCgjgcTzSXLPpBuERMofca5cPI5e5PaM+08TQh+LA75EP3IPS+EBuI46KQL
         fhg9dSuRXv0FT9615B4gShaARAylcdxV1MqSylB2VQP0+9cTiE86n5tb5ApUVUmg64
         vkriq808pE+jA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQo72-001vUc-Sx; Thu, 16 Sep 2021 11:55:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/23] MAINTAINERS: update chipone,icn8318.yaml reference
Date:   Thu, 16 Sep 2021 11:55:19 +0200
Message-Id: <20911bb5ac8b61f9ff598a997efce8c0dfaef130.1631785820.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631785820.git.mchehab+huawei@kernel.org>
References: <cover.1631785820.git.mchehab+huawei@kernel.org>
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
index 3b66ca83e29d..d6df4f5eb86a 100644
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

