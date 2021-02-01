Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B158630A1A4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 06:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhBAFvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 00:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhBAFqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 00:46:52 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6B5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:45:45 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c127so12071552wmf.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6hq9bDI4hag8HudmtF2Bm0TltsRh7MZgeaneVATDrPI=;
        b=mkZzcusQqcs5Pi6sA1AlPtTYE1SiULovPCNO4QWsrrAZKaxor/+faXeBjflYWDDxfM
         s3IPwbBMS22NOE9EW6ssPbXgmJKtzqMzMjJHqJURvi10615DowHxzMpdCy3B34ZoX/IT
         3GgBly+zktPKEffl8XX5hFB5uksG4Ek1v6d9PK8sTfz6ikTyetr4yK7DhxDLeWOVAom2
         CrzzUEU3Iq/AB73044u810bmf3Z6jC8hZWQB8vzRQDaPktIn/irxfS/Mk8UFWCGeXfEn
         GcefacN2KW5TtoFGf/F6qpYOjSzScepel53x+q3jyBZXdAzyHIKYFMUZ+x7Ar1bBkhfF
         qF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6hq9bDI4hag8HudmtF2Bm0TltsRh7MZgeaneVATDrPI=;
        b=qFB9+AZ65+Hay2t9oMkkMS8cns2SMpmNU3gFKQwaMmDGsLDtRK5j3tVUpxiB0gPU0I
         H+mAuzmHedRhQxqBe4wKOETulmeWuspqaCoOW093aSzx1+PlPYcv9I5+ScVOfckX6tsA
         7CmFMGmCdu/NhEWaK1vnto9DqRHL25Yj+Om2QsMqfjufFWkpm02CHHR6SQZ1hFyJU5kA
         SaOl6UAfQq/vP33YW3zcDq7Qf3gIAw8MZvxWkV7GXb3Pp0tdBQnRx1u3UW6DULNCmOPt
         5jRaXuLYmrfG3bJNT1dL5c48wGoFWCJasaEaoyftRVo8jRBY/8VSZIbztrkL5kFpkezU
         azBw==
X-Gm-Message-State: AOAM533B81mYErLUegY+MTRsCt8SyzBK8w+mwREs6vOuAjysOcMCnoUV
        lJ2eM0DzS3y+8+Cz+5319/E=
X-Google-Smtp-Source: ABdhPJxbkyB5+dL1KWNCmyOBlqdpXq5cxY72VqKglwnvK2RfKDs3rSwOjATMCsxI0a5DkMonHMi2GA==
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr335713wmk.17.1612158344186;
        Sun, 31 Jan 2021 21:45:44 -0800 (PST)
Received: from localhost.localdomain (cpc141888-watf13-2-0-cust663.15-2.cable.virginm.net. [86.14.42.152])
        by smtp.googlemail.com with ESMTPSA id r25sm27123540wrr.64.2021.01.31.21.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 21:45:43 -0800 (PST)
From:   Bilal Wasim <bilalwasim676@gmail.com>
X-Google-Original-From: Bilal Wasim <Bilal.Wasim@imgtec.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, enric.balletbo@collabora.com,
        hsinyi@chromium.org, weiyi.lu@mediatek.com
Subject: [PATCH 0/2] Misc bug fixes in mtk power domain driver
Date:   Mon,  1 Feb 2021 10:45:40 +0500
Message-Id: <20210201054542.1470695-1-Bilal.Wasim@imgtec.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Incorrect mask for the "bus_prot_clr" field meant that imgtec
gpu power domain (mfg_async) was not powered up correctly, causing
failure in driver booting. Fixing this and also adding "domain_suuply"
capability to "mfg_async" power domain (for mt8173) as imgtec gpu
needs da9211 regulator to be enabled before enabling this subdomain.

Tested with mt8173 elm chromebook.

Bilal Wasim (2):
  soc: mediatek: pm-domains: Use correct mask for bus_prot_clr
  soc: mediatek: pm-domains: Add domain_supply cap for mfg_async PD

 drivers/soc/mediatek/mt8173-pm-domains.h | 1 +
 drivers/soc/mediatek/mtk-pm-domains.h    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.25.1

