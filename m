Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F53D3D2D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 22:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhGVTjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 15:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhGVTjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 15:39:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A197C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 13:19:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e2so19979wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0ujdD2seOYmwOyOkYC6FtXby/xqiK1w3z/QJHZVeUo=;
        b=uFfJUeBpm6ybWaz/H7K9rD5nZgtUEIdWY6cybO1HgwSG+c4lmW4zl7YeqzApLDAU79
         KK3BUr+8ZGL5bREGhM/6mFovP24OK2rouw/2e7XQ/cJiOD5il0K14gKxK+wpRU6F07aE
         RMa1sI1lclRNAlWPatUGSoEeqkCkI6Qj6eEwomKH3Y5obX78y8zuWjt3apE7IydgBPEi
         lcRCG1yyc9qrLnTSNYmZ0Si6NQ7J9pZCUVM/TvFRte6KNoIIj8QUhu0/KkwyQuY5bjG/
         0WYmeEl1BHFno/bW3z4panCE7Tdz055RJwl031EHhrseTgBp8YPRulqlmtNuwCS5X4D2
         +Tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0ujdD2seOYmwOyOkYC6FtXby/xqiK1w3z/QJHZVeUo=;
        b=iOQ72ikbsgDlxZ17VOK3BgfTMRiZyCKcUshvF95muJ6fy0r9eHbKm1ESEOMpdrVldq
         Lks9ggmNCyHcGyhHadD+XW4QTIwO/HBuDBFelQSyOgO3NUZUMZ0RGO0YUkW1VOAPh5J+
         602rkebyFxJs2Kdit7I9F2O71yTEuB6B0hhM69d3E3FnrVjBugPYBVluomJnAxpbwTct
         18H+aJlszWaGZfnzDNdCWYhZPONVEh+OGWMBQHn3KTovCiXxjUxcEinciole18O86jif
         6Q3LmYSUfQv06H5uwozYHNH6B3OoPsdp0hbUd2G/p7pqmdpackMgggyZX8oCg0HCaZtA
         HQNg==
X-Gm-Message-State: AOAM532Z1hUR8KZ836r4OxqGoxQd6rNKV3BhQJB50PEkJjrM5+ZLEZQw
        NEn3PKuX2zmBOQ2MtA1jiWaqsSHRI6E=
X-Google-Smtp-Source: ABdhPJyM3/gin47Mhu/ruXQQO51dCG/tfyPiS+lPafEqkJdR3gME5Gg+JCO8yhcsV7cvWCEv/0FlaA==
X-Received: by 2002:adf:ed4a:: with SMTP id u10mr1718637wro.330.1626985179173;
        Thu, 22 Jul 2021 13:19:39 -0700 (PDT)
Received: from valhalla.home ([2.29.20.106])
        by smtp.gmail.com with ESMTPSA id o28sm32742054wra.71.2021.07.22.13.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 13:19:38 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH 0/2] Check for endpoints in fwnode->secondary more sensibly
Date:   Thu, 22 Jul 2021 21:19:27 +0100
Message-Id: <20210722201929.3585671-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

A while ago I patched fwnode_graph_get_endpoint_by_id() to check for endpoints
against fwnode->secondary if none was found against the primary. It's actually
better to do this in fwnode_graph_get_next_endpoint() instead, since that
function is called by fwnode_graph_get_endpoint_by_id() and also directly called
in a bunch of other places (primarily sensor drivers checking that they have
endpoints connected during probe). This small series just adds the equivalent
functionality to fwnode_graph_get_next_endpoint() and reverts the earlier
commit.

Thanks
Dan

Daniel Scally (2):
  device property: Check fwnode->secondary in
    fwnode_graph_get_next_endpoint()
  Revert "media: device property: Call fwnode_graph_get_endpoint_by_id()
    for fwnode->secondary"

 drivers/base/property.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

-- 
2.25.1

