Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D23431A2C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 17:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBLQdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 11:33:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230089AbhBLQ3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 11:29:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D922F61490;
        Fri, 12 Feb 2021 16:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613147320;
        bh=czPSaj8fKA6bbzkVvi8hwsv/gBRa8U5bexlofw0Qygs=;
        h=From:To:Cc:Subject:Date:From;
        b=gPYeKl0tTxVUd9/4hsSDoLXqxodFpzp3ZUlle2AlnAXDYfJaUiVoKb3mGiTsfn2b6
         be5yDof39jsOOkMNoEujheitJFFwefohql5ZBnVKjNMKFgowq8s0TpfsFWfbzAkp8e
         O9zdSAVPrXtv01RKx/5Dc6l0YAuDs441kT2rdmvjkflvHZv33bVKqNtB3QRSzeSqjt
         qMCESuE573l6vC62UoKnX56WQSkCt6y6arG2jItpFfXd/Ro//4woRl82dqX6cRdV7K
         2sQzq78XSy2e6XdGry37qI2PyiSVvKKKzaN39cTIRy/onvyFvRF6w+6BD3PylHSNXD
         ExsrDt3HlbuRQ==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [RESEND PATCH] dt-bindings: writing-schema: install from PyPI repository
Date:   Fri, 12 Feb 2021 17:28:36 +0100
Message-Id: <20210212162836.67393-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Installing dtschema from github.com/devicetree-org is not needed anymore
because dtschema is now part of regular PyPI repository.  In certain
cases it might cause some troubles as it brings latest master version,
not the stable release:

    $ pip3 show dtschema
    Version: 2020.8.2.dev4+g341f3e3
    $ make dt_binding_check
    ERROR: dtschema minimum version is v2020.8.1

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/writing-schema.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/writing-schema.rst b/Documentation/devicetree/writing-schema.rst
index 16f21e182ff6..b3cccb7e2059 100644
--- a/Documentation/devicetree/writing-schema.rst
+++ b/Documentation/devicetree/writing-schema.rst
@@ -115,7 +115,7 @@ The DT schema project must be installed in order to validate the DT schema
 binding documents and validate DTS files using the DT schema. The DT schema
 project can be installed with pip::
 
-    pip3 install git+https://github.com/devicetree-org/dt-schema.git@master
+    pip3 install dtschema
 
 Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
 installed. Ensure they are in your PATH (~/.local/bin by default).
-- 
2.25.1

