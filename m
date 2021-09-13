Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE00B4089B8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239388AbhIMLBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239365AbhIMLBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:01:04 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D90C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 03:59:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n4so5522240plh.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 03:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3PU6rpzmAIF3MmTwuCR+v+KeUhrwSAWjubDLHIrtCxY=;
        b=Ss+BIxCkMQlL1cgr7i1797ijRqMGE1AOCv2s9LJHpFO7W6Zmcy4yh0ufxohK3IKZqW
         rxCCqepgePJILA3Dw5lwGHVZxqJmTxqIrrxOJ/Xv6vlbKuTrihPclRmhtqu/FINNZDOU
         kAbkWcPRRCMqYwwqRs1e5nseq5+HdwGPUTAvyeSOLKtpP3ImSRxtkWDz2B1Z2mGC7h1c
         fhC+MkuqiFSOoebYUs3Snf3fPKpm2RiziCajYz9bMhC5fR4R7vtGPlYNhwx+TN++f8hf
         ytXoxX0pj1srlNA0tJcFf3jXQtfwVGm4AuuO83P8MRL9dXEo3zLs0oCcqxdK9hdYe0dh
         48sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PU6rpzmAIF3MmTwuCR+v+KeUhrwSAWjubDLHIrtCxY=;
        b=dWqjdfjf6LUdZvljX6AINFCw5p1YL3wRlter0cWQxSeb5XaeonlyYrnZu6PrqdB/xW
         tguwAMYpSbozOeB0ax/0PreTjmLz6KdbjovBoVav1WpSnveY10VvXvqiQJzD8r6gOTtz
         zN9XW4zos5u5vAp3RpGhQ7VyQeutKbypTDc5wabaS7HRUwfhmJzk1EF2JUMMAMbZQTM5
         vENq4EUXF8+zMZZQd0sUPT4s+cz2Y9Hg/2L0H00bH7En8yzttuhjGwwCEgrtmy5l8ALc
         AdmiJr7IlcRToBEi531hBd1w+UqVTp7K60fcdPyrSWOSe+ifEkA7QfAOShwORR48UYzp
         +8VA==
X-Gm-Message-State: AOAM532bSk2ZyVEC04Q7bsQn7kLyM0LUeQg/ezhDWpYkogMW4rgB0dOW
        n6Q/V6CPgSeXJT5/36G/yV12+w==
X-Google-Smtp-Source: ABdhPJzoG/wn03SrwPzbDGmAr3qausM37Tz+CqGb4to6LPLxMAmkbVUxFUD+RaSCbo/4xnujDcSVSQ==
X-Received: by 2002:a17:902:bb0f:b0:13a:5359:d566 with SMTP id im15-20020a170902bb0f00b0013a5359d566mr9868190plb.60.1631530788873;
        Mon, 13 Sep 2021 03:59:48 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id l22sm8279641pgo.45.2021.09.13.03.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 03:59:48 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [v5 4/5] dt-bindings: boe, tv101wum-n16: Add compatible for boe tv110c9m-ll3 and inx hj110iz-01a
Date:   Mon, 13 Sep 2021 18:59:19 +0800
Message-Id: <20210913105920.3719525-5-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913105920.3719525-1-yangcong5@huaqin.corp-partner.google.com>
References: <20210913105920.3719525-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation for boe tv110c9m-ll3, inx hj110iz-01a panel.

Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
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

