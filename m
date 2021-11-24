Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF3945D0DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 00:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbhKXXOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 18:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243588AbhKXXOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:14:01 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6B3C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 15:10:51 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id c4so4096406pfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 15:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Swlp/EDwl52MALOj9TDs7eiM3OyX943lD6zJZmjHC4g=;
        b=MmKJeaIsBv2CJin5wZ74nmdLIDJzCtxX72xYb4484fB7ipFe5RVHGVYUUtIbGjQjhU
         /pEvtOLjbX537Dd18/m08R3f7LlVxNGmUmTb2TK69KyYOeEpqkCQStTze/zRzn4Yruib
         x28A/s2dsmYfRY6k3w5bMtCAbOnVHqAndeCho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Swlp/EDwl52MALOj9TDs7eiM3OyX943lD6zJZmjHC4g=;
        b=Xlrv9SqrO023r3d/SlUazGrunbkojG5IooIMLG0Bv7NzIMJWuYGcyskNj7n/jKlMxW
         w0nfWnlpLRXGyiBx4n67+8qBoanrI+Cd5bWsJzjBf6obROs3nTA6RVx8bIP7XTl/Ngg2
         vE2w3SXlaGYQxIymisZsg8ibCw+Wh2RpFHqPPrNyaWEgRHI5uPjSe+e/GCEUUFq4RLwd
         nT3PHbdnMC+TUVnUy7G9stOj9bQGOWEvKnJDVm1K/Io88zMTMKNpY17cieGzOXLp48zY
         Db/csibVCn+DBxqbg5/W56FJO8S4zEWiiuS7LkRXMUN8nL79bFSK7ADUPifosNV4jkf5
         d5Ow==
X-Gm-Message-State: AOAM531wkmn5XuIzL5OsO5k4scljaQLXttxVA4jMpzgjc5vIs7nn2e1v
        PCjCovc1X+f7rB1gsvgeLsEXhCrtX1OLwg==
X-Google-Smtp-Source: ABdhPJwh3tgQhmfHg74oXNzlJTegsSlt+0KSe6u/ypuZIH0GgNjKlkV9Q4wWoJOs+IsVIuYSNswdlw==
X-Received: by 2002:a63:d047:: with SMTP id s7mr13105838pgi.470.1637795450371;
        Wed, 24 Nov 2021 15:10:50 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:6bc9:896a:9df2:5d61])
        by smtp.gmail.com with ESMTPSA id nn15sm5783296pjb.11.2021.11.24.15.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 15:10:50 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     wonchung@google.com, bleung@chromium.org,
        heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rajat Jain <rajatja@google.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/4] usb: Use notifier for linking Type C ports.
Date:   Wed, 24 Nov 2021 15:10:06 -0800
Message-Id: <20211124231028.696982-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series resolves the cyclic dependency error which was introduced by
commit 63cd78617350 ("usb: Link the ports to the connectors they are
attached to") which lead to it being reverted. The approach here is to
use a notifier to link a new Type C port to pre-existing USB ports
instead of calling an iterator of usb ports from the Type C connector
class. This allows commit 63cd78617350 ("usb: Link the ports to the
connectors they are attached to") to then be submitted without any
depmod cyclic dependency error.

The final patch removes the usb port iterator since it is no longer
needed.

Heikki Krogerus (1):
  usb: Link the ports to the connectors they are attached to

Prashant Malani (3):
  usb: typec: Add port registration notifier
  usb: Use notifier to link Type C ports
  Revert "usb: Iterator for ports"

 Documentation/ABI/testing/sysfs-bus-usb |  9 +++++
 drivers/usb/core/hub.h                  |  3 ++
 drivers/usb/core/port.c                 | 20 +++++++++++
 drivers/usb/core/usb.c                  | 46 -------------------------
 drivers/usb/typec/class.c               | 33 ++++++++++++++++--
 drivers/usb/typec/class.h               |  1 -
 drivers/usb/typec/port-mapper.c         | 41 ----------------------
 include/linux/usb.h                     |  9 -----
 include/linux/usb/typec.h               | 13 +++++++
 9 files changed, 75 insertions(+), 100 deletions(-)

-- 
2.34.0.rc2.393.gf8c9666880-goog

