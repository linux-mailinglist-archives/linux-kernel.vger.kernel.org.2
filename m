Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE913EDB1A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhHPQmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhHPQmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:42:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF289C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 09:41:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q10so24575257wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VaH1mb4YJaNfLIoBKAGqOfF1CidyUq6GE8UUo9yf+IA=;
        b=0FL71FFEFYgZAt/2TDNCQRJcLZD2MkQLLdGdsGCqZYWqpra+iVRmwzXSODwQZtO7gt
         QU9YZW3WRnh50AlUz/MsVFLpME9SsElyFHsUnbwad24NUpGtq74VMBZ1Kopr161ovvQk
         A+yVSlk26gYm/FmroNM/RifBzC6zfHcaqzlotstlTYmgMBjE85WzFkOhkpfJpB0TyfDF
         vnNeX9EVBOPkURpdcjsTZNDlsyMWPhtVf35FqOJCUZd7nki3E+uMHMtuhUIqqn46g+e5
         aT7sw8vOMx1QLx3vhhdbE3Z8VBKk4SVr+zpvaqjAFRFmsGKEq3OuP8BFoY/yfj40jTXg
         KM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VaH1mb4YJaNfLIoBKAGqOfF1CidyUq6GE8UUo9yf+IA=;
        b=RtXOFVYPy9AJ6ulq5W55Vh9HHvEDH00XIR2m5f4k5otdsOwyDXz0NGX/heYS2wO5t2
         prLkBmpQXGF5Mp74ngI1czQ2/mLPnj4NAAKbrUGmkrAUt8qYuL0Qy1RDNBdQoVlqMa4u
         3P+Qxj6TnkAuOYgIFt1LhjWnvvePR3D6AkEaAJfuTe9lABCTMKTtzJDE9jpoPQN8njB9
         XWDX0/Tdw1iEIpfMVvHKcZ9YossueV3x3YpSa3bLlCvY4MG4QoYkQgzzyt+GR/6OyGXj
         8qFbZrBJOWWkBmDKxb9IFVyXs+oNJ4FUHdmGLuWOtCvfzNLo5XtY3IMAEvQ3SQgub4LZ
         d9iA==
X-Gm-Message-State: AOAM530Opf4hM0pVKOf7R8jb0sXWk1z+OjWfW6OTOiF5wF0dn+mZY/L3
        OPBlerEEdH33F1vSYOpHpAmqDQ==
X-Google-Smtp-Source: ABdhPJxQMWnKzZ0ECLs1a7IEhF2g+rE7+74yku7t8LzXIre6H3dSFys3LS0NMgoW5aqYBTJQ3z4dqg==
X-Received: by 2002:a05:6000:184a:: with SMTP id c10mr19924577wri.26.1629132106459;
        Mon, 16 Aug 2021 09:41:46 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3a81:3690:b885:8dcf:f8c6:7841])
        by smtp.gmail.com with ESMTPSA id m10sm15211730wro.63.2021.08.16.09.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 09:41:45 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     ben.tseng@mediatek.com, michael.kao@mediatek.com,
        ethan.chang@mediatek.com, fparent@baylibre.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 0/3] Add support of thermal for mt8195
Date:   Mon, 16 Aug 2021 18:43:04 +0200
Message-Id: <20210816164307.557315-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds thermal support for mt8195.
Depends on https://patchwork.kernel.org/project/linux-mediatek/list/?series=502403

The changes required to support the mt8195 look very similar to those for
the mt6873 but the differences make code factorisation difficult.

Alexandre Bailon (1):
  dt-bindings: thermal: Add binding document for mt8195 thermal
    controller

Michael Kao (1):
  thermal: mediatek: Add thermal zone settings for mt8195

Tinghan Shen (1):
  arm64: dts: mt8195: Add thermal zone and thermal policy

 .../thermal/mediatek-thermal-lvts.yaml        |   6 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 164 ++++++++++++++
 drivers/thermal/mediatek/soc_temp_lvts.c      | 209 ++++++++++++++++--
 3 files changed, 361 insertions(+), 18 deletions(-)

-- 
2.31.1

