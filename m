Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB50351E62
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbhDASk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239651AbhDASQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:16:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3505661178;
        Thu,  1 Apr 2021 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279476;
        bh=WmmeVF3e2MgvPdqjDqGLuQIv1srgNyiWO6uwFC8Q6cM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcetZXDkNnck6wWX7t+65uQ0KzyM6OBLJDgcgF54vzUZmrMvg3zNEoc+Bv2J4XTpd
         GyyIhslJKSGIjD77J+I4VYLEiFY7XnUwjFkSBvUj7MVDUhAchr1C0qu2F9EO7xWe3x
         Xprv3Nnw+g3pA1y/pRo74gjUtnzDaP5O2zXHXnLazRZF3HhYAyVozIM6k4MjJdKGZN
         yuSbygDuRNJ8cl94hcn6JRbgwdmjtMB/bgf+fHauSs0BFlwvmTjpwXOGTi04E4MMdX
         FE2Wgb0nIxO2hY/G+kBj28Kilq4pV/UCGjbdqgpRMuCUNaVj/c4HatXmO0J65/lcWv
         sYttIlSOGaRCg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGo-001c3F-8L; Thu, 01 Apr 2021 14:17:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 21/32] MAINTAINERS: update ti,dac7612.yaml reference
Date:   Thu,  1 Apr 2021 14:17:41 +0200
Message-Id: <04039b6991838f0107a42ccb0d9774cb8873a61a.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 8b74e06b0f4d ("dt-bindings:iio:dac:ti,dac7612 yaml conversion")
renamed: Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
to: Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml.

Update its cross-reference accordingly.

Fixes: 8b74e06b0f4d ("dt-bindings:iio:dac:ti,dac7612 yaml conversion")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6b0a6f251e6b..2f63ebd2cfc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17907,7 +17907,7 @@ TEXAS INSTRUMENTS' DAC7612 DAC DRIVER
 M:	Ricardo Ribalda <ribalda@kernel.org>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
+F:	Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
 F:	drivers/iio/dac/ti-dac7612.c
 
 TEXAS INSTRUMENTS DMA DRIVERS
-- 
2.30.2

