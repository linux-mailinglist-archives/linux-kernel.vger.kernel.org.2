Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499B03E0D81
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 07:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhHEFHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 01:07:24 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:49415 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231326AbhHEFHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 01:07:22 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D76245C00DD;
        Thu,  5 Aug 2021 01:07:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 05 Aug 2021 01:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=JbkV0OkjI25/Uw7VNuOjM6Wr15
        +eFNku94LfNLShlFI=; b=tRyYKGWjjfutwG0EWgeN9kznaKc/6mYGNboUYPqziK
        UO7lWCa3CsbslnM4UB6NJ/AqZNPZ7y3YCqQ7N+Oy6smguX7db6W8/HlLz4eyDcEi
        gQeQ3nqpr40SqM7MQVxGDwo0gqZKCNK7X9MaDBtY7VkuLT5EIHIziSwT7LDZ1gu5
        jnd7SBULdo08PYvyzNgAN1St39B88z8HDJ8E1qCc7S86kW9rHCU+adg3tvI29Jm3
        ePnBWdNXpxHCnHEJG5EWt+rUY5GHtfK5WoWDdtxmPodNuLD62ZCW4f1tgD86CA8o
        FsJh5hytQoMNlY7mlNBi05EbrgzUY/HBhOStjM/hoFLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=JbkV0OkjI25/Uw7VN
        uOjM6Wr15+eFNku94LfNLShlFI=; b=DCGC7K42wKULXMYV4j86FCHB1c78C01Bz
        bpJs+d2LUJCsIpQUF9b3VY21nucK3y508zsm+KRbvOALj81M0H2bAV6J/m6sMazG
        cOXfaDkn5DeFykCogGPFfi7SEH9zYCM6pO/o4gft2WUEltKQ3NC+TwOVdP76DOqO
        uYD571PhvIJYglB7n5sG2bt64J6q//y3JUiWZtJcNXQ0hEIQGkbUZ+/clYBjTUn8
        mj57G9rZToTSkwD50mEJrhz8dPVSnQr1W4e6PEp5ZeBDbkjmyIJt91D7Ny6dTUtm
        oblfeFf9SmPSONa0TWqkcnNRcYqNJ+rYtcA8hU4VnVVfU/3/QQWyw==
X-ME-Sender: <xms:_HELYUFhRSWvx6IAmVkL9fiUFg2uc9fBYwDdQpfMLFDVQDB3SOf9Ew>
    <xme:_HELYdXqzIGi1uXDyArmf2plstX7BJFR_2Ktr2yTpMX81KwYqrdgVmEHA6JlQ5OMm
    GUP0yF2l2wHcHSVLQ>
X-ME-Received: <xmr:_HELYeKy94g6FSF_GVM7C5RoXE3OfcNO62o-Frbx8hG-NokL6yD3ilb-FPQCKHuQ65kGsiftKPo2QQcvy9Je-cVE8UD79EzVkVS-u_FUVPWdanBtOX-wcISIYGyoJJ4J9ukm_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieekgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:_HELYWGiaQV3Jj5EVUX1jYA7GPWajDC7mIWHadq5U2DToOBBzat8oQ>
    <xmx:_HELYaUNjUGiBESU-pE_JFUGuEk-GZgc89tWa-y9_Q_G3SgK09GRmQ>
    <xmx:_HELYZOpU87xZdlBZ_a6wysxLbAIISxFmlf-wWLH4P3rXRDUVysMDw>
    <xmx:_HELYYxMM-Jg-E3V-iyz33KiWwLbSwE1KERMsggKqEpJ7tvEdF5Zwg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 01:07:07 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH] ASoC: simple-card-utils: Avoid over-allocating DLCs
Date:   Thu,  5 Aug 2021 00:07:06 -0500
Message-Id: <20210805050706.46833-1-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocation of the DAI link components (DLCs) passed the wrong
pointer to sizeof. Since simple_dai_props is much larger than
snd_soc_dai_link_component, there was no out of bounds access, only
wasted memory.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/generic/simple-card-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 677f7da93b4b..10c63b73900c 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -640,8 +640,8 @@ int asoc_simple_init_priv(struct asoc_simple_priv *priv,
 			cnf_num += li->num[i].codecs;
 	}
 
-	dais = devm_kcalloc(dev, dai_num, sizeof(*dais),      GFP_KERNEL);
-	dlcs = devm_kcalloc(dev, dlc_num, sizeof(*dai_props), GFP_KERNEL);
+	dais = devm_kcalloc(dev, dai_num, sizeof(*dais), GFP_KERNEL);
+	dlcs = devm_kcalloc(dev, dlc_num, sizeof(*dlcs), GFP_KERNEL);
 	if (!dais || !dlcs)
 		return -ENOMEM;
 
-- 
2.31.1

