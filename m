Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEAA445352
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 13:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhKDMwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 08:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhKDMwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 08:52:13 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23011C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 05:49:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w1so21100376edd.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 05:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TeIP1bg1nWHRvXywBIkPh57uX1vDbH3a6UVlj7rXquc=;
        b=dxy2RvSOtGGojyBOY1BA/K+J75Ev1g5AtRy5gjPrGY1SBf9C4F/2UQvw1c5DG0XN9V
         OawVBcEbTkqTyWvJx59CO47gthqHCNwQYnAOj5yfPdnlSdTMoUNc12jsepuv0/rsxcRB
         PX0ilCOeE/Ru/ZJdjh2zRDaB4O9F9k+KSAAhD6F+ajtJpL1Gb5QGHHnWAhR4mcrL6aWK
         V25UC8KQiQ89SMjGi5kTIKRIdIMKZM60gdo6jK32tXpXNUbHCQNxw+VYCLnrAeV9mwwF
         u+yyO2BfR27nt2ehWWvNKAKIf01tAT+X9nrRXaDXxNH/w8lWAEUC4XHzc+vXGzMJmqk4
         Rozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TeIP1bg1nWHRvXywBIkPh57uX1vDbH3a6UVlj7rXquc=;
        b=B8/7Ctm2UnzmPw+fkxCNPvmoHbOTgMPBmwuDRqizne9RqBpbURYPVCcsdhOHqV0hLZ
         gtj8YCUaRZqbyQP5XvZrloPL9HgSq9Gra23Xby+penPW4O3GJL9Fp9detWVLRxe540px
         6cn3EQO8tV2NT8ZpwfLhh4uILQ9xWJHZcc8shBUyUzjO49YSCoHjfnasA4xcuhKXX806
         NJMIbnMLGfZuFSRhOvknVCuySfYfdu3UDjDzvLbfAJ69jSy9E1o+83Dbgl9GggixZUCm
         1YX7K209cEgoj+DC2CAw0KXME8OacyiJQZjOLdqM0tpU3R+2iHmVztTuCwOiXFwUstFB
         EcUQ==
X-Gm-Message-State: AOAM531qba+RRfRM45Sw0womkQ9mMch16WBxNscWwEqjRmCosIzvhGU4
        t5GSd1zxNEBZw8LNyuvEY85z5SAd4Xdqow==
X-Google-Smtp-Source: ABdhPJxEx17h6r1dqFFx8yhuTLUlvsaYjBMRd793XG8IBVIl8PNGOwxm8DM4LI9TLvpLhg1gY6r8KQ==
X-Received: by 2002:a17:906:76d4:: with SMTP id q20mr7196983ejn.380.1636030173682;
        Thu, 04 Nov 2021 05:49:33 -0700 (PDT)
Received: from fedora.. (dh207-99-83.xnet.hr. [88.207.99.83])
        by smtp.googlemail.com with ESMTPSA id gb3sm2555432ejc.81.2021.11.04.05.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 05:49:33 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Gabor Juhos <j4g8y7@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>
Subject: [net-next] net: dsa: qca8k: only change the MIB_EN bit in MODULE_EN register
Date:   Thu,  4 Nov 2021 13:49:27 +0100
Message-Id: <20211104124927.364683-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabor Juhos <j4g8y7@gmail.com>

The MIB module needs to be enabled in the MODULE_EN register in
order to make it to counting. This is done in the qca8k_mib_init()
function. However instead of only changing the MIB module enable
bit, the function writes the whole register. As a side effect other
internal modules gets disabled.

Fix up the code to only change the MIB module specific bit.

Fixes: 6b93fb46480a ("net-next: dsa: add new driver for qca8xxx family")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/dsa/qca8k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/qca8k.c b/drivers/net/dsa/qca8k.c
index a984f06f6f04..a229776924f8 100644
--- a/drivers/net/dsa/qca8k.c
+++ b/drivers/net/dsa/qca8k.c
@@ -583,7 +583,7 @@ qca8k_mib_init(struct qca8k_priv *priv)
 	if (ret)
 		goto exit;
 
-	ret = qca8k_write(priv, QCA8K_REG_MODULE_EN, QCA8K_MODULE_EN_MIB);
+	ret = qca8k_reg_set(priv, QCA8K_REG_MODULE_EN, QCA8K_MODULE_EN_MIB);
 
 exit:
 	mutex_unlock(&priv->reg_mutex);
-- 
2.33.1

