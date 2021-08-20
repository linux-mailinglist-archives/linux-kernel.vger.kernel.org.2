Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7E53F26D5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 08:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbhHTGeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 02:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbhHTGeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 02:34:21 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD35C061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:33:44 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o2so8186501pgr.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uizvbGrAGell6LdMB1pzSSzYApXRoXyVsqw6ZRcvWA4=;
        b=1FzClz4/cP22vIiJuVHlGAzTd7Ib7PAHSg++BBzrNQtZk87GbqGXy33+JHRwf2bG9w
         /V0nlxAvcTWDyoxqzpRitPEur2uuK0JjEeAQn5sVKYYw1vg5x2QJ3nMjtQW1JL0a2xg2
         5nhStFIcR+G5IRnwzRVyz8irwDXqNtlKGnCjjECvPtu7SQneOWh2nyFqxpTN6TunXVuP
         dZcbr0y8GdXgoT/sK3cl+fBc19NSRh+Yt5+JnikFM5omtG/nNKhBi1imRFMJQGPGRP0q
         eBxA0spBPqp0bKuF8yK7T/zHFoDkzxdKTMF/S+cSm6auSGc/Eq1UTY3B1GZXHM+f15SY
         5sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uizvbGrAGell6LdMB1pzSSzYApXRoXyVsqw6ZRcvWA4=;
        b=r3paEkSFzBnEZPtWLJEM4tYMWEql6YX30Y5XoPUx/YjeFJZfMIrZyBGCyDnoGfwnGt
         PNj5VAvnpOnyqO7ywhclZgsTG0tksK/vhwMRTiP6xbKD+HKXqxLqDOQdHTOViC6XRlxS
         wxRrOU6Ti9bdn0gay25AQOaRBkaQ07myAQ0FBvg6319Rt7Oev0L5TzbejE0Xhjj6L0iT
         xOpOICBUhzjbnItHt64Zw+l1L6x8sSEfh6P6XC5jR15KZGByIRXjTQuZbAmYHWPa/kuL
         PyOm+uH9wpMYfU5KARrYk6mNegdJwSZnGCpin1l7U2Rel80CZy2+twYb3XHuUjU2fGE/
         yneQ==
X-Gm-Message-State: AOAM533QMQ61h9W5Dc3WGtQcIlLr5IYT+Vf0aEAkHofJxSMq3xcbCGP/
        TGCnP0CP1csFCqCyiV5X+SvIPw==
X-Google-Smtp-Source: ABdhPJz4dCXSZ33XEWhwSZMTETDWB1y7AOtiIjlAEa80L0dWADYvBITxJsFjeraeegigfhEzzLTfUQ==
X-Received: by 2002:a63:1460:: with SMTP id 32mr17343074pgu.323.1629441223783;
        Thu, 19 Aug 2021 23:33:43 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id a10sm5612160pfn.48.2021.08.19.23.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 23:33:43 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v2 0/2] drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Fri, 20 Aug 2021 14:33:35 +0800
Message-Id: <20210820063337.44580-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210819124844.12424-1-yangcong5@huaqin.corp-partner.google.com>
References: <20210819124844.12424-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compared to v1, "pp3300-supply" is removed in the required list:
dt-bindings: drm/panel:
   - reg
   - enable-gpios
   - pp1800-supply
-  - pp3300-supply
   - avdd-supply
   - avee-supply

yangcong (2):
  drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
  dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail

 .../bindings/display/panel/boe,tv101wum-nl6.yaml      |  3 +++
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c        | 11 +++++++++++
 2 files changed, 14 insertions(+)

-- 
2.25.1

