Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415BF40A461
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 05:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbhINDYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 23:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbhINDYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:24:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5C7C0613E2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 20:23:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id 5so7238175plo.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 20:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xXGxvZeRy11wrq81EuFsuIuGp1cxXAYLGS+zZfcIkQ8=;
        b=FUWGMpzYDzNSs1YhVrn4J9x00iaB0aUf5fu/2psw7i1niqGg13CKZBYcUuv4fuN9Pt
         TyvAsNmoPMhNYe5CQtUdiDztWgR5v7qaOy4g6XpdBhEEUnE49lXHDeDbSTBjC4R++Dm7
         exLYw8B66E4vCp6Jbh9Jx3Oa6JpIMmyK8ZXEtA4i30VuU9TnXpKd7H+h5N75tCm/XoZC
         DoGmIDxTL27qkUx16nQsmQ19oO0z2JL/wyTuVhW7sFZdxZzyFWHHHifbj64/ZtQzASff
         MDbwc/IjvYTBXcml1LrMUYBFClE1dReqqOV4HRVhoslz21CU3qt7wz+/1ICS8OQHE0vA
         gm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xXGxvZeRy11wrq81EuFsuIuGp1cxXAYLGS+zZfcIkQ8=;
        b=p4stuBUIOIuTCP3diDg5S4PWIsmi/3CmI8rvSl3wBlvE/0sgd6RX05b23aU9JxM/BV
         ftB1KZv4mW55dBpdeNYbh81FFTLnc/62Sx5Ok+VY1dvKUQD527Woa/6Ze3Zm+IPJE/5V
         1p8PHDrmgYiJQlGIP2kVRLVozKeOISUY6RiBBuiFcZn86Y9uYYgecXwhwmQZ63nUsy8+
         7yU3CMEb7yRH/Lm2z1Q4w4EmTKNEea8oY4V0Pg5WI2NWn4dOQhSFf+JHETkCgKa7gSqz
         Ui/vhvVTiMuEU4qXwCFB9gnnE3REZui/MrdE/ix4Sd0j14fT6WF+jonWwsgXwrpD2P9S
         f8jQ==
X-Gm-Message-State: AOAM5310zmhRSYhinDi/nCc5qTrdkb7CNeLmD9Eq+7BqJteoAzYGal0O
        MKG5foUBx2RuKip31lkuNl5Ixg==
X-Google-Smtp-Source: ABdhPJwSryE04sn4MBsmStYuZGgSfTNorV0kSo8J+9jlVkj5QEy2MmNtVex6BzGNLAeS2J9ZC4EDhQ==
X-Received: by 2002:a17:90b:3e88:: with SMTP id rj8mr3201634pjb.86.1631589795442;
        Mon, 13 Sep 2021 20:23:15 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id x15sm9354101pgt.34.2021.09.13.20.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 20:23:15 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [v6 2/4] dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Tue, 14 Sep 2021 11:22:50 +0800
Message-Id: <20210914032252.3770756-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914032252.3770756-1-yangcong5@huaqin.corp-partner.google.com>
References: <20210914032252.3770756-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The auo,b101uan08.3 panel (already supported by this driver) has
a 3.3V rail that needs to be turned on. For previous users of
this panel this voltage was directly output by pmic. On a new
user (the not-yet-upstream sc7180-trogdor-mrbland board) we need
to turn the 3.3V rail on.

Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index 38bc1d1b511e..a7091ae0f791 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
@@ -36,6 +36,9 @@ properties:
   pp1800-supply:
     description: core voltage supply
 
+  pp3300-supply:
+    description: core voltage supply
+
   avdd-supply:
     description: phandle of the regulator that provides positive voltage
 
-- 
2.25.1

