Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362F03F9604
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244449AbhH0IZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhH0IZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:25:02 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6502C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 01:24:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id d3-20020a17090ae28300b0019629c96f25so1409556pjz.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 01:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnQHZ7OHj8PYIqCneFXHqZGg6bFZw4p6vs1f3Gs6uwM=;
        b=dxJqFOoPY8wPi8gLe0f2xlGZmgweXxliaEtfzrMiuc21g4Bj750eiDF/bS7XKfr9H0
         mcKcZvq2EATPKfJwP9Oe/vr51jxfb7Qf0uhwnViklEkeoPuX9ZtkacK55ZRj0uTOwbqk
         2wgWucaMvLs8/csJtOYxvXEj+ZhDlS/vePLO5H23dPOYqL92EE3ywjragTUNYUojPnvT
         M7qhIGHIsUbXc7Rr2Ehd4KwOXR+POqnpt1S4GPzMqyBodG8XixXQFFdRxn7Cc0BUGlWf
         C2pecOJdTKIKunoLFYymLhyv/fvue9FH+LVAz14KWlA1hcZSdIMQRtvq80yvLgXIZsoO
         S4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnQHZ7OHj8PYIqCneFXHqZGg6bFZw4p6vs1f3Gs6uwM=;
        b=syVzi0xGi8w2s9E4h7v9PnGrKjXH31xA+g3mAsWMRWcLzV3wXMC0oAEEXuWi7RiZ8S
         j53QfF5zpsf9Vvk5uwCY70bpYIqQ7Q0ntJp73s6GOdqlmhuZH+fuViEnI2StZvOmlgnX
         nMVc1iA51QA9D3M1mTF1d0RGdaDQym2O3eqa9Ntjrm9JsGhARGuIBjziix8q4qlIfnkS
         Hb3kWhD1dYhQejWtNA9jWED7LoB1iYjASgDLrOhBfhPHGrcO83ZCTczjIATBk+BR/Va1
         ks1PDD1hqiyhH6JoeK+ez8e6L8rBzF5TxVNUA75QVGNuSAVEw7kyIrWvhVPNkaDJ6LO/
         8hug==
X-Gm-Message-State: AOAM530GAK0pGeU8IR8oUz/zuUugOJ5R729CGaYnv8r/lIzshQgRKP4g
        5/kianQBGMcWlVA3ZL4skOD4Rw==
X-Google-Smtp-Source: ABdhPJzw4pDHx0EMRNGp+WS529vxWxckErf3pl+6/0Z0VJdHVur0BVdRZEVSEldDiI+i+NCCTDWBlw==
X-Received: by 2002:a17:902:7882:b0:131:2e12:c928 with SMTP id q2-20020a170902788200b001312e12c928mr7555092pll.74.1630052653443;
        Fri, 27 Aug 2021 01:24:13 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id m18sm5391371pjq.32.2021.08.27.01.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 01:24:13 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v3 0/4] drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Fri, 27 Aug 2021 16:24:03 +0800
Message-Id: <20210827082407.101053-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compared to v2, support for BOE tv1110c9m-ll3 and Inx hj110iz-01a 
video mode panel.

yangcong (4):
  drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
  dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
  drm/panel: support for BOE and INX video mode panel
  dt-bindngs: display: panel: Add BOE and INX panel bindings

 .../display/panel/boe,tv101wum-nl6.yaml       |   7 +
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 926 +++++++++++++++++-
 2 files changed, 930 insertions(+), 3 deletions(-)

-- 
2.25.1

