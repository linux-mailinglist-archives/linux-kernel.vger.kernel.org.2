Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C4B340957
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhCRPy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:54:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232006AbhCRPx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:53:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39B3E64F18;
        Thu, 18 Mar 2021 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616082838;
        bh=BBrcHhfGE3iBCVKNTfQNX2XldJgZEPsT9zYlvgZfU00=;
        h=From:To:Cc:Subject:Date:From;
        b=iP/UVGFC73InLFx4efZkmlo12J8RlaVD48Fx5M8+2D46+2C2yNZBymLdMF7IwhbPN
         bwZaSqbrY3NMVuZ7OSaQyPeyGMa3rVc74uLWpzmCyDfoxCFv4g5ax6Ps7xOpRFEJz3
         H5j1zOJuwX0aYwRorauR6MNRM/O7yqw5nkOqA88biKUCYWHGTiI/ogws0WrTeh7GyF
         oZEJS710wXtiPH696fkqmJD9uUC9LBoGBHygMdygMYI6kX1rEuAWUk5Zk8nAAiTCsy
         1DQ3Sf32HH/LNVzxv9YV3pIgcH1MGXra6zU5dkXArnuWx4nAxH2RwBJsas6WrkCQbO
         5ulGOj4X2cDMw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lMuyW-0005q3-Nw; Thu, 18 Mar 2021 16:54:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] USB: core: drop outdated interface-binding comment
Date:   Thu, 18 Mar 2021 16:54:05 +0100
Message-Id: <20210318155406.22399-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been almost twenty years since USB drivers returned a data pointer
from their probe routines in order to bind to an interface.

Time to update the documentation for usb_driver_claim_interface().

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/core/driver.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 4dfa44d6cc3c..a1013d9da08d 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -526,10 +526,6 @@ static int usb_unbind_interface(struct device *dev)
  * No device driver should directly modify internal usb_interface or
  * usb_device structure members.
  *
- * Few drivers should need to use this routine, since the most natural
- * way to bind to an interface is to return the private data from
- * the driver's probe() method.
- *
  * Callers must own the device lock, so driver probe() entries don't need
  * extra locking, but other call contexts may need to explicitly claim that
  * lock.
-- 
2.26.2

