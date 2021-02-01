Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7F430A1A1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 06:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhBAFtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 00:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbhBAFqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 00:46:52 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DE2C06178A
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:45:48 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v15so15219124wrx.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=A6nqzjnju0Qhug1o/Lp3c3yaK8vd09BbFSgR2jNN2os=;
        b=HUOIhEGcfxfn8L446WEypesTISgace3Zfj3t+CN+U/snn6XBaUek7PLugfoeumpQ+Z
         fG4zsr/ifmE8CcogDYGl3Da5H9HkEOrQRQBSwFN7yxjFdVjbEW8wlFrtEo2StbTI5V2Y
         AFCsf/caRliaM7KrrPshjo0+qUakjaOGzLSZCeyn8XhFLSKFxuqBd9ajLYl/1zre19Vu
         e10M3HnuiSz/Kns30zB99QcwxBQpwk/kfN2n5i5ZmRoDAK2YJL/r9Ekw15eoZWaj7qhl
         aAGjkHlRReIyR27VjmHgS+dTLNmAoHWchraYcK6TKt0L1H6Hh+3wKm4FMAWS8iYUEzb6
         cvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A6nqzjnju0Qhug1o/Lp3c3yaK8vd09BbFSgR2jNN2os=;
        b=Y57k56lxYB2TvGigJYrXBvrpgS01x6RMsEae/xatGFCZiv0DAKkzO0/1NfMbTmR9lz
         MniYOgM+jC2O/pYGo/eosp+d0teIF9CKjwNoIm5n3HEQ7UpbhyuqUv57d+d8eo7qO6IK
         J3T7yRfGKiTyj3EWfZQ6vDnX60Z3XLsmMVacYH4PfapdUB2aVR0aEvw6rO4ZPbTKjcU+
         uYypqj10qxni39lrbOTKm2z4YyeyNaEZm+STJAoxhNPTx/NXsiJ582fsxT3mH8mz8lKd
         mxFw/t0V5bqxVtUqhnoOvY23yNAiNDGmLsy9x7kuU9zasuuQkr/DQiWyjnRQgb5+mp8b
         XHUA==
X-Gm-Message-State: AOAM531+IJklejkPeujrj7+ODe8BZSDVZo7tY4JUOKsEIyaWImHTSQxe
        k7zILniFev8kdMMZ2teYsQU=
X-Google-Smtp-Source: ABdhPJwOxoNhyRFfFK7IapulMZIkG3cro5Uw/IVmbj1j9tqBC7WXrQU5KVCjAjt5m/pcL4Tu5cv/gQ==
X-Received: by 2002:a5d:50c1:: with SMTP id f1mr16556956wrt.235.1612158345806;
        Sun, 31 Jan 2021 21:45:45 -0800 (PST)
Received: from localhost.localdomain (cpc141888-watf13-2-0-cust663.15-2.cable.virginm.net. [86.14.42.152])
        by smtp.googlemail.com with ESMTPSA id r25sm27123540wrr.64.2021.01.31.21.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 21:45:45 -0800 (PST)
From:   Bilal Wasim <bilalwasim676@gmail.com>
X-Google-Original-From: Bilal Wasim <Bilal.Wasim@imgtec.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, enric.balletbo@collabora.com,
        hsinyi@chromium.org, weiyi.lu@mediatek.com
Subject: [PATCH 2/2] soc: mediatek: pm-domains: Add domain_supply cap for mfg_async PD
Date:   Mon,  1 Feb 2021 10:45:42 +0500
Message-Id: <20210201054542.1470695-3-Bilal.Wasim@imgtec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201054542.1470695-1-Bilal.Wasim@imgtec.com>
References: <20210201054542.1470695-1-Bilal.Wasim@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mfg_async power domain in mt8173 is used to power up imgtec
gpu. This domain requires the da9211 regulator to be enabled before
the power domain can be enabled successfully.

Signed-off-by: Bilal Wasim <Bilal.Wasim@imgtec.com>
---
 drivers/soc/mediatek/mt8173-pm-domains.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mt8173-pm-domains.h b/drivers/soc/mediatek/mt8173-pm-domains.h
index 3e8ee5dabb43..065b8195e7d6 100644
--- a/drivers/soc/mediatek/mt8173-pm-domains.h
+++ b/drivers/soc/mediatek/mt8173-pm-domains.h
@@ -63,6 +63,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = 0,
+		.caps = MTK_SCPD_DOMAIN_SUPPLY,
 	},
 	[MT8173_POWER_DOMAIN_MFG_2D] = {
 		.sta_mask = PWR_STATUS_MFG_2D,
-- 
2.25.1

