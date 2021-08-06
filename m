Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6132A3E26DE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbhHFJL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:11:57 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36717 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244214AbhHFJLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:11:54 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D6AE95C00DF;
        Fri,  6 Aug 2021 05:11:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 06 Aug 2021 05:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=eIDqcwS8u8GjX
        sGunuq8gTAsm/jXtOxzh8KNbC3yjs4=; b=asTRqyywW1NzBZBJ2kq2eq1fm1oiZ
        QpW95g9ik607D0y0eNFjcUnxiQnzUpOPjxSJATDG+1PEtBi/q5Is3EOhsFUoi0qF
        ylUOB65CiRSJGZ2ltZFujQWynzfwH7K1ZziP1J9SxFDNipetK33q+5zBPU+Q6L2v
        pH+5pi6NXeipOB0/ygocH8dGoSeU6xbcS++nPeqRxWRa25XWOY7onrX9Oz12RFnY
        gvt2RLzehRkvM+bn6v++PJHBAPr0EvwiFHkmPt6ns2WfqMDFul3JLn0CiQ8fcCda
        JxdQTH4R43zkIxukw6E8DxcEuRsc+bxRvFu12stR0t7HAxoxud6T092AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=eIDqcwS8u8GjXsGunuq8gTAsm/jXtOxzh8KNbC3yjs4=; b=GHlPVeg8
        iWbop2JSg1S0WnRZN7lWOOSaHU0YosiOE5I0yhyXWfxK+Iyp+NhtrvXc6Y9AmOXt
        5cuKg2IKHw6ev0YcU4KrXN2VBrzphWAm1QQdiGjX6ysJon9fzaTVSNr1cRIotzbj
        856s1PaHr8PbAzqvmJPEOSS7HrkeQcjPZiNpHMSif39yVWvbu8bIwo4WDh74hFoK
        buybN8I3Wi/knAi60qrP41lQAwmjNF0jDDdQVNZU/Iuptq6vmXWlVLM8zaNjd/4O
        lIBJXyWCFrCS5e4R6Pp7iifXwa6wq1x7TNVcDZB5w6PQ871fpNI0f9wdH8deoFjs
        Mgg+PJ9DUXbQng==
X-ME-Sender: <xms:yvwMYQfKojVYRYNu2nuMe1ce23goA6zix8YS4aS3aNKP2_GTzYU9FQ>
    <xme:yvwMYSNrPLBEt-fz2DfPY1NkbICXhrDggK_2FtcOxZTnsgKfTx9BRSOxdYs1LORyo
    CQ_IjUpqSTv9awyTLg>
X-ME-Received: <xmr:yvwMYRhon2eNFPLabVAVGy0w-JpQRe2uExlqun5WqZ8jn0QVaLCjMyNkCdINU_kt0T9THiFqdg8gUosp33gK6JnXvyL2x7DllUFpnj-Z9yRKTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:yvwMYV9OaGGn-pLCQl3DtNUylao2yEpZjEWjwuckQKDjgcKY7bk20A>
    <xmx:yvwMYct8qg3SeRwOXWzvwO-ETDgcDikiK9g8SnxUeDXfDj_tFnLKZg>
    <xmx:yvwMYcEgwJMid2TjPgI0QtZlzu8Sh_kmKcvvwJhTx7TbuFpPOgN6UQ>
    <xmx:yvwMYR8Ec9bxQ-y2-fNBJr8YdwFGWbRPYHlBJi6SlTZ4jNKAONmwqQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 05:11:34 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v9 06/12] regulator: sy7636a: Remove requirement on sy7636a mfd
Date:   Fri,  6 Aug 2021 19:10:52 +1000
Message-Id: <20210806091058.141-7-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210806091058.141-1-alistair@alistair23.me>
References: <20210806091058.141-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/regulator/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 24ce9a17ab4f..54ba141d114a 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1179,7 +1179,6 @@ config REGULATOR_STW481X_VMMC
 
 config REGULATOR_SY7636A
 	tristate "Silergy SY7636A voltage regulator"
-	depends on MFD_SY7636A
 	help
 	  This driver supports Silergy SY3686A voltage regulator.
 
-- 
2.31.1

