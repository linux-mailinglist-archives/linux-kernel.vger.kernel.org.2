Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944C33F960D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244624AbhH0IZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244646AbhH0IZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:25:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAACFC06129D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 01:24:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so8443474pjw.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 01:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jLsLHxbd3S4fLhjqH4jOQcn0e2LX+uyZe1sVTwZGed0=;
        b=kWMrAoKSV+P98zUQj80khcge2kuQuZ9TplBLiiFuxmahSR3sar03XWITz8IRu5NlEg
         2yPEqDlAg4xU40qPy7BDI2010AjkKoZvuMJfDB5Q0PitN31kZ08/08aw/RPCq+LMzIfT
         wdYmCh0Jjg/HmjIbYuUcx5ndcDqUE6vPauBi3jJk6c0l09JDWH7Oh10Hlebi7Urbv/0a
         DedX27D+K2EmKs9LS8TrjNr57xqLpXM7+e8D2SVH0dh5FGb9ujAqABq937MG+s0yv3uH
         to/zh+xcZC0vexcpm3iAyD4E6GHiRLdVB9DzUMTPpSxGrM81H6qogMJ3qZsvhgwEZV8e
         zG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jLsLHxbd3S4fLhjqH4jOQcn0e2LX+uyZe1sVTwZGed0=;
        b=W2gzW1Dc3TO3sqrXHxOIXNNLFHxiIFbluFlQ8F9LKP0YMyaa/ai6mk1oSENa2oEfRF
         rUBMTmcMPIGpUWSalTeZKylAVYsT2E58bUJASF6Ikiii87/7jcWHl6I7tS3a59Mde7i2
         QQ41R92trVit/5CxSTArkESd2O6Z1CceZ+gHP5/uX1PLGeXglj8B9xoXsrR6BB5gmHq/
         a9ZsNliYQruZ03+JxwOabiScw0Lo1PwrVEJeQkMr+vUASchByb5t++/yZCcJSVtqDRbh
         BqBEUjbM3pHP/yAC0osmvNNjWiVquTKHIaxXv/gFaXisqcv7OpilSl3mCOZb0asgcXvL
         omqg==
X-Gm-Message-State: AOAM531EbGrq7tqeTyn0yEfGpoL84QbwpT6deeOafZddC55ofqMVUQYI
        TzyXj1SZz4WgqFLFf+tCrtecXw==
X-Google-Smtp-Source: ABdhPJyFwInI9upXRx4q+KT8Bp36P/OXbwoFTTpiMb9TyNAh25Zf/DLxOU3ql5iXB18AsaHtfmLj+A==
X-Received: by 2002:a17:902:ba81:b0:132:3a70:c16 with SMTP id k1-20020a170902ba8100b001323a700c16mr7538652pls.60.1630052678314;
        Fri, 27 Aug 2021 01:24:38 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id m18sm5391371pjq.32.2021.08.27.01.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 01:24:38 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v3 4/4] dt-bindngs: display: panel: Add BOE and INX panel bindings
Date:   Fri, 27 Aug 2021 16:24:07 +0800
Message-Id: <20210827082407.101053-5-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827082407.101053-1-yangcong5@huaqin.corp-partner.google.com>
References: <20210827082407.101053-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for boe tv110c9m-ll3, inx hj110iz-01a panel.

Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
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

