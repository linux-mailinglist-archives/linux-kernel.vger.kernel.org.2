Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BEC3762E9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbhEGJeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:34:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39427 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbhEGJel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:34:41 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lewrb-0002Vw-2N; Fri, 07 May 2021 09:33:39 +0000
From:   chris.chiu@canonical.com
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        m.v.b@runbox.com, hadess@hadess.net
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH 0/2] USB: propose a generic fix for PORT_SUSPEND set feature timeout
Date:   Fri,  7 May 2021 17:33:27 +0800
Message-Id: <20210507093329.895-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chris.chiu@canonical.com>

For the Realtek Hub which fails to resume the port which has wakeup
enable descendants connected, trying to create a more generic and
better option to have the runtime suspend/resume work instead of
a reset-resume quirk.

Chris Chiu (2):
  USB: reset-resume the device when PORT_SUSPEND is set but timeout
  Revert "USB: Add reset-resume quirk for WD19's Realtek Hub"

 drivers/usb/core/hub.c    | 15 +++++++++++++++
 drivers/usb/core/quirks.c |  1 -
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.20.1

