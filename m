Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443B1325538
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBYSJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:09:23 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18977 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhBYSHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:07:31 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6037e72f0000>; Thu, 25 Feb 2021 10:06:39 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 25 Feb
 2021 18:06:38 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Feb 2021 18:06:36 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh@kernel.org>
CC:     <jonathanh@nvidia.com>, <kuninori.morimoto.gx@renesas.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [RFC PATCH 1/5] ASoC: soc-component: Fix return value of snd_soc_component_set_pll()
Date:   Thu, 25 Feb 2021 23:36:00 +0530
Message-ID: <1614276364-13655-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614276364-13655-1-git-send-email-spujar@nvidia.com>
References: <1614276364-13655-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614276399; bh=MRsEzDmf7J4bxm3LNb2m3+5Sy3ePQpn1ormjOx9bR/Y=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=rjwIH2EkYa0ZBOPnaNJu7vhjIgmBT2tQ8vnw6WoTJB9a5ab17z4EgJSmbwECxUM4O
         FpxT9CjPwJQRe001VBcNuN4szeZscfAf92f5sekbJYkU2AaWe02c8AErvX7C9DVKQd
         FxS35NvFyuprX6GiJ7HcsTvXVut34PGx4PDRxfgua7ZXxMOnVMjQCLjchyDYtHJabB
         SB4ApQEEvW5UxhECAlmf94Nfah26k5+sVHSYll3BejpAbSV9triIpPCB3ZOSYwtVJe
         7FPubV607Hul0rT4/1tO6uYwZnd9QlAv6LhqnSTy6eoQqcb1HV+8Qxoyy26WbXZRrm
         mUmC4Lr+xT0Pw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_soc_component_set_pll() returns "-EINVAL" and prints following
error if a component does not implement set_pll() callback exposed
by the component driver. This happens when snd_soc_dai_set_sysclk()
is invoked, which in turn calls snd_soc_component_set_pll().

  "ASoC: error at snd_soc_dai_set_pll on xxx: -22"

Above is not necessary because a component may not need additional
configuration and chooses to not implement this.

Fix this by changing default return value to "-ENOTSUPP" and driver
code which invokes snd_soc_component_set_pll() can ignore this error.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/soc-component.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index 159bf88..fd04e75 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -109,7 +109,7 @@ int snd_soc_component_set_pll(struct snd_soc_component *component, int pll_id,
 			      int source, unsigned int freq_in,
 			      unsigned int freq_out)
 {
-	int ret = -EINVAL;
+	int ret = -ENOTSUPP;
 
 	if (component->driver->set_pll)
 		ret = component->driver->set_pll(component, pll_id, source,
-- 
2.7.4

