Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A305C3E34E3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhHGKkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:40:23 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33231 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230332AbhHGKkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:40:20 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id A6BE45C00C2;
        Sat,  7 Aug 2021 06:40:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 07 Aug 2021 06:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=ogU9rvn58H76K
        bCYMD7NwPKqr7V2CMfGEVCJQIcAJsE=; b=B6NS1E85IpJZt8YMqCPTOkqQBb/xf
        ms/y78JLwUr343NgzgR6sZ1C8Q/BAAymDWU0ccaYQLnM9UEzhUMKHNncC0jQQsVj
        n64jQUNPjRW7vrenNt4s3IE236dnvF3ZCmRI0Po7jRWpmkOwKoWsFqSUR4a2Yvvj
        w5vE4wixUe+xnmhCU1pE1TrtzUOgSI5UDJMDXVr37erIVHSbAlsKtRGCbjpbbADL
        5ntGw3X5vuoWfTrWoiEJ/hsGKuE8aAzP28kUEA0WpUWJQPkTuD8S6QeSggEY38Fx
        vQ3vzotmrS02SgJ7ZU8kNeCwNvK6I5xD3QixjuYUNcevxGf/Vksw7WHOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ogU9rvn58H76KbCYMD7NwPKqr7V2CMfGEVCJQIcAJsE=; b=YVSRnAO2
        aGh7wnqSJDcYVcLCycq+S4mInpt8fAxenq/Y6CwDI5efmtnO7dgsZY+gvcc763U6
        OH+19wZ3MGtPvJKENR6qhKDsIES3eJdzhlLD0PQveLWs68EHj9rfaOR6P8Poxlbl
        flB8C9o8hrLM8eY/DaXEdg50V5K17r48bw7rSWUJnH3LU4i5GDhXq+1isY9j7RgD
        R1J2FX2RAgbLwArI+mx1UT+UZ9ydlKVNGnKaQGNxlbJef/Y54t1/u+CuDMryWcya
        nMHovtxSZ+5l1plZ6OJkP9c84QksknAE5F818iaHWGOeSxqGiMgmaivadVvOtLas
        LNr6G3lC7csY2w==
X-ME-Sender: <xms:AmMOYfDgWHZjEZ7uQOSE_TBtkAvIOJWceJolm4RLoGoAZrjY_FQOQg>
    <xme:AmMOYViCJQO9JSwYHJiTUGenR16B9W60Zm2pMs5GtDwzr7rIlX4I1qBOOgfrE7nuT
    Alk_szpnjJ9131bFjg>
X-ME-Received: <xmr:AmMOYannk3oUl-engZdnzNeJrAdAtUP0AYAVlxNT0lrO4iUKjH7Cpy5aQDYkgjiO0OvKZyCpa8bwZqKerF7Ac7X-z7_a5wDdiXTRwn_ivi1mzUZghw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeefgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:AmMOYRzlynWA2ssRLsiJ0G54UiMen08uCKRe8CB6peYSRjrADWo-_g>
    <xmx:AmMOYUR5TitdHnP__hW_BkWsl2Rdg6ulQ3Z1C3ccdesOAOpFwuZdkQ>
    <xmx:AmMOYUZW8zQTBacSAr8a49ycCTOPNyqXgLw8qjvJ9bJaZtCI1c3Bmw>
    <xmx:AmMOYZRS1BktemAHI5BWplhb7QofOYmVY7MdRYtxBJOl_hdUQMlmwA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Aug 2021 06:39:58 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v10 02/11] mfd: simple-mfd-i2c: Add a Kconfig name
Date:   Sat,  7 Aug 2021 20:39:31 +1000
Message-Id: <20210807103940.152-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210807103940.152-1-alistair@alistair23.me>
References: <20210807103940.152-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6a3fd2d75f96..09a939f8b7ff 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1176,7 +1176,7 @@ config MFD_SI476X_CORE
 	  module will be called si476x-core.
 
 config MFD_SIMPLE_MFD_I2C
-	tristate
+	tristate "Simple MFD device"
 	depends on I2C
 	select REGMAP_I2C
 	help
-- 
2.31.1

