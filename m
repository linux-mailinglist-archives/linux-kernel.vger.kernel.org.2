Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EB635C33F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244164AbhDLKAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244818AbhDLJ4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:56:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E254761356;
        Mon, 12 Apr 2021 09:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618221379;
        bh=YkLenhuY71ap6FJ9jM9eylYOZtIVa7oAw7qIa0Pb/co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s08/hGNKPYuCHYg6LIbwCYpokGGMhmzB8TgCEUZo7yvgjXJCoZiy4o4OSq73IC2VX
         I50Upyg9eHcVLWAHf9bVB0GXTev3QMeaWDxEQbVWpuRsDo0XhER8Hvt7mR9uhzdHEg
         Snx+/Gu9srD4o3VAGLV+U43buc9P8YycHSmg7XNs7NikDCmbZXwkYU0ULYJKJv/4xp
         B7gxr5NJ1kqOUUQpXzfiryQHraMEyPjkoolKGYJuWg7UWpLXF1VWUsOaA4Sz7FnjsN
         5AgEBxJejDEM1rmCl9mBbcZS7yl9wiEASOqLRDuHID4FsB0dJwXfMosbAG/b3zXQfX
         WibUrb+HSQfcw==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lVtIj-0000L3-Eb; Mon, 12 Apr 2021 11:56:13 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] USB: serial: xr: add copyright notice
Date:   Mon, 12 Apr 2021 11:55:56 +0200
Message-Id: <20210412095557.1213-12-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210412095557.1213-1-johan@kernel.org>
References: <20210412095557.1213-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add another copyright notice for the work done in 2021.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 1b7b3c70a9b3..6853cd56d8dc 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -3,6 +3,7 @@
  * MaxLinear/Exar USB to Serial driver
  *
  * Copyright (c) 2020 Manivannan Sadhasivam <mani@kernel.org>
+ * Copyright (c) 2021 Johan Hovold <johan@kernel.org>
  *
  * Based on the initial driver written by Patong Yang:
  *
-- 
2.26.3

