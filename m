Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0191240D5DE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbhIPJQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235572AbhIPJPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:15:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C26561288;
        Thu, 16 Sep 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631783661;
        bh=vhjK3q8kvaGj45NTIlUCPqKL1djHbANUQHHhFm1yLgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FwgDYp/BUeLueadNbZnsTEteXk38cfn2Nl/K13spugHvmtLDxM1tkGqagNFA6hcOP
         vKHOvP1Zhss6HxBrMMIIqUcp8fBtvr1aNvjqmNOrS2EPy7SJbu1RJiNHJqKKfkq/ci
         PUta7KVvxeI6eJZt8HhxxN6o64fQ47qVqv1bAB3VdaR2vkgyBiaJ9U/rmrxBPYT+UV
         mYHS9jLpb6O40Fh2FzF1zL6JZayBuUFVlbCGJN8IB7Sly6GkfAlBsUknd0Kzue8Lqb
         MWM8P3Eg98iBZnl7AylxbiNxAh2UST9PsgW1yNuPSytm7yYIcujE59gTK9gu7v2rNd
         Fn1b7UxnBtVhg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnTH-001sLt-Uz; Thu, 16 Sep 2021 11:14:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 18/24] MAINTAINERS: update ti,sci.yaml reference
Date:   Thu, 16 Sep 2021 11:14:11 +0200
Message-Id: <4660efcd6c8f906228d91ac0a489bb11b9b88202.1631783482.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631783482.git.mchehab+huawei@kernel.org>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 5a9652f6994e ("dt-bindings: arm: keystone: Convert ti,sci to json schema")
renamed: Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
to: Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml.

Update its cross-reference accordingly.

Fixes: 5a9652f6994e ("dt-bindings: arm: keystone: Convert ti,sci to json schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5154c8578ea4..bb9daad21935 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18546,7 +18546,7 @@ M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
-F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
 F:	Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
-- 
2.31.1

