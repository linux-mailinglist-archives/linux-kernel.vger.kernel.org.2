Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA9031F72B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhBSKNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:13:44 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34583 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229524AbhBSKNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:13:16 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 9A5295C00CF;
        Fri, 19 Feb 2021 05:12:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 19 Feb 2021 05:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=GXJPno7jlQ6lx
        30/f6IQjHMlSbMWtrJPdhY2j80BYQ8=; b=gkuHlMTIuVLLI9zPuudxwm3fGnBx6
        V1IhTJygcnzR7HDrGJ7M3Fjw5aFOKJfC5XOC1C2fN+L1lTTm3iMecPF1hBcywzMf
        3zOGlG82EVxeuPeN/plwdymj+fywnm+YbCrgYwtGesMijIj71yjSfQhlEr0M9F7j
        MPQFb7lQeoDJn5hFHVEbKreyHFYZ4Io1w4OW/1ZlQre3hwSdWpWmCanLCnN+Qi8h
        N8RsH6pwFTB5a+V5WTdrJFtnqdgjrYCZsUT12y4RIgve8x2WKPqw6JWhrEm3QuX3
        o8+2bSvVGCKrpQb9ObJoGTcES12KIDwglBkJbmNr9PZxHGAUeg0pjIwfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=GXJPno7jlQ6lx30/f6IQjHMlSbMWtrJPdhY2j80BYQ8=; b=q/WHWxOW
        gfIxgm8QoNeROtMk9ITiJVKIFYph1kHKkNEL3LnTPlm7BOFuTqyBA+EKXiG3kst2
        afFhvUS3O9Ck5Htq/kYr2SyChOgMhHpxvDsZCiUkzUtIDJ2i3oCBV3rElPQVlV7s
        7cMg7yzbbomPJhaOhnJ0XYWMEn2DZQWlmiB9x0221nTapo49B+2/1qawqqAl34as
        O7N2q5ujq/GHT6qnoTRonEcSqUAIl0jcxuuGRvdcDdRhfxtRBxAFmIg9pTVZ2ozh
        QoQZyABhCHYbP2oVLvq6bJ17UFvs7+pyLnXwoI5TCJU7Q8tWnQkEUte6RvI1AQRP
        H/Q8wZbqR74mEw==
X-ME-Sender: <xms:-o4vYE4RYR_tPfxWbjfsj15M7ws0FuzNqyLfnjwXKUGP7H4W61bp3g>
    <xme:-o4vYGQm1_MXJEUOxMa1eX1m7WdXzvO-UIVqV6RCq1dYtpl_QbhgpK4kkuRM29il_
    -U6wdKef-_eLUDXHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjeeigdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhephghilhhlihgr
    mhcuffhurhgrnhguuceofihilhhlodhgihhtsegurhhnugdrmhgvqeenucggtffrrghtth
    gvrhhnpeejvdegffeiiedvfeelkedvvdduffevhfeigfeuueejvdfggeefleekudffleff
    feenucfkphepudefvddrvdeftddrudelgedrjeefnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepfihilhhlodhgihhtsegurhhnugdrmhgv
X-ME-Proxy: <xmx:-o4vYEk-A7pkLQsS-xy6b9XE-dAezdNmeW3nDaQMUVzsV967HR38Yw>
    <xmx:-o4vYFLMdHQbj5tYww8NT3TZ84GLh4_9-IqIxKV-L6U-pn-bQyuOYw>
    <xmx:-o4vYHSvE5gwa3mrvvQnNg7xV1HEW6zE4-bCJ-7OU8L6VkW8lqr2Pw>
    <xmx:-o4vYO1XKsloxjz65Z8H_KZ-DNHoGm0cjjlK2w2WBT1EqIsZR4ZI-A>
Received: from vagrant.eduroam-fp.privat (ufr-132-230-194-73.eduroam-nat.uni-freiburg.de [132.230.194.73])
        by mail.messagingengine.com (Postfix) with ESMTPA id 098A61080066;
        Fri, 19 Feb 2021 05:12:09 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] staging: rtl8192e: rename charData to char_data in ba_param_set union
Date:   Fri, 19 Feb 2021 10:12:01 +0000
Message-Id: <20210219101206.18036-2-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210219101206.18036-1-will+git@drnd.me>
References: <20210219101206.18036-1-will+git@drnd.me>
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
index b2a784fa051e..4fdff19bb4ae 100644
--- a/drivers/staging/rtl8192e/rtl819x_BA.h
+++ b/drivers/staging/rtl8192e/rtl819x_BA.h
@@ -28,7 +28,7 @@ union sequence_control {
 };

 union ba_param_set {
-	u8 charData[2];
+	u8 char_data[2];
 	u16 shortData;
 	struct {
 		u16 AMSDU_Support:1;
--
2.30.0

