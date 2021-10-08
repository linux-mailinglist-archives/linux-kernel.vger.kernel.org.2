Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AE1426E55
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhJHQD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:03:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230512AbhJHQDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:03:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C12286101E;
        Fri,  8 Oct 2021 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633708881;
        bh=z1iwjovdbaQYyNE1yNGXfDf0GWlT2zOc8pc4bS0xX8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hm/JbU+Byv9BFkMHsopd711K00RbKM0GjhJS+ULAY7U2SvZtaJtWLpq6KxyWVfAgb
         +BhSHG0CbAngXXJsr7fMzM0EVFwvb9x4gZboiY/5VCZQ6h0KGoLn777nRavCSWXRz2
         9I5/oxWz9en5CPTkJ4iMWE2YCfjBcmvVSHBEqMx/Hs4DkhXfVrSrRPO4BwulQBMFwy
         tjTypepLyPhDIqbrkvChRhArNLMdUoLZ4RWSnSn/j55F/4P02/wn4z8j594TqPNKDo
         tuHqB29pP6ySpyLzuezS2RzwuNXR4K79+e9vh46ucM4TPWyvMHpSTs2FPgnGUp9sub
         EwbCeu/JitF+Q==
Received: by pali.im (Postfix)
        id 06E2A2AEA; Fri,  8 Oct 2021 18:01:20 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Documentation: arm: marvell: Fix link to armada_1000_pb.pdf document
Date:   Fri,  8 Oct 2021 18:01:05 +0200
Message-Id: <20211008160105.24225-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211008160105.24225-1-pali@kernel.org>
References: <20211008160105.24225-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File armada_1000_pb.pdf is not available on Marvell website anymore.
So update link to webarchive where is backup copy.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/arm/marvell.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
index 65d27b7ab110..7f5233b3256d 100644
--- a/Documentation/arm/marvell.rst
+++ b/Documentation/arm/marvell.rst
@@ -435,7 +435,7 @@ Berlin family (Multimedia Solutions)
   - Flavors:
 	- 88DE3010, Armada 1000 (no Linux support)
 		- Core:		Marvell PJ1 (ARMv5TE), Dual-core
-		- Product Brief:	http://www.marvell.com.cn/digital-entertainment/assets/armada_1000_pb.pdf
+		- Product Brief:	https://web.archive.org/web/20131103162620/http://www.marvell.com/digital-entertainment/assets/armada_1000_pb.pdf
 	- 88DE3005, Armada 1500 Mini
 		- Design name:	BG2CD
 		- Core:		ARM Cortex-A9, PL310 L2CC
-- 
2.20.1

