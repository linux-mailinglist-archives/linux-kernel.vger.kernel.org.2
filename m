Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FC13F1550
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbhHSIl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237066AbhHSIl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:41:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8ABC061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:41:20 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so4264174pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mlxsOtjk3EQe8tY0Dl2bnQT6hDTIci57yhrirNK4WM4=;
        b=J7/7iAoHBDmJ+jijEgkPLQqL7yz1iWvqEwo78YK1BwX97MSrHakJ2RbUqycjfuvrK7
         54csJnm2oINVomeUcsMqP3fqP6WMcmypPhExBHa9Q922tMRhNm0K5f5lfmEx9UJQxm39
         WH4XVK+vxAfEskugvFuGWPEJok99CSod9fHWyYnA1Ie6yQAXqtcT2zq4woR2VGBJhKKe
         /EUiKeWCqu9o98hdnZgPUxLHjgIJtN8X73vGw0C+hnExrViimJU5+Twn337t1/EiyYo3
         nCRM0Oob47CtOX1nFN80IJFKw33J9i3xZAeJh2JM+Tz3IdBOVUtTXsoh9seX+YiwD2fD
         //pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mlxsOtjk3EQe8tY0Dl2bnQT6hDTIci57yhrirNK4WM4=;
        b=gkTXvrB7AQIzXj27dMC0vsT0MmSZ0M/HBh9NnFnyQHvARrVzeL2uYtiFU5RHUsEkDT
         5uDTMyWo0tj+3eGSVtxQUWwOAE0iZL0Pny0EkTs2k7xxdZKHze9HJiHdDnkiDeSmGyyj
         qp+qdLydD2JaJpDreofB5hRsfj3wNQe+7AsSd9IhsXK+24//QRZIANZRZkgAs8FMrvJC
         BC+DLC8hmWWDf8GtCD6WvA2/R9DqWp4/F9KRuuuHvk1rKIZkHGfxR8oA5I3dwefNdEj6
         kEzs18HRJTye6NxA/BAFUEXJ74wlC3XR9R3IBYiTkzWOlwxPoZ8PLr4iaomW5kzBDHTw
         IJDQ==
X-Gm-Message-State: AOAM533IEZpKHHAHPRU+149UGmf90yWvAN0PdgF96oWKh2bmrKtzZO7H
        5rIu/O9dTYt0T/XMAw3Zmv4TPA==
X-Google-Smtp-Source: ABdhPJxj6IiPxCEeaWe8hcpu1lJ2CyEbpbuNaQ7LwH3BNdQJgcpu88ogcCz2DITWjeOrYMYdIbDcog==
X-Received: by 2002:a17:90a:bd18:: with SMTP id y24mr14096989pjr.83.1629362479708;
        Thu, 19 Aug 2021 01:41:19 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id c26sm3027492pgl.10.2021.08.19.01.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 01:41:19 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v1 0/2] drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Thu, 19 Aug 2021 16:41:09 +0800
Message-Id: <20210819084111.717459-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The auo,b101uan08.3 panel (already supported by this driver) has
a 3.3V rail that needs to be turned on. For previous users of
this panel this voltage was directly output by pmic. On a new 
user (the not-yet-upstream sc7180-trogdor-mrbland board) we need
to turn the 3.3V rail on. Add support in the driver for this.

yangcong (2):
  drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
  dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail

 .../bindings/display/panel/boe,tv101wum-nl6.yaml      |  4 ++++
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c        | 11 +++++++++++
 2 files changed, 15 insertions(+)

-- 
2.25.1

