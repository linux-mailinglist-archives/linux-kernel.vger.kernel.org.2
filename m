Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D2E379170
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbhEJOyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:54:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47586 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbhEJOv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:51:59 -0400
Received: from 111-240-141-101.dynamic-ip.hinet.net ([111.240.141.101] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lg7FD-0007Dv-AU; Mon, 10 May 2021 14:50:52 +0000
From:   chris.chiu@canonical.com
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        m.v.b@runbox.com, hadess@hadess.net
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH v2 0/2] USB: propose a generic fix for PORT_SUSPEND set feature timeout
Date:   Mon, 10 May 2021 22:50:28 +0800
Message-Id: <20210510145030.1495-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chris.chiu@canonical.com>

For the Realtek Hub which fails to resume the port which has wakeup
enable descendants, trying to create a more generic and better option
to have the runtime suspend/resume work instead of a reset-resume quirk.

Chris Chiu (2):
  USB: reset-resume the device when PORT_SUSPEND is set but timeout
  Revert "USB: Add reset-resume quirk for WD19's Realtek Hub"

 drivers/usb/core/hub.c    | 15 +++++++++++++++
 drivers/usb/core/quirks.c |  1 -
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.20.1

