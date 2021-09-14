Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98CC40A456
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 05:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbhINDYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 23:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238906AbhINDYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:24:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B89C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 20:22:59 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o8so4158857pll.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 20:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C0Pyszb77kVFDjaQaXOEMOCa900lerPKMQKPppnAJQE=;
        b=0INH2Bplst7+ZbmgVuhok9MU/n0Qi1bLUfBwcxdaa9J3m4tHivoOILLqQCQKIaWrKC
         P7+kG8mL2xGcn6NKojhGLytFJTIO5ojEtoc6ZYxamPjPH1SdjMyQebPt5zgCB5ZO0O53
         zTEpOGQ+i1mk/K9FCy5CHYyfp2xkLEiub/p1X+B5Xc56tO6KBCJ1WbxMOmA2ry8+XDMh
         5TYmk0bI8C+dItSoA3cfCVjR3Rd8+FvTvzH5771ehZHdHgD26sN555tVlHQ55iL3/jnq
         86MC0p5F7FbyHQua9t+WOfM+CB0LodetPYAoeeDU8OwRSGQQ1iOCZNybRyuMyUwjviau
         gKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C0Pyszb77kVFDjaQaXOEMOCa900lerPKMQKPppnAJQE=;
        b=RiWa7m7abYVaOkIBAST5cwN9pT9m6fxCAe5L3O4kWm5s7n77DKmZZ4yqUXFVFaa16i
         c9venmt/iyHm1Tfd/trgdpRFiCqTt0W9O5szSSU9zSQpO3PcOXKPrJIk/gRwF+2WRde0
         xKjugLURT9Inw3lKCqQMuIwkqJBaThMY1Hk6a3u/MYzdEaCl/26LHKEAWjucOcL5c4qD
         0l+b1imZXMCxVciHpBtdUpbx59HpOvjOKOAlnS9gQyi3XdL342cY4tofTYc+TAd6L9Mh
         iDX2BB06euJjWNIH1EVYx4WlRRIIoSyjZFWLfFf/nS7Vrvq8JhE3OEjCOhQyRaRxQFyb
         Twxw==
X-Gm-Message-State: AOAM530PENV8fwalU54VaZeF/IlU6o8TaQ8+jj+ksoRMRCe6KlMwf3/R
        y9JtBLwMVhhIz6NTAx50+f+QRg==
X-Google-Smtp-Source: ABdhPJz1DdZK49E07+QyJY5WTECud5A1UoAqX7gpd3q2PdmbPMkP+OUkd6dZhi70kekwXNO1cnbs3g==
X-Received: by 2002:a17:902:8ec5:b0:13a:2789:cbb0 with SMTP id x5-20020a1709028ec500b0013a2789cbb0mr13323405plo.60.1631589779166;
        Mon, 13 Sep 2021 20:22:59 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id x15sm9354101pgt.34.2021.09.13.20.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 20:22:58 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v6 0/4] drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Tue, 14 Sep 2021 11:22:48 +0800
Message-Id: <20210914032252.3770756-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compared to v5, squash this with patch #3 in the series in 
drm/panel: boe-tv101wum-nl6

yangcong (4):
  drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
  dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
  drm/panel: support for BOE and INX video mode panel
  dt-bindings: boe, tv101wum-n16: Add compatible for boe tv110c9m-ll3
    and inx hj110iz-01a

 .../display/panel/boe,tv101wum-nl6.yaml       |   7 +
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 745 +++++++++++++++++-
 2 files changed, 750 insertions(+), 2 deletions(-)

-- 
2.25.1

