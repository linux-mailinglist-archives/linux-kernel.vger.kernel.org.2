Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104B232003A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhBSVSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:18:01 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55119 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229612AbhBSVR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:17:57 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 88FC05C0101;
        Fri, 19 Feb 2021 16:16:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 19 Feb 2021 16:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=PriXmizIybIVa
        b2U33M73MGMRE0fcS9JPe0vXDEdtZ4=; b=Thgp541fCoXNdmSt/8OT9GWF8S/Vl
        cgalptmBGNvpM4OnExwSEvgG97nWV+JJrmM9ZEXK8aglnYfZ1WAR6Oj4tMCJ79cB
        yvRQYJiign9Zo2c82zIT/Dk8lUx+vSxaNCN6ecBGAUArd7jvX5dLDjTisPyiOhrb
        uRZ1OXzOdmR81cTlg0uCLoqY5mtFMJ1zuMEjX4OEfr62fHAASBUMYY9/UnO2wZMs
        tlqCvBVIzNJT8hXrpWoqymC7TuDS8GgHVNEe/f1prcgGnzJ9EmWb2k8v0D808ssA
        +geuBM/674T+DOPvBjjihodpAWfrprs+zZ3SlsbH9pyTMxDPrbrm4qomQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=PriXmizIybIVab2U33M73MGMRE0fcS9JPe0vXDEdtZ4=; b=oU39fnVU
        otoX6vVvrM/oxKNE92gh5Wfo5jmAjZxIOGPwOK1nixwvGgEg9hburZcbAkWcjLW7
        Cf2Mh1ofC2NDQmNFX3OPRRdZ1sogGTDMbM1RiL97rDExhex2QJZ7AeSIQPS2lfLP
        AMONZjqG1q/dco66uW0TFuZVzhEEmuIVGg2ECG3Y3Tqy6OP/vX4c7Ymxvj8uaRUv
        Y9i/wTVapT/F1dJVkWnQkUwVejVeGmuS6tg3Wxd2eFuylghyB1/lXK7Tf8TGreu2
        /sqavIOm2L0EoavVvjMIpy45kp6jevduBPa3p7brb2mayF5kYSW/+dmXCAkA9DNV
        MwfQkzWCyF/n5Q==
X-ME-Sender: <xms:wyowYNqBSK_A33aFGcWsL-L2YOijM2AQwMfOutRWHmgnGjrgKQUnOA>
    <xme:wyowYPpBd8-UndbFvAoKq8yj6ub9QjVTq0rkjittbJjJfO4AKxNBICc9WE7O8u0To
    pZfU6TL3KA8xPLZCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjeeigddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepjedvgeffieeivdefleekvddvudffvefhiefgueeujedvgfegfeelkeduffel
    ffefnecukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:wyowYKML5hAb1cIfyJhMgV_lIh9VKQRlieHxfuSRDtG9IeTfEHyxqA>
    <xmx:wyowYI7Sjjm-5D6pYOf3c3XflJJHxH1L-vLKrCPAiUm7uqyH_PBITg>
    <xmx:wyowYM7-Jk7iCG62m0oV_SPqTejxO6UnzWeGZi2kmv2l_wo2srgqkA>
    <xmx:wyowYBjavSJE8XJn4e5Bvc5T3wPosD7NM6ZgirFL4sDtXuQBZU2YMw>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0020F24005B;
        Fri, 19 Feb 2021 16:16:50 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] staging: rtl8192e: rename charData to char_data in delba_param_set union
Date:   Fri, 19 Feb 2021 16:13:56 +0000
Message-Id: <20210219161400.29316-2-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210219161400.29316-1-will+git@drnd.me>
References: <20210219161400.29316-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a checkpatch CHECK message.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtl819x_BA.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BA.h b/drivers/staging/rtl8192e/rtl819x_BA.h
index 36280c62fa56..de41d2182ff5 100644
--- a/drivers/staging/rtl8192e/rtl819x_BA.h
+++ b/drivers/staging/rtl8192e/rtl819x_BA.h
@@ -39,7 +39,7 @@ union ba_param_set {
 };

 union delba_param_set {
-	u8 charData[2];
+	u8 char_data[2];
 	u16 shortData;
 	struct {
 		u16 Reserved:11;
--
2.30.0

