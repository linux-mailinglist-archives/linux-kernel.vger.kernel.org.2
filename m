Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6D8351E6B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbhDASlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237001AbhDASSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:18:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6AE1610F8;
        Thu,  1 Apr 2021 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279475;
        bh=T/GXlpXW8ul7Ps8wou3KSUek2HsmaK6PZyYYBhRZni0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZelJAP2fnqkCPf+CzHRaW1rzs9TbjF2mgXPjvXvTVK7kGsbq7vJ+ty6MU4j2hm2Y2
         dWtTs1yfVyT5fa9j2h6UZDBAImfLi867+RIqPh0DlFKiOEeRBFfbgRMT7uxi4JxzBD
         0JcDTMKB2yrgC8GSo29jA3igx8JR/x0PKmm7asECFalH/y3MmS1SSZ1pqxMFv9BSI+
         oiMQx71YAX5J/7NMbySKVQw8ci53L/3J27gdmga/aQ5F/zTz9WaoLXjDoDXLCVv7wk
         h/qhMtmLHHB82O4Mmh9mLyk4F6VGc3rGR4vG9vqZWNh/qJ4eDgb5qWYDIKq3mkkrsv
         LgCaFVPKBD7jQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGn-001c2Q-Is; Thu, 01 Apr 2021 14:17:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Maxime Ripard <mripard@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/32] MAINTAINERS: update brcm,bcm-v3d.yaml reference
Date:   Thu,  1 Apr 2021 14:17:23 +0200
Message-Id: <461b3766c00fb60d6223835df3d64364a55f1619.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset cb18a7979a35 ("dt-bindings: gpu: Convert v3d to json-schema")
renamed: Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.txt
to: Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml.

Update its cross-reference accordingly.

Fixes: cb18a7979a35 ("dt-bindings: gpu: Convert v3d to json-schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 069cbf59da86..53c66a6908b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6131,7 +6131,7 @@ DRM DRIVERS FOR V3D
 M:	Eric Anholt <eric@anholt.net>
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-F:	Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.txt
+F:	Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml
 F:	drivers/gpu/drm/v3d/
 F:	include/uapi/drm/v3d_drm.h
 
-- 
2.30.2

