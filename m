Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761B7397AEB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 22:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbhFAUDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 16:03:49 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:25374 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbhFAUDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 16:03:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622577709; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lydiRoxQyQGGbo+Mv6BvowK33nLDm9VA+oSr6mVGgi2z91yp0q07ckGMTFCqhRHiY3
    2oiKDZ8yU2bNutpkHRycqM0V3RVxFog2zNMLIPp8hv5rUB5i6Wlt+LECyF+mxtpGbOkC
    OBT4Gy+2HOZliZPnYMAUMi6yCS5GgdgurfYqZk00YI4PZfFKozZtkFxO1a641K60uEhW
    3j1fBJ/1UqWEKwcAGHhXMPwMDb/NreEW+NCQT+XEegwUFwOwMs8NxaFdNVRLT8hG1cBh
    HS9TGyWgGiI5Yu/Dbp7ZclfIruDDIn8sT8dZasfIPsvlCVHewifxCZ1nI401dOgu7z+/
    r8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622577709;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WusjepEf0ImZGQpetBmFDA0rblZD8nyERdVuhtSp86Q=;
    b=GBFZntddEu1G9htlFhC0nzZzf+ENj5vNBXxtCfKM5sQFNtQPD9PFMCmbuDCVfx3ZzG
    jXslihIkgkwd2M8gnkypzb0CpxCSm9vVm8U2icZS51n21DPf8KBNFJZtSd3x3MBrS+hq
    KbWmpfISKFhYBJgzF/lxK5abVUmUEKRz0+n+fCYosamkrz+n1HqK4uWeGMNlKhWbyRJH
    wSBrfvkBbl55cvcj43qr+d9rD4VHJh6tpu+tM6WKEYaOpQXHQlIZWHKyxbdvxd++LA2U
    YT6DkzJveWJ3JZTKzmbwiZpd9/EcwC58g8GhnLW3Yr/KZoJH5WtFaKac4khUhiQGyEWl
    KueA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622577709;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WusjepEf0ImZGQpetBmFDA0rblZD8nyERdVuhtSp86Q=;
    b=pHGQ1TWzKl+F1HPIQdp1IeRG80uwQ9PzPOtOLWxGZJ3AtT2/9lqpu7R7aMP5GSDc7d
    UXdS4qGm4P0kJv0Gh/+POYfaTemc7qBsxfxRJkDUwUbHZak4fdJI1rrt3gJXd6ISV0Oy
    dZWytKHHMWDs8tAXgawBCDTT4dmFd/Ghlg7w16irf4+5jfFf4yzJfuXqL/p8XAhw0A6l
    VjG5Epf79w+txkQuPYA68Pb0iVlMNtvIWbsk3DGm9moyYyarBriMl25O/BZkDNZVHCJc
    /47h+TTCIQz26GDeaoLV3RWtD/M6yaSkzLsR9A6EY8kZ0gEtckc92etciMQnyfrXaIOp
    w9iQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4W6Na3kD"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.3 DYNA|AUTH)
    with ESMTPSA id U0b2c9x51K1nWn1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 1 Jun 2021 22:01:49 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 1/3] dt-bindings: extcon: sm5502: Document siliconmitus,sm5504-muic
Date:   Tue,  1 Jun 2021 22:00:05 +0200
Message-Id: <20210601200007.218802-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210601200007.218802-1-stephan@gerhold.net>
References: <20210601200007.218802-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document support for SM5504 with the new siliconmitus,sm5504-muic
compatible.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../bindings/extcon/siliconmitus,sm5502-muic.yaml           | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml b/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
index 0432b0502e0b..fd2e55088888 100644
--- a/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
+++ b/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/extcon/siliconmitus,sm5502-muic.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: SM5502 MUIC (Micro-USB Interface Controller) device
+title: SM5502/SM5504 MUIC (Micro-USB Interface Controller) device
 
 maintainers:
   - Chanwoo Choi <cw00.choi@samsung.com>
@@ -19,10 +19,12 @@ properties:
   compatible:
     enum:
       - siliconmitus,sm5502-muic
+      - siliconmitus,sm5504-muic
 
   reg:
     maxItems: 1
-    description: I2C slave address of the device. Usually 0x25 for SM5502.
+    description: I2C slave address of the device. Usually 0x25 for SM5502,
+      0x14 for SM5504.
 
   interrupts:
     maxItems: 1
-- 
2.31.1

