Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918953BA165
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhGBNp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232695AbhGBNp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:45:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 836406142C;
        Fri,  2 Jul 2021 13:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625233374;
        bh=zOX+FTluH2U02y8XyREMEHRyXOW0wlBd7RBEcHKV/AA=;
        h=From:To:Cc:Subject:Date:From;
        b=uf5MBApkwtli0CLrC8CAZwmpDWmzoTyEqcVEd4kycg0zL4dpu49K+neXEj3dCM4S1
         VamKvzAE5uCQAu12Kzk0l1UPVSb0InhELrDTt2TfpvSrQ5AWfzsL4lTfpB6/SqU6CQ
         LF3Y//JvtVVHPchdbyCrBni2ZNs3P6Foh5qBjD2XM0KRxsTZcp+xjQvfkwPOPriRX/
         R4320ZmROaenE1QA6k4DC0E5E/UfOhekEv+0edbtWXvcqjLDuLF5N+0/fb2Yc+pA7w
         IOE+zdtXPI1XaTN+PSapecBF5trfYwkXivcVfZ6uMN+fEkNlL5h86GmUJmIUcFMyum
         5YRslxJxHtruw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lzJRS-0006Q0-6l; Fri, 02 Jul 2021 15:42:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] USB: serial: cp210x: fixes and CP2105/CP2108 fw version
Date:   Fri,  2 Jul 2021 15:42:21 +0200
Message-Id: <20210702134227.24621-1-johan@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are couple of minor fixes and some cleanups related to the recent
regression which broke RTS control on some CP2102N devices with buggy
firmware.

In case we run into another one of these, let's log the firmware
version also for CP2105 and CP2108 for which it can be retrieved.

Johan


Johan Hovold (6):
  USB: serial: cp210x: fix control-characters error handling
  USB: serial: cp210x: fix flow-control error handling
  USB: serial: cp210x: clean up control-request timeout
  USB: serial: cp210x: clean up set-chars request
  USB: serial: cp210x: clean up type detection
  USB: serial: cp210x: determine fw version for CP2105 and CP2108

 drivers/usb/serial/cp210x.c | 73 ++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 45 deletions(-)

-- 
2.31.1

