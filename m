Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237CB337D44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 20:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCKTJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 14:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhCKTJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:09:05 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CA1C061574;
        Thu, 11 Mar 2021 11:09:05 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id bt4so3935557pjb.5;
        Thu, 11 Mar 2021 11:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KVD/yX0YVXjpbZWf4Wsmpu6bg5NBDiXGNWUgz0L2nkM=;
        b=nU++/H2VZmR0Q80Vg/vwaGppBKK9HLgOm5KAAzU6IcBIU9pTnk8eWuOdaZhZ4hkEVt
         stcsNzC4bXWCxqBlYCLc2kJY5wO2Vb4VPbxw6TLRJk1Vz6j7Kr0kp9kDgDfz6TXE/d9f
         GcpS4p/mcmPipiAc2mO3fv/csZL6dlklII/1sQVQGUrUjAEJ8Q6rv98PXdURqtZtSsVQ
         D9Sn3eXTZrtIgkiehxgUWkGN/EWp6bXtGixxfZg7ZbjsaU8d/+J5dm7HxwFOn1Dy8kP5
         Maqc2fpWhqF9VXG4Ld/8QNUCU4mHQARibH4+5oLGqCdrOU7knkocP1MfTjrOXH9QgmGB
         2GVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KVD/yX0YVXjpbZWf4Wsmpu6bg5NBDiXGNWUgz0L2nkM=;
        b=PvoVfT1U2k6yvwLPMMBaDURZYen3DIMnbQ72O6H6LFQf6MxZvTcYNu6KBWf2BQ2oqi
         RWG9R1saqJpkgSuLIHyf/OE7B+1JogAn+XCWfJu3oce+S0d/N5X8rXk8+0Qssw9V4Yli
         IPcfGUNkpOka6Kww3+XuaHCLdqAhyabRa4jgjcLEIpUJpI5ywTdQjxaNjbosJeBZ7Xdn
         ZPOxRi7xIet/DepehdxlTHo1WYVHs8CBrukoVVk20panzo7foFcc6NhmIY45QFdSIMkP
         iaGkE9RktEgEVCzCq9cv0NzAYfRmi6enqYP579+xNc6eUcjYijhhRSXaYnTZFLNSR7u4
         36DA==
X-Gm-Message-State: AOAM530LFBUauCJTphrQgiwVQ5w0NYIV0Yla5RYl32QdSZLE4bkZw900
        EzHv9h0JH+Xhrn5oX5p+dxfxVVyzqzcgHa7e
X-Google-Smtp-Source: ABdhPJxMpW7+8b3Kyapq0+kjxpRHhJwvARg1L9EumKyIfJy1NAyfoXNnqM3STGrn6khWudB/GWe4vw==
X-Received: by 2002:a17:902:ac82:b029:e3:bca2:cca7 with SMTP id h2-20020a170902ac82b02900e3bca2cca7mr9365484plr.43.1615489745172;
        Thu, 11 Mar 2021 11:09:05 -0800 (PST)
Received: from localhost ([122.167.149.62])
        by smtp.gmail.com with ESMTPSA id s62sm3193981pfb.148.2021.03.11.11.09.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Mar 2021 11:09:04 -0800 (PST)
Date:   Fri, 12 Mar 2021 00:39:01 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gustavoars@kernel.org, lee.jones@linaro.org, vulab@iscas.ac.cn,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drivers: usb: host: fotg210-hcd.c: Fix alignment of
 comment
Message-ID: <20210311190901.gaw7m7ndib3uzakm@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The * has been aligned on each line for block comment.

Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 drivers/usb/host/fotg210-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index b20898dda1f3..6cac642520fc 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -2699,7 +2699,7 @@ static struct list_head *qh_urb_transaction(struct fotg210_hcd *fotg210,
  * any previous qh and cancel its urbs first; endpoints are
  * implicitly reset then (data toggle too).
  * That'd mean updating how usbcore talks to HCDs. (2.7?)
-*/
+ */
 
 
 /* Each QH holds a qtd list; a QH is used for everything except iso.
-- 
2.17.1

