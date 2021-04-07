Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0905635665F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346946AbhDGIVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234102AbhDGIVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:21:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34A8F61363;
        Wed,  7 Apr 2021 08:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617783662;
        bh=nzYUbxWuELJbtrmYufmtVzvZIETB4Z9oWnwJLiMSquQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YB6nRfEynua3bicMchbwddo3ZhpR2K/w9LShFouOHE4o9eT1HKx6rYBYGM9fxLFgR
         gOyfC4rZiHy9JPVUZNnHWlPVQgq3jtRC7YeRKQvT4x4dwan+pXDqSB8WMKXJDvyFhn
         gfqtrkZ1cxAF0azUc7dNHIEOiGiMxI52TG+ZEwkrgA8UAOPbDXGnjYv0lLFA5NlhKd
         gF0J76/l31UOT3vsVj+uEplcLEGGAjrlG35WQBJNgwYnHG8toNjhGPiyrAhaqrdzel
         AY+b9LGrLuXDNVBwk28LjPR3fdL1Qonp7ZE1tq4nS5q1g3PTHEE3MigYvjdDJ0yEco
         PSRR1XJCiy7ew==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lU3Qq-005i26-6O; Wed, 07 Apr 2021 10:21:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/19] MAINTAINERS: update ste,mcde.yaml reference
Date:   Wed,  7 Apr 2021 10:20:40 +0200
Message-Id: <9ffac92903de5a1f295e02206103db2b2d34ba83.1617783062.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617783062.git.mchehab+huawei@kernel.org>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 2abb0b994db5 ("dt-bindings: display: mcde: Convert to YAML schema")
renamed: Documentation/devicetree/bindings/display/ste,mcde.txt
to: Documentation/devicetree/bindings/display/ste,mcde.yaml.

Update its cross-reference accordingly.

Fixes: 2abb0b994db5 ("dt-bindings: display: mcde: Convert to YAML schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03b2096a5f8f..92e5039b90ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5794,7 +5794,7 @@ DRM DRIVER FOR ST-ERICSSON MCDE
 M:	Linus Walleij <linus.walleij@linaro.org>
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-F:	Documentation/devicetree/bindings/display/ste,mcde.txt
+F:	Documentation/devicetree/bindings/display/ste,mcde.yaml
 F:	drivers/gpu/drm/mcde/
 
 DRM DRIVER FOR TDFX VIDEO CARDS
-- 
2.30.2

