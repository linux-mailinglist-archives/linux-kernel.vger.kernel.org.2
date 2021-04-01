Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8B8351E70
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240835AbhDASlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:41:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237022AbhDASSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:18:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8FF2610F9;
        Thu,  1 Apr 2021 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279475;
        bh=NdeTd6q6PkZJqKLM05Vg9LkVZEBc49fko76Eywoja8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kjcBIsT8hj+p5ZuWUPs49kni+mETOGt745FCzZzqPTo1p+Y+fnlSEo3zcqqxHSRao
         Zd+WPyfkbxoG3uvTMXPsX4S/Vi24JWD7YiPddotb/nEnGSrw9kDSfzD6BcziF7AWVu
         HbgSnz7i0p+L3/3Rwy5+oj+yZNDIlSa4ctANBp7Cj42D+Ep3m53K2EVbmL+UQO/+tW
         6l7hsiBHdwJeEwLb5xOEUDrE6ghEN5GTZ2jCsAalPTIg7WC+ryap6z3Zguo9VibXJ1
         sMbN8KoArPKoVCaRkTGvpNhF5JtI+NI6QF8stP7rnKW+ra4hR2x7ksiH6VTEJ6HzRr
         +jW4hu0TVt6/w==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGn-001c2O-I8; Thu, 01 Apr 2021 14:17:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/32] MAINTAINERS: update ste,mcde.yaml reference
Date:   Thu,  1 Apr 2021 14:17:22 +0200
Message-Id: <d7d064ecdc014266479fc1455c4566dd9c11798e.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
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
index 4c8a926ef201..069cbf59da86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5857,7 +5857,7 @@ DRM DRIVER FOR ST-ERICSSON MCDE
 M:	Linus Walleij <linus.walleij@linaro.org>
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-F:	Documentation/devicetree/bindings/display/ste,mcde.txt
+F:	Documentation/devicetree/bindings/display/ste,mcde.yaml
 F:	drivers/gpu/drm/mcde/
 
 DRM DRIVER FOR TDFX VIDEO CARDS
-- 
2.30.2

