Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4098C3FAFE2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 04:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbhH3CkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 22:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbhH3CkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 22:40:07 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1118C061796
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 19:39:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x16so6017633pll.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 19:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZWe9odMZgnt9mjtq2iv4uaqfnCxctrfiTl8at5lg+U=;
        b=H5JVPbTHC8SB8r/+TeRp4H245mDk6SyWLQnjgfEMHdAhlNV/mq4L5R5OVUT1A+px2E
         9k4RQmsdK8EjY8F/XWTekRCMfWyNMQkLrtF2uBaMaRH9b/4nR5u3vQ8chIh5pbV+gxvM
         cW1XDRcH3ABMFvihUp/VMVxbZr/M0RU85KKnFQyFOVwevLPn1O57O2ECc//J9MzbOJmU
         WthZaFTkf0SA7M/I9D5FzKm+pJIDPFEL+DZBJHj2YtfJ6jOHBAbXMNp6PPgJcfBMPIGD
         0CRLHlujjrFyWOICoDcacrvJD+h1qeFUNVv69/g8muXTHwq8LWUdPwpQDxBPLKqA7fCU
         Gm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZWe9odMZgnt9mjtq2iv4uaqfnCxctrfiTl8at5lg+U=;
        b=dXsG5QiOUlx/kzG6jQ0tvKMvUWHD5vPsn9LeGDZh9B2esMVaUhDwo+nt1qLqbmNOn+
         x8P6kCbGv5HE8CIyY6B3u/HTaMuH1KzasI59Rugb8LiuVAczZka4TGS62wb91p9XOQgx
         WotXUIEctUxM9OMXHYly68iPhMWMWVHZnoaKLQfK6EJtXAnStkLsP1qgRXNzsYaZcYSm
         Xi9umQoQo5No56wJ0/f78sBPkHvp/I+egCtgS1V1EqMeneyb/WAICg0fzjYjjBFJ2me9
         UBz/bOT10dOv4+fg+MpE2VxdjLsDl566aceV3+9mbJo+C3lAQW0lecBJ+Mm7fgg1u4a8
         6XZw==
X-Gm-Message-State: AOAM532t6w3I5LsHlXmDlL5siKAsna47aprlVu32NQl0yaHz4frrry0k
        n3nHdl47mUBSW7AZCsaJKpBFMQ==
X-Google-Smtp-Source: ABdhPJyCt808VXD8pif69vuHIxZz9bz2CGJZPLiMhs3Yn7Mxjw9rlv0cHRIwrwSM44nC1ZLlM2qE3g==
X-Received: by 2002:a17:90a:598e:: with SMTP id l14mr36347757pji.28.1630291154320;
        Sun, 29 Aug 2021 19:39:14 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id g13sm906839pfi.176.2021.08.29.19.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 19:39:14 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [v4 4/4] dt-bindngs: display: panel: Add BOE and INX panel bindings
Date:   Mon, 30 Aug 2021 10:38:49 +0800
Message-Id: <20210830023849.258839-5-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210830023849.258839-1-yangcong5@huaqin.corp-partner.google.com>
References: <20210830023849.258839-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for boe tv110c9m-ll3, inx hj110iz-01a panel.

Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml   | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index a7091ae0f791..45bd82931805 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
@@ -26,6 +26,10 @@ properties:
       - auo,b101uan08.3
         # BOE TV105WUM-NW0 10.5" WUXGA TFT LCD panel
       - boe,tv105wum-nw0
+        # BOE TV110C9M-LL3 10.95" WUXGA TFT LCD panel
+      - boe,tv110c9m-ll3
+        # INX HJ110IZ-01A 10.95" WUXGA TFT LCD panel
+      - inx,hj110iz-01a
 
   reg:
     description: the virtual channel number of a DSI peripheral
-- 
2.25.1

